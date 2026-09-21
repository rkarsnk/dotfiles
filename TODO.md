# TODO

- [x] Blueprintの理解
- [x] 現行dotfiles棚卸し
- [x] Blueprint初期化
- [x] モジュール設計とマッピング
- [ ] 設定ファイル移植 (部分完了: zsh/ghostty/karabinerは済み、emacsはinit.elの最小構成(日本語/UTF-8・mac-ime・C-j)まで済み、以降の設定は未移植)
- [x] アセット配置とシンボリック連携
- [x] ビルドと検証 (`nix flake check` / `make darwin-build` / `make home-build` は成功。ただし既知の軽微な制約が残存、下記参照)
- [ ] ドキュメント化とクリーンアップ

## 次の優先事項

1. Emacsのinit.elを拡充する（フォント、ウィンドウ拡大の確認など。下記「Emacsメモ」参照）
2. README に運用ルールとモジュール追加方針を追記する
3. 不要な旧ファイルやテンプレートのクリーンアップを確定する
4. 今回の変更（`modules/home/programs/default.nix`追加、`README.md`修正、`homebrew.nix`のdrawio対応）をコミットする

## 既知の制約 (対応不要)

- `nix flake check` は `darwinModules.system-shared` / `homeModules.home-shared` の `isFunctionOrAttrs` チェックで失敗し続ける。これは `pkgs`/`lib`/`config` を引数に取る通常のnix-darwin/home-managerモジュールが、blueprintの規約上ファイルパスのまま返され、flake出力としてはstring化されるために起きる構造的な制約。`darwinConfigurations.*` のビルド自体には影響しないため、対応不要と判断。

## Emacsメモ

- 構成: `modules/darwin/programs/emacs.nix` で `nixpkgs-unstable` の `emacs`（31.1, Cocoa/NS）に `emacsPackages.mac-ime` を入れている。`mac-ime` は26.05のリリースブランチにはなく、unstableにしかない。
- 設定: `modules/home/programs/emacs/init.el` を `~/.emacs.d/init.el` として配置している（日本語/UTF-8、mac-ime、C-jでmacSKKをひらがなモードにする）。
- `mac-ime` の動的モジュール（`mac-ime-module.so`）はnix管理外。初回の有効化時にcurlでGitHubから取得する。保存先はnix storeが読み取り専用で書けないため `~/.emacs.d/mac-ime/` に変更している。パッケージ更新でバージョンが変わると再取得を求められる。
- C-jはEmacsが先に処理してmacSKKに届かないため、Emacs側でmacSKKの入力ソースID（`net.mtgto.inputmethod.macSKK.hiragana`）に切り替えている。変換中の確定などmacSKK本来のC-j動作は再現できない。
- ターミナルから `emacs` を起動すると `error messaging the mach port for IMKCFRunLoopWakeUpReliable` がstderrに出る。入力には影響しないため対応していない（Finder/Spotlight/`open -a Emacs` から起動すると出ない）。
- 旧構成（emacs-macport）ではウィンドウ拡大ができなかった。`frame-resize-pixelwise` が `nil`（デフォルト）でフレームが文字セル単位に丸められるのが原因と推測。Cocoa版でも同じなら init.el で `(setq frame-resize-pixelwise t window-resize-pixelwise t)` を試す（Cocoa版での確認は未実施）。
- 試して見送ったこと: `takaxp/ns-inline-patch` の `emacs-29.1-inline.patch` を `pkgs.emacs`（30.2）に `overrideAttrs` で当てる案は、`configure.ac` の変更により `configure` を再生成すると clang が `-std=gnu23` を選び、Objective-C（`nsterm.m` など）で `bool` / `static_assert` が未定義になりビルドできなかった。`mac-ime` で日本語入力ができたため、現在は使っていない。

---

## 1. アセット配置 / シンボリック連携

- `ghostty` / `karabiner` / `zsh` / `emacs` の設定を `home-manager` 管理下で完結させる
- 設定ファイル本体は各 `modules/home/programs/<name>/` 配下に同居させ、`home.file` / `builtins.readFile` で `./` 相対パス参照する（旧 `home-manager/` トップレベルディレクトリは廃止済み）
- 必要ならホスト固有の config は `hosts/<machine>/users/<user>/home-configuration.nix` で分離する

## 2. ドキュメント化

- `README.md` に現在のディレクトリ構成と、追加する際のルールを明確に追記
- `modules` の役割、`hosts` の使い分け、`hosts` の目的を記載する
- 使い方として `nix flake check` / `make darwin-build` / `sudo make darwin-switch` / `make home-switch` を明記

## 3. クリーンアップ

- もう一度 `git status` で不要な変更や残骸がないか確認
- 不要なテンプレート・旧構成ファイルがあれば削除
- `README.md` と `Makefile` の整合性を最終確認

## 4. 追加のモジュール分割

- `darwin` 側の `system.defaults` / `fonts` / `nix.settings` も個別モジュールに分ける
- `home-manager` 側の `programs` をさらに細かく分ける（すでに `zsh` / `ghostty` / `karabiner` / `emacs` を分割済み）

## 5. 最終検証

- 変更ごとに `nix flake check`
- `make darwin-build` / `make home-build`
- 必要に応じて `sudo make darwin-switch` / `make home-switch`

## 6. コミット

- 「動作確認済み」の状態でコミット
- 可能ならタグや changelog にまとめる

> いまのフェーズでは、機能追加よりも「構成の完成度」と「運用安定性」を優先するのが良いです。
