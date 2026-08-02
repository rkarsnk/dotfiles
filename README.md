# dotfiles Nix

このリポジトリは nix-darwin と home-manager を flake で管理する構成です。

## 構成

- flake の入口: [flake.nix](flake.nix)
- 共通の darwin 設定: [modules/darwin/system-shared.nix](modules/darwin/system-shared.nix)
- 共通の home-manager 設定: [modules/home/home-shared.nix](modules/home/home-shared.nix)
- ホスト固有の darwin 設定: [hosts/my-darwin](hosts/my-darwin)
- ユーザー固有の home-manager 設定: [home-manager/hosts](home-manager/hosts)

## 使い方

### 検証

```bash
nix flake check
nix eval .#packages.aarch64-darwin.default.name
```

### darwin へ適用

```bash
make darwin-build
sudo make darwin-switch
```

### home-manager へ適用

```bash
make home-build
make home-switch
```

## 追加するときの考え方

- 共有したい設定は [modules](modules) に置く
- マシン依存の設定は [hosts/my-darwin](hosts/my-darwin) に置く
- ユーザー依存の設定は [home-manager/hosts](home-manager/hosts) に置く
- 新しい機能を追加するときは、まず個別 module を作ってから [modules/home/home-shared.nix](modules/home/home-shared.nix) から import する
- 1つの機能につき 1つの module を基本にし、設定の責務を分ける
