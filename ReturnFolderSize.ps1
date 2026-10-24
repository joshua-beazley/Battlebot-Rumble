param (
    [string]$folderPath
)

# If no path is provided as an argument, prompt the user
if (-not $folderPath) {$folderPath = Read-Host "Please enter the folder path"
}

# Validate if path exists
if (Test-Path -Path $folderPath) {
    Write-Host "Calculating size for: $folderPath ..." -ForegroundColor Cyan
    
    $measure = Get-ChildItem -Path $folderPath -Recurse -File -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    
    if ($measure.Sum) {
        $sizeInMB = [math]::Round(($measure.Sum / 1MB), 2)
        Write-Host "`nTotal Size: $sizeInMB MB" -ForegroundColor Green
    } else {
        Write-Host "`nFolder is empty or contains no readable files." -ForegroundColor Yellow
    }
} else {
        Write-Host "`nError: The path '$folderPath' does not exist." -ForegroundColor Red
}

# Keep window open if run via double-click
Write-Host "`nPress any key to exit..."
$null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
