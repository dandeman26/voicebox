$ErrorActionPreference = "Stop"

Write-Host "Voicebox AMD ROCm verification" -ForegroundColor Cyan

$gpu = Get-CimInstance Win32_VideoController |
    Where-Object { $_.Name -match "AMD|Radeon" } |
    Select-Object -First 1 Name, DriverVersion

if (-not $gpu) {
    throw "No AMD Radeon display adapter was detected by Windows."
}

Write-Host "GPU: $($gpu.Name)"
Write-Host "Driver: $($gpu.DriverVersion)"

try {
    $health = Invoke-RestMethod -Uri "http://127.0.0.1:17493/health" -TimeoutSec 10
} catch {
    throw "Voicebox is not responding on http://127.0.0.1:17493. Open the app and try again."
}

Write-Host "Backend: $($health.backend_variant)"
Write-Host "GPU type: $($health.gpu_type)"
Write-Host "GPU available: $($health.gpu_available)"

if ($health.backend_variant -ne "rocm") {
    throw "Voicebox is running the '$($health.backend_variant)' backend, not ROCm. Switch it under Settings > GPU."
}

if (-not $health.gpu_available -or $health.gpu_type -notmatch "ROCm") {
    throw "The ROCm server started, but PyTorch did not report an available AMD GPU."
}

Write-Host "ROCm acceleration is active." -ForegroundColor Green
