# PROMPT
autoload -Uz promptinit
promptinit

prompt_debian_setup() {
    PS1='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%# '
    PS2='%# '
}
prompt_default_setup() {
    #PS1='%B%F{blue}%n@%m%f%b%B %F{red}%~%f%b ¥ '
    PS1='%B%F{blue}%n@%m%f%b%B %F{red}%(4~|.../%3~|%~)%f%b ¥ '
    PS2='¥ '
}
prompt_server_setup(){
    PS1='%B%F{green}%n@%m%f%b%B %F{blue}%(4~|.../%3~|%~)%f%b ¥ '
    PS2='¥ '
}
prompt_mobile_setup() {
    PS1='%F{blue}%~%f%b ¥ '
    PS2='¥ '
}
prompt_themes+=( debian default server mobile )

if [ "$(uname -m)" = "aarch64" ]; then
    prompt server
else
    prompt default
fi

# History
if [ "$(uname -m)" != "aarch64" ]; then
    HISTFILE="$XDG_CONFIG_HOME/zsh/history"
fi
HISTSIZE=5000
SAVEHIST=5000
HISTORY_IGNORE='(ls|cd|pwd|exit|cd *|..)'
setopt share_history
setopt histignorealldups

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# Directory options
setopt auto_cd
setopt cdable_vars

# No match
set nonomatch
set nomatch

# Color
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Alias
alias ll='ls -la'
alias la='ls -a'
alias mv='mv -i'
alias rm='rm -i'
alias ps='ps --sort=start_time'
alias df='df -h'
alias free='free -m'
alias vi=nvim
alias vim=nvim
alias svim=sudoedit
alias ping='ping -c 5'
alias aria2='aria2c -s 16 -x 16'
if command -v prime-run > /dev/null; then
    alias ffmpeg='prime-run ffmpeg'
fi
#alias restartshell='plasmashell --replace &; disown'
alias killuser='pkill -KILL -u $USER'

# Directory variables
personal='/mnt/DATA'

# Custom commands
function mkcd() {
    if [[ -d $1 ]]; then
        print -P "zsh: \"$1\" already exists!"
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

function srm() {
    if read -q "choice?zsh: sure you want to secure delete \"$1\"?"; then
        shred -u $1
    else
        return 1
    fi
}

function restartshell() {
    if command -v plasmashell > /dev/null; then
        plasmashell --replace & disown
    else
        print "zsh: command not supported in this environment!"
    fi
}

# Custom functions
function command_not_found_handler {
    if command -v pacman > /dev/null; then
        local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
        printf 'zsh: command not found: %s\n' "$1"
        local entries=(
            ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
        )
        if (( ${#entries[@]} )); then
            printf "${bright}$1${reset} may be found in the following packages:\n"
            local pkg
            for entry in "${entries[@]}"; do
                # (repo package version file)
                local fields=(
                    ${(0)entry}
                )
                if [[ "$pkg" != "${fields[2]}" ]]; then
                    printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
                fi
                printf '    /%s\n' "${fields[4]}"
                pkg="${fields[2]}"
            done
        fi
        return 127
    fi
}

function clear-screen-scrollback() {
    echoti civis >"$TTY"
    printf '%b' '\e[H\e[2J' >"$TTY"
    zle .reset-prompt
    zle -R
    printf '%b' '\e[3J' >"$TTY"
    echoti cnorm >"$TTY"
}
zle -N clear-screen-scrollback
bindkey '^L' clear-screen-scrollback
