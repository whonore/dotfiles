## Build Tools and Libraries
```sh
sudo apt install gcc make zlib1g-dev libbz2-dev libreadline-dev libssl-dev libsqlite3-dev libffi-dev
```

## [Kitty](https://sw.kovidgoyal.net/kitty/) and [FiraCode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager)
```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/kitty.app/share/applications/kitty.desktop.bk
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/kitty.app/share/applications/kitty.desktop
ln -s ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications
sudo apt install fonts-firacode
```

## [Nix](https://nixos.org/download.html)
```sh
curl -L https://nixos.org/nix/install | sh
cd ~/.dotfiles/nix; ./install-packages.sh
```

## [Fish](https://fishshell.com/docs/current/index.html#installation)
```sh
echo $HOME/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s $HOME/.nix-profile/bin/fish
curl -L https://gist.githubusercontent.com/whonore/05abc83f9c741ff60583b5acefd7336d/raw/8518e88adc8307d5d6af8de3561a9e106e8386a0/nix-fishgen.py | python3
```

## Rust
```sh
rustup update stable
rustup default stable
cargo install peridot
~/.cargo/bin/peridot --link
```

## Xmonad
```sh
sudo ln -s ~/.dotfiles/xmonad/xmonad.desktop /usr/share/xsessions
```

## [Python](https://github.com/pyenv/pyenv)
```sh
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
pyenv install 3.*.*
pyenv global 3.*.*
python -m pip install --user --upgrade -r ~/.dotfiles/python/requirements.txt
```

## Vim
```sh
usevim 8.1 3
vim +PlugInstall +Blueper
```

## Snap
```sh
snap install discord spotify firefox chromium
```
