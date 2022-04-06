# Docker Registry on dev.mdctec.local

* Central location for internal Docker images
* also used by DEV Server and Gitlab pipelines to pull/push images

## Configure Docker to use our Registry
Add this to your `daemon.json` file:
```json
{
    "insecure-registries": [ "dev.mdctec.local:5000" ]
}
```

When using WSL you can do this:
```bash
export DOCKERDAEMONCONFIG=$(wslpath "$(wslvar USERPROFILE)")/.docker/daemon.json; \
echo $(jq --arg registryUrl "dev.mdctec.local:5000" \
'."insecure-registries" = [ $registryUrl ]' $DOCKERDAEMONCONFIG) > $DOCKERDAEMONCONFIG
```

### Common pathes of the `daemon.json` file:

* **Linux:**  
  `/etc/docker/daemon.json`

* **Docker Desktop (Windows):**  
  `C:\ProgramData\Docker\config\daemon.json`

