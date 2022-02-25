# MDCTec Infrastructure

<img width="300" src="./avatar.png" alt="[avatar.png]">

This repository collects some utility scripts and documentation  related to our internal infrastructure.
We should seriously consider the ["Infrastructure as Code"][1] convention and therefore write code that can at best 'generate' all of our dev infrastructure.

Most directories have nested README.md files with detailed documentation.

[1]: https://en.wikipedia.org/wiki/Infrastructure_as_code

## Artifacts available to download:

| Artifact File | Description | Details |
|---    |---  |--- 
| [powershell-modules.zip][3] | Contains the MdctecMaintenanceMenu. | [README](powershell-modules/MdctecMaintenanceMenu/README.txt)

[3]: http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/powershell-modules/powershell-modules.zip?job=artifacts

## Repository Contents:
<!---
Symbole zum copy&pasten
│
├─
└─
--->
See the nested README.md files for further documentation

| Path | Description | Readme |
|--- |--- |--- |
| `machines/`| Directory with content specific to a certain machine setup. For example `machines/dev.mdctec.com/` is for our internal DEV server||
| [machines/dev-workstation/windows] | Utility scripts related to a developer workstation |<ul> <li>[Basic Setup][21]</li><li>[Access to stage & dev servers][22]</li> </ul>|
| `scripts` | Directory with common utility scripts that can be used and shared across the infrastructure.  |  |
| <pre style="padding:0"> scripts/powershell/</pre> | Utility scripts for MS Powershell |
| <pre style="padding:0"> powershell-modules/MdctecMaintenanceMenu</pre> | See this nested [README](powershell-modules/MdctecMaintenanceMenu/README.txt) |

[machines/dev-workstation/windows]: machines/dev-workstation/windows
[21]: machines/dev-workstation/windows/basic-setup.README.md
[22]: machines/dev-workstation/windows/enable-server-access.README.md


Go [here](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/browse?job=artifacts) to browse and see all available artifacts on Gitlab.

