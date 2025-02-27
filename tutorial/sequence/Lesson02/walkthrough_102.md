

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/walkthrough/walkthrough_102_src.html](../../source/walkthrough/walkthrough_102_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: XProc fundamentals

## Goals

* More familiarity with XProc 3.0, with more syntax
* Get hands a little dirty – and practice washing up
* First look at XProc pipeline organization

## Prerequisites

You have done [Setup 101](../acquire/acquire_101.md), [Setup 102](../acquire/acquire_101.md) and [Unpack 101](walkthrough_101.md).

## Resources

Take a quick look *now* (and a longer look later):

* This tutorial's handmade [XProc links page](../../xproc-links.md)
* Also, the official [XProc.org dashboard page](https://xproc.org)
* If interested, check out XProc index materials produced in this repository: [XProc docs](../../../projects/xproc-doc/readme.md)
* In any case, the same pipelines you ran in setup: [Setup 101](../acquire/acquire_101.md).

## Learning more about XProc

A partial list of ways to learn more about XProc:

* Search engines: use keywords &ldquo;XProc3&rdquo; or &ldquo;XProc 3.0&rdquo; to help distinguish from 1.0 technologies
* Resources: [links](../../xproc-links.md) here and elsewhere
* Hands on exercises
* Work the notes - save out and annotate these pages

## Details details!

XProc pipelines described in [the previous lesson                unit](walkthrough_101.md) contain a few noteworthy features. In this section we take a closer look at the internals of a couple of these examples.

 To edit these files, use any XML-capable plain text editor (that is, with care, any editor at all that saves text files as UTF-8).

### [TEST-XSPEC](../../../smoketest/TEST-XSPEC.xpl)

* Where XSpec documents are bound to the input port `source`, they have `content-type='application/xml'` given. This is because with the unconventional file suffix `xspec` (useful for other reasons), the XProc engine needs extra information to know they should be read as XML, not some other data format. Try removing the `content-type` to see what happens when the engine does not know an XML file is XML.
* The step `p:for-each` is not just a step: it also contains steps. It is a *compound step*. You would be correct to infer this step enables us to perform operations on several inputs in parallel: just what this pipeline needs.
* Within the `p:for-each`, the step `ox:execute-xspec` is named in the `ox` namespace, which resolves to the string `http://csrc.nist.gov/ns/oscal-xproc3`, a value assigned for this project. This step is defined in the [imported pipeline](../../../xspec/xspec-execute.xpl). By requiring that a (non-XProc) namespace be used for new steps, XProc enables arbitrary and unplanned (uncoordinated) extensibility, since we can create new steps without fear of name clashes with other steps, whether they be already defined and in scope, or still uninvented and unnamed. We can develop and name steps in our own namespace, while also acquiring and using steps in other namespaces.
* The `p:identity` step is used in this pipeline for one purpose only: to indicate messages the XProc engine should deliver. In the normal configuration, you should see these messages in the console when the pipeline runs. This is a common use for `p:identity`.
* The repository observes a couple of conventions with regard to steps and messages. For example: any `p:load` or `p:save` step should have a message; and messages should always be prefixed with a bracketed indicator of the pipeline that issues them, for example the `[TEST-XSPEC]` messages that are emitted here, once for each input and again once when the pipeline finishes.
* Yes, those conventions are enforced in the repository by [a Schematron rule set](../../../testing/xproc3-house-rules.sch) that can be applied to any pipeline, both in development and when it is committed to the repository under [CI/CD (continuous integration / continuous                      development)](walkthrough_301.md). Assuming we take care to run our tests and validations, this does most of the difficult work maintaining consistency, namely detecting the inconsistency. The result, assuming we do things correctly, is a more-than-human level of consistency in error checking and correction. This is discussed again [in a subsequent                      Lesson Unit](../courseware/courseware_101.md).
* Reassuring messages aside, no XSpec reports are actually captured by this XProc! The `ox:execute-xspec` steps produces results – and produces its own runtime messages – but those results have no [connection](https://spec.xproc.org/3.0/xproc/#connections) given in the main pipepline, and it has no output port (`p:output`). Accordingly the pipeline *sinks* by default – the documents delivered at the end are discarded. (For smoke test purposes, we care only to see that it runs and completes without error.) The inputs are all controlled, so we know what those reports say. (Or we can find out by altering the pipeline to capture the findings, not discard them.)

### [PRODUCE-PROJECTS-ELEMENTLIST](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl)

The pipeline [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl) has &ldquo;real-world complexity&rdquo;. Reviewing its steps can give a sense of how XProc combines simple capabilities into complex operations. Notwithstanding the title of this section, it is not important to understand every detail – knowing they are there is enough.

* The prologue here contains a single `p:input` configuration. This one gives its input inline, as an XML document. Within this XML, all the project folders to be covered by the index are listed. Their order also matters since one of the two indexes built works incrementally, prior elements affecting what happens with later elements.

This pipeline exploits one other important feature of XProc: so far at least, it is all XML. Even short of dynamically generating and executing XProc (a feature the language [provides for](https://spec.xproc.org/lastcall-2024-08/head/run/)), XML and its related ecosystem (most significantly but not only XPath) is always available, providing an instrumental &ldquo;force magnifier&rdquo; or power tool that we can put to work again and again. In XProc, errors are reported in XML. So we can capture, aggregate and index error messages in XProc. In XProc, a directory file listing is provided in XML. So we have a ready way to present views of file systems – the XML shows all the names and structures – as well as analyze them and access the files in them. Etc.

## Messing around

Taking some time to make and test small adjustments to working code is a great way to develop a sense of how it behaves.

As an exercise, make some changes in copies of the test pipelines. An easy way to do this without perturbing the working code in the repository is to copy a pipeline and modify the copy.

Make at least one change that produces outputs (such as echoing a document to the console) that are visibly different from the results of the original pipeline. Also try breaking the pipeline to see how it handles errors.

You might see what happens when:

* An `@href` points to a location on the system where there is no file
* A file is there, but it is not what is expected (for example: XML is expected but the file is not well formed)
* A `p:namespace-delete` step is removed from the end of a pipeline – how does the result change?
* Other steps are excluded
* New elements are renamed (etc.)

When changes introduce errors, runtime failures and tracebacks will *sometimes* appear. The indicated problem or the source of the reported problem must be repaired.

And sometimes a process will run successfully, despite an &ldquo;error&rdquo;. Whether it is in error then depends on how well it conforms to its requirements. Does it deliver the results we want and expect?

### Disabling your code

When debugging, being able to switch operations on and off easily to compare results is often essential.

#### XML comment syntax

For newcomers to XML coding – you can &ldquo;comment out&rdquo; code in any XML by wrapping it in comment syntax:

```
<tagged>Text</tagged>
```

becomes:

```
<!--  <tagged>Text</tagged> -->
```

A code editor that supports XML might let you do this with a keystroke, for example `ctrl-,` (Control key plus comma), after selecting the text you wish to include in the comment.

Take care when doing this that the XML is still intact with all the tags balanced. This is a very useful technique for rapidly and interactively testing your pipelines, by deactivating and reactivating blocks of code.

#### Native XProc

XProc also offers other ways to switch code on and off, including XProc conditionals ([p:if](https://spec.xproc.org/3.0/xproc/#p.if) and [p:choose](https://spec.xproc.org/3.0/xproc/#p.choose)) and a [use-when](https://spec.xproc.org/3.0/xproc/#use-when) attribute on steps to provide for runtime contingency. These can be used when more permanent solutions or more capabilities are needed than a simple comment (placeholder) can offer.

So a step like `<p:namespace-delete prefixes="ox" use-when="false()"/>` will never run because XPath `false()` is never true. And `<p:namespace-delete prefixes="ox" use-when="$cleaning-up"/>` will run only if the variable `$cleaning-up` evalues to XPath `true()`.

## Take note

### Where are these downloads coming from?

Pipelines can use a few different strategies for resource acquisition, depending on the case, and on where and in what form the resource is available. (Sometimes a file on Github is easiest to download "raw", sometimes an archive is downloaded and opened, and so on.) For now, it is not necessary to understand details in every case, only to observe the variation and range. (With more ideas welcome. Could XProc be used to build a &ldquo;secure downloader&rdquo; that knows how, for example, to compare hash-based signatures?)

Wherever you see `href` attributes, take note.

Since `href` is how XProc &ldquo;sees&rdquo; the world, either to read data in or to write data out, this attribute is a reliable indicator of an assumed feature, often a dependency of some kind. For example, a download will not succeed if the resource indicated by the `href` for the download returns an error, or nothing. In XProc, `href` attribute settings become important *points of control* for interaction between an XProc pipeline, and its runtime environment.

Useful detail: where XProc has `p:store href="some-uri.file"`, the `href` is read by the processor as the intended location for storage of pipeline data, that is, for a *write* operation. In other cases `href` is always an argument for a *read* operation.

### Syntax tips

In XPath syntax, `$foo` (a name with a `$` prefixed) indicates a **variable reference** named (in this case) &ldquo;foo&rdquo;. XProc also uses a *value expansion syntax* (either *text value syntax* or *attribute value syntax*) using curly braces - so syntax such as `href="{$some-xml-uri}"` is not uncommon. Depending on use, this would mean &ldquo;read [or write] to the URI given by `$some-xml-uri`&rdquo;.

An XProc developer always knows where `href` is used in a pipeline, and how to test for and update its use. As always with syntax, the easiest way to learn it is to try making changes and observing outcomes.
