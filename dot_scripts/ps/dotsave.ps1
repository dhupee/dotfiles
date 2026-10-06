## chezmoi-add.ps1

# STATUS: OPERATIONAL

# Fetch managed paths from chezmoi, split by encryption state,
# then re-add each one individually.

function Add-ManagedToChezmoi {
    param (
        [string]$Include,
        [string]$Exclude,
        [switch]$Encrypt
    )

    $chezmoiArgs = @('managed', '--path-style', 'absolute')
    if ($Include) { $chezmoiArgs += "--include=$Include" }
    if ($Exclude) { $chezmoiArgs += "--exclude=$Exclude" }

    $paths = & chezmoi @chezmoiArgs 2>$null

    if (-not $paths -or $paths.Count -eq 0) {
        Write-Host "No managed paths found (include=$Include exclude=$Exclude)"
        return
    }

    # Normalize: ensure it's always an array even for a single result
    $paths = @($paths)

    foreach ($path in $paths) {
        $path = "$path".Trim()
        if (-not $path) { continue }

        if (-not (Test-Path -LiteralPath $path)) {
            Write-Host "Skipping missing path: $path"
            continue
        }

        if ($Encrypt) {
            Write-Host "Encrypting and re-adding: $path"
            # chezmoi re-add --re-encrypt -- $path
            chezmoi re-add -- $path
        } else {
            Write-Host "Re-adding: $path"
            chezmoi re-add -- $path
        }
    }
}

# Process all non-encrypted managed entries
Add-ManagedToChezmoi -Exclude "encrypted"

# Process only encrypted managed entries
Add-ManagedToChezmoi -Include "encrypted" -Encrypt

