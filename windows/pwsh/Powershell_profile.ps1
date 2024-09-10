Import-Module PSReadLine

Enable-PowerType
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

oh-my-posh init pwsh --config 'C:/Users/irad/irad.omp.json' | Invoke-Expression

Import-Module PSFzf
Set-PsFzfOption -PSReadLineChordProvider ‘Ctrl+f’ -PSReadLineChordReverseHistory ‘Ctrl+r’

Import-Module git-aliases -DisableNameChecking

Import-Module posh-git

function Switch-GitBranch {
    $branch = git branch --all | ForEach-Object { $_.Substring(2) } | fzf |  ForEach-Object { $_ -replace 'remotes/origin/', '' }
    if ($branch) {
        git switch $branch
    }
}

function Delete-GitBranch {
    $branch = git branch | ForEach-Object { $_.Substring(2) } | fzf |  ForEach-Object { $_ -replace 'remotes/origin/', '' }
    if ($branch) {
        git branch -D $branch
    }
}
