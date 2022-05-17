docker exec $Env:CB_DOCKER_CONTAINER powershell -c 'Get-Content C:/log/nginx/access.log -Wait'
