# Domain_Password_Spray

**Description**

`Domain_Password_Spray.ps1` is a powerful PowerShell script designed for Red Teaming activities. It reads a list of usernames from a file and verifies their credentials using a specified password. If the credentials are valid, it prints a message indicating that the username has been "pwned" in green color and saves the output messages to a specified text file.

This script can help Red Teaming efforts by spraying a password to every domain user in the organization, identifying accounts that use the same password. It's crafted to bypass Antivirus and EDR solutions, making it a valuable tool in your security testing toolkit.

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



