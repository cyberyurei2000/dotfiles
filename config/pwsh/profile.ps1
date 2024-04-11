# PROMPT
function prompt {
    $path = [Environment]::CurrentDirectory
    $path_arr = $path.path.Split("\")
    if ($path_arr.count -gt 4) {
        $path = @($path_arr[0], "..." + $path_arr[-3,-2,-1]) -join "\"
    }

    #"PS:$([Environment]::MachineName) " + $path + "¥> "
    "PS " + $path + " ¥> "
}

# Options
Set-PSReadLineOption -PredictionSource None -ErrorAction SilentlyContinue

# Colors
#$PSStyle.FileInfo.Directory = "`e[38;2;255;255;255m"
$PSStyle.FileInfo.Directory = "`e[36m"

# Alias
if ($PSVersionTable.Platform -eq "Win32NT") {
    Set-Alias -Name touch -Value New-Item
}
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim
Set-Alias -Name neofetch -Value winfetch

Remove-Item Alias:curl -ErrorAction SilentlyContinue

# Custom commands
function mkcd($dir) {
    New-Item -Type Directory -Path $dir
    Set-Location -Path $dir
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

function pwd {
    [Environment]::CurrentDirectory
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

function aria2 {
    aria2c -s 16 -x 16
}
