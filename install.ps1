# Copyright (c) cyberyurei2000 2023-2024
# Released under the 0BSD License
# https://opensource.org/license/0bsd

$Dir = [Environment]::CurrentDirectory

$AppData = [Environment]::GetFolderPath('ApplicationData')
$LocalAppData = [Environment]::GetFolderPath('LocalApplicationData')
$IsDiskC = $Dir | Select-String -Pattern "C:"

function Setup-Aria2 {
    $File = New-Item -Path "$HOME" -Name ".aria2" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    $File = New-Item -Path "$HOME" -Name ".cache" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    $Aria2ConfigPath = "$HOME\.aria2"

    if($IsDiskC -ne $null) {
        New-Item -Path "$Aria2ConfigPath" -Name "aria2.conf" -ItemType "HardLink" -Target "$Dir\config\aria2\aria2.conf" -Force
    } else {
        Copy-Item -Path "$Dir\config\aria2\aria2.conf" -Destination "$Aria2ConfigPath\aria2.conf" -Force
    }
}

function Setup-Git {
    $File = New-Item -Path "$HOME" -Name ".config" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    New-Item -Path "$HOME\.config" -Name "git" -ItemType "Directory" -Force
    $GitConfigPath = "$HOME\.config\git"

    if($IsDiskC -ne $null) {
        New-Item -Path "$GitConfigPath" -Name "config" -ItemType "HardLink" -Target "$Dir\config\git\gitconfig" -Force
    } else {
        Copy-Item -Path "$Dir\config\git\gitconfig" -Destination "$GitConfigPath\config" -Force
    }
}

function Setup-Mpv {
    New-Item -Path "$AppData" -Name "mpv" -ItemType "Directory" -Force
    $MpvConfigPath = "$AppData\mpv"

    if($IsDiskC -ne $null) {
        New-Item -Path "$MpvConfigPath" -Name "mpv.conf" -ItemType "HardLink" -Target "$Dir\config\mpv\mpv.conf" -Force
    } else {
        Copy-Item -Path "$Dir\config\mpv\mpv.conf" -Destination "$MpvConfigPath\mpv.conf" -Force
    }
}

function Setup-Nvim {
    New-Item -Path "$LocalAppData" -Name "nvim" -ItemType "Directory" -Force
    $NvimConfigPath = "$LocalAppData\nvim"

    if($IsDiskC -ne $null) {
        New-Item -Path "$NvimConfigPath" -Name "init.vim" -ItemType "HardLink" -Target "$Dir\config\nvim\init.vim" -Force
    } else {
        Copy-Item -Path "$Dir\config\nvim\init.vim" -Destination "$NvimConfigPath\init.vim" -Force
    }
}

function Setup-Pwsh {
    New-Item -Path "$HOME\Documents" -Name "PowerShell" -ItemType "Directory" -Force
    $PwshConfigPath = "$HOME\Documents\PowerShell"

    if($IsDiskC -ne $null) {
        New-Item -Path "$PwshConfigPath" -Name "profile.ps1" -ItemType "HardLink" -Target "$Dir\config\pwsh\profile.ps1" -Force
    } else {
        Copy-Item -Path "$Dir\config\pwsh\profile.ps1" -Destination "$PwshConfigPath\profile.ps1" -Force
    }
}

Setup-Aria2
Setup-Git
Setup-Mpv
Setup-Nvim
Setup-Pwsh
