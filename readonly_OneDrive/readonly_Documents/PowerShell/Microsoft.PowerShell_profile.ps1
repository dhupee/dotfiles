# POWERSHELL PROFILE

# Load PSReadLine (autocomplete, syntax highlight)
Import-Module PSReadLine -ErrorAction SilentlyContinue

# PSReadLine History Substring Search
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PSReadLine Syntax Highlighting + Prediction
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{
    Command        = 'Cyan'
    Parameter      = 'Yellow'
    String         = 'Green'
    Operator       = 'Gray'
    Number         = 'Magenta'
    Variable       = 'White'
    InlinePrediction = 'DarkGray'
}

