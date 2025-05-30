# Domain_Password_Spray

**Description**

`Domain_Password_Spray.ps1` is a PowerShell script that checks a list of usernames against a single supplied password to identify potentially compromised (or "pwned") accounts. It’s useful for detecting weak password reuse across accounts in environments like Active Directory.

The script supports:
`Resume capability`: Automatically keeps track of progress so it can resume from where it left off.
`Throttling`: Adds a delay between each authentication attempt to avoid account lockouts or throttling by the authentication system.
`Output logging`: Stores all successfully authenticated (pwned) usernames in a specified output file.

⚠️ `Use responsibly`. This tool should only be used for authorized auditing and security testing within your own infrastructure.

**Features**

- Reads a list of usernames from a file.

- Verifies credentials using a single password.

- Prints a message in green if the credentials are valid.

- Saves output messages to a specified text file.

- Introduces a delay between attempts to avoid triggering account lockouts.

**Parameters**

- UserListFilePath: The path to the file containing the list of usernames.

- Password: The password to verify the credentials.

- OutputFilePath (optional): The path to the output file where results will be saved. Default is output.txt.

- DelayBetweenAttempts (optional): The delay in seconds between attempts to avoid triggering account lockouts. Default is 2 seconds.

**Usage**
1. Create a text file with a list of usernames (one username per line), for example, usernames.txt:
  - user1
  - user2
  - user3

2. Run the PowerShell script with the file path, password, and optional output file path as parameters:
  > PowerShell -ExecutionPolicy Bypass -File .\Domain_Password_Spray.ps1 -UserListFilePath "path\to\usernames.txt" -Password "your_password" -OutputFilePath "path\to\output.txt"

OR 

  > PowerShell -ExecutionPolicy Bypass

  > .\Domain_Password_Spray.ps1 -UserListFilePath "C:\Users\YourUser\Documents\usernames.txt" -Password "your_password" -OutputFilePath "C:\Users\YourUser\Documents\output.txt"



