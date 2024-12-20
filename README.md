# OSCAL-XProc3

**[OSCAL][oscal] on an [XProc 3.0][xproc] platform**

OSCAL is the [Open Security Controls Assessment Language][oscal]. It is a domain-specific language (DSL) supporting the field of systems security, security assessment and risk management (RMF), expressed in XML, JSON and other formats. This site supports primarily but *not exclusively* XML-formatted OSCAL.

The XProc demonstrations and capabilities shown are not limited to OSCAL.

## Background and project goals

This project aims to make XML-based processing using commodity (open-source) tools more broadly available, useful, reliable and intelligible, especially to users and developers of OSCAL.

The many subordinate goals include:

  - Supporting OSCAL activities such as schema testing and development
  - Providing useful applications and models for study, showing XProc 3.0 and related standards and initiatives  

Learn more about XProc in [researching-xproc.md](./researching-xproc.md).

## Software description

*Process OSCAL (XML and JSON) easily on a standards-based, portable and open-source XML platform.*

This repository serves as a platform for demonstration and development of capabilities in information and data processing in support of [OSCAL, the Open Security Controls and Assessment Language][oscal], using publicly-specified [XProc 3.0][xproc] technology.

This may include either OSCAL applications, or applications built to be used in OSCAL development such as production of OSCAL tools. See below and project (folder) readme files for more details.

Enabling these lightweight, transparent and declarative "logical layers" written in XProc (pipeline step definitions), in XSLT (transformations) and in Schematron (query-based validations) are these excellent libraries (with their dependencies):

- [Morgana XProc IIIse][morgana] - XProc 3.0
- [Saxon-HE][saxon12] - XSLT 3.0/3.1 (and XQuery)
- [SchXSLT][schxslt] - ISO Schematron / community enhancements
- [XSpec][xspec] - XSpec - XSLT/XQuery unit testing

As an alternative to Morgana, users are also invited to test [XML Calabash 3][xmlcalabash3]. At time of writing, this release is too new to be incorporated into the project, but appears promising as an alternative platform for everything demonstrated here. Among the project goals is demonstrating portability in principle and fact - if only because at the extremes, the viability of a code base across implementations becomes a data security issue.

These are open-source projects in support of W3C- and ISO-standardized technologies. Helping to install, configure, and make these work seamlessly, so users do not have to notice, is also a goal of this project.

If this software is as easy, securable and performant as we hope to show, it might be useful not only to XML-stack developers but also to others who wish to cross-check their OSCAL data or software supporting OSCAL by comparison with another stack.

### XProc testbed

XProc developers, similarly, may be interested in this project as a testbed for performance and conformance testing.

This deployment is also intended to demonstrate conformance to relevant standards and external specifications, not just to APIs and interfaces defined by tool sets.

### Projects

See the [Projects folder](./projects/) for current projects. Projects now planned for deployment in this repository include:

   - [`oscal-convert`](projects/oscal-convert/) - convert OSCAL XML into JSON and OSCAL JSON into XML
  - [`oscal-publish`](projects/oscal-publish/) - convert OSCAL catalogs (including resolved profiles) into HTML (and with XProc support, PDF)
  - [`profile-resolution`](projects/profile-resolution) - run and test NIST XSLTs for rendering a profile into its catalog of controls
  - [`xproc-doc`](projects/xproc-doc) XProc 3.0 documentation produced using XProc, often from the specifications
 - [`schema-field-tests`](projects/schema-field-tests) OSCAL "validation validation" test harness (you read that right) - validating the validator or testing the examiner: does an OSCAL schema validator test what you think it tests? (try it and see)
    - Find and demonstrate modeling or conformance issues in schemas or processors
    - Conversely, demonstrate conformance of validators and design of models
    - Showcase differences between valid and invalid documents, especially edge cases
  - [`cprt-import`](projects/cprt-import/) - produce OSCAL from a raw JSON feed (not OSCAL) - demonstrating conversion of NIST CPRT [NIST SP 800-171](https://csrc.nist.gov/projects/cprt/catalog#/cprt/framework/version/SP_800_171_3_0_0/home) into OSCAL
  - [`FM6-22-import`](projects/FM6-22-import/) - produce OSCAL from PDF via HTML and NIST STS formats - a demonstration showing conversion of a 'high-touch' document into OSCAL, namely US Army Field Manual 6-22 Chapter 4 "Developing Leadership", mapping its structures into STS and OSCAL formats
  - `batch-validate` validate OSCAL in batches against schemas and schema emulators
  - `index-oscal` - produce indexes to information encoded in OSCAL  

TODO: update this list

READERS: [anything to add?][repo-issues]

Applications in this repository may occasionally have general use outside OSCAL; users who find any of its capabilities should be generalized and published separately please [create a Github Issue][repo-issues].

### Organization

Folders outside `projects` including `lib`, `smoketest`, `project-template`, `testing`, `icons` and (hidden) `.github` folders serve the repository as a whole; specific applications are all to be found among [projects](./projects/).

An exception to this is the [tutorial](./tutorial/), which is a project, but also uses the projects as its source, so is kept apart from the other applications as a "global" project.

[The `lib` directory](./lib) comes bare bones - it has only its readme, a configuration file and a couple of utility pipelines. This library is populated by the [installation script](./setup.sh), and (once the basic setup is done) by running the pipelines.

`lib` can be cleaned up, and restored, more or less with impunity, but if it disappears or its contents are renamed, rearranged or altered, things will cease working - see its [readme](./lib/readme.md) for more information.

Within  [projects](./projects), each project is kept in its own separate folder. There, the project will have its own **readme.md**. While projects may rely on the shared libraries, each one is considered as its own starting point. As projects can not only 'cross-pollinate', but also call one another's logic directly as long as all resources are available), experiment is easy - so care must be taken.

At the top level (not stored as a project), pipelines in [smoketest](./smoketest) are devoted to testing the software installation both in its basic installation and fully configured and equipped.

[The `project-template` directory](./project-template) contains a blank project template. Copy and rename this folder for a quick start on XProc infrastructure for your project. It contains boilerlate documentation and logic ready for rewriting.

(TODO: instead of hand copy/paste, XProc for this can generate a customized copy.)

[The `testing` directory](./testing) contains tests and logic applicable to the repository or its contents, such as Schematron governing usage of XProc or other formats - XML-based code introspection. As this is still in development, it can be expected to change and grow.

[`tutorial`](./tutorial) contains a tutorial (work in progress at time of writing) based on project walkthroughs.

The [`xspec` directory](./xspec) contains pipeline support for XSpec, the unit testing framework for XSLT and XQyery. This is saved here inasmuch as it is considered intfrastructure, not a project.

Finally, the [`icons` directory](./icons) holds SVG and Windows icon files that can be associated with scripts or file types.

## Software maturity

The software in this repository is at varying levels of maturity. Many stylesheets are fairly mature, having been developed and tested in other contexts. Yet work here also includes job configuration (XProc itself) and testing, which is to say on tools to determine correctness and reliability, therefore (by implication) maturity. These may be experimental, not mature.

At the same time, the libraries we use (Morgana, Saxon and others) are themselves at various levels of maturity (Saxon in particular having been field-tested for over 20 years). And both particular initiatives and the code repository as a whole follow an incremental development model. Things left as good-enough-for-now are regarded as being good enough, until experience shows us it is no longer so. Punctuated equilibrium is normal. New contrivances are made of old and reliable parts.

*Assume the worst, hope for the best, and test.*

Cloning the repository is encouraged and taken as a sign of success. So is any participation in testing and development activities.

<details><summary>FAIR principles</summary>

This project is developed with an interest in FAIR principles &mdash; **F**indable, **A**ccessible, **I**nteroperable and **R**eusable. See the [FAIR Software](./fair-software.md) page for a writeup.

At the same time, the work here is intended to provide a model for study. Any lapses from FAIRness are also therefore instructive. [Channels for discussion][repo-issues] are open.

TODO: Register this software in MIDAS and any other public listings or search portals

TODO: Anything else to make the project more FAIR
</details>

<details><summary>House rules</summary>

Contributors are expected to follow [CONTRIBUTORS](./CONTRIBUTORS.md) guidelines and to try to [be FAIR](fair-software.md); additionally there are some [house rules](./testing/house-rules.md). Since there is a house rule against making rules with no mechanism for enforcement or amelioration, constraints are light and mainly regard coding conventions.

</details>
<details><summary>`TODO` annotation convention</summary>

A house rule: documentation on this site starting with this file uses a conventional marker in plain text, `TODO`, to take passing note of tasks remaining undone or incomplete.

Project contributors can see them as either indicators that someone is paying attention (maybe to the wrong thing), or prompts for contributions.

Assuming 'TODO' items are addressed and these markers disappear, the git history for edited files will reflect this.
</details>

<details>
<summary>Innovations</summary>

As of mid-2024, we believe some aspects of this initiative are innovative or unusual, even as it stands on foundations laid by others. Please let us know of relevant prior art, or independent invention, especially if it anticipates the work here. It is to be hoped that some of these applications are "obvious" and not as new as we think at least in conception.

#### Pipelines for &ldquo;self setup&rdquo;

After a single script is run to download and unpack, all setup and configuration is done with pipelines. Like all XProc pipelines in the repo these can be edited or adjusted, enabling the developer or user to override or customize the setup easily, or to perform it manually.

#### XProc 3.0-based CI/CD

After a single installation of a Java application to initialize (Morgana XProcIIIse), XProc itself is used to define and drive all installation, extraction, building, testing and deployment under continuous integration / continuous development (CI/CD).

This includes testing for all included capabilities and upstream dependendencies (XSLT, Schematron, XSpec, iXML etc.), protecting the ongoing integrity of the build and runtimes.

#### Batch runtimes in XProc 3.0

File lists are maintained in XProc 3.0 for batch processing. This includes files to be validated with a schema or Schematron, XSpec test files to be compiled and run, or any other processes to be run on sets of files. Lists are cross-checked against sources using Schematron to ensure link integrity.

Batch runtime results, including reports, can be aggregated using XProc and XSLT.

#### Prototype implementation of XSpec under XProc 3.0

This repository supports running [XSpec][xspec] to test XSLT, Schematron and XQuery.

Because it runs under XProc, XSpec becomes available to any project as well as CI/CD.

Assuming it holds up under use and testing, we hope to be able to contribute this work into the XSpec repository (XSpec developers please take note), if not to retire it in favor of a better implementation.

#### New XSLT maintenance model (demonstration) &mdash; patching XSLT on the fly

When we discover bugs in dependent processes, we can not only report them as bugs (to the upstream project), but also mitigate them in place. Since XSLT transformations are in XML, we can use XProc and XSLT to modify any XSLT discovered to have bugs and lapses.

The code capturing such a modification provides a patch to upstream developers, who can refer to it easily to discover, analyze and evaluate our problem diagnosis and solution in its home context, at any later point.

And until this is done, we can run ahead, while proceeding to use the feature in question as modified.

Examples of this can be found in the (XSpec implementation pipeline)(xspec/xspec-execute.xpl), which (at time of writing) offers patches to an XSLT provided in the XSpec repository.

#### Loosely coupled projects

Projects each have their own libraries and dependencies in addition to the common (platform) dependencies. Consequently the repository as a whole can easily be pared down to just a minimalistic implementation of one or a few functionalities or applications, for demonstration or further development.

This makes cloning and further development easier.

</details>

## Where to start

One way to start is to dive into the [Tutorial](tutorial/readme.md). This introduction to XProc does not assume prior XML expertise, only a willingness to learn.

<details>
<summary>OSCAL developers</summary>

OSCAL developers may wish to use software on this site as a 'black box', without interest in its internals except insofar as they may be subject to assessment (not reverse engineering).

After following the installation instructions to download and test the core libraries, choose the application you are interested in, and start there.

- [OSCAL Schema Field Testing](./schema-field-tests/) - assessing the adequacy and correctness of schemas against their definitions
- [OSCAL Profile Resolution](./profile-resolution/) - producing a catalog of controls from an OSCAL profile, representing a control baseline or catalog overlay

</details>
<details>
<summary>XML/XSLT/XProc developers</summary>

Software developers using and learning XProc 3.0 and the XDM stack (XML/XSLT/XQuery) may wish to open the box and see how the internals work.

After installation and testing, you can start anywhere &mdash; you have already started.

- [Project starter template](./template/) - Blank readmes with a working pipeline ready for adaptation

</details>

<details>
<summary>Tutorial</summary>

An [XProc tutorial](tutorial/sequence/lesson-sequence.md) is offered on this site - it provides an introduction to XProc aimed at a range of users at different levels, with walkthroughs of the project pipelines with detailed explanations of features, methods and techniques they illustrate.
</details>


### Installation instructions

Needed only if you do not already have an XProc 3 engine such as Morgana or XML Calabash. If you already have support for XProc 3, consider using your available tooling, instead or in addition to the runtime offered.

(Any bugs you find in doing so can be addressed and the entire repository "hardened" thereby -- one of the beneficial network effects of multiple implementations of a standard.)

*Platform requirements*: Java, with a `bash` shell for automated installation. Only Java is required if you can install manually.

Developed on Windows and tested with WSL, Git bash, and Windows Powershell.

I. Install the XProc3 engine by running the script:

```bash
./setup.sh
```

The [setup-notes](./setup-notes.md) file provides a walkthrough of what this script does, if `bash` does not come through: the setup can be done by hand.

After setup, you should now be able to run bare-bones XProc using a pipeline processor (Morgana) with rudimentary capabilities. How to run any of these pipelines is [detailed below](#running-the-software).

A simple pipeline, [smoketest/TEST-XPROC3.xpl](smoketest/TEST-XPROC3.xpl) can be used to verify your installation works. More details are given below. (**Does It Work?**)

The next steps both help to accustom you to the engine, and provide Morgana with more power, namely XSLT for transformations (using Saxon), and Schematron for query-based validation (using SchXLST).

SchXSLT is written in XSLT and requires Saxon, so run (and test) the Saxon pipeline first.

II. To install Saxon: [lib/GRAB-SAXON.xpl](lib/GRAB-SAXON.xpl)

To test Saxon: [smoketest/TEST-XSLT.xpl](smoketest/TEST-XSLT.xpl)

III. To install SchXSLT: [lib/GRAB-SCHXSLT.xpl](lib/GRAB-SCHXSLT.xpl)

To test SchXSLT: [smoketest/TEST-SCHEMATRON.xpl](smoketest/TEST-SCHEMATRON.xpl)

IV. To install XSpec: [lib/GRAB-XSPEC.xpl](lib/GRAB-XSPEC.xpl)

To test XSPec: [smoketest/TEST-XSPEC.xpl](smoketest/TEST-XSPEC.xpl)

<details><summary><bold>Does it work?</bold></summary>

To test your Java installation from the command line:

```bash
java -version
```

You should see a nice message with your Java version, not an error or traceback.

TODO - tip for anyone with no Java?

**Smoke test**

To test Morgana, try the [Smoke test application](./smoketest):

```bash
./xp3.sh smoketest/TEST-XPROC3.xpl
```

or (Windows users, from a command line or Powershell window)

```bash
.\xp3 smoketest\TEST-XPROC3.xpl
```

Again you should see fine-looking results, this time in XML.

*FEAR NOT THE ANGLE BRACKET*

**Other smoke tests**

After installing Saxon, the smoke test [smoketest/TEST-XSLT.xpl](smoketest/TEST-XSLT.xpl) will function, returning sensible outputs.

After installing SchXSLT, the smoke test [smoketest/TEST-SCHEMATRON.xpl](smoketest/TEST-SCHEMATRON.xpl) will function, returning sensible outputs.

After installing XSpec, the smoke test [smoketest/TEST-XSPEC.xpl](smoketest/TEST-XSPEC.xpl) will function, returning sensible outputs.

[Another page offers help](./setup-notes.md) with details on manual setup.

</details>

## Running the software

If Morgana is installed with Saxon-HE you should be good to go running any pipeline. See project readme documents for details on each project.

See the [projects/](./projects/) directory with a list of projects - each should have a readme.

Or jump to these projects:

- [XProc Tutorial](tutorial/readme.md) provides step-by-step instructions and play-by-play commentary. 
- [Schema Field Tests](./schema-field-tests) - Testing whether OSCAL schemas correctly enforce rules over data (with surprises)
- [OSCAL Profile Resolution](./profile-resolution) - converting an OSCAL profile (representing a baseline or overlay) into its catalog of controls
- Produce OSCAL from other data formats: from raw JSON source in [CPRT import](projects/CPRT-import/); or from PDF source via HTML and XML conversions[FM6-22 import](projects/FM6-22-import)

Any XProc3 pipeline can be executed using the script `xp3.sh` (`bash`) or `xp3.bat` (Windows CMD). For example:

```bash
./xp3.sh LAUNCH.xpl
```

Will initiate an XProc 3 step (pipeline) defined in the file `LAUNCH.xpl` (or return an error when no pipeline is found by that name).

Note that a pipeline may run successfully without XSLT or Schematron support, if the pipeline itself does not depend on these capabilities.

Similarly, the Morgana installation provided by this project is not the only way to run XProc - these pipelines will work just as well in any other conformant XProc 3.0 engine or processing environment.

<details><summary>ALL-CAPS file naming convention</summary>

In this repository, an XProc pipeline (step) named in all capitals, as in `ALL-CAPS.xpr`, is a "standalone" pipeline step, meaning it works without having to set any external bindings or options.

See the [House Rules](./house-rules.md) for more information.

(NB: this convention is unlikely to apply in repository submodules.)

</details>

<details><summary>Drag and drop (Windows only)</summary>

[Optionally, Windows users can use a batch file command interface](https://github.com/usnistgov/oscal-xproc3/discussions/18), with drag-and-drop functionality in the GUI (graphical user interface, your 'Desktop').

In the File Explorer, try dragging an icon for an XPL file onto the icon for `xp3.bat`. (Tip: choose a pipeline whose name is in all capitals, as in 'ALL-CAPS.xpl' &mdash; explanation below.)

Gild the lily by creating a Windows shortcut to the 'bat' file. This link can be placed on your Desktop or in another folder, ready to run any pipelines that happen to be dropped onto it. Renaming the shortcut and changing its icon are also options. Some icons for this purpose are provided [in the repository](./icons/).

TODO: Develop and test [./xp3.sh](./xp3.sh) (or scripts to come) so it too offers this or equivalent functionality on \*nix or Mac platforms - AppleScript! - lettuce know &#x1F96C; if you want or can do this

</details>

## Testing

Testing is a central focus of this initiative. See [TESTING.md](./TESTING.md).

Some repository-wide testing, not for functionality but for other requirements, is maintained in the [testing](./testing) directory.

## Contact the project

- [Create a Github Issue][repo-issues]
- [Pursue an OSCAL lead](https://pages.nist.gov/OSCAL/contact/)
- Send email to [xslt-interest@nist.gov](mailto:xslt-interest@nist.gov)

This project is being maintained by Wendell Piez, w a p i e z @ n i s t . g o v of the National Institute of Standards and Technology, Information Technology Laboratory, Computer Security Division (NIST/ITL/CSD 773.03).

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

As noted above, however, all software is also conformant with relevant open-source language specifications, and should deliver the same results, verifiably, using other software that follows the same specifications, including XProc and XSLT processors yet to be developed.

XProc 3.0 aims to be platform- and application-independent, so one use of this project will be to test and assess portability across environments supporting XProc. 

## XProc platform acknowledgements

With the authors of incorporated tooling, the many contributors to the XProc and XML stacks underlying this functionality are owed thanks and acknowledgement. These include

- [Henry Thompson](https://www.xml.com/pub/a/ws/2001/02/21/devcon1.html) and other pioneers of structured data pipelining on a standards basis
- Committee members and developers of XProc versions 1.0 and 3.0, especially Norm Walsh, chair and exemplar of graceful persistence
- Developers of embedded commodity parsers and processers such as Java Xerces, Trang, and Apache FOP (to mention only three)
- All developers of XML, XSLT, and XQuery technologies and applications, especially unencumbered and open-source
 
Only an open, dedicated and supportive community could prove capable of such a collective achievement.

This work is dedicated to the grateful memory of Michael Sperberg-McQueen and to all his students, past and future.

---

This README was composed starting from the [NIST Open Source Repository template as of April 24, 2024](https://github.com/usnistgov/opensource-repo/blob/095af7e/README.md).

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
[xmlcalabash3]: https://github.com/xmlcalabash/xmlcalabash3 
[xslt3]: https://www.w3.org/TR/xslt-30/
[xproc]: https://xproc.org/
[xproc-specs]: https://xproc.org/specifications.html
[xproc1]: https://xproc.org/
[xproc1-site]: https://archive.xproc.org/
[xspec]: https://github.com/xspec/xspec
[ixml]: https://invisiblexml.org
[morgana]: https://www.xml-project.com/morganaxproc-iiise.html
[saxon12]: https://www.saxonica.com/documentation12/documentation.xml
[schxslt]: https://github.com/schxslt/schxslt

