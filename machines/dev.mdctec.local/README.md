# Documentation for `dev.mdctec.local`

The `DEV` machine is a Ubuntu Server whose main purpose is to provide a Gitlab Runner instance with a linux environment.

> *OS*:         `Ubuntu 20.04 LTS`  
> *DNS Name*:   `dev.mdctec.local`  
> *Hostname*:   `gitlabrunnerstage`

## Hosted Applications & Services:

### Software accessible via http
| Description              | URL                                                               | Details                                                                                          |
|--------------------------|-------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| Internal Docker Registry | [`http://dev.mdctec.local:5000`](http://dev.mdctec.local:5000/v2) | [README.md](./registry/README.md)                                                                | 


### Additional software installed as a background service
| Description         | Details                                                                                          |
|---------------------|--------------------------------------------------------------------------------------------------|
| Docker Engine       | was installed using this script: [install-docker.apt.sh](../../scripts/sh/install-docker.apt.sh) |
| Gitlab Runner       | [README.md](./gitlab-runner/README.md)                                                           | 
| Prometheus Exporter | [README.md](./prometheus-node-exporter/README.md)                                                | 

## How to connect:

use ssh from a terminal like `ssh <USER>@dev.mdctec.local`

`<USER>` is the 1st letter of your first name followed by the first 5 letters of your last name

### Note:

Login with `root` user is enabled but not advisable.  
See [this Entry on our PW Server](https://mdctecapps.mdctec.local:10001/WebClient/Main?itemId=44967dbd-e3e3-4ef1-b4bb-f031b69813fe)
exit
