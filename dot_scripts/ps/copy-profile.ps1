# Hardcoded source file path (update this to your actual profile.ps1 location)
$sourceProfile = "$HOME\.config\powershell\profile.ps1"

# Target profile path (automatic PowerShell profile location)
$targetProfile = $PROFILE

# Create parent directory if it doesn't exist
$profileDir = Split-Path $targetProfile -Parent
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "Created directory: $profileDir"
}

# Check if source file exists
if (-not (Test-Path $sourceProfile)) {
    Write-Error "Source file not found: $sourceProfile" -ErrorAction Stop
}

# Copy file (overwrite if exists)
Copy-Item -Path $sourceProfile -Destination $targetProfile -Force
Write-Host "Copied profile:"
Write-Host "  From: $sourceProfile"
Write-Host "  To  : $targetProfile"
