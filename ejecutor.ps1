param(
    [Parameter(Mandatory=$true)]
    [string]$archivo
)

# Agregar NASM al PATH
$env:Path += ";C:\Users\Aaron\AppData\Local\bin\NASM"

$basePath = "c:\Users\Aaron\Documents\GitHub\Proyecto_Ensamblador"
$nombre = [System.IO.Path]::GetFileNameWithoutExtension($archivo)
$asmFile = "$basePath\$nombre.asm"
$binFile = "$basePath\$nombre.bin"

if (-not (Test-Path $asmFile)) {
    Write-Host "[X] Error: Archivo '$asmFile' no encontrado" -ForegroundColor Red
    exit 1
}

Write-Host "[*] Compilando $nombre.asm..." -ForegroundColor Cyan
nasm -f bin "$asmFile" -o "$binFile"

if ($LASTEXITCODE -ne 0) {
    Write-Host "[X] Error en la compilación" -ForegroundColor Red
    exit 1
}

Write-Host "[+] Compilación exitosa" -ForegroundColor Green
Write-Host "[+] Archivo generado: $binFile" -ForegroundColor Green