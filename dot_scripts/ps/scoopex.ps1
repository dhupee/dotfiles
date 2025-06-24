# Define target path and filename
$targetPath = Join-Path $HOME '.local\share\chezmoi\mutable-configs\scoop'
$filename = 'scoop-export.json'
$fullPath = Join-Path $targetPath $filename

# Check if the directory exists
if (Test-Path $targetPath) {
    scoop export | Out-File -FilePath $fullPath -Encoding utf8
    Write-Host "Scoop export completed: $fullPath"
} else {
    Write-Host "Target path does not exist: $targetPath"
}
