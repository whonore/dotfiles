## Build Tools
```sh
sudo apt install gcc make
```

## [Kitty](https://sw.kovidgoyal.net/kitty) and [FiraCode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager)
```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh
~/.dotfiles/kitty/install.sh
sudo apt install fonts-firacode
```

## [Nix](https://nixos.org/download.html)
```sh
curl -L https://nixos.org/nix/install | sh
nix-env -j auto --cores 0 -if ~/.dotfiles/nix/packages.nix
```

## [Fish](https://fishshell.com/docs/current/index.html#installation)
```sh
echo $HOME/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s $HOME/.nix-profile/bin/fish
curl -L https://gist.githubusercontent.com/whonore/05abc83f9c741ff60583b5acefd7336d/raw/8518e88adc8307d5d6af8de3561a9e106e8386a0/nix-fishgen.py | python3
```

## Vim
```sh
cachix use whonore-vim
vim +PlugInstall +Blueper
```

## Symlinks
```sh
peridot --link
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
ln -s ~/.pyenv/pyenv.1 ~/.local/man/man1
set PY_LATEST (pyenv install --list | awk '/^\s*3\.[0-9]+\.[0-9]+$/ { print $1 }' | tail -n1)
pyenv install $PY_LATEST
pyenv global $PY_LATEST
pyenv rehash
python -m pip install --user --upgrade -r ~/.dotfiles/python/requirements.txt
```

## Rust
```sh
rustup update stable
rustup default stable
```

## Snap
```sh
snap install discord spotify firefox chromium
```

## [Qutebrowser](https://github.com/qutebrowser/qutebrowser/blob/master/doc/install.asciidoc)
```sh
sudo apt install ca-certificates libglib2.0-0 libgl1 libfontconfig1 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev libxml2-utils xsltproc
git clone https://github.com/qutebrowser/qutebrowser.git ~/.qutebrowser
~/.dotfiles/qutebrowser/install.sh
```

## Scripts
```sh
make -C ~/.dotfiles/scripts
```

## LaTeX
```sh
sudo mkdir /usr/local/texlive
sudo chown -R $USER /usr/local/texlive
mkdir tlmgr-install; cd tlmgr-install
curl -L -O http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzvf install-tl-unx.tar.gz; cd install-tl-20*; ./install-tl
cd ../..; rm -r tlmgr-install
tlmgr init-usertree --usertree $TEXMFHOME
```
