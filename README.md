# PowerShell-AD-Tools

This is a collection of Powershell scripts to manage your AD Infrastructure

# Scripts

### Empty-Group-Clean

This scirpt will remove all groups that have no members in them. This is useful for cleaning up AD after a migration or other event that may have left empty groups behind.
#
### Old-PC-Clean

This script will remove all computers that have not been seen in the last 30 days. This is useful for cleaning up AD after a migration or other event that may have left old computers behind.
#
### Old-User-Clean

This script will remove all users that have not logged in for the last 30 days. This is useful for cleaning up AD after a migration or other event that may have left old users behind.
#
### PC-Logins

This script will list all computer in a given OU and saved the last login time to a CSV file. This is useful for auditing computers that have not been used in a while.
#
### PC-Mover

This script will move all new computers to a given OU. The OU is determined by the computer name.