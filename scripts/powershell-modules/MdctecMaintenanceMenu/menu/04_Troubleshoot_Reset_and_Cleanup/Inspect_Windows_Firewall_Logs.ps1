$DOCKER_NETWORK_NAT_SUBNET = $( docker network inspect --format '{{ (index .IPAM.Config 0).Subnet }}' nat )
$DOCKER_NETWORK_NAT_GATEWAY = $( docker network inspect --format '{{ (index .IPAM.Config 0).Gateway }}' nat )
$CB_CONTAINER_IP = $( docker inspect --format = '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cb-app )
$HOST_IP4 = (Get-NetIPConfiguration |        Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected" }).IPv4Address.IPAddress
""
"Context Information:"
"DOCKER_NETWORK_NAT_SUBNET=$DOCKER_NETWORK_NAT_SUBNET"
"DOCKER_NETWORK_NAT_GATEWAY=$DOCKER_NETWORK_NAT_GATEWAY"
"CB_CONTAINER_IP=$CB_CONTAINER_IP"
"HOST_IP4=$HOST_IP4"
$FIREWALL_LOG_FILE_PATH = "$( netsh advfirewall show private | Select-String '(Filename|Dateiname)\s+(.+)' | % { $_.Matches.Groups[2].Value -replace "%systemroot%", $env:systemroot } )"
$FIREWALL_LOG = Get-Content $FIREWALL_LOG_FILE_PATH
$FIREWALL_LOG_FILE_LENGTH = "$FIREWALL_LOG_FILE_CONTENT" -Split "`n"

"FIREWALL_LOG:"
$FIREWALL_LOG | Select-String "DROP" | Select -Last 40
