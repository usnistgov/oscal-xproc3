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
- [GRAB-XSPEC.xpl](GRAB-XSPECT.xpl) - XSpec download pipeline (current XSpec)

## Restore

Refresh by deleting everything but the files just named.

Run [setup](../setup.sh) again (or [follow the setup notes](../setup-notes.md)) and the three `GRAB*` pipelines in the folder, to acquire libraries for XSLT, Schematron and XSpec support.

Test by running the [smoke tests](../smoketest/).

## Reduce

If you know you don't need a capability (such as XSpec) you don't need to install the library.

If you already have XSpec on your system, you don't need a second copy here.

Accommodate the local pipelines by editing the XSpec pipeline [../xspec/xspec-execute.xpl](../xspec/xspec-execute.xpl). At line 28 where it has

```xml
<p:variable name="xspec-home"     select="'../lib/xspec-3.0.3/'"/>
```

Change this to provide an appropriate path on your system, relative to the containing folder.

Also, the sharp-eyed will notice that XSpec also comes with its own copy of SchXSLT.

This suggests you can trim this library further by removing schxslt.

In this case, for Schematron functionality to work in your pipelines, edit the [Morgana configuration file](morgana-config.xml), line 9 (`path_to_SchXSLT_2` element), providing a path to a subdirectory where SchXSLT can be found, inside XProc or elsewhere.

[Smoke tests](../smoketest) can be used to verify functionality after reconfiguration.

---

