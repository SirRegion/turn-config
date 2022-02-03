"Stopping all running containers"
docker ps --quiet | ForEach-Object { docker stop $_ ; docker rm $_ }

"Done!"
