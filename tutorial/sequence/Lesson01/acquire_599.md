

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 599: Meeting XProc

## Some observations

Because it is now centered on *pipelines* as much as on files and software packages, dependency management is different from other technologies including Java and NodeJS – how so?

MorganaXProc-III is implemented in Scala, and Saxon is built in Java, but otherwise distributions including the SchXSLT and XSpec distributions consist mainly of XSLT. This is either very good (with development and maintenance requirements in view), or not good at all.

Which is it, and what are the determining variables that tell you XProc is a good fit? How much of this is due to the high-level, abstracted nature of [4GLs](https://en.wikipedia.org/wiki/Fourth-generation_programming_language) including both XSLT 3.1 and XProc 3.0? Prior experience with XML-based systems and the problem domains in which they work well is probably a factor. How much are the impediments technical, and how much are they due to culture?

The next lesson unit includes more information on where to learn about XProc and how to become familiar not only with its uses in connection with OSCAL, but in general.

## Declarative markup in action

Considerable care is taken in developing these demonstrations to see to it that the technologies on which we depend, notably XProc and XSLT but not limited to these, are both nominally and actually conformant to externally specified standard technologies, i.e. XProc and XSLT respectively (as well as others), and reliant to the greatest possible extent on well-documented and accessible runtimes.

It is a tall order to ask that any code base should be both easy to integrate and use with others, and at the same time, functionally complete and self-sufficient. Of these two, we are lucky to get one. Because the world is complex, we are always throwing in one or another new dependency, along with new rule sets. Here, we work by making everything transparent as possible (so nothing is downloaded behind the scenes, for example) while also documenting as thoroughly as we can, including with code comments.

Can any code base be self-explanatory in any meaningful sense? Doubtful. But one can try and leave tracks and markers, at least. 
