# MDCTec Infrastructure

In here are some utilities or scripts that have to do with our internal infrastructure.
We should seriously consider the ["Infrastructure as Code"][1] convention and therefore write code that can at best 'generate' all of our dev infrastructure.

[1]: https://en.wikipedia.org/wiki/Infrastructure_as_code

## Repository Cont``ents:
<!---
Symbole zum copy&pasten
│
├─
└─
--->
See the nested README.md files for further documentation

| Path | Description |
|--- |--- | 
| <pre style="padding:0"> machines/</pre> | Contains folders corresponding to (virtual) machines with the respective DNS entry. |    
| <pre style="padding:0"> scripts/</pre> | Contains utility scripts that can be used and shared across the infrastructure.  |
| <pre style="padding:0"> ├─ powershell/</pre> | Utility scripts for Microsoft powershell |
| <pre style="padding:0"> │  └─ MdctecMaintenance</pre> | See this nested [README](scripts/powershell/MdctecMaintenance/README.md) |

## Artifacts available to download:
### MdctecMaintenance powershell Module
A PowerShell module providing a console-based menu to execute several maintenance tasks related to the ComplianceBase™ setup and deployment.

> Download latest version: [link](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/MdctecMaintenance/MdctecMaintenance.zip?job=zip_MdctecMaintenance_module)

### bash scripts with a full machine setup:
| Path | Description | Download |
|--- |--- |--- |
| `machines/dev.mdctec.com/full-install.sh` | TODO | [link](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/machines/dev.mdctec.com/full-install.sh?job=artifacts)
