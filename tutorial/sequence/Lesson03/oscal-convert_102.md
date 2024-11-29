

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: Hands on data conversions

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how to detect, avoid, prevent or mitigate them.

Work with XProc features designed for handling JSON data (XDM **map** objects that can be cast to XML).

## Prerequisites

Run the pipelines described in [the 101                Lesson](https://github.com/usnistgov/oscal-xproc3/discussions/18)

## Resources

Same as the [101 lesson](oscal-convert_101.md).

## Some breaking and making

Every project you examine provides an opportunity to alter pipelines and see how they fail when not encoded correctly – when &ldquo;broken&rdquo;, any way we can think of breaking them. Then build good habits by repairing the damage. Experiment and observation bring learning.

After reading this page and [the project readme](../../../projects/oscal-convert/readme.md), run the pipelines while performing some more disassembly / reassembly. Here are a few ideas (including a few you may have already done):

* Switch out the value of an `@href` on a `p:document` or `p:load` step. See what happens when the file it points to is not actually there.
* There is a difference between `p:input`, used to configure a pipeline in its prologue, and `p:load`, a step that loads data. Ponder what these differences are. Try changing a pipeline that uses one into a pipeline that uses the other.
* Similarly, there is a difference between a `p:output` configuration for a pipeline, and a `p:store` step executed by that pipeline. Consider this difference and how we might define a rule for when to prefer one or the other. How is the pipeline used - is it called directly, or intended for use as a step in other pipelines? How is it to be controlled at runtime?
* Try inserting `p:store` steps into a pipeline to capture intermediate results, that is, the output of any step before they are processed by the next step. Such steps can aid in debugging, among other uses.
* `@message` attributes on steps provide messages for the runtime traceback. They are optional but this repo follows a rule that any `p:load` or `p:store` should be provided with a message. Why?
* A `p:identity` step passes its input unchanged to the next step. But can also be provided with a `@message`.

After breaking anything, restore it to working order. Create modified copies of any pipelines for further analysis and discussion.

* Concept: copy and change one of the pipelines provided to acquire a software library or resource of your choice.

## Value templates in attributes and text: { expr }

Practitioners of XQuery, XSLT and related technologies will recognize the curly-bracket characters (U+007B and U+007D) as indicators of [attribute                value templates](https://www.w3.org/TR/xslt-10/#dt-attribute-value-template), [text value                templates](https://www.w3.org/TR/xslt-30/#text-value-templates), or [enclosed expressions](https://www.w3.org/TR/xquery-31/#id-enclosed-expr). The expression within the braces is to be evaluated dynamically by the processor. This is one of the most useful convenience features in the language.

These quickly become invisible. Upon seeing

```
<p:identity message="Processing { $filename } at { current-date() }"/>
```

the XProc developer understands:

* The date, in some form (try it and see) should be written into the message
* The variable reference `$filename` is defined somewhere, and here will expand to a string

If you need to see actual curly braces, escape by doubling: `{{` for the single open and `}}` for the single close.

Extra care must be taken with embedded XSLT and XQuery due to this feature, since their functioning will depend on correctly interpreting these within literal code. Yes, double escaping is sometimes necessary. (This can be tried with [a worksheet XProc](../../worksheets/NAMESPACE_worksheet.xpl).)

Setting `expand-text` to `false` on an XProc element turns this behavior off: the braces become regular braces again. [The                spec also describes](https://spec.xproc.org/3.0/xproc/#expand-text-attribute) a `p:inline-expand-text` attribute that can be used in places (namely inside literal XML provided in your XProc using `p:inline`) where the regular expand-text has no effect. Either setting can be used inside elements already set, resulting in &ldquo;toggling&rdquo; behavior (it can be turned on and off), as any `expand-text` applies to override settings on its ancestors.

## Designating an input at runtime by binding input ports

One potential problem with the pipelines we have looked at so far is that their inputs are hard-wired. While this is sometimes helpful, it should also be possible to apply a pipeline to an XML document (or other input) without having to designate the document inside the pipeline itself. The user or calling application should be able to say &ldquo;run this pipeline, but this time with this input&rdquo;.

The input ports for a pipeline, specified using `p:input` within the prologue, provide for this.

For example, the [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl) pipeline defines an input port:

```
<p:input port="source" sequence="true">
    <p:document href="data/catalog-model/xml/cat_catalog.xml"/>
</p:input>
```

By default, this pipeline will pick up and process the data it finds at path `data/catalog-model/xml/cat_catalog.xml`, relative to the stylesheet. But any call to this pipeline, whether directly or as a step in another pipeline, can override this.

The Morgana processor defines [a command                syntax for binding inputs to ports](https://www.xml-project.com/manual/ch01.html#R_ch1_s1_2). It looks like this (when used with the script deployed with this repository):

```
$ ../xp3.sh *PIPELINE.xpl* -input:*portname=path/to/a-document.xml* -input:*portname=path/to/another-document.xml*
```

Here, two different `-input` arguments are given for the same port. You can have as many as needed if the port, like this one, has `sequence="true"`, meaning any number of documents (from zero to many) can be bound to the port, and the pipeline will accommodate. When more than one port is defined, one (only) can be designated as `primary="true"`, meaning it will be provided implicitly when a port connection is required (by a step) but not given in the pipeline. Notice that the name of the port must also appear, as in `-input:portname`, since pipelines can have ports supporting sequences, but also as many input ports as it needs, named differently, for documents playing different roles in the pipeline. In place of `portname` here, a common name for a port (conventional when it is the pipeline's only or primary input) is `source`.

### Binding to input ports vs p:load steps

XProc offers two ways to acquire data from outside the pipeline: by using `p:load` or by binding inputs to an input port using `p:input/p:document`. These are somewhat different in operation - errors produced by `p:load` cannot be detected until the pipeline is run, whereas failures with `p:input` should be detected when the pipeline itself is loaded and compiled (i.e. during *static analysis*), and processors may be able to apply different kinds of exception handling, fallbacks or support for redirects. (As always you can try, test and determine for yourself.) Apart from this distinction the two approaches have similar effects – whether to use one or the other depends often on how you expect the pipeline to be used and distributed, not on whether it works.

Although one distinction is that p:document appears on input ports, which can be overridden, this does not mean that p:document can't be essentially &ldquo;private&rdquo; to a pipeline or pipeline step. For example, if you wish to acquire more than a single document, without p:load, known in advance (i.e. the file names can be hard-coded), make a step like this:

```
<p:identity>
  <p:with-input>
    <p:document href="..."/>
    <p:document href="..."/>
    ...
  </p:with-input>
<p:identity>
```

This binds the documents to the input of an **identity** step (which supports a sequence), without exposing an input port in the main pipeline.

A more dynamic approach is sometimes useful: first, acquire a list of file names, for example:

```
<p:input port="source">
   <p:inline>
      <FILELIST>
         <FILE>A</FILE>
         <FILE>B</FILE>
      </FILELIST>
   </p:inline>
</p:input>
```

Then in our subpipeline we use the compound step `p:for-each` to process each FILE element in the list:

```
<p:for-each>
   <p:with-input select="//FILE"/>
   <p:load href="{ string(.) }"/>
</p:for-each>   
```

This has the effect of traversing the document given in line (the file list) and for each of its FILE elements, loading the document named as the FILE element's string value, that is &ldquo;A&rdquo;, &ldquo;B&rdquo; and so on. This is just as if A and B had been bound directly to the port. In either case, what we get is a sequence of XDM *document* objects, one for each of the resources parsed.

One tradeoff is that the override mechanism will be different. We override the first approach by binding the pipeline's `source` port directly to whatever documents we want in place of A and B. We override the second approach by providing a different FILELIST document. Alternatively such a FILELIST can be referenced instead of included … `p:document href="the-filelist.xml`, providing us a resource that we can maintain separately.

This makes the second approach especially appealing if the file list can be derived from some kind of metadata resource or, indeed, `p:directory-list`….

## Identity pipeline testbed

An identity or &ldquo;near-identity&rdquo; or modified-identity pipeline has its uses, including diagnostics. Since inputs and outputs are supposed to look the same, any changes they show between inputs and outputs can be revealing.

They are also useful for testing features in your environment or setup, for example features for resource acquisition and disposition, that is, how you get data into your pipeline and then out again.

Additionally, there are actually useful operations supported by a pipeline that presents its input unchanged with respect to its model. For example, it can be used to transcode a file from one encoding to another – changing nothing in the data, but rewriting it into a different character set. This is because with XProc, transcoding does not actually happen within the pipeline, but on its boundaries - when a file is read, or written (aka serialized). So internally, a pipeline set up to do this doesn't have any action to take.

### 0.01 - what is a &ldquo;document&rdquo;

Just about any kind of digital input can be an XProc document. Keeping things simple and regular, XProc's concept of document is broad enough to encompass XML, HTML, JSON and other kinds of inputs including plain text and binaries. [Read more here](oscal-convert_402.md).

### 0.1 - loading documents known or discovered in advance

The XProc step `p:load` can be used to load the resource indicated into the pipeline.

Watch out, since `p:load` with `href=""` – loading the resource at the location indicated by the empty string, `""` – will load the XProc file itself. This is conformant with rules for URL resolution.

### 0.2 - binding a document to an input port

### 0.3 - loading documents discovered dynamically with `p:directory-list`

### 0.4 - saving results to the file system

### 0.5 - exposing results on an output port

## Probing error space - data conversions

Broadly speaking, problems encountered running these conversions fall into two categories, the distinction being simple, namely whether a bad outcome is due to an error in the processor and its logic, or in the data inputs provided. The term &ldquo;error&rdquo; here hides a great deal. So does &ldquo;bad outcome&rdquo;. One type of bad outcome takes the form of failures at runtime - the term &ldquo;failure&rdquo; again leaving questions open, while at the same time it seems fair to assume that not being able to conclude successfully, is bad. But other bad outcomes are not detectable at runtime. If inputs are bad (inconsistent with stated contracts such as data validation), processes can run *correctly* and deliver incorrect results: correctly representing inputs, in their incorrectness. Again, the term *correct* here is underspecified and underdefined, except in the case.

For these and other reasons we sometimes prefer to call them &ldquo;exceptions&rdquo;, while at the same time we know many errors are not actually errors in the process but in the inputs. We need reliable ways to tell this difference. A library of reliable source examples -- a test suite – is one asset that helps a great deal. Even short of unit tests, however, a great deal can be discovered when working with &ldquo;bad inputs&rdquo; interactively.

### Converting broken XML or JSON

Create a syntactically-invalid (not **well-formed**) XML or JSON document - or rather (more correctly), a text document that might have been XML or JSON but for some incidental problem.

*Try using this as input* to any XProc. Note how the processor delivers error messages bringing attention to problems it discovers.

### Converting not-OSCAL

XML practitioners understand how XML can be well-formed and therefore legible for processing, without being a valid instance of a specific markup vocabulary. You can have XML, for example, without having OSCAL.

When providing XML that is not OSCAL to a process that expects OSCAL inputs, you should properly see either errors (exceptions), or bad results (outputs missing or wrongly expressed) or both. *Experiment and see!*

Detection of bad results is an important capability - why we have validation against external constraint sets such as schemas. A later unit will cover this – meanwhile, inquiries on the topic are welcome.

### Converting broken OSCAL

The same thing applies to attempting to process inputs when OSCAL is expected, yet the data sources fail to meet requirements in some important respect, sometimes even a subtle requirement, depending on the case. The more fundamental problem here is the definition of &ldquo;correct&rdquo; versus &ldquo;broken&rdquo;.

We begin generally with the stipulation that by &ldquo;OSCAL&rdquo; what we mean is, any XML (or JSON or YAML) instance conformant to an OSCAL schema, and thereby defined in such a manner as to enable their convertibility. The reasoning is thus somewhat circular. If we can convert it successfully, we can claim to know it as OSCAL (by virtue of the knowledge we demonstrate in the conversion). If we know it to be OSCAL by virtue of schema validation, we have assurances also regarding its convertibility.

This is because with respect to these model-based conversions, the OSCAL project also offers tools that can convert any schema-valid OSCAL XML into equivalent schema-valid JSON, while doing the same the other way, making OSCAL XML from OSCAL JSON. In either case, schema validation is invaluable for defining the boundaries of the conversion itself. Data that is not schema-valid, it is reasoned, cannot be qualified or described at all, so no straightforward mapping from arbitrary inputs can be specified. But a mapping can be specified for inputs that are known, namely OSCAL inputs. The converter respects the validation rule not by enforcing it directly, but rather by depending on it.

Fortunately, by means of Schematron and transformations, XProc is an excellent tool not only for altering data sets, but also for detecting variances, either in inputs or its results, from any specifications that can be expressed in XPath. These capabilities – detection and amelioration – can be used together, and separately. When a pipeline cannot guarantee correct outputs, it can at least provide feedback.

Altering XML to &ldquo;break&rdquo; it in various subtle ways is likely to happen by accident. Get used to the feeling by *making it happen* on purpose.

## XProc diagnostic how-to

### Emitting runtime messages

### Saving out interim results

`p:store`

## Validate early and often
