# Libraries for OSCAL XProc 3

Downloaded libraries for running the code in this repository are saved in this subdirectory.

Run [../setup.sh](../setup.sh) to save the libraries on your system, with their documentation and licensing information.

See the project [readme](../README.md), the [setup script](../setup.sh) and [setup notes](../setup-notes.md) for details regarding these dependencies.

Expect runtime errors from processing if libraries are missing or named incorrectly. Since scripts including [xp3.sh](../xp3.sh) and [xp3.bat](../xp3.bat) invocation shells use this software, adjustments must be made as software versions, locations or interfaces change.

## Look ma, no libraries

None of pipelines offered by projects in this repository depend on this particular software or installation, which is offered to provide for easy testing, enable adoption and offer demonstration to users new to XProc.

More experienced users who are already running Morgana or any capable XProc 3 processor should consider using that installation instead of, or in addition to, the repository setup. This is a useful test of capabilities and claims.

When run by any conformant XProc engine the pipelines should perform similarly and give the same results. As and when they are minimalistic, and given reasonably minor and straightforward adjustment to system paths etc., scripts should also function.

## In the subdirectory

- [readme.md](readme.md) - this file
- [morgana-config.xml](morgana-config.xml) - Morgana configuration file
- [GRAB-SAXON.xpl](GRAB-SAXON.xpl) - Saxon download and installation pipeline
- [GRAB-SCHXSLT.xpl](GRAB-SCHXSLT.xpl) - SchXSLT download pipeline
- [GRAB-XSPEC.xpl](GRAB-XSPEC.xpl) - XSpec download pipeline

## Restore

Refresh by deleting everything but the files just named.

Run [setup](../setup.sh) again (or [follow the setup notes](../setup-notes.md)) and the three `GRAB*` pipelines in the folder, to acquire libraries for XSLT, Schematron and XSpec support.

Test by running the [smoke tests](../smoketest/).

## Reduce

If you know you don't need a capability (such as XSpec) you don't need to install the library.

Since all XSpec operations are piped through a single library file, only that XProc instance needs to adjusted for a new XSpec location. Accommodate calling pipelines by editing the pipeline [../xspec/xspec-execute.xpl](../xspec/xspec-execute.xpl). Where it has

```xml
<p:variable name="xspec-home" select="'../lib/xspec-3.0.3/'"/>
```

Change this to provide an appropriate path on your system, relative to the containing folder.

Also, the sharp-eyed will notice that XSpec also comes with its own copy of SchXSLT.

This suggests you can trim this library further by using that copy of SchXSLT (or any other) instead of downloading one.

In this case, for Schematron functionality to work in your pipelines, edit the [Morgana configuration file](morgana-config.xml), updating element `/morgana-config/path_to_SchXSLT_2`) provide a path to a subdirectory where SchXSLT can be found and called.

[Smoke tests](../smoketest) can be used to verify functionality after reconfiguration.

Keep in mind that sharing information about bugs also helps reward the hard-working people who have built software - making it better for everyone and confirming the value of the effort.


---

