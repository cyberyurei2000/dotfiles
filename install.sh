#!/bin/sh

# Copyright (c) cyberyurei2000 2023-2026
# Released under the 0BSD License
# https://opensource.org/license/0bsd

DIR="$(pwd)"

IS_COPY=0
while getopts ":c" option; do
    case $option in
        c)
            IS_COPY=1
            ;;
    esac
done

if [ "$XDG_CONFIG_HOME" = "" ]; then
    XDG_CONFIG_HOME="$HOME/.config"
fi

if [ "$XDG_DATA_HOME" = "" ]; then
    XDG_DATA_HOME="$HOME/.local/share"
fi

is_fedora() {
    if [ -r /etc/os-release ]; then
        . /etc/os-release

        if [ "${ID:-}" = "fedora" ]; then
            return 0
        else
            return 1
        fi
    fi
}

setup_aria2() {
    mkdir -p "$XDG_CONFIG_HOME/aria2"
    ARIA_CONFIG_PATH="$XDG_CONFIG_HOME/aria2"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/aria2/aria2.conf" "$ARIA_CONFIG_PATH/aria2.conf"
    else
        ln -sf "$DIR/config/aria2/aria2.conf" "$ARIA_CONFIG_PATH/aria2.conf"
    fi
}

setup_fontconfig() {
    mkdir -p "$XDG_CONFIG_HOME/fontconfig"
    FONT_CONFIG_PATH="$XDG_CONFIG_HOME/fontconfig"

    cp -f "$DIR/config/fontconfig/fonts.conf" "$FONT_CONFIG_PATH/fonts.conf"
}

setup_git() {
    mkdir -p "$XDG_CONFIG_HOME/git"
    GIT_CONFIG_PATH="$XDG_CONFIG_HOME/git"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/git/gitconfig" "$GIT_CONFIG_PATH/config"
        cp -f "$DIR/config/git/gitignore" "$GIT_CONFIG_PATH/ignore"
    else
        ln -sf "$DIR/config/git/gitconfig" "$GIT_CONFIG_PATH/config"
        ln -sf "$DIR/config/git/gitignore" "$GIT_CONFIG_PATH/ignore"
    fi
}

setup_mpv() {
    mkdir -p "$XDG_CONFIG_HOME/mpv"
    mkdir -p "$XDG_CONFIG_HOME/mpv/script-opts"
    MPV_CONFIG_PATH="$XDG_CONFIG_HOME/mpv"
    MPV_OPTS_PATH="$MPV_CONFIG_PATH/script-opts"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/mpv/input.conf" "$MPV_CONFIG_PATH/input.conf"
        cp - f "$DIR/config/mpv/script-opts/osc-clock.conf" "$MPV_OPTS_PATH/osc-clock.conf"

        if is_fedora() then
            cp -f "$DIR/config/mpv/mpv_legacy.conf" "$MPV_CONFIG_PATH/mpv.conf"
            cp -f "$DIR/config/mpv/script-opts/modernz_linux.conf" "$MPV_OPTS_PATH/modernz.conf"
        else
            cp -f "$DIR/config/mpv/mpv_linux.conf" "$MPV_CONFIG_PATH/mpv.conf"
        fi
    else
        ln -sf "$DIR/config/mpv/input.conf" "$MPV_CONFIG_PATH/input.conf"
        ln -sf "$DIR/config/mpv/script-opts/osc-clock.conf" "$MPV_OPTS_PATH/osc-clock.conf"

        if is_fedora() then
            ln -sf "$DIR/config/mpv/mpv_legacy.conf" "$MPV_CONFIG_PATH/mpv.conf"
            ln -sf "$DIR/config/mpv/script-opts/modernz_linux.conf" "$MPV_OPTS_PATH/modernz.conf"
        else
            ln -sf "$DIR/config/mpv/mpv_linux.conf" "$MPV_CONFIG_PATH/mpv.conf"
        fi
    fi
}

setup_nvim() {
    mkdir -p "$XDG_CONFIG_HOME/nvim"
    NVIM_CONFIG_PATH="$XDG_CONFIG_HOME/nvim"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/nvim/init.lua" "$NVIM_CONFIG_PATH/init.lua"
    else
        ln -sf "$DIR/config/nvim/init.lua" "$NVIM_CONFIG_PATH/init.lua"
    fi
}

setup_zsh() {
    mkdir -p "$XDG_CONFIG_HOME/zsh"
    ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"

    if [ ! -d "${HOME}/.local/bin" ]; then
    	mkdir -p "${HOME}/.local/bin"
    fi

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/zsh/zshrc" "$ZSH_CONFIG_PATH/.zshrc"
        cp -f "$DIR/config/zsh/zprofile" "$ZSH_CONFIG_PATH/.zprofile"
        cp -f "$DIR/config/zsh/zshenv" "$HOME/.zshenv"
    else
        ln -sf "$DIR/config/zsh/zshrc" "$ZSH_CONFIG_PATH/.zshrc"
        ln -sf "$DIR/config/zsh/zprofile" "$ZSH_CONFIG_PATH/.zprofile"
        ln -sf "$DIR/config/zsh/zshenv" "$HOME/.zshenv"
    fi
}

setup_tmux() {
    mkdir -p "$XDG_CONFIG_HOME/tmux"
    TMUX_CONFIG_PATH="$XDG_CONFIG_HOME/tmux"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/tmux/tmux.conf" "$TMUX_CONFIG_PATH/tmux.conf"
    else
        ln -sf "$DIR/config/tmux/tmux.conf" "$TMUX_CONFIG_PATH/tmux.conf"
    fi
}

setup_fastfetch() {
    mkdir -p "$XDG_CONFIG_HOME/fastfetch"
    FETCH_CONFIG_PATH="$XDG_CONFIG_HOME/fastfetch"

    if [ $IS_COPY -eq 1 ]; then
        cp -f "$DIR/config/fastfetch/config_linux.jsonc" "$FETCH_CONFIG_PATH/config.jsonc"
    else
        ln -sf "$DIR/config/fastfetch/config_linux.jsonc" "$FETCH_CONFIG_PATH/config.jsonc"
    fi
}

setup_kwi() {
    if is_fedora() then
        cp -f "$DIR/config/kwi/kwiterminalrc" "$HOME/.var/app/org.kde.kwi/config/kwiterminalrc"
    else
        cp -f "$DIR/config/kwi/kwiterminalrc" "$XDG_CONFIG_HOME/kwiterminalrc"
    fi
}

setup_ssh() {
    mkdir -p "$HOME/.ssh"
    SSH_CONFIG_PATH="$HOME/.ssh"

    if [ -f "$DIR/config/ssh/config_linux" ]; then
        if [ $IS_COPY -eq 1 ]; then
            cp -f "$DIR/config/ssh/config_linux" "$SSH_CONFIG_PATH/config"
        else
            ln -sf "$DIR/config/ssh/config_linux" "$SSH_CONFIG_PATH/config"
        fi
    else
        printf "SSH configuration file not found, skipping..."
    fi
}

setup_winedir() {
    if [ ! -d "$XDG_DATA_HOME/wine" ]; then
        mkdir -p "$XDG_DATA_HOME/wine"
    fi
}

setup_mpv_scripts() {
    MPV_CONFIG_PATH="$XDG_CONFIG_HOME/mpv"

    mkdir -p "$MPV_CONFIG_PATH/scripts"
    mkdir -p "$MPV_CONFIG_PATH/fonts"

    if is_fedora() then
        git clone "https://github.com/Samillion/ModernZ.git" "/tmp/ModernZ"
        mv "/tmp/ModernZ/modernz.lua" "$MPV_CONFIG_PATH/scripts/"
        mv "/tmp/ModernZ/modernz-icons.ttf" "$MPV_CONFIG_PATH/fonts/"
    fi

    git clone "https://github.com/cyberyurei2000/mpv-osc-clock.git" "/tmp/mpv-osc-clock"
    mv "/tmp/mpv-osc-clock/scripts/osc-clock.lua" "$MPV_CONFIG_PATH/scripts/"
}

if [ "$(uname -m)" = "aarch64" ]; then
    setup_nvim
    setup_zsh
    setup_fastfetch
    setup_tmux
else
    setup_aria2
    setup_fontconfig
    setup_git
    setup_mpv
    setup_nvim
    setup_zsh
    setup_tmux
    setup_fastfetch
    setup_kwi
    setup_ssh
    setup_winedir
    setup_mpv_scripts
fi
