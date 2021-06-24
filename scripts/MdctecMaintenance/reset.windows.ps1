# Stop all running containers
docker ps --quiet | ForEach-Object {docker stop $_}
docker system prune --volumes --all
Uninstall-Package -Name docker -ProviderName DockerMsftProvider
Uninstall-Module -Name DockerProvider
Get-HNSNetwork | Remove-HNSNetwork
Remove-Item "C:\ProgramData\docker" -Recurse
