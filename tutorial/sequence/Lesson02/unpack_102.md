102: XProc fundamentals
# 102: XProc fundamentals



## Goals

 * More familiarity with XProc 3.0: more syntax
 * History, concepts and resources
 

## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101_src.html).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../xproc-doc/readme.md)

## Prerequisites
Same as [Setup 101](setup_101_src.html).

## Learning about XProc

## Architecture of an XProc pipeline

PIpeline prologue and steps.

## Take note

### Where are these downloads coming from?

These pipelines use different strategies for resource acquisition, depending on the case, and on where and in what form the resource is available. (Sometimes a file on Github is downloaded "raw", sometimes an archive is downloaded and opened, and so on.) For now, it is not necessary to understand details in every case, only to observe the variation and range. (With more ideas welcome. Could XProc be used to build a "secure downloader"?)

Wherever you see `href` attributes, take note.

Since `href` is how XProc "sees" the world, either to read data in or to write data out, this attribute is a reliable indicator of an assumed feature, often a dependency of some kind. For example, a download will not succeed if the resource indicated by the `href` for the download returns an error, or nothing. `href` attribute settings therefore become *points of control* for interaction between an XProc pipeline, and its runtime environment.

Useful detail: where XProc has `p:store href="some-uri.file"`, the `href` is read by the processor as the intended location for storage of pipeline data, that is, for a *write* operation. In other cases `href` is always an argument for a *read* operation.

### Syntax tips

XProc uses XPath syntax, in which a syntax such as `$foo` (a name with a `$` prefixed) indicates a **variable reference**. XProc also uses a *value expansion syntax* (either*text* or *attribute* value syntax) using curly braces - so syntax such as `href="{$some-xml-uri}"` is not uncommon. Depending on use, this would mean "read [or write] to the URI given by `$some-xml-uri`".

An XProc developer always knows where `href` is used in a pipeline, and how to test for and update their use. As always with syntax, the easiest way to learn about it is to try making changes and observing outcomes.
