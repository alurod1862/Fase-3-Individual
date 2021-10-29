param($a,$b)
$dominio=$a
$sufijo=$b
$dc="dc="+$dominio+",dc="+$sufijo


if (!(Get-Module -Name ActiveDirectory)) #Accederá al then solo si no existe una entrada llamada ActiveDirectory
{
  Import-Module ActiveDirectory #Se carga el módulo
}

$fichero_csv=Read-Host "Introduce el fichero csv de los usuarios:"

$fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
foreach($linea_leida in $fichero_csv_importado)
{
	
  	$rutaContenedor =$linea_leida.ContainerPath+","+$dc 

	$name=$linea.Name
	$nameShort=$linea.Name+'.'+$linea_leida.Surname
	$Surnames=$linea.Surname+' '+$linea_leida.Surname2
	$nameLarge=$linea.Name+' '+$linea_leida.Surname+' '+$linea_leida.Surname2
	$computerAccount=$linea_leida.Computer
	$email=$nameShort+"@"+$a+"."+$b

	[boolean]$Habilitado=$true
  	If($linea_leida.Hability -Match 'false') { $Habilitado=$false}
  
	New-ADUser `
    		-SamAccountName $nameShort `
    		-UserPrincipalName $nameShort `
    		-Name $nameShort `
		-Surname $Surnames `
    		-DisplayName $nameLarge `
    		-GivenName $name `
    		-LogonWorkstations:$linea.Computer `
		-Description "Cuenta de $nameLarge" `
    		-EmailAddress $email `
		-AccountPassword $passAccount `
    		-Enabled $Habilitado `
		-CannotChangePassword $false `
    		-ChangePasswordAtLogon $true `
		-PasswordNotRequired $false `
    		-Path $rutaContenedor
}