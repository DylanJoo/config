## vim 
- font: Fira Mono Medium for Powerline - medium bold

## (optional) Install miniconda
- Install latest miniconda from the website
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

- Activate conda execution: if you opt off intializing automatic conda env. You should modify sth similar to the first line of ``bashrc`` file.

## vim plugin and ctags/cscope
- vim-plug installation:
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
- Some "ERROR" might occured, if the version mismatched
```
:version
```
See if the version of VIM is 'small version'
```
sudo apt-get install vim-gui-common
sudo apt-get install vim-runtime
```
- ctag installtion
```
brew install ctags-exuberant
```
- font-powerline installation:
```
cd ~/Library/Fonts/
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```
- add line in ~/.tmux.conf
```
set -g default-terminal "xterm-256color"
```
## Installation
- Code tracing tools
```
ctags
cscope
```
## Build-up 
```
ctags -R
cscope -Rbq
```
#### Last updated: Oct 3
