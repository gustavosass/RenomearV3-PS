# $Path: Pasta pai
$path = "path"

$pathLog = "$path\RenomearV3_log.txt"
Clear-Content -Path $pathLog
"Script RenomearV3" | Out-File -FilePath $pathLog -Append

$pastas = Get-ChildItem -Path $path -Directory -Recurse -Force 

foreach ($pasta in $pastas) {    
    Get-ChildItem -Path $($pasta.FullName) -File -Recurse -Force | ForEach-Object { 
        try {
            Move-Item -Path $($_.FullName) -Destination "$path\$($pasta.Name)_$($_.Name)"
            Write-Host "Renomeado : $path\$($pasta.Name)_$($_.Name)" 
            "SUCESS : $path\$($pasta.Name)_$($_.Name)" | Out-File -FilePath $pathLog -Append
        } catch {
            Write-Host "Erro ao copiar arquivo: $($_.FullName) | $($_.Exception.Message)"
            "ERROR : $($_.FullName) | $($_.Exception.Message)" | Out-File -FilePath $pathLog -Append
        }
    }
}
"Script finalizado!" | Out-File -FilePath $pathLog -Append
Write-Host "Script finalizado!"


