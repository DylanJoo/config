## vim 
- font: Fira Mono Medium for Powerline - medium bold

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
