# Parent Root Path
$ParentRootPath = Split-Path -Path $PSScriptRoot -Parent 

New-UDPage -Name "Report Page" -Content {
    # Grids
    $ADComputerGrid = New-UdGrid -Title "AD Computers" -Endpoint {
        get-adcomputer -Filter * -properties OperatingSystem | Select-Object -Property name, OperatingSystem, DistinguishedName | Out-UDGridData
    } 

    $ADUserGrid = New-UdGrid -Title "AD Users" -Endpoint {
        Get-ADUser -Filter * -Properties Department, whenchanged | Select-Object -Property Name, GivenName, Surname, whenchanged, Department, DistinguishedName | Where-Object {$_.Surname -ne $null} | Out-UDGridData
    } 

    $DNSGrid = New-UdGrid -Title "DNS Records" -Endpoint {
        Invoke-Command -ComputerName dc01 -ScriptBlock {Get-DnsServerResourceRecord -ZoneName "ps.local" } | Select-Object -property RecordType, hostname | Out-UDGridData
    } 
    $WelcomeCard = New-udcard -Title "Welcome to the reports page" -Content {
        New-UDParagraph -Text "This page provides reports on active directory users, computers and DNS records"
    }

    New-UDLayout -Columns 1 -Content {
        $WelcomeCard
        $ADComputerGrid
        $ADUserGrid
        $DNSGrid
    }

}