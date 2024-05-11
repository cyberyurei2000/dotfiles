# dotfiles

My configuration files and scripts for Windows and Linux.

### Targets

- aria2
- fastfetch
- fontconfig
- git
- mpv
- nvim
- pwsh (PowerShell 7)
- vim
- vscode (Visual Studio Code)
- zsh

### Quick setup

#### Linux

```
$ ./install.sh
```

#### Windows

This script only suports PowerShell version 7 or above.

```
> ./install.ps1
```

If you want to disable the configuration of a specific target, simply comment out the function call at the end of the install script.

```sh
...
setup_aria2
setup_fontconfig
setup_git
#setup_mpv
setup_nvim
setup_zsh
#setup_mpv_scripts
#setup_nvim_theme
```

### Screenshots

![screenshot](./docs/screenshot_linux.png)

![screenshot](./docs/screenshot_windows.png)

### License

This project is licensed under the __BSD Zero Clause License__ - See the [LICENSE](./LICENSE) file for more details.
