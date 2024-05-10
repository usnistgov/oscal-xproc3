# Libraries for OSCAL XProc 3

Downloaded libraries for running the code in this repository are saved in this subdirectory.

Run [../setup.sh](../setup.sh) to save the libraries on your system, with their documentation and licensing information.

See the project [readme](../README.md), the [setup script](../setup.sh) and [setup notes](../setup-notes.md) for details regarding these dependencies.

Expect runtime errors from processing if libraries are missing or named incorrectly. Since scripts including [xp3.sh](../xp3.sh) and [xp3.bat](../xp3.bat) invocation shells use this software, adjustments must be made as software versions, locations or interfaces change.

## In the subdirectory

- [readme.md](readme.md) - this file
- [morgana-config.xml](morgana-config.xml) - Morgana configuration file
- [GRAB-SAXON.xpl](GRAB-SAXON.xpl) - Saxon download and installation pipeline (XProc 3.0)
- [GRAB-SCHXSLT.xpl](GRAB-SCHXSLT.xpl) - SchXSLT download pipeline (XProc 3.0)

## Restore

Refresh by deleting everything but the files just named.

Run [setup](../setup.sh) again (or [follow the setup notes](../setup-notes.md)) and the two `GRAB*` pipelines in the folder, to acquire Saxon and SchXSLT for XSLT and Schematron support.

Test by running the [smoke tests](../smoketest/).


---

