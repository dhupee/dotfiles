# Base path for scoop configs
$basePath   = Join-Path $HOME '.local\share\chezmoi\mutable-configs\scoop'

# Per-machine subfolder
$targetPath = Join-Path $basePath $env:COMPUTERNAME
$fullPath   = Join-Path $targetPath 'scoop-export.json'

# Create the per-machine directory if it doesn't exist
if (-not (Test-Path $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
}

# Run the export and only write if it succeeded and produced output
$json = scoop export
if ($LASTEXITCODE -eq 0 -and $json) {
    $json | Out-File -FilePath $fullPath -Encoding utf8
    Write-Host "Scoop export completed: $fullPath"
} else {
    Write-Error "scoop export failed; file not overwritten."
}
