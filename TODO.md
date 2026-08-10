# TODO

- [x] Blueprintの理解
- [x] 現行dotfiles棚卸し
- [x] Blueprint初期化
- [x] モジュール設計とマッピング
- [ ] 設定ファイル移植 (部分完了: zsh/ghostty/karabinerは済み、emacsの設定ファイルは未移植)
- [x] アセット配置とシンボリック連携
- [x] ビルドと検証 (`nix flake check` / `make darwin-build` / `make home-build` は成功。ただし既知の軽微な制約が残存、下記参照)
- [ ] ドキュメント化とクリーンアップ

## 次の優先事項

1. emacsの設定ファイル（init.el等）をhome-manager管理下に移植する
2. README に運用ルールとモジュール追加方針を追記する
3. 不要な旧ファイルやテンプレートのクリーンアップを確定する
4. 今回の変更（`modules/home/programs/default.nix`追加、`README.md`修正、`homebrew.nix`のdrawio対応）をコミットする

## 既知の制約 (対応不要)

- `nix flake check` は `darwinModules.emacs` / `darwinModules.system-shared` / `homeModules.home-shared` の `isFunctionOrAttrs` チェックで失敗し続ける。これは `pkgs`/`lib`/`config` を引数に取る通常のnix-darwin/home-managerモジュールが、blueprintの規約上ファイルパスのまま返され、flake出力としてはstring化されるために起きる構造的な制約。`darwinConfigurations.*` のビルド自体には影響しないため、対応不要と判断。
- `drawio` cask は `nixpkgs` 同梱のHomebrewコードが古く `command_wrapper` 構文を解釈できないため `modules/darwin/homebrew.nix` で一時的に無効化を検討中（nixpkgsのHomebrewパッケージ更新待ち）。

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
