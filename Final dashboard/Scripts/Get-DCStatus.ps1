Class DCStatusClass{
    $name
    $ip
    $online
}
# Collection of results
$Results = {}.Invoke()

# Get All DCs
$DCinfo = Get-ADDomainController

# Check if online
Foreach($item in $DCinfo){
    $Result = [DCStatusClass]::new()
    $Result.name = $item.hostname
    $Result.IP = $item.IPv4Address
    # If online
    If(Test-Connection -Quiet -Count 2 $item.IPv4Address){
        $Result.Online = New-UDElement -Tag 'div' -Attributes @{ style = @{ 'backgroundColor' = 'green'; 'color' = 'white'}  } -Content {"True"}
    }
    # If offline
    else{
        $Result.Online = New-UDElement -Tag 'div' -Attributes @{ style = @{ 'backgroundColor' = 'red'; 'color' = 'white'}  } -Content {"False"}
    }
    
    $Results.Add($Result)
}

return $Results