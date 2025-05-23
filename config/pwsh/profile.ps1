#Requires -Version 7.0

# Variables
$Identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$Principal = New-Object Security.Principal.WindowsPrincipal $Identity
$IsAdmin = $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# PROMPT
function Prompt {
    #$Domain = $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)
    $Path = $(Get-Location)
    $Path_arr = $Path.path.Split("\")
    if($Path_arr.count -gt 4) {
        $Path = @($Path_arr[0], "..." + $Path_arr[-3,-2,-1]) -join "\"
    }
    $Explorer = $(Get-Process -Name explorer -ErrorAction SilentlyContinue)

    if($IsAdmin) {
        if(!$Explorer) {
            Write-Host $(Get-Date -Format "[HH:mm] ") -NoNewline
        }
        #Write-Host $($Domain + " ") -ForegroundColor "DarkCyan" -NoNewline
        Write-Host $($Path) -NoNewline
        return " #> "
    } else {
        if(!$Explorer) {
            Write-Host $(Get-Date -Format "[HH:mm] ") -NoNewline
        }
        #Write-Host $($Domain + " ") -ForegroundColor "DarkCyan" -NoNewline
        Write-Host $($Path) -NoNewline
        return " ¥> "
    }
}

# Options
Set-PSReadLineOption -PredictionSource None -ErrorAction SilentlyContinue
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

# Colors
$PSStyle.FileInfo.Directory = "`e[36m"

# Autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Shortcuts
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name aria2 -Value aria2c
Remove-Item Alias:curl -ErrorAction SilentlyContinue
Remove-Item Alias:wget -ErrorAction SilentlyContinue
Remove-Item Alias:mkdir -ErrorAction SilentlyContinue

# Custom commands
function ll([String]$Path) {
    if($Path -eq "") {
        $Path = "."
    }
    Get-ChildItem -Path $Path -Force | Format-Table -AutoSize
}

function mkdir([String]$Path) {
    $File = New-Item -Path $Path -ItemType "Directory"
    if(Test-Path -Path $Path) {
        if($Path[0] -eq ".") {
            $File.attributes = "Hidden"
        }
    }
}

function mkcd([String]$Path) {
    if(Test-Path -Path $Path) {
        Write-Host "pwsh: \"$Path\" already exists!" -ForegroundColor "Yellow"
        Set-Location -Path $Path
    } else {
        $File = New-Item -Path $Path -ItemType "Directory"
        if(Test-Path -Path $Path) {
            if($Path[0] -eq ".") {
                $File.attributes = "Hidden"
            }
            Set-Location -Path $Path
        }
    }
}

function touch([String]$Path) {
    $File = New-Item -Path $Path -ItemType "File"
    if(Test-Path -Path $Path) {
        if($Path[0] -eq ".") {
            $File.attributes = "Hidden"
        }
    }
}

function .. {
    Set-Location -Path ..
}

function grep([String]$Regex, [String]$Path) {
	if($Path) {
		Get-ChildItem $Path | Select-String $Regex
		return
	}
	$Input | Select-String $Regex
}

function activate {
    $VenvPath = ".\.venv\Scripts\Activate.ps1"
    if(Test-Path -Path $VenvPath) {
        $VenvPath
    } else {
        Write-Host "pwsh: python environment not found!" -ForegroundColor "Red"
    }
}

function rcp([String]$Path, [String]$TargetPath) {
    $ParentPath = Split-Path (Get-Item $Path) -Parent
    $File = Split-Path (Get-Item $Path) -Leaf
    Robocopy.exe $ParentPath $TargetPath $File //mt //z
}

function restartshell {
    Stop-Process -ProcessName explorer
}

function killexplorer {
    taskkill /F /IM explorer.exe
}

function df {
    Get-Volume
}

function pkill([String]$Name) {
    Get-Process $Name -ErrorAction SilentlyContinue | Stop-Process
}

function md5sum {
    Get-FileHash -Algorithm MD5 $Args
}

function sha1sum {
    Get-FileHash -Algorithm SHA1 $Args
}

function sha256sum {
    Get-FileHash -Algorithm SHA256 $Args
}

function sysinfo {
    Write-Host ""
    fastfetch && Write-Host ""
}
