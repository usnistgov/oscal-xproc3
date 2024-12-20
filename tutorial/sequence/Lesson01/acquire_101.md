

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../../source/acquire/acquire_101_src.html](../../../source/acquire/acquire_101_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Project setup and installation

## Goals

Set up and run an XProc 3.0 pipeline in an XProc 3.0 engine.

Get some results. See them in the console (message tracebacks), the file system (new files acquired or produced), or both.

With a little practice, become comfortable running XProc pipelines.

After the first script to get the XProc engine, we use XProc for subsequent downloads. Finishing the setup gets you started practicing with the pipelines.

## Prerequisites

If you have not done so, scan the [tutorial readme file](../../readme.md) for some helpful background and ideas on how tutorial materials are arranged.

If ready to proceed, **you have a system with Java installed** offering a JVM (Java Virtual Machine) available on the command line (a JRE or JDK), version 8 (and later).

**Tip:** check your Java version from the console using `java --version`.

Also, **you have an Internet connection available** and the capability to download and save resources (binaries and code libraries) for local use. (There are no runtime dependencies on connecting, but some XProc pipelines make requests over `http/s`.)

**You are comfortable entering commands on the command line** (i.e. terminal or console window). For installation, you want a `bash` shell if available. On Windows, both WSL (Ubuntu) and Git Bash have been found to work. If you cannot use `bash`, the setup can be done by hand (downloading and unpacking a package from SourceForge).

After installation, subsequent work on Windows does not require `bash` unless you choose to use it – a Windows `CMD` or Powershell can serve as your environment and the processor invoked with a Windows `bat` file (as described in the documentation). Mac and Linux (and WSL) users can continue to use `bash`.

If you have already performed the setup as described in [README](../../../README.md) and [setup notes](../../../setup-notes.md), this lesson unit will be a breeze.

Prior knowledge of XProc, XSLT or XML is *not* a prerequisite (for this or any lesson unit). If you are learning as we go – at any level – welcome and please seek us out for help and feedback.

## Resources

The setup script is a `bash` script: [./setup.sh](../../../setup.sh), to be run with no arguments. See [top-level documentation](../../../setup-notes.md) if you can't use this script or if you prefer to download and unzip the dependencies by hand.

For XProc runtime — to execute pipelines — use either of the scripts [./xp3.sh](../../../xp3.sh) (under `bash`) or [./xp3.bat](../../../xp3.bat) (for Windows). These scripts are used for all pipelines (basically, for everything) unless otherwise noted.

To perform the setup: first, you download an XProc engine; then you complete setup and testing by running these pipelines. They are described in top-level [README](../../../README.md) documentation and the expected places.

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl)
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl)
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl)
* [smoketest/TEST-XPROC3.xpl](../../../smoketest/TEST-XPROC3.xpl)
* [smoketest/TEST-XSLT.xpl](../../../smoketest/TEST-XSLT.xpl)
* [smoketest/TEST-SCHEMATRON.xpl](../../../smoketest/TEST-SCHEMATRON.xpl)
* [smoketest/TEST-XSPEC.xpl](../../../smoketest/TEST-XSPEC.xpl)

## Step One: Setup

Find setup instructions for the repository in the [Project README](../../../README.md) and in the linked [Setup Notes](../../../setup-notes.md).

After reading and reviewing these documents, perform the setup on your system as instructed. To do this you can either fork or clone the repository in GitHub or simply download and decompress a zip of the [current             distribution](https://github.com/usnistgov/oscal-xproc3/archive/refs/heads/main.zip).

After running the setup script, or performing the installation by hand, make sure you can run all the smoke tests successfully.

As noted in the docs, if you happen already to have an XProc 3.0 processor, you do not need to download [Morgana XProc III](https://www.xml-project.com/morganaxproc-iiise.html) here. At time of writing (December 2024) this notably includes [XML Calabash                3](https://github.com/xmlcalabash/xmlcalabash3) (newly out in an alpha release). In any case, equipped with *any conformant XProc 3.0/3.1 implemenentation*. try skipping straight to the smoke tests. You can use a runtime script `xp3.sh` or `xp3.bat` as a model for your own, and adjust.

### Shortcut

If you want to run through the tutorial exercises but you are unsure of how deeply you will delve, you can postpone two of the installations until later:

* You will need XSpec only when you want to run tests of stylesheets or queries using the [XSpec](https://github.com/xspec/xspec) testing framework
* You will need SchXSLT only when you want to run Schematron (or XSpec tests of Schematron)

When you see tracebacks suggesting one of these is not supported, you can return to setup.

Since almost any pipeline will use XSLT and since we do use the latest version (XSLT 3.0 with XPath 3.1), consider the Saxon installation an essential requirement.

## Step Two: Confirm

The top-level README and setup notes also describe testing your installation. Do this next.

You know things are working in your XProc when two things are happening:

* On the console, notifications show up with reassuring messages announcing progress
* When you expect files to be produced for you, they appear, or are updated, as expected

Both of those will occur with this lesson. The files produced by downloading pipelines are written into the project `lib` directory, as documented. Refresh or restore by deleting the downloaded files and running the pipelines to acquire them again.

Note: you need a live Internet connection for your `http` requests to go through.

When you can run all the smoke tests without ugly tracebacks, this lesson is complete.

## Comments / review

Within this project as a whole, and within its subprojects, everything is done with XProc 3.0. The aim is to make it possible to do anything needed with XProc, regarded as a general-purpose 'scripting' solution for the choreography of arbitrarily complex jobs, tasks and workflows. To support arbitrary complexity and scalability together, it must be very simple. This simplicity, with the composability that goes with it, is at the center of the argument for XProc.

You will see this simplicity at the level of &ldquo;top-level&rdquo; *invocation* XProc pipelines designed to serve as entry points. If things are done right, these will be fairly simple, well encapsulated &ldquo;subroutines&rdquo; in potentially elegant arrangements. They in turn may call on libraries of XProc pipelines for well-defined tasks.

Effectively (and much more could be said about the processing stack, dependency management and so forth) what this means is that XProc promises the user and the developer (in either or both roles) with focused and concentrated points of control or points of adjustment. In the field – where software is deployed and used – things almost never just &ldquo;drop in&rdquo;. User interfaces, APIs, dependencies and platform quirks: all these constrain what users can do, and even developers are rarely as free as they would like to experiment and explore.

What is offered here is therefore *both* an example of a deployment of a demonstration solution set using an open-source tool (an XProc engine capable of running the pipelines we offer), doing things that are actually or potential useful (with OSCAL data), *and* a set of pipelines that should in principle work as well in any other tool or software deployment supporting XProc 3.0.

But to the extent this imposes a requirement for both abstract and testable conformance (or at any rate for interoperability as a proxy for that), this project only works if things are actually simple enough to pick up, use, learn and adapt. `xp3.sh` and `xp3.bat` represent attempts at making a simple deployment, easy to emulate but better yet, improve.

Each of these scripts (on its execution platform) enables a user to run, without further configuration, the [Morgana XProcIIIse](https://www.xml-project.com/morganaxproc-iiise.html) processor on any XProc 3.0 pipeline, assuming the appropriate platform for each (`bash` in the case of the shell script, Windows batch command syntax for the `bat` file). Providing a similar script for XML Calabash remains (with apologies to NDW) a *desideratum* for this project as we post this version of the tutorial. Stay tuned!

In any case such a script itself must be &ldquo;vanilla&rdquo; and generic: it will simply invoke the processor with the designated pipeline, and stand back. (Yes, runtime arguments and settings can be provided.) The logic of operations is entirely encapsulated in the XProc pipeline designated. XProc 3.0 is both scalable and flexible enough to open a wide range of possibilities for data processing, both XML-based and using other formats such as JSON and plain text. It is the intent of this project not to explore and map this space – which is vast – but to show off enough XProc and related logic (XSLT, XSpec) to show how this exploration can be done. We are an outfitter at the beginning of what we hope will be many profitable voyages to places we have never been.

### When running from a command line

As simple examples, these scripts show only one way of running XProc. Keep in mind that even simple scripts can be used in more than one way.

For example, a pipeline can be executed from the project root:

```
$ ./xp3.sh smoketest/TEST-XPROC3.xpl
```

Alternatively, a pipeline can be executed from its home directory, for example if currently in the `smoketest` directory (note the path to the script):

```
$ ../xp3.sh TEST-XPROC3.xpl
```

This works the same ways on Windows, with adjustments:

```
> ..\xp3 TEST-XPROC3.xpl 
```

(On Windows a `bat` file suffix marks it as executable and does not have to be given explicitly when called.)

Windows users (and others to varying degrees) can set up [a drag-and-drop based workflow](https://github.com/usnistgov/oscal-xproc3/discussions/18) – using your mouse or pointer, select an XProc pipeline file and drag it to a shortcut for the executable (Windows batch file). A command window opens to show the operation of the pipeline. See the [README](../../README.md) for more information.

It is important to try things out since any of these methods can be the basis of a workflow.

For the big picture, keep in mind that while the command line is useful for development and demonstration – and however familiar XProc itself may become to the developer – to a great number of people it remains, like XProc, obscure, cryptic and intimidating if not forbidding.

This is a pity because (among other reasons) the kind of layered system we will see and build here is not endless or infinitely complex. Begin by making yourself comfortable at the command line. See how the pieces fit together by working them.

Then too, if you have something better, by all means use it. XProc-based systems, when integrated into tools or developer editors and environments, can look much nicer than tracebacks in a console window. The elegance and power we are trying to cultivate are at a deeper level. First and last, the focus must be on the data.
