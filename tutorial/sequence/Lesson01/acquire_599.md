

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/acquire/acquire_599_src.html](../../source/acquire/acquire_599_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 599: Meeting XProc

## Goals

Gain some more sense of context.

XProc is not a simple thing, with only one way in. The territory is vast, but it has also been well charted. And here we have a pathway marked in front of us.

## Resources

[A Declarative Markup Bibliography](https://markupdeclaration.org/resources/bibliography) is available online for future reference on this interesting topic.

## Some observations

Dependency management when using XProc is different from other technologies including Java and Javascript/NodeJS – how so? Because it is now centered on *pipelines* built out of combining capabilities of *steps* (which may be black boxes), as much as on files and software packages. Arguably, XProc blurs the distinction between code you write, and libraries you use, in a useful way – while presenting its own challenges.

MorganaXProc-III is implemented in Scala, and Saxon is built in Java, but otherwise distributions including the SchXSLT and XSpec distributions consist mainly of XSLT. This is either very good (with development and maintenance requirements in view), or not good at all.

If not using Morgana but another XProc engine (at time of writing, XML Calabash 3 has been published in alpha), there will presumably be analogous arrangements: contracts between the tool and its dependencies, software or components and capabilities bundled and unbundled.

So does this work well, on balance, and what are the determining variables that tell you XProc is a good fit for data processing, whether high touch, or at scale? How much of this is due to the high-level, abstracted nature of [4GLs](https://en.wikipedia.org/wiki/Fourth-generation_programming_language) including both XSLT 3.1 and XProc 3.0? Prior experience with XML-based systems and the problem domains in which they work well is probably a consideration. But maybe the more important blockers have to do with culture, states of knowledge, incorrect assumptions and outdated perceptions.

Will it always be that a developer determined to use XSLT will find a way, whereas a developer determined not to, will find a way to refuse it? XProc in 2024 seems slow in adoption – maybe because everyone who would want it, already has a functional equivalent in place.

In any case, it might also be that such neglect creates a market opportunity. Those who use these technologies without advertising the fact may have the most to gain. But building the commons is also a common responsibility.

It's all about the tools. Find ways to support your open-source developer and the software development operations who offer free tools and services.

## Declarative markup in action

Considerable care is taken in developing these demonstrations to see to it that the technologies on which we depend, notably XProc and XSLT but not limited to these, are both nominally and actually conformant to externally specified standard technologies, i.e. XProc and XSLT respectively (as well as others), and reliant to the greatest possible extent on well-documented and accessible runtimes.

Is it too much to expect that any code base should be both easy to integrate and use with others, and at the same time, functionally complete and self-sufficient? Of these two, we are lucky to get one, even if we are thoughtful enough to limit ourselves to building blocks. Because the world is complex, we are always throwing in one or another new dependency, along with new rule sets. The approach enabled by XML and openly-specified supporting specifications is to work by making everything transparent as possible. We seek for clarity and transparency at all levels (so nothing is downloaded behind the scenes, for example) while also documenting as thoroughly as we can, including with code comments.

Can any code base be fully self-explanatory and self-disclosing? This may be doubtful even if we can agree what those terms mean. At the same time, the attempt can be made: we can try and leave tracks and markers, at least. We call it &ldquo;code&rdquo; with the hope and intent that it should be amenable to and rewarding of interpretation.

### Standards for documents

In addition to the web itself (in HTML and CSS), a number of important initiatives in recent decades have capitalized on the core principles of declarative markup:

* [Text Encoding Initiative                   ](https://tei-c.org/release/doc/tei-p5-doc/en/html/index.html)(TEI) since 1989
* OASIS [DocBook](https://www.oasis-open.org/standard/docbook/) since 1991
* [Darwin Information                      Typing Architecture](https://docs.oasis-open.org/dita/dita/v1.3/dita-v1.3-part0-overview.html) (DITA) since 2001
* [Journal Article Tag Suite](https://jats.niso.org/) (JATS, since 2003) with [Standards Tag Suite](https://niso-sts.org/) (STS, since 2017)
* [Open Security Controls Assessment Language](https://pages.nist.gov/OSCAL/) (OSCAL), since 2018
