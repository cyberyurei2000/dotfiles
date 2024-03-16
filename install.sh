#!/bin/sh

# Copyright (c) cyberyurei2000 2023-2024
# Released under the 0BSD License
# https://opensource.org/license/0bsd

DIR=$(pwd)

if [ "$XDG_CONFIG_HOME" = "" ]; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

if [ "$XDG_DATA_HOME" = "" ]; then
    XDG_DATA_HOME="$HOME/.local/share"
fi

setup_aria2() {
    mkdir -p "$XDG_CONFIG_HOME/aria2"
    ARIA_CONFIG_PATH="$XDG_CONFIG_HOME/aria2"

    ln -sf "$DIR/config/aria2/aria2.conf" "$ARIA_CONFIG_PATH/"
}

setup_fontconfig() {
    mkdir -p "$XDG_CONFIG_HOME/fontconfig"
    FONT_CONFIG_PATH="$XDG_CONFIG_HOME/fontconfig"

    cp "$DIR/config/fontconfig/fonts.conf" "$FONT_CONFIG_PATH/fonts.conf"
}

setup_git() {
    mkdir -p "$XDG_CONFIG_HOME/git"
    GIT_CONFIG_PATH="$XDG_CONFIG_HOME/git"

    ln -sf "$DIR/config/git/gitconfig" "$GIT_CONFIG_PATH/config"
}

setup_mpv() {
    mkdir -p "$XDG_CONFIG_HOME/mpv"
    MPV_CONFIG_PATH="$XDG_CONFIG_HOME/mpv"

    ln -sf "$DIR/config/mpv/mpv.conf" "$MPV_CONFIG_PATH/"
}

setup_nvim() {
    mkdir -p "$XDG_CONFIG_HOME/nvim"
    NVIM_CONFIG_PATH="$XDG_CONFIG_HOME/nvim"

    ln -sf "$DIR/config/nvim/init.vim" "$NVIM_CONFIG_PATH/"
}

setup_zsh() {
    mkdir -p "$XDG_CONFIG_HOME/zsh"
    ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"

    if [ ! -e "${HOME}/.local/bin" ]; then
    	mkdir -p "${HOME}/.local/bin"
    fi

    ln -sf "$DIR/config/zsh/zshrc" "$ZSH_CONFIG_PATH/.zshrc"
    ln -sf "$DIR/config/zsh/zprofile" "$ZSH_CONFIG_PATH/.zprofile"
    ln -sf "$DIR/config/zsh/zshenv" "$HOME/.zshenv"
}

setup_ssh() {
    mkdir -p "$HOME/.ssh"
    SSH_CONFIG_PATH="$HOME/.ssh"

    if [ -f "$DIR/config/ssh/config" ]; then
        ln -sf "$DIR/config/ssh/config" "$SSH_CONFIG_PATH/"
    else
        printf "ERROR: Failed to setup SSH! Configuration file not found."
    fi
}

setup_wineprefix() {
    if [ ! -d "$XDG_DATA_HOME/wine" ]; then
        mkdir -p "$XDG_DATA_HOME/wine"
    fi
}

setup_mpv_scripts() {
    MPV_CONFIG_PATH="$XDG_CONFIG_HOME/mpv"

    mkdir -p "$MPV_CONFIG_PATH/scripts"
    mkdir -p "$MPV_CONFIG_PATH/fonts"

    git clone "https://github.com/cyl0/ModernX.git" "/tmp/ModernX"
    mv "/tmp/ModernX/modernx.lua" "$MPV_CONFIG_PATH/scripts/"
    mv "/tmp/ModernX/Material-Design-Iconic-Font.ttf" "$MPV_CONFIG_PATH/fonts/"

    git clone "https://github.com/po5/thumbfast.git" "/tmp/thumbfast"
    mv "/tmp/thumbfast/thumbfast.lua" "$MPV_CONFIG_PATH/scripts/"
}

setup_nvim_theme() {
    NVIM_CONFIG_PATH="$XDG_CONFIG_HOME/nvim"

    mkdir -p "$NVIM_CONFIG_PATH/colors"
    mkdir -p "$NVIM_CONFIG_PATH/lua"

    git clone "https://github.com/folke/tokyonight.nvim.git" "/tmp/tokyonight"
    cp -r "/tmp/tokyonight/colors" "$NVIM_CONFIG_PATH/"

    mkdir -p "$NVIM_CONFIG_PATH/lua/tokyonight"
    cp /tmp/tokyonight/lua/tokyonight/* "$NVIM_CONFIG_PATH/lua/tokyonight/"
}

setup_aria2
setup_fontconfig
setup_git
setup_mpv
setup_nvim
setup_zsh
#setup_ssh
#setup_wineprefix
setup_mpv_scripts
setup_nvim_theme
