$inspect = $(docker volume inspect cb-app_data);

if ("$inspect" -eq "[]"){
    Write-Host "docker volume 'cb-app_data' does not exist!";
    Write-Host "Creating a new one...";
    docker volume create cb-app_data;
    Write-Host "Ready to start the container!";
}else{
    Write-Host "docker volume 'cb-app_data' already exists!";
    Write-Host "Ready to start the container!";
}

