## Build Tools
```sh
sudo apt install gcc make
```

## [Kitty](https://sw.kovidgoyal.net/kitty/) and [FiraCode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager)
```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh
~/.dotfiles/kitty/install-kitty.sh
sudo apt install fonts-firacode
```

## [Nix](https://nixos.org/download.html)
```sh
curl -L https://nixos.org/nix/install | sh
cd ~/.dotfiles/nix; ./install-packages.sh
nix-env -if ~/.dotfiles/nix/ctags/default.nix
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
sudo apt install zlib1g-dev libbz2-dev libreadline-dev libssl-dev libsqlite3-dev libffi-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
pyenv install 3.*.*
pyenv global 3.*.*
python -m pip install --user --upgrade -r ~/.dotfiles/python/requirements.txt
```

## Vim
```sh
nix-env -if ~/.dotfiles/nix/vim/default.nix --argstr version 8.2
vim +PlugInstall +Blueper
```

## Snap
```sh
snap install discord spotify firefox chromium
```

## [Qutebrowser](https://github.com/qutebrowser/qutebrowser/blob/master/doc/install.asciidoc)
```sh
sudo apt install ca-certificates libglib2.0-0 libgl1 libfontconfig1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev libxml2-utils xsltproc
git clone https://github.com/qutebrowser/qutebrowser.git ~/.qutebrowser
~/.dotfiles/qutebrowser/install-qutebrowser.sh
```

## Scripts
```sh
make -C ~/.dotfiles/scripts/
```
