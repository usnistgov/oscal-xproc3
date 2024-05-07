# OSCAL-XProc3

[OSCAL][oscal] on an [XProc 3.0][xproc] platform

OSCAL is the Open Security Controls Assessment Language. It is a domain-specific language supporting the field of systems security and risk management (RMF), expressed in XML, JSON and other formats. This site supports primarily but *not exclusively* XML formatted OSCAL.

The XProc demonstrations and capabilities shown are not limited to OSCAL.

[TODO: split out some of the high-level discussion and guidance into a wiki?]

## Background and project goals

This project aims to make XML-based processing using commodity (open-source) tools more broadly available to users and developers of OSCAL.

The many subordinate goals include:

  - Supporting OSCAL activities such as schema testing and development
  - Providing useful models for XProc 3.0 and related standards and initiatives  

<details><summary>XProc 3.0</summary>

[XProc 3.0][xproc] is an XDM-based (XML Data Model) information processing and pipelining stack published and supported by its development community. The problems it addresses - the configuration, management and execution of complex, composable information processing *pipelines* - are in the center of any XML system, yet they are commonly dealt with - or worked around - by painful means and methods including carefully engineered and customized build utilities (Apache Ant or GNU `make`), scripts (`bash` and other), execution environments (web processing stacks), IDE workflows and proprietary solutions -- almost inevitably platform-dependent, if only because a single link with a dependency brings that dependency to the entire chain.

This has hindered the propagation of XML-based technology despite its demonstrated generality, usefuless and power, because wherever it is painful and awkward to integrate, its strengths and virtues are masked or (worse) obstructed and left unexplored.

As a standard supporting a common semantics across implementations -- itself proof-tested by a history of earlier work -- XProc 3.0 promises greater adaptability, accessibility, and scalability than prior solutions to the problem of pipeline orchestration.

[XProc 1.0][xproc1] was published as a [W3C Recommendation](http://www.w3.org/2005/10/Process-20051014/tr.html#rec-publication) in 2010. In addition to integrating the latest XSLT and XQuery technologies such as [XSLT 3.0][xslt3], [XProc 3.0][xproc-specs] (finalized 2022) represents a significant advance over XProc 1.0, being

- More streamlined and easier to learn and use
- Capable of processing and delivering any data notation, not only XML, including both JSON and plain-text-based formats (e.g. CSV, TSV etc.)

Both of these are important for OSCAL, which comes as both XML and JSON and whose users vary from the highly technical, to the bare beginner (in data formats, in OSCAL or both).
</details>

## Software description

*Process OSCAL (XML and JSON) easily on a standards-based, portable and open-source XML platform.*

This repository serves as a platform for demonstration and development of capabilities in information and data processing in support of [OSCAL, the Open Security Controls and Assessment Language][oscal], using community-standard [XProc 3.0][xproc] technology.

This may include either OSCAL applications, or applications built to be used in OSCAL development. See below and project (folder) readme files for more details.

If this software is as easy and performant as we hope, it might be useful not only to XML-stack developers but also to others who wish to cross-check their OSCAL data or software supporting OSCAL by comparison with another stack.

### Currently planned projects

Projects currently planned for deployment in this repository include:

  - `schema-field-test` OSCAL validation validation test harness - does an OSCAL schema test what you think it tests (try it and see)
  - `batch-validate` validate OSCAL in batches against schemas or schema emulators
  - `data-convert` - convert OSCAL XML into JSON and OSCAL JSON into XML
  - `display-render` - convert OSCAL catalogs (including resolved profiles) into HTML and PDF

TODO: update this list
READERS: [anything to add?][repo-issues]

Applications in this repository may occasionally have general use outside OSCAL; users who find any of its capabilities should be generalized and published separately please [create a Github Issue][repo-issues].

### Organization

The `lib` folder contents are excluded from git, and used to save third-party libraries. The `lib` library is populated by the installation script and should ordinarily be hands off.

Each project is kept in its own folder, next to the `lib` folder. In that folder, the project will have its own README.md. While projects may rely on the shared libraries, each one is considered to be discrete and independent from others unless otherwise noted.

## Software maturity

The software in this repository is at varying levels of maturity. Many stylesheets are fairly mature, having been developed and tested in other contexts. Yet work here also includes work on job configuration (XProc itself) and on testing, which is to say on tools to determine correctness and reliability, therefore (by implication) maturity. These may be experimental, not mature.

At the same time, both individual initiatives and the site as a whole follow an incremental development model. Things left as good-enough-for-now are regarded as being good enough, until experience shows us it is no longer so.

Assume the worst, hope for the best, and test.

Cloning the repository is encouraged and taken as a sign of success, as is participation in testing and development activities.

<details><summary>FAIR principles</summary>

This project is developed with an interest in FAIR principles -- **F**indable, **A**ccessible, **I**nteroperable and **R**eusable. See the [FAIR Software](./fair-software.md) page for a writeup.

At the same time, the work here is intended to provide a model for study. Any lapses from FAIRness are also therefore instructive. [Channels for discussion][repo-issues] are open.

TODO: Register this software in MIDAS and any other public listings or search portals

TODO: Anything else to make the project more FAIR
</details>

<details><summary>`TODO` convention</summary>

Documentation on this site starting with this file uses a conventional marker in plain text, `TODO`, to take passing note of tasks remaining undone or incomplete.

Project contributors can see them as either indicators that someone is paying attention (maybe to the wrong thing), or prompts for contributions.

Assuming 'TODO' items are addressed and these markers disappear, the git history for edited files will reflect this.
</details>

## Where to start

<details>
<summary>OSCAL developers</summary>

OSCAL developers may wish to use software on this site as a 'black box', without interest in its internals except insofar as they may be subject to assessment (not reverse engineering).

After following the installation instructions to download and test the core libraries, choose the application you are interested in, and start there.

- [OSCAL Schema Field Testing](./schema-field-tests/) - assessing the adequacy and correctness of schemas against their definitions

</details>
<details>
<summary>XML/XSLT/XProc developers</summary>

Software developers using and learning XProc 3.0 and the XDM stack (XML/XSLT/XQuery) may wish to open the box and see how the internals work.

Again, after installation and testing, you can start anywhere -- you have already started.
</details>

### Installation instructions

*Platform requirements*: Java, plus a `bash` shell.

Developed on Windows and tested with WSL and Git bash.

Install the libraries by running the script:

```
> ./setup.sh
```

<details><summary>Does it work?</summary>

To test your Java installation from the command line:

```
> java -version
```


You should see a nice message with your Java version, not an error or traceback.

TODO - tip for anyone with no Java?

To test your Morgana setup and installation, try the [Smoke test application](./smoketest):

```
> ./xp3.sh smoketest/POWER-UP.xpl
```

or (Windows users)


```
> .\xp3 smoketest\POWER-UP.xpl
```

Again you should see fine-looking results, this time in XML.

*FEAR NOT THE ANGLE BRACKET*

[Another page offers help](./setup-notes.md) with details on manual setup.

</details>

## Running the software

If Morgana is installed with Saxon-HE you should be good to go running any pipeline. See project readme documents for details on each project.

- [Schema Field Tests](./schema-field-tests/readme.md)

TODO: keep this list up to date

Any XProc3 pipeline can be executed using the script `xp3.sh` (`bash`) or `xp3.bat` (Windows CMD). For example:

> ./xp3.sh LAUNCH.xpl

Will initiate an XProc 3 step (pipeline) defined in the file `LAUNCH.xpl` (there is no actual pipeline of that name).

<details><summary>Drag and drop</summary>

Optionally, Windows users can use a 'batch file' command interface, with drag-and-drop functionality in the GUI (graphic user interface, your 'Desktop').

In the File Explorer, try dragging an icon for an XPL file onto the icon for `xp3.bat`. (Tip: choose a pipeline whose name is in all capitals as in 'ALL-CAPS.xpl') -- explanation below.)

Gild the lily by creating a Windows shortcut to the 'bat' file. This link can be placed on your Desktop or in another folder, ready to run any pipelines that happen to be dropped onto it. Renaming the shortcut and changing its icon are also options.

TODO: Develop and test ./xp3.sh so it too offers this functionality on \*nix or Mac platforms
  
</details>
<details><summary>Repository naming convention for XProc - `ALL-CAPS.xpr` files</summary>

For their data sources, XProc pipelines can either read from the Internet (when connected and authorized), from the local file system under user permissions (more commonly), or from inputs provided at runtime using ports on the pipeline(s) invoked.

Likewise, when run they can either write outputs (into the local file system), or expose results on output ports, or both.
A well-designed pipeline will alert its user as to these activities, effects and state changes, using comments in the code, runtime messaging, and logs as appropriate.

In this repository (not its submodules) we follow a convention that an XProc with *no exposed ports* (no output ports to bind, and no input ports to provide for) is named with ALL CAPITALS. For example, the [smoke-testing pipeline smoketest/POWER-UP.xpl](./smoketest/POWER-UP.xpl). When run, it reports outputs back to the console but does not write anywhere (unless you redirect those outputs to do so).

Such pipelines can be run with no arguments and no prior knowledge of their intended inputs and outputs, since these are all declared in the XProc itself. As processes they are also deterministic, in the sense that hard-wiring them also makes it easy to see, under simple inspection, where they read and write, following the ['rule of least power'](https://en.wikipedia.org/wiki/Rule_of_least_power) and helping the user to do so. Such a pipeline will ordinarily result in outputs to STDOUT (if only status messages) unless configured otherwise at runtime -- but they may and commonly will also write to the file system.

Other XProc pipelines represent either subpipelines, or specialized processing with ports exposed for special purposes, to be called with arguments or parameters as documented. Indeed, the only function of a 'self-contained' ALL-CAPS pipeline may be to apply subpipelines (steps defined in imported XProcs) to hard-wired inputs, producing hard-wired outputs.

(NB: this convention is unlikely to apply in repository submodules.)
</details>

## Testing

Testing is a central focus of this initiative. See [TESTING.md](./TESTING.md).

## Contact information

TODO: procure a project alias from ServiceNow

This project is being maintained by Wendell Piez, wapiez @ nist . gov of the National Institute of Standards and Technology, Information Technology Laboratory, Computer Security Division (NIST/ITL/CSD 773.03).

Please [create a Github Issue][repo-issues] or [join an OSCAL forum]() to pursue discussion on this repository. In support of this project, email to the principal investigator is also welcome.

## Related Material

<details><summary>**OSCAL**, the Open Controls and Assessment Language</summary>

- [OSCAL web site][oscal]
- [OSCAL model reference site][oscal-reference]
- [OSCAL Github code repository][oscal-repo]
- [OSCAL XSLT code repository][oscal-xslt] - has code that will be useful here

More sites and repositories are devoted to OSCAL and OSCAL tools, but these are the references to start with.

</details>
<details><summary>### XProc 3.0</summary>

Again these are only a foothold and starting place -

- [XProc community page][xproc]
- [XProc 3.0 specifications][xproc-specs]

</details>

## How to cite

Piez, Wendell (2024), OSCAL-XProc3, US National Institute of Standards and Technology (NIST), https://github.com/usnistgov/oscal-xslt3.

TODO: secure a DOI by registering the project in MIDAS, and update accordingly

## Included software and licenses

The code in this repository is all declarative, and depends on lower-level processors provided in libraries.

Currently these dependencies are:

- [Morgana XProc IIIse][morgana], by Achim Berndzen and &lt;xml-project />
- [Saxon 12.3][saxon12], from Saxonica

Both require Java, as detailed on their support pages.

See [THIRD_PARTY_LICENSES.md](./THIRD_PARTY_LICENSES.md) for more.

XProc 3.0 aims to be platform- and application-independent, so one use of this project will be to test and assess portability across environments supporting XProc. 

## Acknowledgements

With the authors of Morgana and Saxon, the many contributors to the XProc and XML stacks underlying this functionality are owed thanks and acknowledgement. These include Norman Walsh and the developers of XProc versions 1.0 and 3.0; developers of embedded commodity parsers and processers such as Java Xerces; Trang; and Apache FOP (to mention only three); and all developers of XML, XSLT, and XQuery especially open-source. Only an open, welcoming and supportive community could prove capable of such a collective achievement.

---

This README was composed using the [NIST Open Source Repository template as of April 24, 2024](https://github.com/usnistgov/opensource-repo/blob/095af7e/README.md).

---


<!-- links -->

[repo-issues]: https://github.com/usnistgov/oscal-xproc3/issues
[metaschema]: https://pages.nist.gov/metaschema
[metaschema-repo]: https://github.com/usnistgov/metaschema
[metaschema-java]: https://github.com/usnistgov/metaschema-java
[metaschema-xslt]: https://github.com/usnistgov/metaschema-xslt
[oscal]: https://pages.nist.gov/OSCAL
[oscal-reference]: https://pages.nist.gov/OSCAL-Reference
[oscal-repo]: https://github.com/usnistgov/OSCAL
[oscal-xslt]: https://github.com/usnistgov/oscal-xslt
[oscal-cli]: https://github.com/usnistgov/oscal-cli
[xslt3-functions]: https://github.com/usnistgov/xslt3-functions

[xslt]: https://www.w3.org/TR/xslt-30/
[xproc]: https://xproc.org/
[xproc-specs]: https://xproc.org/specifications.html
[xproc1]: https://xproc.org/
[xproc1-site]: https://archive.xproc.org/

[morgana]: https://www.xml-project.com/morganaxproc-iiise.html
[saxon12]: https://www.saxonica.com/documentation12/documentation.xml

