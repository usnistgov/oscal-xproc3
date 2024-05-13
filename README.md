# OSCAL-XProc3

[OSCAL][oscal] on an [XProc 3.0][xproc] platform

OSCAL is the Open Security Controls Assessment Language. It is a domain-specific language supporting the field of systems security, security assessment and risk management (RMF), expressed in XML, JSON and other formats. This site supports primarily but *not exclusively* XML-formatted OSCAL.

The XProc demonstrations and capabilities shown are not limited to OSCAL.

## Background and project goals

This project aims to make XML-based processing using commodity (open-source) tools more broadly available, useful, reliable and intelligible, especially to users and developers of OSCAL.

The many subordinate goals include:

  - Supporting OSCAL activities such as schema testing and development
  - Providing useful applications and models for study, showing XProc 3.0 and related standards and initiatives  

Learn more about XProc in [researching-xproc.md](./researching-xproc.md).

## Software description

*Process OSCAL (XML and JSON) easily on a standards-based, portable and open-source XML platform.*

This repository serves as a platform for demonstration and development of capabilities in information and data processing in support of [OSCAL, the Open Security Controls and Assessment Language][oscal], using community-standard [XProc 3.0][xproc] technology.

This may include either OSCAL applications, or applications built to be used in OSCAL development. See below and project (folder) readme files for more details.

If this software is as easy and performant as we hope, it might be useful not only to XML-stack developers but also to others who wish to cross-check their OSCAL data or software supporting OSCAL by comparison with another stack.

### Currently planned projects

Projects currently planned for deployment in this repository include:

  - [`schema-field-test](./schema-field-test)` OSCAL "validation validation" test harness (you read that right) - validating the validator or testing the examiner: does an OSCAL schema validator test what you think it tests? (try it and see)
    - Find and demonstrate modeling or conformance issues in schemas or processors
    - Conversely, demonstrate conformance of validators and design of models
    - Showcase differences between valid and invalid documents, especially edge cases
  - `batch-validate` validate OSCAL in batches against schemas and schema emulators
  - `data-convert` - convert OSCAL XML into JSON and OSCAL JSON into XML
  - `display-render` - convert OSCAL catalogs (including resolved profiles) into HTML and PDF

TODO: update this list
READERS: [anything to add?][repo-issues]

Applications in this repository may occasionally have general use outside OSCAL; users who find any of its capabilities should be generalized and published separately please [create a Github Issue][repo-issues].

### Organization

`lib` and `testing` folders are special; others represent projects.

The `lib` folder comes bare bones - it has only its readme, a configuration file and a couple of utility pipelines. This library is populated by the [installation script](./setup.sh), ahnd (once the basic setup is done) by these same utility pipelines.

`lib` can be cleaned up, and restored, more or less with impunity, but if it disappears or its contents are renamed, rearranged or altered, things will cease working - see its [readme](./lib/readme.md) for more information.

Next to `lib`, each project is kept in its own separate folder. There, the project will have its own README.md. While projects may rely on the shared libraries, each one is considered to be discrete and independent from others unless otherwise noted.

One such project is [smoketest](./smoketest), devoted to testing the software installation both in its basic and 'fully assembled' forms.

The `testing` directory contains tests and logic applicable to the repository or its contents, such as Schematron governing usage of XProc or other formats - XML-based code introspection. As this is still in development, it can be expected to change and grow.

## Software maturity

The software in this repository is at varying levels of maturity. Many stylesheets are fairly mature, having been developed and tested in other contexts. Yet work here also includes job configuration (XProc itself) and testing, which is to say on tools to determine correctness and reliability, therefore (by implication) maturity. These may be experimental, not mature.

At the same time, both individual initiatives and the site as a whole follow an incremental development model. Things left as good-enough-for-now are regarded as being good enough, until experience shows us it is no longer so. Punctuated equilibrium is normal.

Assume the worst, hope for the best, and test.

Cloning the repository is encouraged and taken as a sign of success. So is any participation in testing and development activities.

<details><summary>FAIR principles</summary>

This project is developed with an interest in FAIR principles &mdash; **F**indable, **A**ccessible, **I**nteroperable and **R**eusable. See the [FAIR Software](./fair-software.md) page for a writeup.

At the same time, the work here is intended to provide a model for study. Any lapses from FAIRness are also therefore instructive. [Channels for discussion][repo-issues] are open.

TODO: Register this software in MIDAS and any other public listings or search portals

TODO: Anything else to make the project more FAIR
</details>

<details><summary>House rules</summary>

Contributors are expected to follow [CONTRIBUTORS](./CONTRIBUTORS.md) guidelines and to try to [be FAIR](fair-software.md); additionally there are some [house rules](house-rules.md). Since there is a house rule against making rules with no mechanism for enforcement or amelioration, constraints are light and mainly regard coding conventions.

</details>
<details><summary>`TODO` annotation convention</summary>

A house rule: documentation on this site starting with this file uses a conventional marker in plain text, `TODO`, to take passing note of tasks remaining undone or incomplete.

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

After installation and testing, you can start anywhere &mdash; you have already started.
</details>

### Installation instructions

*Platform requirements*: Java, with a `bash` shell for automated installation. (Only Java is required if you can install manually.)

Developed on Windows and tested with WSL, Git bash, and Windows Powershell.

I. Install the XProc3 engine by running the script:

```
> ./setup.sh
```

The [setup-notes](./setup-notes.md) file provides a walkthrough of what this script does, if `bash` does not come through -- the setup can be done by hand.

After setup, you should now be able to run bare-bones XProc - a pipeline processor (Morgana) with rudimentary capabilities. How to run any of these pipelines is [detailed below](#running-the-software).

If impatient to test, review **Does It Work?** below before proceeding.

The next steps both test the runtime, and provide Morgana with more power, namely XSLT for transformations (using Saxon), and Schematron for query-based validation (using SchXLST).

SchXSLT is written in XSLT and requires Saxon, so run (and test) the Saxon pipeline first.

II. To install Saxon: [lib/GRAB-SAXON.xpl](lib/GRAB-SAXON.xpl)

To test Saxon: [smoketest/SMOKETEST-XSLT.xpl](smoketest/SMOKETEST-XSLT.xpl)

III. To install SchXSLT: [lib/GRAB-SCHXSLT.xpl](lib/GRAB-SCHXSLT.xpl)

To test SchXSLT: [smoketest/SMOKETEST-SCHEMATRON.xpl](smoketest/SMOKETEST-SCHEMATRON.xpl)

<details><summary>**Does it work?**</summary>

To test your Java installation from the command line:

```
> java -version
```

You should see a nice message with your Java version, not an error or traceback.

TODO - tip for anyone with no Java?

**Smoke test**

To test Morgana, try the [Smoke test application](./smoketest):

```
> ./xp3.sh smoketest/POWER-UP.xpl
```

or (Windows users, from a command line or Powershell window)

```
> .\xp3 smoketest\POWER-UP.xpl
```

Again you should see fine-looking results, this time in XML.

*FEAR NOT THE ANGLE BRACKET*

**Other smoke tests**

After installing Saxon, the smoke test [smoketest/SMOKETEST-XSLT.xpl](smoketest/SMOKETEST-XSLT.xpl) will function, returning sensible outputs.

After installing SchXSLT, the smoke test [smoketest/SMOKETEST-SCHEMATRON.xpl](smoketest/SMOKETEST-SCHEMATRON.xpl) will function, returning sensible outputs.

[Another page offers help](./setup-notes.md) with details on manual setup.

</details>

## Running the software

If Morgana is installed with Saxon-HE you should be good to go running any pipeline. See project readme documents for details on each project.

- [Schema Field Tests](./schema-field-tests/readme.md)

TODO: keep this list up to date

Any XProc3 pipeline can be executed using the script `xp3.sh` (`bash`) or `xp3.bat` (Windows CMD). For example:

> ./xp3.sh LAUNCH.xpl

Will initiate an XProc 3 step (pipeline) defined in the file `LAUNCH.xpl` (there is no actual pipeline of that name).

Note that a pipeline may run successfully without XSLT or Schematron support, if the pipeline itself does not depend on these capabilities.

<details><summary>ALL-CAPS file naming convention</summary>

In this repository, an XProc pipeline (step) named in all capitals, as in `ALL-CAPS.xpr`, is a "standalone" pipeline step, meaning it works without having to set any external bindings or options.

See the [House Rules](./house-rules.md) for more information.

(NB: this convention is unlikely to apply in repository submodules.)
</details>

<details><summary>Drag and drop (Windows only)</summary>

Optionally, Windows users can use a 'batch file' command interface, with drag-and-drop functionality in the GUI (graphic user interface, your 'Desktop').

In the File Explorer, try dragging an icon for an XPL file onto the icon for `xp3.bat`. (Tip: choose a pipeline whose name is in all capitals as in 'ALL-CAPS.xpl') &mdash; explanation below.)

Gild the lily by creating a Windows shortcut to the 'bat' file. This link can be placed on your Desktop or in another folder, ready to run any pipelines that happen to be dropped onto it. Renaming the shortcut and changing its icon are also options.

TODO: Develop and test [./xp3.sh](./xp3.sh) so it too offers this functionality on \*nix or Mac platforms - lettuce know &#x1F96C; if you want or can do this
  
</details>

## Testing

Testing is a central focus of this initiative. See [TESTING.md](./TESTING.md).

Some repository-wide testing, not for functionality but for other requirements, is maintained in the [testing](./testing) directory.

## Contact information

TODO: procure a project alias from ServiceNow

This project is being maintained by Wendell Piez, w a p i e z @ n i s t . g o v of the National Institute of Standards and Technology, Information Technology Laboratory, Computer Security Division (NIST/ITL/CSD 773.03).

Please [create a Github Issue][repo-issues] or [pursue an OSCAL lead](https://pages.nist.gov/OSCAL/contact/) for discussion on this repository. In support of this project, email to the principal investigator is also welcome.

## Related Material

<details><summary>OSCAL, the Open Security Controls and Assessment Language</summary>

- [OSCAL web site][oscal]
- [OSCAL model reference site][oscal-reference]
- [OSCAL Github code repository][oscal-repo]
- [OSCAL XSLT code repository][oscal-xslt] - has code that will be useful here

More sites and repositories are devoted to OSCAL and OSCAL tools, but these are the references to start with.

</details>
<details><summary>XProc 3.0</summary>

Only a foothold and starting place -

- [XProc community page][xproc]
- [XProc 3.0 specifications][xproc-specs]

For more on XProc see the page [Researching XProc](./researching-xproc.md)
</details>

## How to cite

Piez, Wendell (2024), OSCAL-XProc3, US National Institute of Standards and Technology (NIST), https://github.com/usnistgov/oscal-xslt3.

TODO: secure a DOI by registering the project in MIDAS, and update accordingly

## Included software and licenses

The code in this repository is all declarative, and depends on lower-level processors provided in libraries.

Currently these dependencies are:

- [Morgana XProc IIIse][morgana], by Achim Berndzen and &lt;xml-project />
- [Saxon 12.3][saxon12], from Saxonica
- [SchXSLT][schxslt], by David Maus

Morgana and Saxon both require Java, as detailed on their support pages. SchXSLT requires XSLT, hence Saxon.

See [THIRD_PARTY_LICENSES.md](./THIRD_PARTY_LICENSES.md) for more.

XProc 3.0 aims to be platform- and application-independent, so one use of this project will be to test and assess portability across environments supporting XProc. 

## Acknowledgements

With the authors of incorporated tooling, the many contributors to the XProc and XML stacks underlying this functionality are owed thanks and acknowledgement. These include Norman Walsh and the developers of XProc versions 1.0 and 3.0; developers of embedded commodity parsers and processers such as Java Xerces; Trang; and Apache FOP (to mention only three); and all developers of XML, XSLT, and XQuery especially open-source. Only an open, welcoming and supportive community could prove capable of such a collective achievement.

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

[xdm3]: https://www.w3.org/TR/xpath-datamodel/
[xslt3]: https://www.w3.org/TR/xslt-30/
[xproc]: https://xproc.org/
[xproc-specs]: https://xproc.org/specifications.html
[xproc1]: https://xproc.org/
[xproc1-site]: https://archive.xproc.org/
[ixml]: https://invisiblexml.org
[morgana]: https://www.xml-project.com/morganaxproc-iiise.html
[saxon12]: https://www.saxonica.com/documentation12/documentation.xml
[schxslt]: https://github.com/schxslt/schxslt

