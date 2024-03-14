# dotfiles

My configuration files and scripts for Windows and Linux.

![screenshot](./docs/screenshot.png)

[![OS:Linux](https://img.shields.io/badge/OS-Linux-blue?style=flat-square&logo=linux)](https://kernel.org)
[![OS:Windows](https://img.shields.io/badge/OS-Windows-blue?style=flat-square&logo=windows11)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-BSD%20Zero%20Clause-red?style=flat-square&)](./LICENSE)

### Targets

- aria2
- fontconfig
- git
- mpv
- nvim
- pwsh (PowerShell)
- vim
- vscode (Visual Studio Code)
- zsh

### Quick setup

#### Linux

> [!NOTE]
> For now, there is only a Linux version of the quick install script.

```
$ ./install.sh
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

### License

This project is licensed under the __BSD Zero Clause License__ - See the [LICENSE](./LICENSE) file for more details.
