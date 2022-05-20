# My dotfiles
dotfile管理用リポジトリ

# 使い方

```
git clone git@github.com:rkarsnk/dotfiles.git ~/.dotfiles
```

`.dofiles`ディレクトリ以下のファイルのシンボリックリンクを`home`に作成する。

```
cd $HOME
ln -s .dotfiles/bashrc .bashrc
ln -s .dotfiles/colorrc .colorrc
ln -s .dotfiles/config .config
ln -s .dotfiles/gitconfig .gitconfig
ln -s .dotfiles/profile .profile
ln -s .dotfiles/vimrc .vimrc
```

