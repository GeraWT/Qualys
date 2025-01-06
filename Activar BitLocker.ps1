# Define la unidad que quieres cifrar
$driveLetter = "C:"
# Verifica si BitLocker ya está activado en la unidad
if ((Get-BitLockerVolume -MountPoint $driveLetter).ProtectionStatus -eq "On") {
    Write-Host "BitLocker ya está activado en la unidad $driveLetter."
    break
} else {
    # Genera una contraseña aleatoria
    $password = -join (1..48 | ForEach-Object { Get-Random -Minimum 0 -Maximum 10 })
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    # Habilita BitLocker con la contraseña generada
    Enable-BitLocker -MountPoint $driveLetter -EncryptionMethod XtsAes256 -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector $securePassword
}
# Verifica que se haya activado, en caso de ser positivo, notifica y brinda la password generada.
if ((Get-BitLockerVolume -MountPoint $driveLetter).ProtectionStatus -eq "On") {
    $password | Out-File -FilePath "C:\BitLockerRecovery.txt"
    Write-Host "BitLocker se ha activado en la unidad $driveLetter."
    Write-Host "La contraseña de recuperación se ha guardado en C:\BitLockerRecovery.txt"
    Write-Host $password
} else {
    Write-Host "No pudo activarse BitLocker"
}