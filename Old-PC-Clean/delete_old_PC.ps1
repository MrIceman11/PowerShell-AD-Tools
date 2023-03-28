Import-Module ActiveDirectory

# Set parameters
$ou = "OU=Computers,OU=MyCompany,DC=MyCompany,DC=local"
$maxAgeDays = 90

# Get current date
$now = Get-Date

# Get computers in OU
$computers = Get-ADComputer -SearchBase $ou -Filter * -Properties LastLogonTimeStamp

# Loop through each computer
foreach ($computer in $computers) {
    # Check if computer has a last logon timestamp
    if ($computer.LastLogonTimeStamp) {
        # Calculate number of days since last logon
        $lastLogon = [DateTime]::FromFileTime($computer.LastLogonTimeStamp)
        $age = ($now - $lastLogon).Days
        
        # Check if computer is older than max age
        if ($age -ge $maxAgeDays) {
            # Delete computer
            Write-Host "Deleting computer $($computer.Name) (last logon $lastLogon)"
            Remove-ADObject -Identity $computer -Recursive -Confirm:$false
        }
    }
}