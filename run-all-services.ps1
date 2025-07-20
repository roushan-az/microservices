Write-Output "Starting all microservices..."

# Create logs folder
$logsPath = "logs"
If (!(Test-Path -Path $logsPath)) {
    New-Item -ItemType Directory -Path $logsPath
}

# List of services
$services = @(
    "util",
    "api-service",
    "product-service",
    "product-composite-service"
)

foreach ($service in $services) {
    $logFile = ".\logs\$service.log"
    Start-Process -NoNewWindow -FilePath "cmd.exe" `
        -ArgumentList "/c", "gradlew.bat", ":$service:bootRun", ">", "$logFile", "2>&1"
    Write-Output "$service started (log: $logFile)"
}

Write-Output "All services are running in the background."
