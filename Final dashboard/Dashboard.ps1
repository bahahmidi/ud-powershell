# Stop all dashboards
Get-UDDashboard | Stop-UDDashboard

$PageDirectory = "$PSScriptRoot\Pages"
$Pages = Get-ChildItem $PageDirectory
$Pagedata = foreach($Page in $pages){
    . $page.FullName
}

# Navigation
$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home Page" -PageName "Home" -Icon house
    New-UDSideNavItem -Text "Admin Page" -PageName "Admin Page" -Icon User
    New-UDSideNavItem -Text "Report Page" -PageName "Report Page" -Icon Users
    
}

#Themes
$Theme = Get-UDTheme -Name DarkRounded

# The dashboard
$Dashboard = New-UDDashboard -Title "Active Directory" -Pages $Pagedata -Navigation $Navigation -Theme $Theme

# Starting the dashboard
Start-UDDashboard -Port 8080 -Name "Acive Directory" -Dashboard $Dashboard