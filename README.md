# OSCAL-XProc3 - OSCAL on an XProc3 platform

## 'FAIR' principles

**F**indable, **A**ccessible, **I**nteroperable and **R**eusable - see the [FAIR Software](fair-software.md) page adopted from NIST boilerplate.

TODO: Register this software in MIDAS and any other public listings or search portals

# Software description

This repository serves as a platform for demonstration and development of capabilities in information and data processing in support of [OSCAL, the Open Security Controls and Assessment Language](oscal), using W3C-standard [XProc 3.0](xproc) technology.

This may include either OSCAL applications, or applications built to be used in OSCAL development. Each project is kept in its own folder, next to the `lib` and `bin` folders (if present). In that folder, the project will have its own README.md. While projects may rely on shared libraries, each one is considered to be discrete and independent unless otherwise noted.

[XProc 3.0](xproc) is an XDM-based (XML Data Model) information processing and pipelining stack published and supported by a development community. [XProc 1.0](xproc1) was published as a [W3C Recommendation](http://www.w3.org/2005/10/Process-20051014/tr.html#rec-publication) in 2010. In addition to integrating the latest XSLT and XQuery technologies such as [XSLT 3.0](xslt3), XProc 3.0 represents a significant advance over XProc 1.0:

- More streamlined and easier to learn and use
- Capable of processing and delivering any data notation, not only XML, including both JSON and plain-text-based formats (e.g. CSV, TSV etc.)

Both of these are important for OSCAL, which comes as both XML and JSON and whose users vary from the highly technical, to the bare beginner (in XML, OSCAL or both).

Projects currently planned for deployment include:

  - `schema-field-test` OSCAL validation validation test harness - does an OSCAL schema test what you think it tests?
  - `batch-validate` validate OSCAL in batches against schemas or schema emulators
  - `data-convert` - convert OSCAL XML into JSON and OSCAL JSON into XML
  - `display-render` - convert OSCAL catalogs (including resolved profiles) into HTML and PDF

TODO: update this list

Applications in this repository may occasionally have general use outside OSCAL; users who find any of its capabilities should be generalized and published separately please [create a Github Issue](repo-issues).

### OSCAL developers

OSCAL developers may wish to use software on this site as a 'black box', without interest in its internals except insofar as they may be subject to assessment (not reverse engineering).

After following the installation instructions to download and test the core libraries, choose the application you are interested in, and start there.

### XML/XSLT/XProc developers

Software developers using and learning XProc 3.0 and the XDM stack (XML/XSLT/XQuery) may wish to open the box and see how the internals work.

Again, after installation and testing, you can start anywhere -- you have already started.

## Installation instructions

## Running the software

Any XProc3 pipeline can be executed using the script `xp3.sh` (`bash`) or `xp3.bat` (Windows CMD). For example:

> ./xp3.sh LAUNCH.xpl

Will initiate an XProc 3 step (pipeline) defined in the file `LAUNCH.xpl`.

TODO: indicate which pipeline to use first

# Contact information

This project is being maintained by Wendell Piez, w e n d e l l (dot) p i e z (at) n i s t (dot) g o v) of the National Institute of Standards and Technology, Information Technology Laboratory, Computer Security Division (NIST/ITL/CSD 773.03).

Please [create a Github Issue](repo-issues) or [join an OSCAL forum]() to pursue discussion on this repository. In support of this project, email to the principal investigator is also welcome.

# Related Material

OSCAL and associated repositories
oscal-cli

XProc 3.0

# How to cite

# Included software and licenses




[repo-issues]: https://github.com/usnistgov/oscal-xproc3/issues
[metaschema]: https://pages.nist.gov/metaschema
[metaschema-repo]: https://github.com/usnistgov/metaschema
[metaschema-java]: https://github.com/usnistgov/metaschema-java
[metaschema-xslt]: https://github.com/usnistgov/metaschema-xslt
[oscal]: https://pages.nist.gov/OSCAL
[oscal-repo]: https://github.com/usnistgov/OSCAL
[oscal-xslt]: https://github.com/usnistgov/oscal-xslt
[oscal-cli]: https://github.com/usnistgov/oscal-cli
[xslt3-functions]: https://github.com/usnistgov/xslt3-functions

[xproc]: https://xproc.org/
[xproc-spec]: https://xproc.org/
[xproc1]: https://xproc.org/
[xproc1-site]: https://archive.xproc.org/

---

## TODO

- [ ] Software or Data description
   - [ ] Statements of purpose and maturity
   - [ ] Description of the repository contents
   - [ ] Technical installation instructions, including operating system or software dependencies
- [ ] Contact information
  - [ ] PI name, NIST OU, Division, and Group names
   - [ ] Contact email address at NIST
   - [ ] Details of mailing lists, chatrooms, and discussion forums, where applicable
- [ ] Related Material
   - [ ] - URL for associated project on the NIST website or other Department of Commerce page, if available
   - [ ] - References to user guides if stored outside of GitHub
[ ] 1. Directions on appropriate citation with example text
[ ] 1. References to any included non-public domain software modules, and additional license language if needed, *e.g.* [BSD][li-bsd], [GPL][li-gpl], or [MIT][li-mit]


---
BOILERPLATE FOLLOWS

# NIST Open-Source Software Repository Template

Use of GitHub by NIST employees for government work is subject to
the [Rules of Behavior for GitHub][gh-rob]. This is the
recommended template for NIST employees, since it contains
required files with approved text. For details, please consult
the Office of Data & Informatics' [Quickstart Guide to GitHub at
NIST][gh-odi].

Please click on the green **Use this template** button above to
create a new repository under the [usnistgov][gh-nst]
organization for your own open-source work. Please do not "fork"
the repository directly, and do not create the templated
repository under your individual account.

The key files contained in this repository -- which will also
appear in templated copies -- are listed below, with some things
to know about each.

---

## README

Each repository will contain a plain-text [README file][wk-rdm],
preferably formatted using [GitHub-flavored Markdown][gh-mdn] and
named `README.md` (this file) or `README`.

Per the [GitHub ROB][gh-rob] and [NIST Suborder 1801.02][nist-s-1801-02],
your README should contain:

1. Software or Data description
   - Statements of purpose and maturity
   - Description of the repository contents
   - Technical installation instructions, including operating
     system or software dependencies
1. Contact information
   - PI name, NIST OU, Division, and Group names
   - Contact email address at NIST
   - Details of mailing lists, chatrooms, and discussion forums,
     where applicable
1. Related Material
   - URL for associated project on the NIST website or other Department
     of Commerce page, if available
   - References to user guides if stored outside of GitHub
1. Directions on appropriate citation with example text
1. References to any included non-public domain software modules,
   and additional license language if needed, *e.g.* [BSD][li-bsd],
   [GPL][li-gpl], or [MIT][li-mit]

The more detailed your README, the more likely our colleagues
around the world are to find it through a Web search. For general
advice on writing a helpful README, please review
[*Making Readmes Readable*][18f-guide] from 18F and Cornell's
[*Guide to Writing README-style Metadata*][cornell-meta].

## LICENSE

Each repository will contain a plain-text file named `LICENSE.md`
or `LICENSE` that is phrased in compliance with the Public Access
to NIST Research [*Copyright, Fair Use, and Licensing Statement
for SRD, Data, and Software*][nist-open], which provides
up-to-date official language for each category in a blue box.

- The version of [LICENSE.md](LICENSE.md) included in this
  repository is approved for use.
- Updated language on the [Licensing Statement][nist-open] page
  supersedes the copy in this repository. You may transcribe the
  language from the appropriate "blue box" on that page into your
  README.

If your repository includes any software or data that is licensed
by a third party, create a separate file for third-party licenses
(`THIRD_PARTY_LICENSES.md` is recommended) and include copyright
and licensing statements in compliance with the conditions of
those licenses.

## CODEOWNERS

This template repository includes a file named
[CODEOWNERS](CODEOWNERS), which visitors can view to discover
which GitHub users are "in charge" of the repository. More
crucially, GitHub uses it to assign reviewers on pull requests.
GitHub documents the file (and how to write one) [here][gh-cdo].

***Please update that file*** to point to your own account or
team, so that the [Open-Source Team][gh-ost] doesn't get spammed
with spurious review requests. *Thanks!*

## CODEMETA

Project metadata is captured in `CODEMETA.yaml`, used by the NIST
Software Portal to sort your work under the appropriate thematic
homepage. ***Please update this file*** with the appropriate
"theme" and "category" for your code/data/software. The Tier 1
themes are:

- [Advanced communications](https://www.nist.gov/advanced-communications)
- [Bioscience](https://www.nist.gov/bioscience)
- [Buildings and Construction](https://www.nist.gov/buildings-construction)
- [Chemistry](https://www.nist.gov/chemistry)
- [Electronics](https://www.nist.gov/electronics)
- [Energy](https://www.nist.gov/energy)
- [Environment](https://www.nist.gov/environment)
- [Fire](https://www.nist.gov/fire)
- [Forensic Science](https://www.nist.gov/forensic-science)
- [Health](https://www.nist.gov/health)
- [Information Technology](https://www.nist.gov/information-technology)
- [Infrastructure](https://www.nist.gov/infrastructure)
- [Manufacturing](https://www.nist.gov/manufacturing)
- [Materials](https://www.nist.gov/materials)
- [Mathematics and Statistics](https://www.nist.gov/mathematics-statistics)
- [Metrology](https://www.nist.gov/metrology)
- [Nanotechnology](https://www.nist.gov/nanotechnology)
- [Neutron research](https://www.nist.gov/neutron-research)
- [Performance excellence](https://www.nist.gov/performance-excellence)
- [Physics](https://www.nist.gov/physics)
- [Public safety](https://www.nist.gov/public-safety)
- [Resilience](https://www.nist.gov/resilience)
- [Standards](https://www.nist.gov/standards)
- [Transportation](https://www.nist.gov/transportation)

---

[usnistgov/opensource-repo][gh-osr] is developed and maintained
by the [opensource-team][gh-ost], principally:

- Gretchen Greene, @GRG2
- Yannick Congo, @faical-yannick-congo
- Trevor Keller, @tkphd

Please reach out with questions and comments.

<!-- References -->

[18f-guide]: https://github.com/18F/open-source-guide/blob/18f-pages/pages/making-readmes-readable.md
[cornell-meta]: https://data.research.cornell.edu/content/readme
[gh-cdo]: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
[gh-mdn]: https://github.github.com/gfm/
[gh-nst]: https://github.com/usnistgov
[gh-odi]: https://odiwiki.nist.gov/ODI/GitHub.html
[gh-osr]: https://github.com/usnistgov/opensource-repo/
[gh-ost]: https://github.com/orgs/usnistgov/teams/opensource-team
[gh-rob]: https://odiwiki.nist.gov/pub/ODI/GitHub/GHROB.pdf
[gh-tpl]: https://github.com/usnistgov/carpentries-development/discussions/3
[li-bsd]: https://opensource.org/licenses/bsd-license
[li-gpl]: https://opensource.org/licenses/gpl-license
[li-mit]: https://opensource.org/licenses/mit-license
[nist-code]: https://code.nist.gov
[nist-disclaimer]: https://www.nist.gov/open/license
[nist-s-1801-02]: https://inet.nist.gov/adlp/directives/review-data-intended-publication
[nist-open]: https://www.nist.gov/open/license#software
[wk-rdm]: https://en.wikipedia.org/wiki/README



