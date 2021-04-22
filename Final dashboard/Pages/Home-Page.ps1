# Parent Root Path
$ParentRootPath = Split-Path -path $PSScriptRoot -Parent

New-UDPage -name "Home" -DefaultHomePage -Content{
    
    # Table
    $Table = New-UDTable -Title "Domain information" -Headers @(" ", " ") -Endpoint {
        $DomainInfo = Get-ADDomain
        $ForestInfo = Get-ADForest
        @{
            'Domain mode' = $DomainInfo.DomainMode.ToString()
        'Infrastructure Master' = $DomainInfo.InfrastructureMaster
        'RID Master' = $DomainInfo.RIDMaster
        'PDC Emulator' = $DomainInfo.PDCEmulator
        'Domain Naming Master' = $ForestInfo.DomainNamingMaster
        'Schema Master' = $ForestInfo.SchemaMaster
        }.GetEnumerator() | Out-UDTableData -Property @("Name", "Value")
    } 

    # Grid
    $DCGrid = New-UDGrid -Title "Domain controllers" -Headers @("Name","IP","STATUS") -Properties @("name" ,"ip","online") -Endpoint {
        # Collect results from script
        $results = . "$ParentRootPath\Scripts\Get-DCStatus.ps1"
        $results | Out-UDGridData
        
    }

    # OS pie chart
    $OSPiechart = New-UDChart -Type Pie -Title "Active Directory Computer OS Piechart"  -Endpoint {
        # To collect the results
        $results = {}.Invoke()
        # Computer OS list
        $OSList = get-content -path "$ParentRootPath\Scripts\ComputerOSList.txt"
        # TODO
        # Chart colors
        $ChartColors = "#037bfc", "#e00202", "#6FFF37"

        Class OSPieChartClass {
            $Name
            $Num
        }
        Foreach($OS in $OSList){
            $computers = Get-ADComputer -Filter * -Properties OperatingSystem | Where-Object {$_.Operatingsystem -eq $OS}
            $result = [OSPieChartClass]::new()
            $result.Name = $OS
            $result.Num = $computers.count
            $results.Add($result)
        }
        
        $Results | Out-UDChartData -LabelProperty "Name" -DataProperty "Num" -BackgroundColor $ChartColors
    }

    # Welcome Card
    $WelcomeCard = New-UDCard -Title "Welcome to the Active Directory Dashboard" -Content {
        New-UDParagraph -Text "This Dashboard provides realtime data on the active directory domain!"
        New-UDParagraph -Text "This also includes domain tools to reset user passwords and create computer accounts!"
    }

    New-UDLayout -Columns 1 -Content {
        $WelcomeCard
    }
    New-UDLayout -Columns 2 -Content {
        $Table
        $DCGrid
        $OSPiechart
    }

}