# TODO

- [x] Blueprintの理解
- [x] 現行dotfiles棚卸し
- [x] Blueprint初期化
- [ ] モジュール設計とマッピング (部分完了)
- [ ] 設定ファイル移植
- [x] アセット配置とシンボリック連携
- [ ] ビルドと検証 (部分完了)
- [ ] ドキュメント化とクリーンアップ

## 次の優先事項

1. アセット配置とシンボリック連携を整理する
2. README に運用ルールとモジュール追加方針を追記する
3. 不要な旧ファイルやテンプレートのクリーンアップを確定する
4. `nix flake check` / `make darwin-build` / `make home-switch` で最終確認する

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
