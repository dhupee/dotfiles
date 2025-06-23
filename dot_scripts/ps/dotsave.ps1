# chezmoi-add.ps1

# STATUS: UNUSED

# Hardcoded arrays
$filePaths = @(
    "C:\Users\you\.gitconfig",
    "C:\Users\you\AppData\Roaming\nvim\init.lua"
)

$dirPaths = @(
    "C:\Users\you\AppData\Roaming\alacritty"
)

$encryptedFilePaths = @(
    "C:\Users\you\.ssh\config"
)

$encryptedDirPaths = @(
    "C:\Users\you\AppData\Roaming\gopass"
)

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

