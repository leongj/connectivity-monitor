param (
    [int]$interval_sec = 5
)

# Define the IP address
$local_ip = "192.168.88.200"
$remote_ip = "8.8.8.8"


Write-Host "Pinging local IP $local_ip and DNS IP $remote_ip every $interval_sec seconds."
Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')." -NoNewline

$count = 0
while ($true) {
    # Send a single ping packet and capture the result
    $local_ping = Test-Connection -ComputerName $local_ip -Count 1 -Quiet
    $dns_ping = Test-Connection -ComputerName $remote_ip -Count 1 -Quiet

    $count++

    # Check local ping
    if (-not $local_ping) {
        [console]::beep(1000, 250)  # 1000 Hz for 250 ms
        Write-Host "`n$(Get-Date -Format 'HH:mm:ss') - Ping to $local_ip failed."
    }

    # Check DNS ping
    if (-not $dns_ping) {
        [console]::beep(500, 250)  # 500 Hz for 250 ms
        Write-Host "`n$(Get-Date -Format 'HH:mm:ss') - Ping to $remote_ip failed."
    }

    # Print the time every minute
    if ($count -ge 60 / $interval_sec) {
        Write-Host "`n$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -NoNewline
        $count = 0
        # [console]::beep(500, 250)  
    }

    # write progress to console
    Write-Host "." -NoNewline

    # Sleep for interval_sec seconds
    Start-Sleep -Seconds $interval_sec
}
