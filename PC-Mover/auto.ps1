Import-Module ActiveDirectory

# Define function to move PC to target OU
function Move-PC {
    # Get base OU
    $ou = "OU=Installed,OU=Computers,OU=000,OU=TUCS-LABOR,DC=wzs,DC=tum,DC=de"
    # Get PC in OU
    $PC = Get-ADComputer -SearchBase $ou -Filter * | Select-Object -ExpandProperty Name

    if ($PC -eq $null -and $PC -gt 1) {

        #Find Professor OU
        if ($PC -match '^[^-]+-') {
            $profname = $matches[0] -replace '-',''
            Write-Host "Professour OU: $profname"
        } else { 
            Write-Host "Ungültiger Computernamen"
            return
        }

        #Find PCGroup OU
        if ($PC -match '-[^-]+') {
            $PCGroup = $matches[0] -replace '-',''
            Write-Host "PCGroup: $PCGroup"
        } else {
            Write-Host "Ungültiger Computernamen"
            return
        }

        #Finde OU fÃ¼r PC
        $MoveOU = "OU=$PCGroup,OU=Computers,OU=$profname,OU=TUCS-LABOR,DC=wzs,DC=tum,DC=de"

        $PCOU = Get-ADComputer -SearchBase $ou -Filter "Name -eq '$PC'"

        Move-ADObject -Identity $PCOU -TargetPath $MoveOU
    } else {Write-Host "Kein oder zu viele PCs gefunden!"}

}

# Run function once and then every 5 minutes
Move-PC
while ($true) {
    Start-Sleep -Seconds 300
    Move-PC
}