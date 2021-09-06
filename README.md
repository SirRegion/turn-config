# MDCTec Infrastructure

<img style="float: left; width: 30%" src="./avatar.png" alt="[avatar.png]">

In here are some utilities or scripts that have to do with our internal infrastructure.
We should seriously consider the ["Infrastructure as Code"][1] convention and therefore write code that can at best 'generate' all of our dev infrastructure.

[1]: https://en.wikipedia.org/wiki/Infrastructure_as_code
## Artifacts available to download:

| Artifact File | Description | Details |
|---    |---  |--- 
| [MdctecMaintenance.zip](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/powershell/MdctecMaintenance/MdctecMaintenance.zip?job=artifacts) | Powershell module providing the MdctecMaintenance Menu helping to deploy the ComplianceBase application | [README](scripts/powershell/MdctecMaintenance/README.md)
| [dev.mdctec.com/full-install.sh](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/machines/dev.mdctec.com/full-install.sh?job=artifacts) | dev.mdctec.com |

Go [here](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/browse?job=artifacts) to browse and see all available artifacts on Gitlab.

### MdctecMaintenance powershell Module
A PowerShell module providing a console-based menu to execute several maintenance tasks related to the ComplianceBase™ setup and deployment.

> Download latest version: [link](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/MdctecMaintenance/MdctecMaintenance.zip?job=zip_MdctecMaintenance_module)

### Bash scripts for a full machine setup:

To execute a script directly with bash use the following commands:  
```bash
# replace $url with one of the links above
source <(curl -s "$url")
```

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
| <pre style="padding:0"> machines/</pre> | Contains folders with scripts for a full machine setup. |    
| <pre style="padding:0"> scripts/</pre> | Contains utility scripts that can be used and shared across the infrastructure.  |
| <pre style="padding:0"> ├─ powershell/</pre> | Utility scripts for Microsoft powershell |
| <pre style="padding:0"> │  └─ MdctecMaintenance</pre> | See this nested [README](scripts/powershell/MdctecMaintenance/README.md) |

