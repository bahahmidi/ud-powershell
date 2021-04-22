$ParentRootPath = Split-Path -Path $PSScriptRoot -Parent 
#. "$ParentRootPath\Scripts\Get-DCStatus.ps1"

$FirstNames = Get-Content $ParentRootPath\scripts\FirstNames.txt
$LastNames = Get-Content $ParentRootPath\scripts\LastNames.txt
$Departments = Get-Content $ParentRootPath\scripts\Departments.txt
$char = Get-Content $ParentRootPath\scripts\char.txt
$Userlimit = 10
$PasswordCharacterLimit = 30
$Firstname = $FirstNames[(Get-Random -Minimum 0 -Maximum $FirstNames.Count)]
$LastName = $LastNames[(Get-Random -Minimum 0 -Maximum $LastNames.Count)]


for($i=0; $i -le $Userlimit; $i++){
    $Firstname = $FirstNames[(Get-Random -Minimum 0 -Maximum $FirstNames.Count)]
    $LastName = $LastNames[(Get-Random -Minimum 0 -Maximum $LastNames.Count)]
    $Department = $Departments[(Get-Random -Minimum 0 -Maximum $Departments.Count)]
    Write-Host "$Firstname $lastname"
    $username = $lastname + $FirstName[0]
    for($i=0; $i -le $PasswordCharacterLimit; $i++){
        $Password = $Password + $char[(Get-Random -Minimum 0 -Maximum ($char.Length))]
    }
    New-aduser -Name $username -OtherAttributes @{'givenName' = $Firstname;'sn' = $LastName;'displayname'= "$FirstName $LastName";'department' = "$Department"}
    Set-ADAccountPassword -Identity $username -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
    Enable-ADAccount -Identity $username
}




<#
$letters = {}.Invoke()
$c = Get-Content "C:\Users\ps\OneDrive\Documents\Udemy Class\Dashboard Class\Scripts\characters.txt"
for($i=0; $i -le $c.Length; $i++){
    $letters.add($c[$i])
}
$letters | Out-File "C:\Users\ps\OneDrive\Documents\Udemy Class\Dashboard Class\Scripts\char.txt"
#>