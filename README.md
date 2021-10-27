# MDCTec Infrastructure

<img width="300" src="./avatar.png" alt="[avatar.png]">

This repository collects some utility scripts and documentation  related to our internal infrastructure.
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
| <pre style="padding:0"> machines/</pre> | Contains content specific to a certain internal machine. For example `machines/dev.mdctec.com/` is for our internal DEV server|
| <pre style="padding:0"> scripts/</pre> | Contains common utility scripts that can be used and shared across the infrastructure.  |
| <pre style="padding:0"> scripts/powershell/</pre> | Utility scripts for MS Powershell |
| <pre style="padding:0"> scripts/powershell-modules/MdctecMaintenanceMenu</pre> | See this nested [README](scripts/powershell-modules/MdctecMaintenanceMenu/README.md) |


## Artifacts available to download:

| Artifact File | Description | Details |
|---    |---  |--- 
| [powershell-modules.zip][2] | Contains the MdctecMaintenanceMenu. | [README](scripts/powershell-modules/MdctecMaintenanceMenu/README.md)

[2]: http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/scripts/powershell-modules/powershell-modules.zip?job=artifacts

Go [here](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/browse?job=artifacts) to browse and see all available artifacts on Gitlab.

