#!/bin/bash
ln -sf ./configs/.vimrc ~/.vimrc
ln -sf ./ini.lua ~/.config/nvim/ini.lua
ln -sf ./.Rprofile ~/.Rprofile
ln -sf ./.tmux.conf ~/.tmux.conf
echo If there weren\'t any error messages, then all symbolic links were created successfully.
