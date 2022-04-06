# MDCTec Infrastructure

<img width="300" src="./avatar.png" alt="[avatar.png]">

This repository collects some utility scripts and documentation related to our internal infrastructure. We should
seriously consider the ["Infrastructure as Code"][1] convention and therefore write code that can at best 'generate' all
of our dev infrastructure.

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

| Path                                                                  | Description                                                                                                                         | Readme                                                                            |
|-----------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| [docs/](docs)                                                         | Contains documentation for some general topics                                                                                      | <ul> <li>[Allgemeine Doku zur internen Infrastruktur][21]</li></ul>               |
| [machines/](machines)                                                 | Directory with content specific to a certain machine setup. For example `machines/dev.mdctec.local/` is for our internal DEV server |                                                                                   |
| [└─ /gitlab.mdctec.com/](machines/gitlab.mdctec.com)                  | Regarding our Gitlab machine                                                                                                        |                                                                                   |
| [└─ /dev.mdctec.local/](machines/dev.mdctec.local)                    | Regarding our DEV Server machine                                                                                                    | [README](machines/dev.mdctec.local/README.md)                                     |
| [└─ /dev-workstation/](machines/dev-workstation)                      | Documentation related to a developer workstation                                                                                    | <ul> <li>[Basic Setup][22]</li><li>[Access to stage & dev servers][23]</li> </ul> |
| [scripts](scripts)                                                    | Directory with common utility scripts that can be used and shared across the infrastructure.                                        |                                                                                   |
| [└─ /powershell](scripts/powershell)                                  | Utility scripts for MS Powershell                                                                                                   |                                                                                   | 
| [powershell-modules](powershell-modules)                              |                                                                                                                                     |                                                                                   |
| [└─ /MdctecMaintenanceMenu](powershell-modules/MdctecMaintenanceMenu) | See this nested [README](powershell-modules/MdctecMaintenanceMenu/README.txt)                                                       |                                                                                   |

[machines/dev-workstation/windows]: machines/dev-workstation/windows
[21]: docs/README.md

[22]: machines/dev-workstation/windows/basic-setup.README.md

[23]: machines/dev-workstation/windows/enable-server-access.README.md

## Artifacts available to download:

| Artifact File               | Description                         | Details                                                       |
|-----------------------------|-------------------------------------|---------------------------------------------------------------|
| [powershell-modules.zip][3] | Contains the MdctecMaintenanceMenu. | [README](powershell-modules/MdctecMaintenanceMenu/README.txt) |

[3]: http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/raw/powershell-modules/powershell-modules.zip?job=artifacts



Go [here](http://gitlab.mdctec.com/mdctec-developers/internal/infrastructure/-/jobs/artifacts/master/browse?job=artifacts)
to browse and see all available artifacts on Gitlab.

