
> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [source/setup/setup_101_src.html](../../source/setup/setup_101_src.html) 

# XProc 101: Project setup and installation

## Goals

Run an XProc 3.0 pipeline in an XProc 3.0 engine.

With a little practice, become comfortable running XProc pipelines, seeing results on a console (command-line) window as well as in the file system.

Since pipelines can be used to download resources, after the first script to get the XProc engine, we use XProc. Finishing the setup gets you started practicing with the pipelines.

## Prerequisites

You have Java installed with a JVM (Java Virtual Machine) available on the command line, version 8.0 and 11 (and later).

You have a live Internet connection and the capability to download and save resources (binaries and code libraries) for local use.

**Tip:** check your Java version from the console using `java --version`.

You are comfortable entering commands on the command line. For installation, you want a `bash` shell if available. On Windows, both WSL (Ubuntu) and Git Bash have been found to work. If you cannot use `bash`, the setup can be done by hand (downloading and unpacking a package from SourceForge).

After installation, subsequent work on Windows does not require `bash` unless you choose to use it ??? a Windows `CMD` or Powershell can serve as your environment and the processor invoked with a Windows `bat` file (as described in the documentation).

## Resources

The setup script is a `bash` script: [./setup.sh](../../setup.sh), to be run with no arguments.

For XProc runtime -- to execute pipelines -- use either of the scripts [./xp3.sh](../../xp3.sh) (under `bash`) or [./xp3.bat](../../xp3.bat) (for Windows). These scripts are used for all pipelines (basically, for everything) unless otherwise noted.

The following pipelines will be run. They are described in top-level [README](../../README.md) documentation and the expected places.

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl)
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl)
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl)
* [smoketest/SMOKETEST-XSLT.xpl](../../../smoketest/SMOKETEST-XSLT.xpl)
* [smoketest/SMOKETEST-SCHEMATRON.xpl](../../../smoketest/SMOKETEST-SCHEMATRON.xpl)
* [smoketest/SMOKETEST-XSPEC.xpl](../../../smoketest/SMOKETEST-XSPEC.xpl)


## Step One: Setup

Find setup instructions for the repository in the [Project README](../../README.md) and in the linked [Setup Notes](../../setup-notes.md).

After reading and reviewing these documents, perform the setup as instructed. To do this you can either fork or clone the repository in Github or simply download and decompress a zip of the [current
            distribution](https://github.com/usnistgov/oscal-xproc3/archive/refs/heads/main.zip).

After running the setup script, or performing the installation by hand, make sure you can run all the smoke tests successfully.

As noted in the docs, if you happen already to have [Morgana XProc III](https://www.xml-project.com/morganaxproc-iiise.html), you do not need to download it again. Try skipping straight to the smoke tests. (You can use a runtime script `xp3.sh` or `xp3.bat` as a model for your own, and adjust. Any reasonably recent version of Morgana should function if configured correctly, and we are interested if it does not.) 

### Shortcut

If you want to run through the tutorial exercises but you are unsure of how deeply you will delve, you can postpone two of the installations until later:

* You will need SchXSLT only when you want to run Schematron
* You will need XSpec only when you want to run XSpec unit tests


When you see tracebacks suggesting one of these is not supported, you can return to setup.

Since almost any pipeline will use XSLT and since we do use the latest version (XSLT 3.0/3.1), consider the Saxon installation an essential requirement.

## Step Two: Confirm

The top-level README and setup notes also describe testing your installation. Do this next.

You know things are working in your XProc when either or both of two things are happening:

* On the console, notifications show up with reassuring messages announcing progress
* When you expect files to be produced, they appear (or are updated) as expected


Both of those will occur with this lesson. The files produced by downloading scripts are written into the project `lib` directory, as documented. Refresh or restore by deleting the downloaded files and running the pipelines to acquire them again.

Note: you need a live Internet connection for your http requests to go through.

When you can run all the smoke tests without ugly tracebacks, this lesson is complete.

## Comments / review

Within the project as a whole, everything is done with XProc 3.0, meaning everything can be done using a single script, which invokes an XProc processor to read and execute a pipeline.

Among other benefits, this makes an XProc-based system largely or entirely platform-independent and portable. And this portability does not require a dedicated environment, only a Java Virtual Machine (JVM).

`xp3.sh` and `xp3.bat` are examples of such scripts written for this project. Either of them enables a user to run, without further configuration, the [Morgana XProcIIIse]() processor on any XProc 3.0 pipeline, assuming the appropriate platform for each (`bash` in the case of the shell script, Windows batch command syntax for the `bat` file). Other platforms supporting Java (and hence Morgana with its libraries) could be provided with similar scripts. (Pull request opportunity.)

XProc 3.0 is both scalable and flexible enough to open a wide range of possibilities for data processing, both XML-based and using other formats such as JSON and plain text. The scripts in the repo show only one way of running XProc. Keep in mind that even simple scripts can be used in more than one way. 

For example, a pipeline can be executed from the project root:

```
$ ./xp3.sh smoketest/POWER-UP.xpl
```

Alternatively, a pipeline can be executed from its home directory, for example if currently in the `smoketest` directory (note the path to the script): 

```
$ ../xp3.sh POWER-UP.xpl
```

This works the same ways on Windows, with adjustments: 

```
> ..\xp3 POWER-UP.xpl 
```

(On Windows a `bat` file suffix marks it as executable and does not have to be given explicitly when calling.)

Windows users (and others to varying degrees) can set up a drag-and-drop based workflow - using your mouse or pointer, select an XProc pipeline file and drag it to a shortcut for the executable (Windows batch file). A command window opens to show the operation of the pipeline. See the [README](../../README.md) for more information.

It is important to try things out since any of these methods can be the basis of a workflow. 

For the big picture, also keep in mind that while the command line is useful for development and demonstration, it can be obscure and cryptic. XProc-based systems, when integrated into tools or developer editors and environments, can look much nicer than tracebacks in a console window.
