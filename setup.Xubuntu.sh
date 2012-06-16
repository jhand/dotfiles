#!/bin/sh

mkdir ~/.xmonad
ln -s ~/.dotfiles/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
ln -s ~/.dotfiles/autostart.Xubuntu ~/.xmonad/xmonad.start
ln -s ~/.dotfiles/xmonad/.xmobarrc ~/.xmonad/.xmobarrc

ln -s ~/.dotfiles/.Xdefaults ~/.Xdefaults

mkdir ~/.config/awesome/
ln -s ~/.dotfiles/awesome/rc.lua ~/.config/awesome/rc.lua
ln -s ~/.dotfiles/autostart.Xubuntu ~/.config/awesome/autostart.sh

ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
