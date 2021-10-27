# MDCTec Infrastructure

<img style="float: left; width: 150px" src="./avatar.png" alt="[avatar.png]">

This repository collects all Documentation and utility scripts related to our internal infrastructure.
We should seriously consider the ["Infrastructure as Code"][1] convention and therefore write code that can at best 'generate' all of our dev infrastructure.

Most directories have nested README.md files with detailed documentation.

[1]: https://en.wikipedia.org/wiki/Infrastructure_as_code
## Repository Contents:
<!---
Symbole zum copy&pasten
│
├─
└─
--->
See the nested README.md files for further documentation

| Path | Description |
|--- |--- | 
| <pre style="padding:0"> machines/</pre> | Contains content specific to a certain internal machine. |    
| <pre style="padding:0"> scripts/</pre> | Contains utility scripts that can be used and shared across the infrastructure.  |
| <pre style="padding:0"> scripts/powershell/</pre> | Utility scripts for MS Powershell |
| <pre style="padding:0"> scripts/powershell/MdctecMaintenanceMenu</pre> | See this nested [README](scripts/powershell-modules/MdctecMaintenanceMenu/README.md) |


## Artifacts available to download:

| Artifact File | Description | Details |
|---    |---  |--- 
| [MdctecMaintenanceMenu.zip](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/powershell-modules/powershell-modules.zip?job=artifacts) | Powershell module providing the MdctecMaintenanceMenu helping to deploy the ComplianceBase application | [README](scripts/powershell-modules/MdctecMaintenanceMenu/README.md)
| [dev.mdctec.com/full-install.sh](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/machines/dev.mdctec.com/full-install.sh?job=artifacts) | dev.mdctec.com |

Go [here](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/browse?job=artifacts) to browse and see all available artifacts on Gitlab.

### MdctecMaintenanceMenu powershell Module
A PowerShell module providing a console-based menu to execute several maintenance tasks related to the ComplianceBase™ setup and deployment.

> Download latest version: [link](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/MdctecMaintenanceMenu/MdctecMaintenanceMenu.zip?job=zip_MdctecMaintenanceMenu_module)

### Bash scripts for a full machine setup:

To execute a script directly with bash use the following commands:  
```bash
# replace $url with one of the links above
source <(curl -s "$url")
```

