function crear_estructura
{
                Clear-Host
                $ficheroCsvUO=Read-Host "Introduce el fichero csv de UO"
                $fichero = import-csv -Path $ficheroCsvUO -delimiter :
                foreach($line in $fichero)
{
   New-ADOrganizationalUnit -Description:$line.Descripcion -Name:$line.Name -Path:$line.Path -ProtectedFromAccidentalDeletion:$true
}
                $gruposCsv=Read-Host "Introduce el fichero csv de Grupos"
                $fichero = import-csv -Path $gruposCsv -delimiter :
                foreach($linea in $fichero)
{
   New-ADGroup -Name:$linea.Name -Path:$linea.Path -Description:$linea.Description -GroupCategory:$linea.Category -GroupScope:$linea.Scope 
}
                $equiposCsv=Read-Host "Introduce el fichero csv de Equipos:"
                $fichero= import-csv -Path $equiposCsv -delimiter ":"
                foreach($line in $fichero)
{
   New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$line.Path -SamAccountName:$line.Computer
}
                $fichero_csv=Read-Host "Introduce el fichero csv de los usuarios:"
                $fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
                foreach($linea in $fichero_csv_importado)
{
  	            $rutaContenedor=$linea.ContainerPath+","+$path
  	            $passAccount=ConvertTo-SecureString $linea.Password -AsPlainText -force
	            $name=$linea.Name
	            $nameShort=$linea.Name+' '+$linea.Surname1
	            $Surnames=$linea.Surname
	            $nameLarge=$linea.Name+'.'+$linea.Surname1+'.'+$linea.Surname2
	            $computerAccount=$linea.Computer
	            $email=$email.Name
                
                
	  
	            if (Get-ADUser -filter { name -eq $nameShort })
{
   $nameShort=$linea.Surname1
}
	
	
	            New-ADUser  -SamAccountName $nameShort `
   	 	                    -UserPrincipalName $nameShort `
    		                -Name $nameShort `
		                    -Surname $Surnames `
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
                pause
}
function eliminar_estructura
{
                Clear-Host 
                Set-ADOrganizationalUnit -Identity "OU=Clientes-Gandia,DC=gandia,DC=upv,DC=es" -ProtectedFromAccidentalDeletion $false
                Remove-ADOrganizationalUnit -Identity "OU=Clientes-Gandia,DC=gandia,DC=upv,DC=es" -Recursive
                pause
}
function alta_usuario
{
                Clear-Host
                $user=Read-Host "Escribe el nombre de la cuenta a habilitar"
                $path=Read-Host "Escribe el nombre del departamento"
                Enable-ADAccount -Identity "CN=$user, OU=$path,OU=Clientes-Gandia,DC=gandia,DC=upv,DC=es"
                return
                pause
}
function alta_grupo
{
$descrip=Read-Host "Escribe la descripcion de este grupo"
$name=Read-Host "Escribe el nombre del grupo a crear"
New-LocalGroup -Name $name -Description $descrip
}
function alta_equipo
{
$name=Read-Host "Escribe el nombre del equipo a crear"
New-ADComputer -Enabled:$true -Name $name -Path "OU=Comunicaciones,OU=Clientes-Gandaia,DC=gandia,DC=upv,DC=es"
}
function alta_uo
{
$name=Read-Host "Escribe el nombre de la uo a crear"
    New-ADOrganizationalUnit -Name:$name -Path:"OU=Clientes-Gandia,DC=gandia,DC=upv,DC=es" -ProtectedFromAccidentalDeletion:$false
}

function mostrar_Submenu-2
{
     param (
           [string]$Titulo = 'Submenu de Altas'
     )
     Clear-Host 
     Write-Host "================ $Titulo ================"
    
     Write-Host "1: Alta de un usuario"
     Write-Host "2: Alta de un grupo"
     Write-Host "3: Alta de un equipo"
     Write-Host "4: Alta de  UO"
     Write-Host "s: Volver al menu ."
do
{
     $input = Read-Host "Por favor, pulse una opcion"
     switch ($input)
     {
           '1' {
                Clear-Host
                alta_usuario
                return
           } '2' {
                Clear-Host
                alta_grupo
                return
           } '3' {
                Clear-Host
                alta_equipo
                return
           } '4' {
                Clear-Host
                alta_uo
                return
           } 's' {
                "Saliendo del submenu..."
                return
           } 
     }
}
until ($input -eq 'q')
}

function mostrar_Submenu1
{
     param (
           [string]$Titulo = 'Submenu.....'
     )
     Clear-Host 
     Write-Host "================ $Titulo ================"
    
     Write-Host "1: Alta de un objeto"
     Write-Host "s: Volver al menu principal."
do
{
     $input = Read-Host "Por favor, pulse una opción"
     switch ($input)
     {
           '1' {
                Clear-Host
                mostrar_Submenu-2
                return
           } 's' {
                "Saliendo del submenu..."
                return
           } 
     }
}
until ($input -eq 'q')
}



function mostrarMenu 
{ 
     param ( 
           [string]$Titulo = 'Selección de opciones' 
     ) 
     Clear-Host 
     Write-Host "================ $Titulo================" 
      
     
     Write-Host "1. Estructura logica" 
     Write-Host "2. Eliminacion estructura logica" 
     Write-Host "3. Gestion de objetos" 
     Write-Host "s. Presiona 's' para salir" 
}

do 
{ 
     mostrarMenu 
     $input = Read-Host "Elegir una Opcion" 
     switch ($input) 
     { 
           '1' { 
                crear_estructura
           } '2' { 
                eliminar_estructura
           } '3' {  
                Clear-Host
                mostrar_Submenu1      
           } 's' {
                'Saliendo del script...'
                return 
           }  
     } 
     pause 
} 
until ($input -eq 's')
