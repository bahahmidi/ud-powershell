New-UDPage -Name "Admin Page" -Content {
    $PasswordReset = New-UDInput -Title "Reset a user password" -Endpoint {
        param($Username, $Password) 
        try{
            $ADUser = Get-ADUser -Identity $Username 
        }
        catch{
            New-UDInputAction -Toast "Invalid Username" -Duration 5000
        }
    
        If($Null -ne $ADUser){
            try {
                Set-ADAccountPassword -Identity $ADUser  -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)    
                New-UDInputAction -Toast "You reset $Username's password!" -Duration 5000
            }
            catch {
                New-UDInputAction -Toast "Invalid Password" -Duration 5000
            }  
        }
    }

    # Create computer
    $CreateComputer = New-UDInput -Title "Create Computer" -Endpoint {
        param($ComputerName) 
        #$ADComputer = Get-ADComputer -Identity $ComputerName -ErrorAction SilentlyContinue

        If($Null -ne $ADComputer){
            New-UDInputAction -Toast "Computer already exists" -Duration 5000
        }
        else{
            try{
                New-ADComputer -Name $ComputerName -SamAccountName $ComputerName
                New-UDInputAction -Toast "You created a new computer $ComputerName" -Duration 5000
            }
            catch{
                New-UDInputAction -Toast "Failed to create a new computer named $Computername" -Duration 5000
            }
        }
    }

    $WelcomeCard = New-UDCard -Title "Welcome to the Admin Page"-Content {
        New-UDParagraph -Text "This page provides you the ability to create computer accounts and reset user passwords"
    }

    New-UDLayout -Columns 1 -Content {
        $WelcomeCard
    }
    New-UDLayout -Columns 2 -Content {
        $CreateComputer
        $PasswordReset
    }
}