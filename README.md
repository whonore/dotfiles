## [Homebrew](https://brew.sh)
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Build Tools
```sh
# Linux
sudo apt install gcc make

# Mac
brew install gettext # For envsubst
```

## Generate Scripts/Configs
```sh
make
```

## [Kitty](https://sw.kovidgoyal.net/kitty)
```sh
curl -fL https://sw.kovidgoyal.net/kitty/installer.sh | sh
~/.dotfiles/kitty/install.sh
```

## [Nix](https://nixos.org/download.html) and [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone)
```sh
curl -fL https://nixos.org/nix/install | sh
~/.dotfiles/nix/install.sh
~/.dotfiles/nix/update-hm.sh
```

[FiraCode](https://github.com/tonsky/FiraCode/wiki/Linux-instructions#manual-installation)
```sh
fc-cache -fv
fc-list | rg -i fira
```

## Symlinks
```sh
peridot --link
```

## [Fish](https://fishshell.com/docs/current/index.html#installation)
```sh
echo $HOME/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s $HOME/.nix-profile/bin/fish
curl -fL https://gist.githubusercontent.com/whonore/05abc83f9c741ff60583b5acefd7336d/raw/8518e88adc8307d5d6af8de3561a9e106e8386a0/nix-fishgen.py | python3
```

## Vim
```sh
cachix use whonore-vim
vim +PlugInstall
vim +Blueper
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
set PY_LATEST (pyenv install --list | awk '/^[[:space:]]*3\.[0-9]+\.[0-9]+$/ { print $1 }' | tail -n1); echo $PY_LATEST
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
sudo apt install --no-install-recommends ca-certificates libgl1 libxkbcommon-x11-0 libegl1-mesa libfontconfig1 libglib2.0-0 libdbus-1-3 libxcb-cursor0 libxcb-icccm4 libxcb-keysyms1 libxcb-shape0 libnss3 libxcomposite1 libxdamage1 libxrender1 libxrandr2 libxtst6 libxi6 libasound2

git clone https://github.com/qutebrowser/qutebrowser.git ~/.qutebrowser
~/.dotfiles/qutebrowser/install.sh
```

## [LaTeX](https://tug.org/texlive/doc/texlive-en/texlive-en.html#installation)
```sh
sudo mkdir /usr/local/texlive
sudo chown -R $USER /usr/local/texlive
mkdir tlmgr-install; cd tlmgr-install
curl -fLO http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzvf install-tl-unx.tar.gz; cd install-tl-20*; ./install-tl
cd ../..; rm -r tlmgr-install
tlmgr init-usertree --usertree $TEXMFHOME
```
