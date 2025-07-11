#!/bin/sh

# Copyright (c) cyberyurei2000 2023-2025
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

    ln -sf "$DIR/config/aria2/aria2.conf" "$ARIA_CONFIG_PATH/aria2.conf"
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
    ln -sf "$DIR/config/git/gitignore" "$GIT_CONFIG_PATH/ignore"
}

setup_mpv() {
    mkdir -p "$XDG_CONFIG_HOME/mpv"
    mkdir -p "$XDG_CONFIG_HOME/mpv/script-opts"
    MPV_CONFIG_PATH="$XDG_CONFIG_HOME/mpv"
    MPV_OPTS_PATH="$MPV_CONFIG_PATH/script-opts"

    ln -sf "$DIR/config/mpv/mpv_linux.conf" "$MPV_CONFIG_PATH/mpv.conf"
    ln -sf "$DIR/config/mpv/input.conf" "$MPV_CONFIG_PATH/input.conf"
    ln -sf "$DIR/config/mpv/script-opts/modernz_linux.conf" "$MPV_OPTS_PATH/modernz.conf"
}

setup_nvim() {
    mkdir -p "$XDG_CONFIG_HOME/nvim"
    NVIM_CONFIG_PATH="$XDG_CONFIG_HOME/nvim"

    ln -sf "$DIR/config/nvim/init.lua" "$NVIM_CONFIG_PATH/init.lua"
}

setup_zsh() {
    mkdir -p "$XDG_CONFIG_HOME/zsh"
    ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"

    if [ ! -d "${HOME}/.local/bin" ]; then
    	mkdir -p "${HOME}/.local/bin"
    fi

    ln -sf "$DIR/config/zsh/zshrc" "$ZSH_CONFIG_PATH/.zshrc"
    ln -sf "$DIR/config/zsh/zprofile" "$ZSH_CONFIG_PATH/.zprofile"
    ln -sf "$DIR/config/zsh/zshenv" "$HOME/.zshenv"
}

setup_tmux() {
    mkdir -p "$XDG_CONFIG_HOME/tmux"
    TMUX_CONFIG_PATH="$XDG_CONFIG_HOME/tmux"

    ln -sf "$DIR/config/tmux/tmux.conf" "$TMUX_CONFIG_PATH/tmux.conf"
}

setup_fastfetch() {
    mkdir -p "$XDG_CONFIG_HOME/fastfetch"
    FETCH_CONFIG_PATH="$XDG_CONFIG_HOME/fastfetch"

    ln -sf "$DIR/config/fastfetch/config.jsonc" "$FETCH_CONFIG_PATH/config.jsonc"
}

setup_ghostty() {
    mkdir -p "$XDG_CONFIG_HOME/ghostty"
    GTTY_CONFIG_PATH="$XDG_CONFIG_HOME/ghostty"

    ln -sf "$DIR/config/ghostty/config" "$GTTY_CONFIG_PATH/config"
}

setup_ssh() {
    mkdir -p "$HOME/.ssh"
    SSH_CONFIG_PATH="$HOME/.ssh"

    if [ -f "$DIR/config/ssh/config_linux" ]; then
        ln -sf "$DIR/config/ssh/config_linux" "$SSH_CONFIG_PATH/config"
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
    mkdir -p "$MPV_CONFIG_PATH/scripts/mpv-gallery-view"

    git clone "https://github.com/Samillion/ModernZ.git" "/tmp/ModernZ"
    mv "/tmp/ModernZ/modernz.lua" "$MPV_CONFIG_PATH/scripts/"
    mv "/tmp/ModernZ/material-design-icons.ttf" "$MPV_CONFIG_PATH/fonts/"

    git clone "https://github.com/po5/thumbfast.git" "/tmp/thumbfast"
    mv "/tmp/thumbfast/thumbfast.lua" "$MPV_CONFIG_PATH/scripts/"

    git clone "https://github.com/cyberyurei2000/mpv-osc-clock.git" "/tmp/mpv-osc-clock"
    mv "/tmp/mpv-osc-clock/scripts/osc-clock.lua" "$MPV_CONFIG_PATH/scripts/"
    mv "/tmp/mpv-osc-clock/fonts/FO-TVASAHI-GMorning.otf" "$MPV_CONFIG_PATH/fonts/"
}

setup_nvim_theme() {
    NVIM_CONFIG_PATH="$XDG_CONFIG_HOME/nvim"

    mkdir -p "$NVIM_CONFIG_PATH/colors"
    mkdir -p "$NVIM_CONFIG_PATH/lua"

    git clone "https://github.com/folke/tokyonight.nvim.git" "/tmp/tokyonight"
    cp -r "/tmp/tokyonight/colors" "$NVIM_CONFIG_PATH/"

    mkdir -p "$NVIM_CONFIG_PATH/lua/tokyonight"
    cp /tmp/tokyonight/lua/tokyonight/*.lua "$NVIM_CONFIG_PATH/lua/tokyonight/"
    cp -r "/tmp/tokyonight/lua/tokyonight/colors" "$NVIM_CONFIG_PATH/lua/tokyonight/"
    cp -r "/tmp/tokyonight/lua/tokyonight/groups" "$NVIM_CONFIG_PATH/lua/tokyonight/"
}

setup_aria2
setup_fontconfig
setup_git
setup_mpv
setup_nvim
setup_zsh
setup_tmux
setup_fastfetch
setup_ghostty
setup_ssh
setup_wineprefix
setup_mpv_scripts
setup_nvim_theme
