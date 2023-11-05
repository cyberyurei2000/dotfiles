export EDITOR=nvim

# Fcitx5
export INPUT_METHOD=fcitx5
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5

# OpenJDK
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Nvidia
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME"/nv

# GTK 2.0
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Wine
export WINEPREFIX=~/.local/share/wine/default

# Firefox
MOZ_ENABLE_WAYLAND=1

