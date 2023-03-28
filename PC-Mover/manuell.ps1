Import-Module ActiveDirectory

# Get base OU
$ou = "OU=Installed,OU=Computers,OU=000,OU=TUCS-LABOR,DC=wzs,DC=tum,DC=de"
# Get PC in OU

$PC = Get-ADComputer -SearchBase $ou -Filter * | Select-Object -ExpandProperty Name

def run (if ($PC -eq $null -and $PC -gt 1) {
    
    #Find Professour OU
    if ($PC -match '^[^-]+-') {
        $profname = $matches[0] -replace '-',''
        Write-Host "Der Computernamen lautet: $profname"
    } else { 
        Write-Host "Ung�ltiger Computernamen"
    }

    #Find PCGroup OU
    if ($PC -match '-[^-]+') {
        $PCGroup = $matches[0] -replace '-',''
        Write-Host "Der Computernamen lautet: $PCGroup"
    } else {
        Write-Host "Ung�ltiger Computernamen"
    }

    #Finde OU für PC
    $MoveOU = "OU=$PCGroup,OU=Computers,OU=$profname,OU=TUCS-LABOR,DC=wzs,DC=tum,DC=de"

    $PCOU = Get-ADComputer -SearchBase $ou -Filter *

    Move-ADObject -Identity $PCOU -TargetPath $MoveOU

})

#Run Script every 5 Minutes
while ($true) {
    run
    Start-Sleep -Seconds 300
}