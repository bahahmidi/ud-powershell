#$ParentRootPath = Split-Path -Path $PSScriptRoot -Parent 

$FirstNames = Get-Content  $PSScriptRoot\FirstNames.txt
$LastNames = Get-Content  $PSScriptRoot\LastNames.txt
$Departments = Get-Content  $PSScriptRoot\Departments.txt
$char = Get-Content  $PSScriptRoot\char.txt
$Userlimit = 300
$PasswordCharacterLimit = 30
$Firstname = $FirstNames[(Get-Random -Minimum 0 -Maximum $FirstNames.Count)]
$LastName = $LastNames[(Get-Random -Minimum 0 -Maximum $LastNames.Count)]


for($i=0; $i -le $Userlimit; $i++){
    $Firstname = $FirstNames[(Get-Random -Minimum 0 -Maximum $FirstNames.Count)]
    $LastName = $LastNames[(Get-Random -Minimum 0 -Maximum $LastNames.Count)]
    $Department = $Departments[(Get-Random -Minimum 0 -Maximum $Departments.Count)]
    Write-Host "$Firstname $lastname"
    $username = $lastname + $FirstName[0]
    $Password = ""
    for($j=0; $j -le $PasswordCharacterLimit; $j++){
        $Password = $Password + $char[(Get-Random -Minimum 0 -Maximum ($char.Length))]
    }
    New-aduser -Name $username -Path "OU=GeneratedUsers,DC=PS,DC=local" -OtherAttributes @{'givenName' = $Firstname;'sn' = $LastName;'displayname'= "$FirstName $LastName";'department' = "$Department"}
    Set-ADAccountPassword -Identity $username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
    Enable-ADAccount -Identity $username
}