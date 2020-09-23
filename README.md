## [Kitty](https://sw.kovidgoyal.net/kitty/) and [FiraCode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager)
```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/kitty.app/share/applications/kitty.desktop.bk
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/kitty.app/share/applications/kitty.desktop
ln -s ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
sudo apt install fonts-firacode
```

## [Python](https://github.com/pyenv/pyenv)
```sh
git clone https://github.com/pyenv/pyenv.git ~/.pyenv`
pyenv install 3.*.*
pyenv global 3.*.*
python -m pip install --user --upgrade -r ~/.dotfiles/python/requirements.txt
```

## [Nix](https://nixos.org/download.html)
```sh
curl -L https://nixos.org/nix/install | sh
cd ~/.dotfiles/nix; ./install-packages.sh
```

## Rust
```sh
rustup update stable
rustup default stable
cargo install peridot
peridot --link
```

## Vim
```sh
usevim 8.1 3
vim +PlugUpdate
```

## Snap
```sh
snap install discord spotify chromium
```
