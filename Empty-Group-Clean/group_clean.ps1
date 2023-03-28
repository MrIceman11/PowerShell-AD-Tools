Import-Module ActiveDirectory

$groups = Get-ADGroup -Filter * -Properties Members

foreach ($group in $groups) {
    $members = $group.Members

    if ($members.Count -eq 0) {
        Write-Host "Gruppe $($group.Name) hat keine Mitglieder und wird gelöscht"
        Remove-ADGroup $group.DistinguishedName
    }
}
