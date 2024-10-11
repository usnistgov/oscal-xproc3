

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/unpack/unpack_102_src.html](../../../tutorial/source/unpack/unpack_102_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: XProc fundamentals



## Goals

* More familiarity with XProc 3.0, with more syntax
* Get hands a little dirty – and practice washing up
* First look at XProc pipeline organization

## Resources

Take a quick look *now* (and a longer look later):

This tutorial's handmade [XProc links page](../../xproc-links.md)

Also, the official [XProc.org dashboard page](https://xproc.org)

Also, check out XProc index materials produced in this repository: [XProc docs](../../../projects/xproc-doc/readme.md)

And the same pipelines you ran in setup: [Setup 101](../setup/setup_101.md).

## Prerequisites

You have done [Setup 101](../setup/setup_101.md), [Setup 102](../setup/setup_101.md) and [Unpack 101](unpack_101.md).

## Learning more about XProc

A partial list of ways to learn more about XProc:

* Search engines: use keywords &ldquo;XProc3&rdquo; or &ldquo;XProc 3.0&rdquo; to help distinguish from 1.0 technologies
* Resources: [links](../../xproc-links.md) here and elsewhere
* Hands on exercises
* Work the notes - save out and annotate these pages

## Details details!

XProc pipelines described in [the previous lesson unit](unpack_101.md) contain a few noteworthy features.

 To edit these files, use any XML-capable plain text editor (that is, with care, any editor at all that saves text files as UTF-8).

### TEST-XSPEC

* Where XSpec documents are bound to the input port `source`, they have `content-type='application/xml'` given. This is because with the unconventional file suffix `xspec` (useful for other reasons), the XProc engine needs extra information to know they should be read as XML, not some other data format. Try removing the `content-type` to 
* The step `p:for-each` is not just a step: it also contains steps. It is a *compound step*, described further below. You would be correct to infer this step enables us to perform operations on several inputs in parallel: just what this pipeline needs.
* Within the `p:for-each`, the step `ox:execute-xspec` is named in the `ox` namespace, which resolves to the string `http://csrc.nist.gov/ns/oscal-xproc3`, a value assigned for this project. This step is defined in the [imported pipeline](../../../xspec/xspec-execute.xpl). XProc is indefinitely extensible: the namespace feature allows us to create new steps without fear of name clashes with old steps – or steps that are still uninvented and unnamed. We can develop and name steps in our own namespace, while also acquiring and using steps in other namespaces.
* The `p:identity` step is used twice in this pipeline for one purpose only: to indicate messages the XProc engine should deliver. In the normal configuration, you should see these messages in the console when the pipeline runs. This is a common use for `p:identity`.
* The repository observes a couple of conventions with regard to steps and messages. For example: any `p:load` or `p:save` step should have a message; and messages should always be prefixed with a bracketed indicator of the pipeline that issues them, for example the `[TEST-XSPEC]` messages that are emitted here, once for each input and again once when the pipeline finishes.
* Yes, those conventions are enforced in the repository by [a Schematron](../../../testing/xproc3-house-rules.sch) that can be applied to any pipeline, both in development and when it is committed to the repository under CI/CD (continuous integration / continous development). Assuming we take care to run our tests and validations, this does most of the difficult work maintaining consistency, namely detecting the inconsistency.
* Reassuring messages aside, no XSpec reports are actually captured by this XProc! With nothing bound to an output port, it *sinks* by default. That is because it is a smoke test, and we care only to see that it runs and completes without error. The inputs are all controlled, so we know what those reports say. Or we can find out.

### PRODUCE-TUTORIAL-ELEMENTLIST.xpl

The pipeline [PRODUCE-TUTORIAL-ELEMENTLIST.xpl](../../PRODUCE-TUTORIAL-ELEMENTLIST.xpl) has &ldquo;real-world complexity&rdquo;. Reviewing its steps can give a sense of how XProc combines simple capabilities into complex operations. Notwithstanding the title of this section, it is not important to understand every detail – knowing they are there is enough.

* The prologue here contains a single `p:input` configuration. This one gives the input in line, as an XML document. Within this XML, all the project folders to be covered by the index are listed. Their order also matters since one of the two indexes built works incrementally, prior elements affecting what happens with later elements.

## Messing around

Taking some time to make and test small adjustments to working code is a great way to develop a sense of how it behaves.

An easy way to do this without perturbing the working code in the repository is to copy a pipeline and modify the copy. Modifying one of the smoketest pipelines, see what happens when:

* An `@href` points to a location on the system where there is no file
* A file is there, but it is not what is expected (for example: XML is expected but the file is not well formed)
* A `p:namespace-delete` step is removed from the end of a pipeline – how does the result change?
* Other steps are excluded
* New elements are renamed (etc.)

When changes introduce errors, runtime failures and tracebacks will *sometimes* appear. The indicated problem or the source of the reported problem must be repaired.

And sometimes a process will run successfully, despite an &ldquo;error&rdquo;. Whether it is in error then depends on how well it conforms to its requirements. Does it deliver the results we want and expect?

As an exercise, make some changes in copies of the test pipelines. Make at least one change that produces outputs (such as echoing a document to the console) that are visibly different from the results of the original pipeline.

### Disabling your code

For newcomers to XML coding – you can &ldquo;comment out&rdquo; code in any XML by wrapping it in comment syntax:

```
<tagged>Text</tagged>
```

becomes

```
<!--  <tagged>Text</tagged> -->
```

A code editor that supports XML might let you do this with a keystroke, for example `ctrl-,` (Control key plus comma), after selecting the text you wish to include in the comment.

Take care when doing this that the XML is still intact with all the tags balanced. This is a very useful technique for rapidly and interactively testing your pipelines.

## Take note

### Where are these downloads coming from?

Pipelines can use a few different strategies for resource acquisition, depending on the case, and on where and in what form the resource is available. (Sometimes a file on Github is easiest to download "raw", sometimes an archive is downloaded and opened, and so on.) For now, it is not necessary to understand details in every case, only to observe the variation and range. (With more ideas welcome. Could XProc be used to build a &ldquo;secure downloader&rdquo; that knows how, for example, to compare hashes?)

Wherever you see `href` attributes, take note.

Since `href` is how XProc &ldquo;sees&rdquo; the world, either to read data in or to write data out, this attribute is a reliable indicator of an assumed feature, often a dependency of some kind. For example, a download will not succeed if the resource indicated by the `href` for the download returns an error, or nothing. In XProc, `href` attribute settings are the *points of control* for interaction between an XProc pipeline, and its runtime environment.

Useful detail: where XProc has `p:store href="some-uri.file"`, the `href` is read by the processor as the intended location for storage of pipeline data, that is, for a *write* operation. In other cases `href` is always an argument for a *read* operation.

### Syntax tips

In XPath syntax, `$foo` (a name with a `$` prefixed) indicates a **variable reference** named (in this case) &ldquo;foo&rdquo;. XProc also uses a *value expansion syntax* (either*text value syntax* or *attribute value syntax*) using curly braces - so syntax such as `href="{$some-xml-uri}"` is not uncommon. Depending on use, this would mean &ldquo;read [or write] to the URI given by `$some-xml-uri`&rdquo;.

An XProc developer always knows where `href` is used in a pipeline, and how to test for and update its use. As always with syntax, the easiest way to learn it is to try making changes and observing outcomes.
