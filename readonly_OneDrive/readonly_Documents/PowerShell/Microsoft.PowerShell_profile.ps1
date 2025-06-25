# POWERSHELL PROFILE

# Init Starship Prompt
Invoke-Expression (&starship init powershell)

# Load PSReadLine (autocomplete, syntax highlight)
Import-Module PSReadLine -ErrorAction SilentlyContinue

# enable completion in current shell, use absolute path because PowerShell Core not respect $env:PSModulePath
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"

# PSReadLine History Substring Search
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PSReadLine Syntax Highlighting + Prediction
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{
    Command          = 'Cyan'
    Parameter        = 'Yellow'
    String           = 'Green'
    Operator         = 'Gray'
    Number           = 'Magenta'
    Variable         = 'White'
    InlinePrediction = 'DarkGray'
}

#==================FUNCTIONS & ALIASES==============================#
function dotsave {
    & "$HOME\.local\share\chezmoi\dot_scripts\ps\dotsave.ps1"
}
function lsa {
    param ($file, $n = 10)
    Get-Content $file -Head $n
}
function scoopex {
    & "$HOME\.local\share\chezmoi\dot_scripts\ps\scoopex.ps1"
}
function touch {
    param ($file)
    New-Item -ItemType File -Path $file -Force | Out-Null
}
function head {
    param ($file, $n = 10)
    Get-Content $file -Head $n
}
function tail {
    param ($file, $n = 10)
    Get-Content $file -Tail $n
}
function ssrm {
    Remove-Item -Recurse "$HOME\Pictures\Screenshots\*"
}

Set-Alias c Clear-Host
Set-Alias lg lazygit
Set-Alias which Get-Command

#===================================================================#

# Invoke Zoxide(MUST IN THE END)
$env:_ZO_DATA_DIR = "$HOME\.local\share\chezmoi\mutable-configs\zoxide\windows"
Invoke-Expression (& { (zoxide init powershell | Out-String) })

