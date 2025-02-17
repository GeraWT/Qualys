# Verifico que exista la carpeta C:\Temp
if (!(Test-Path "C:\Temp")) {
    # Si no existe, la crea
    New-Item -ItemType directory -Path "C:\Temp" -Force
}
# Ruta del archivo ZIP
$zipFilePath = "C:\Temp\Qualys-main.zip"
# Ruta de la carpeta descomprimida
$folderPath = "C:\Temp\Qualys-main"

# Verificar si el archivo ZIP existe y eliminarlo si es necesario
if (Test-Path $zipFilePath) {
    Remove-Item -Path $zipFilePath -Force
    Write-Output "Archivo eliminado."
} 
# Verificar si la carpeta descomprimida existe y eliminarla si es necesario
if (Test-Path $folderPath) {
    Remove-Item -Path $folderPath -Recurse -Force
    Write-Output "Carpeta eliminada."
}
# Forzar conexion TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Realizo descarga de github a carpeta c:\temp
Invoke-WebRequest -Uri "https://github.com/GeraWT/Qualys/archive/refs/heads/main.zip" -OutFile "C:\Temp\Qualys-main.zip"
# Descomprimo el archivo .zip en c:\temp
# Expand-Archive -LiteralPath 'C:\Temp\V1ESUninstallTool.zip' -DestinationPath 'C:\Temp'

if (!(Test-Path "C:\Temp\Qualys-main")) {
   # Agregar el ensamblado necesario para la compresión de archivos
   Add-Type -AssemblyName System.IO.Compression.FileSystem
   # Descomprimo el archivo ZIP usando System.IO.Compression
   $zipFilePath = 'C:\Temp\Qualys-main.zip'
   $destinationPath = 'C:\Temp'
   [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFilePath, $destinationPath)
} 
#Ejecuto proceso de desinstalacion
#Start-Process -FilePath "C:\Temp\Qualys-main\QualysCloudAgent.exe" -ArgumentList "/S CustomerId={5591b12a-9a3f-ee57-828e-1b151dbcf953} ActivationId={ec733490-624d-4dcd-9053-27c4ea8d8cc2} WebServiceUri=https://qagpublic.qg3.apps.qualys.com/CloudAgent/" -Verb RunAs
Start-Process -FilePath "cmd.exe" -Verb RunAs -ArgumentList '/k', 'C:\Temp\Qualys-main\instalar.bat'