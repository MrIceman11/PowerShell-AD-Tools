Import-Module ActiveDirectory

# Set the number of days to check for inactive users
$InactiveDays = 90

# Get the current date and time
$CurrentDate = Get-Date

# Get all users in Active Directory
$Users = Get-ADUser -Filter *

# Loop through each user and check if they have been inactive for more than $InactiveDays
foreach ($User in $Users) {
    if (($CurrentDate - $User.LastLogonDate).Days -ge $InactiveDays) {
        # If the user has been inactive for more than $InactiveDays, delete them
        Write-Host "Deleting inactive user $($User.SamAccountName)"
        Remove-ADUser $User -Confirm:$false
    }
}