# chezmoi-add.ps1

# STATUS: OPERATIONAL

# Hardcoded arrays
$filePaths = @(
    "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
    "$env:LOCALAPPDATA\lazygit\config.yml",
    "$HOME\.gitconfig"
    "$PROFILE"
)

# $dirPaths = @(
#     "C:\Users\you\AppData\Roaming\alacritty"
# )

# $encryptedFilePaths = @(
#     "C:\Users\you\.ssh\config"
# )

# $encryptedDirPaths = @(
#     "$HOME\.ssh"
# )

function Add-ToChezmoi {
    param (
        [string[]]$Paths,
        [string]$Type,
        [switch]$Encrypt
    )

    if (-not $Paths -or $Paths.Count -eq 0) {
        Write-Host "Skipping $Type{} No paths"
        return
    }

    foreach ($path in $Paths) {
        if (-not (Test-Path $path)) {
            Write-Host "Skipping missing $Type path: $path"
            continue
        }

        $quotedPath = '"' + $path + '"'
        if ($Encrypt) {
            Write-Host "Encrypting and adding $Type{} $path"
            chezmoi add --encrypt -- $path
        } else {
            Write-Host "Adding $Type{} $path"
            chezmoi add -- $path
        }
    }
}

# Process each group
Add-ToChezmoi -Paths $filePaths -Type "File"
Add-ToChezmoi -Paths $dirPaths -Type "Directory"
Add-ToChezmoi -Paths $encryptedFilePaths -Type "Encrypted File" -Encrypt
Add-ToChezmoi -Paths $encryptedDirPaths -Type "Encrypted Directory" -Encrypt

