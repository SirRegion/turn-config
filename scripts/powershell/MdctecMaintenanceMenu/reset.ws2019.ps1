# Stop all running containers
docker ps --quiet | ForEach-Object {docker stop $_}

# Clear all data
docker system prune --volumes --all
Uninstall-Package -Name docker -ProviderName DockerMsftProvider
Uninstall-Module -Name DockerMsftProvider
Get-HNSNetwork | Remove-HNSNetwork
Remove-Item "C:\ProgramData\docker" -Recurse


$steps = @(
[pscustomobject]@{
    Description = 'This will clear all data & uninstall docker! Only continue if you are absolutelly sure what you are doing!'
    Command = ' \
        docker ps --quiet | ForEach-Object {docker stop $_};
        docker system prune --volumes --all;
        Uninstall-Package -Name docker -ProviderName DockerMsftProvider;
        Uninstall-Module -Name DockerMsftProvider;
        Get-HNSNetwork | Remove-HNSNetwork;
        Remove-Item "C:\ProgramData\docker" -Recurse;
    '
}
)

Interactive-Steps $steps -TaskName "Install and Launch complianceBase app on this machine"
