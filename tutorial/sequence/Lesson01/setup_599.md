> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/setup/setup_599_src.html](../../../tutorial/source/setup/setup_599_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 599: Meeting XProc

## Some observations

Because it is now centered on *pipelines* as much as on software packages, dependency management is different from other technologies including Java and NodeJS - how so?

MorganaXProc-III is implemented in Scala, and Saxon is built in Java, but otherwise distributions including the SchXSLT and XSpec distributions consist mainly of XSLT. This is either very good (with development and maintenance requirements in view), or not good at all.

How much of this is due to the high-level, abstracted nature of [4GLs](https://en.wikipedia.org/wiki/Fourth-generation_programming_language) including both XSLT 3.1 and XProc 3.0?
