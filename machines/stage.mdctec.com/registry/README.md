# Internal Docker Registry  (http://stage.mdctec.com:5000)

* Central location for internal Docker images
* also used by stage & dev pipelines to pull/push images

## Docker für den Zugriff konfigurieren:
Add this to your `daemon.json` file:
```json
{
    "insecure-registries": [ "stage.mdctec.com:5000" ]
}
```

####Common pathes of the `daemon.json` file:

* **Linux:**  
  `/etc/docker/daemon.json`

* **Docker Desktop (Windows):**  
  `C:\ProgramData\Docker\config\daemon.json`
