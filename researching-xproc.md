# Researching XProc

<details><summary>What is XProc 3.0</summary>

[XProc 3.0][xproc] is an information processing and pipelining stack based on (W3C Recommendation) XDM [XQuery and XPath Data Model 3.1][xdm3], a technology published and supported by its developer, customer and user community. The problems addressed by XProc  &mdash; the configuration, management and execution of complex, composable information processing subsystems (*pipelines* in XProc)  &mdash; are in the center of any XML system, yet they are commonly dealt with &mdash; or worked around - by painful means and methods including carefully engineered and customized build utilities (Apache Ant or GNU `make`), scripts (`bash` and other), execution environments (web processing stacks), IDE workflows and proprietary solutions &mdash; almost inevitably platform-dependent, if only because a single link with a dependency brings that dependency to every chain that includes it.

This has hindered the propagation of XML-based technology despite its demonstrated generality, usefuless and power, because wherever it is painful and awkward to integrate, its strengths and virtues are masked or (worse) obstructed and left unexplored.

As a standard supporting a common semantics across implementations -- itself proof-tested by a history of earlier work -- [XProc 3.0](xproc) promises greater adaptability, accessibility, and scalability than prior solutions to the problem of pipeline orchestration.

[XProc 1.0][xproc1] was published as a [W3C Recommendation](http://www.w3.org/2005/10/Process-20051014/tr.html#rec-publication) in 2010. In addition to integrating the latest XSLT and XQuery technologies such as [XSLT 3.0][xslt3], [XProc 3.0][xproc-specs] (finalized 2022) represents a significant advance over XProc 1.0, being

- More streamlined and easier to learn and use
- Open to any format or data notation, including JSON and plain-text-based formats (e.g. CSV, TSV etc.), in addition to XML\*

Both of these are important for OSCAL, which comes as both XML and JSON and whose users vary from the highly technical, to the bare beginner (in data formats, in OSCAL or both).

\* Especially when combined with [Invisible XML](https://invisiblexml.org).

</details>

XProc enthusiasts with current links or news should please contact the project or offer a PR with a listing.

## Site

[XProc.org site](https://xproc.org/) - with links to specs and other resources

[XProc 3.0 Overview](https://spec.xproc.org/master/head/)

With links to component specifications (important to have) such as the Standard Step Library and the additional steps.

## Tutorials

[An accessible overview of XProc 3.0](https://www.xml.com/articles/2019/11/05/introduction-xproc-30/), by Erik Siegel, appears on [XML.com](https://www.xml.com/)
[XPorc.net](xporc.net) is a site run by Martin Kraetke with an [XProc tutorial](https://xporc.net/xproc-tutorial)

## Book

Erik Siegel's [*XProc 3.0 Programmer Reference*](https://xmlpress.net/publications/xproc-3-0/)
