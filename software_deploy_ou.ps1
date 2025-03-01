# for creating "software deploy" OU on ad01

# variables
$domain = "rune"
$domainType = "local"
$ouName = "Software Deploy"
$userName = "Rune Seregina"
$computerName = "wks01-rune"

# create new OU
New-AdOrganizationalUnit -Name $ouName -Path "DC=$domain,DC=$domainType"

# move wks01-rune to new OU
Move-ADObject -Identity "CN=$computerName, CN=Computers,DC=$domain,DC=$domainType" -TargetPath "OU=$ouName,DC=$domain,DC=$domainType"

# move named user to new OU
Move-ADObject -Identity "CN=$userName,CN=Users,DC=$domain,DC=$domainType" -TargetPath "OU=$ouName,DC=$domain,DC=$domainType"

# delete test OU

Set-ADOrganizationalUnit -Identity "OU=Test OU,DC=$domain,DC=$domainType" -ProtecedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity "OU-Test OU,DC=$domain,DC=$domainType" -Confirm:$false

Write-Host "Success!"