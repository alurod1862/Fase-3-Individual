$fichero_csv=Read-Host "Introduce el fichero csv de los usuarios:"
$fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
foreach($linea_leida in $fichero_csv_importado)
{
	
  	$rutaContenedor =$linea_leida.ContainerPath+","+$dc

	$name=$linea.Name
	$nameShort=$linea.Name+'.'+$linea_leida.Surname1
	$Surnames=$linea.Surname
	$nameLarge=$linea.Name+' '+$linea_leida.Surname1+' '+$linea_leida.Surname2
	$computerAccount=$linea_leida.Computer
    $email=$linia_leida.email
    $dc="DC=alcoy,DC=upv,DC=es"
  	          
	   

	[boolean]$Habilitado=$true
  	If($linea_leida.Hability -Match 'false') { $Habilitado=$false}


  
	    New-ADUser  -SamAccountName $nameShort `
   	 	            -UserPrincipalName $nameShort `
    		        -Name $nameShort `
		            -Surname $Surnames `
    		        -DisplayName $nameShort `
    		        -GivenName $nameShort `
    		        -LogonWorkstations:$linea.Computer `
		            -Description "Cuenta de $nameLarge" `
    		        -EmailAddress $email `
		            -AccountPassword $passAccount `
    		        -Enabled $Habilitado `
		            -CannotChangePassword $false `
    		        -ChangePasswordAtLogon $true `
		            -PasswordNotRequired $false `
    		        -Path $rutaContenedor `
}