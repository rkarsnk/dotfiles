# dotfiles Nix

このリポジトリは [nix-darwin](https://github.com/nix-darwin/nix-darwin) と [home-manager](https://github.com/nix-community/home-manager) を [numtide/blueprint](https://github.com/numtide/blueprint) 経由の flake で管理する構成です。blueprint がディレクトリ規約に基づいて `darwinConfigurations` / `homeConfigurations` / `darwinModules` / `homeModules` を自動生成するため、`flake.nix` 自体には出力定義を書きません。

## ディレクトリ構成

```text
.
├── flake.nix                          # flakeの入口。inputsの定義とblueprintの呼び出しのみ
├── lib/
│   └── default.nix                    # 全モジュール共通で使う値（username, homeDirectoryなど）
├── modules/
│   ├── darwin/                        # nix-darwin用モジュール（darwinModules.<name>として公開）
│   │   ├── system-shared.nix          # 全ホスト共通のdarwin設定（Finder/Dock/フォント/nix設定など）
│   │   ├── homebrew.nix               # Homebrew（brew/cask）のパッケージ管理
│   │   └── emacs.nix                  # Emacs本体（emacs-macport）のインストール
│   └── home/                          # home-manager用モジュール（homeModules.<name>として公開）
│       ├── home-shared.nix            # 全ユーザー共通のhome-manager設定
│       └── programs/                  # プログラムごとの設定（dotfiles本体を同居させる）
│           ├── zsh/                   # zshrcなど
│           ├── ghostty/               # ghostty configなど
│           ├── karabiner/             # karabinerのcomplex_modificationsなど
│           └── opencode.nix           # 現在無効化中（home-shared.nixからimportコメントアウト）
└── hosts/
    └── <machine>/                     # マシンごとのホスト定義（例: MacBookNeo, MacMiniM4）
        ├── darwin-configuration.nix   # system-sharedをimportし、hostNameなどマシン固有値を設定
        └── users/<user>/
            └── home-configuration.nix # home-sharedをimportし、ユーザー固有設定があれば追加
```

その他:

- [Makefile](Makefile) — `darwin-build` / `darwin-switch` / `home-build` / `home-switch` / `update` の各コマンド
- [devshell.nix](devshell.nix) / [package.nix](package.nix) — 開発シェルとパッケージ定義
- [TODO.md](TODO.md) — 移行作業の進捗管理

## モジュールの役割と使い分け

| ディレクトリ | 役割 | 適用範囲 |
| --- | --- | --- |
| `modules/darwin/` | macOS(nix-darwin)のシステム全体設定 | 全ホスト共通 or `hosts/<machine>` からimportして個別適用 |
| `modules/home/` | home-manager によるユーザー環境設定 | 全ユーザー共通 or `hosts/*/users/*` からimportして個別適用 |
| `modules/home/programs/<name>/` | 個別アプリの設定（dotfiles本体を同居） | `home-shared.nix` 経由で全ユーザーに適用 |
| `hosts/<machine>/` | マシン固有の値（hostNameなど）の注入 | 該当マシンのみ |
| `hosts/<machine>/users/<user>/` | ユーザー固有のhome-manager設定 | 該当マシン・該当ユーザーのみ |
| `lib/` | 複数モジュールから参照する共通値（username, homeDirectoryなど） | 全体 |

blueprint の規約上、`modules/darwin/*.nix` は自動的に `darwinModules.<ファイル名>` として、`modules/home/*.nix` は `homeModules.<ファイル名>` として公開されます。`hosts/<machine>/darwin-configuration.nix` はそのホスト用の `darwinConfigurations.<machine>` として、`hosts/<machine>/users/<user>/home-configuration.nix` は `homeConfigurations."<user>@<machine>"` として公開されます。

## 使い方

### 検証

```bash
nix flake check
nix eval .#packages.aarch64-darwin.default.name
```

### darwin へ適用

```bash
make darwin-build     # ビルドのみ（適用しない）
sudo make darwin-switch
```

### home-manager へ適用

```bash
make home-build       # ビルドのみ（適用しない）
make home-switch
```

### その他

```bash
make update            # flake.lock を更新
```

## 追加するときの考え方

- 共有したい設定は [modules](modules) に置く
- マシン依存の設定は `hosts/<machine>`（例: [hosts/MacBookNeo](hosts/MacBookNeo), [hosts/MacMiniM4](hosts/MacMiniM4)）に置く
- ユーザー依存の設定は `hosts/<machine>/users/<user>/home-configuration.nix` に置く
- プログラムごとの設定ファイル（dotfiles 本体）は対応する [modules/home/programs](modules/home/programs) の各モジュール配下に同居させ、`home.file` / `builtins.readFile` で `./` 相対パス参照する
- 新しい機能を追加するときは、まず個別 module を作ってから [modules/home/home-shared.nix](modules/home/home-shared.nix)（darwin側は [modules/darwin/system-shared.nix](modules/darwin/system-shared.nix)）から import する
- 1つの機能につき 1つの module を基本にし、設定の責務を分ける
- 新しいホストを追加する場合は `hosts/<machine>/darwin-configuration.nix` と `hosts/<machine>/users/<user>/home-configuration.nix` を用意し、それぞれ `system-shared` / `home-shared` を import した上でホスト固有の差分だけを追加する

## 既知の制約

- `nix flake check` は `darwinModules.emacs` / `darwinModules.system-shared` / `homeModules.home-shared` の `isFunctionOrAttrs` チェックで失敗する。これは `pkgs`/`lib`/`config` を引数に取る通常の nix-darwin/home-manager モジュールが、blueprint の規約上ファイルパスのまま返され flake 出力としては string 化されるために起きる構造的な制約で、`darwinConfigurations.*` のビルド自体には影響しないため対応不要と判断している。

進捗の詳細は [TODO.md](TODO.md) を参照してください。
