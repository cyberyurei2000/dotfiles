Set-Alias -Name touch -Value New-Item
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim

function mkcd {
    Param ($Directory)

    New-Item -Type Directory -Path $Directory
    Set-Location -Path $Directory
}
