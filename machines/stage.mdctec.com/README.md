# Documentation for `stage.mdctec.com`
The `Stage` machine is a Ubuntu Server whose main purpose is to provide a Gitlab Runner instance with a linux environment.

> *OS*:         `Ubuntu 20.04.3 LTS`  
> *DNS Name*:   `stage.mdctec.com`  
> *Hostname*:   `gitlabrunnerstage`

## Hosted Applications & Services:

| Description              | URL                                                             | Details                           |
|--------------------------|-----------------------------------------------------------------|-----------------------------------|
| Interne Docker Registry  | [`http://stage.mdctec.com:5000`](http://stage.mdctec.com:5000)  | [README.md](./registry/README.md) | 
| Gitlab Runner 'stage'    | N.A                                                             | [README.md](./registry/README.md) |

## How to connect:

use ssh from a terminal like `ssh <USER>@stage.mdctec.com`
