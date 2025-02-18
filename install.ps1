#Requires -Version 7.0

# Copyright (c) cyberyurei2000 2023-2025
# Released under the 0BSD License
# https://opensource.org/license/0bsd

$Dir = [Environment]::CurrentDirectory

$AppData = [Environment]::GetFolderPath('ApplicationData')
$LocalAppData = [Environment]::GetFolderPath('LocalApplicationData')
$Temp = $env:TEMP
$IsDiskC = $Dir | Select-String -Pattern "C:"

function Set-Aria2 {
    $File = New-Item -Path "$HOME" -Name ".aria2" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    $File = New-Item -Path "$HOME" -Name ".cache" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    $Aria2ConfigPath = "$HOME\.aria2"

    if($null -ne $IsDiskC) {
        New-Item -Path "$Aria2ConfigPath" -Name "aria2.conf" -ItemType "HardLink" -Target "$Dir\config\aria2\aria2.conf" -Force
    } else {
        Copy-Item -Path "$Dir\config\aria2\aria2.conf" -Destination "$Aria2ConfigPath\aria2.conf" -Force
    }
}

function Set-Git {
    $File = New-Item -Path "$HOME" -Name ".config" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    New-Item -Path "$HOME\.config" -Name "git" -ItemType "Directory" -Force
    $GitConfigPath = "$HOME\.config\git"

    if($null -ne $IsDiskC) {
        New-Item -Path "$GitConfigPath" -Name "config" -ItemType "HardLink" -Target "$Dir\config\git\gitconfig" -Force
        New-Item -Path "$GitConfigPath" -Name "ignore" -ItemType "HardLink" -Target "$Dir\config\git\gitignore" -Force
    } else {
        Copy-Item -Path "$Dir\config\git\gitconfig" -Destination "$GitConfigPath\config" -Force
        Copy-Item -Path "$Dir\config\git\gitignore" -Destination "$GitConfigPath\ignore" -Force
    }
}

function Set-Mpv {
    New-Item -Path "$AppData" -Name "mpv" -ItemType "Directory" -Force
    New-Item -Path "$AppData\mpv" -Name "script-opts" -ItemType "Directory" -Force
    $MpvConfigPath = "$AppData\mpv"
    $MpvOptsPath = "$MpvConfigPath\script-opts"

    if($null -ne $IsDiskC) {
        New-Item -Path "$MpvConfigPath" -Name "mpv.conf" -ItemType "HardLink" -Target "$Dir\config\mpv\mpv_windows.conf" -Force
        New-Item -Path "$MpvConfigPath" -Name "input.conf" -ItemType "HardItem" -Target "$Dir\config\mpv\input.conf" -Force
        New-Item -Path "$MpvOptsPath" -Name "modernz.conf" -ItemType "HardLink" -Target "$Dir\config\mpv\script-opts\modernz_windows.conf" -Force
    } else {
        Copy-Item -Path "$Dir\config\mpv\mpv_windows.conf" -Destination "$MpvConfigPath\mpv.conf" -Force
        Copy-Item -Path "$Dir\config\mpv\input.conf" -Destination "$MpvConfigPath\input.conf" -Force
        Copy-Item -Path "$Dir\config\mpv\script-opts\modernz_windows.conf" -Destination "$MpvOptsPath\modernz.conf" -Force
    }
}

function Set-Nvim {
    New-Item -Path "$LocalAppData" -Name "nvim" -ItemType "Directory" -Force
    $NvimConfigPath = "$LocalAppData\nvim"

    if($null -ne $IsDiskC) {
        New-Item -Path "$NvimConfigPath" -Name "init.lua" -ItemType "HardLink" -Target "$Dir\config\nvim\init.lua" -Force
    } else {
        Copy-Item -Path "$Dir\config\nvim\init.lua" -Destination "$NvimConfigPath\init.lua" -Force
    }
}

function Set-Pwsh {
    New-Item -Path "$HOME\Documents" -Name "PowerShell" -ItemType "Directory" -Force
    $PwshConfigPath = "$HOME\Documents\PowerShell"

    if($null -ne $IsDiskC) {
        New-Item -Path "$PwshConfigPath" -Name "profile.ps1" -ItemType "HardLink" -Target "$Dir\config\pwsh\profile.ps1" -Force
    } else {
        Copy-Item -Path "$Dir\config\pwsh\profile.ps1" -Destination "$PwshConfigPath\profile.ps1" -Force
    }
}

function Set-Fastfetch() {
    $File = New-Item -Path "$HOME" -Name ".config" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    New-Item -Path "$HOME\.config" -Name "fastfetch" -ItemType "Directory" -Force
    $FetchConfigPath = "$HOME\.config\fastfetch"

    if($null -ne $IsDiskC) {
        New-Item -Path "$FetchConfigPath" -Name "config.jsonc" -ItemType "HardLink" -Target "$Dir\config\fastfetch\config.jsonc" -Force
    } else {
        Copy-Item -Path "$Dir\config\fastfetch\config.jsonc" -Destination "$FetchConfigPath\config.jsonc" -Force
    }
}

function Set-Ssh {
    $File = New-Item -Path "$HOME" -Name ".ssh" -ItemType "Directory" -Force
    $File.attributes = "Hidden"
    $SshConfigPath = "$HOME\.ssh"

    if(Test-Path -Path "$Dir\config\ssh\config_windows") {
        if($null -ne $IsDiskC) {
            New-Item -Path "$SshConfigPath" -Name "config" -ItemType "HardLink" -Target "$Dir\config\ssh\config_windows" -Force
        } else {
            Copy-Item -Path "$Dir\config\ssh\config_windows" -Destination "$SshConfigPath\config" -Force
        }
    } else {
        Write-Host "ERROR: Failed to setup SSH! Configuration file not found." -ForegroundColor "Red"
    }
}

function Set-MpvScripts {
    $MpvConfigPath = "$AppData\mpv"

    New-Item -Path "$MpvConfigPath" -Name "scripts" -ItemType "Directory" -Force
    New-Item -Path "$MpvConfigPath" -Name "fonts" -ItemType "Directory" -Force

    git clone "https://github.com/Samillion/ModernZ.git" "$Temp\ModernZ"
    Move-Item -Path "$Temp\ModernZ\modernz.lua" -Destination "$MpvConfigPath\scripts\" -Force
    Move-Item -Path "$Temp\ModernZ\fluent-system-icons.ttf" -Destination "$MpvConfigPath\fonts\" -Force

    git clone "https://github.com/po5/thumbfast.git" "$Temp\thumbfast"
    Move-Item -Path "$Temp\thumbfast\thumbfast.lua" -Destination "$MpvConfigPath\scripts\" -Force

    git clone "https://github.com/cyberyurei2000/mpv-osc-clock.git" "$Temp\mpv-osc-clock"
    Move-Item -Path "$Temp\mpv-osc-clock\scripts\osc-clock.lua" -Destination "$MpvConfigPath\scripts\" -Force
    Move-Item -Path "$Temp\mpv-osc-clock\fonts\FO-TVASAHI-GMorning.otf" -Destination "$MpvConfigPath\fonts\" -Force

    git clone "https://github.com/occivink/mpv-gallery-view.git" "$Temp\mpv-gallery-view"
    Move-Item -Path "$Temp\mpv-gallery-view\scripts\*" -Destination "$MpvConfigPath\scripts\" -Force
    Copy-Item -Path "$Temp\mpv-gallery-view\script-modules\" -Destination "$MpvConfigPath\" -Recurse -Force
}

Set-Aria2
Set-Git
Set-Mpv
Set-Nvim
Set-Pwsh
Set-Fastfetch
Set-Ssh
Set-MpvScripts
