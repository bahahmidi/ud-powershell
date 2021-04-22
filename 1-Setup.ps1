# Run PowerShell as Administrator

# Install Universal Dashboard Community

# First check your PowerShellGet version. The Universal Dashboard module requires PowerShellGet 2 or higher.
Get-Module -Name PowerShellGet -ListAvailable

#If you dont have PowerShellGet Version 2 or higher you need to update PowerShellGet
# Update PowerShell Get
Install-Module -name PowerShellGet -Force

# Review current PowerShellGet versions
Get-Module -Name PowerShellGet -ListAvailable

# Delete old version of PowerShellGet
    # x64 path
    Get-ChildItem -Path "C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\"
    Remove-Item -Path "C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\1.0.0.1" -Recurse -Force

    # x86 path
    Get-ChildItem -Path "C:\Program Files (x86)\WindowsPowerShell\Modules\PowerShellGet\"
    Remove-Item -Path "C:\Program Files (x86)\WindowsPowerShell\Modules\PowerShellGet\1.0.0.1" -Recurse -Force

# Copy new version from the x64 directory to the x86 directory
Copy-item -Path "C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\*" -Destination "C:\Program Files (x86)\WindowsPowerShell\Modules\PowerShellGet\"

# Copy new version from the x86 directory to the x64 directory
Copy-item -Path "C:\Program Files (x86)\WindowsPowerShell\Modules\PowerShellGet\*" -Destination "C:\Program Files\WindowsPowerShell\Modules\PowerShellGet\"

# Close this Powershell session and open a new one.

#Check .Net version
$Lookup = @{
    378389 = [version]'4.5'
    378675 = [version]'4.5.1'
    378758 = [version]'4.5.1'
    379893 = [version]'4.5.2'
    393295 = [version]'4.6'
    393297 = [version]'4.6'
    394254 = [version]'4.6.1'
    394271 = [version]'4.6.1'
    394802 = [version]'4.6.2'
    394806 = [version]'4.6.2'
    460798 = [version]'4.7'
    460805 = [version]'4.7'
    461308 = [version]'4.7.1'
    461310 = [version]'4.7.1'
    461808 = [version]'4.7.2'
    461814 = [version]'4.7.2'
    528040 = [version]'4.8'
    528049 = [version]'4.8'
}
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse |
  Get-ItemProperty -name Version, Release -EA 0 |
  Where-Object { $_.PSChildName -eq 'Full'} |
  Select-Object @{name = ".NET Framework"; expression = {$_.PSChildName}}, 
@{name = "Product"; expression = {$Lookup[$_.Release]}}, 
Version, Release

#Link to download .Net --> https://www.microsoft.com/net/download/dotnet-framework-runtime


# Install the UniversalDashboard Community module
Install-Module -Name UniversalDashboard.Community
