docker run -d --rm `
    -p 443:443/udp -p 443:443/tcp `
    --mount 'type=volume,src=cb-app_data,dst=C:/app/data/mysql' `
    --name cb-app `
    complianceBaseContainerRegistry.azurecr.io/main/cb-app/mondi:0.0.1-rc2