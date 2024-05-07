# Windows Admin
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# PROMPT
function prompt {
    $path = $(Get-Location)
    $path_arr = $path.path.Split("\")
    if ($path_arr.count -gt 4) {
        $path = @($path_arr[0], "..." + $path_arr[-3,-2,-1]) -join "\"
    }

    if($isAdmin) {
        "PS " + $path + " #> "
    } else {
        "PS " + $path + " ¥> "
    }
}

# Options
Set-PSReadLineOption -PredictionSource None -ErrorAction SilentlyContinue

# Colors
#$PSStyle.FileInfo.Directory = "`e[38;2;255;255;255m"
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

# Custom commands
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function mkcd($file) {
    New-Item -Type Directory -Path $file
    Set-Location -Path $file
}

function pwd {
    [Environment]::CurrentDirectory
}

function .. {
    Set-Location -Path ..
}

function grep($regex, $dir) {
	if($dir) {
		Get-ChildItem $dir | Select-String $regex
		return
	}

	$input | Select-String $regex
}

function df {
    Get-Volume
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function md5sum {
    Get-FileHash -Algorithm MD5 $args
}

function sha1sum {
    Get-FileHash -Algorithm SHA1 $args
}

function sha256sum {
    Get-FileHash -Algorithm SHA256 $args
}
