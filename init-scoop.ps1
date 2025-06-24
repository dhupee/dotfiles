Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Invoke-RestMethod get.scoop.sh -OutFile 'install-scoop.ps1'

# Uncomment and edit the following line to specify a custom Scoop install directory
# $TARGET_PATH = 'D:\Applications\Scoop'

if (-not $TARGET_PATH) {
    Write-Host "No custom path set. Running default install."
    powershell -ExecutionPolicy Bypass -File .\install-scoop.ps1
} else {
    Write-Host "Custom path detected: $TARGET_PATH"
    powershell -ExecutionPolicy Bypass -File .\install-scoop.ps1 -ScoopDir $TARGET_PATH
}
