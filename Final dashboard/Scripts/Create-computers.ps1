# Get list of OSs
$ComputerOSList = Get-Content $PSScriptRoot\ComputerOSlist.txt
# Limits the number of computers created
$limit = 200
# Create computers with a random OS
for($i=0;$i -lt $limit;$i++){
    #Pick Random OS
    $RandomComputerOS = $ComputerOSList[(Get-Random -Minimum 0 -Maximum $ComputerOSList.Count)]
    # Create computer
    New-ADComputer -Name "$RandomComputerOS-$i" -Path "OU=GeneratedComputers,DC=PS,DC=local"
    # Set OS of the computer object
    get-adcomputer -Identity "$RandomComputerOS-$i" | set-adcomputer -OperatingSystem $RandomComputerOS
}
