

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../../source/oscal-convert/oscal-convert_102_src.html](../../../source/oscal-convert/oscal-convert_102_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: Hands on data conversions

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn about potential problems and limitations when doing this, and about how to detect, avoid, prevent or mitigate them.

Learn something about XProc features designed for handling JSON data (XDM **map** objects that can be cast to XML).

## Prerequisites

Run the pipelines described in [the 101 Lesson                Unit](oscal-convert_101.md) in this topic.

## Resources

Same as the [101 lesson](oscal-convert_101.md).

## Some breaking and making

Every project you examine provides an opportunity to alter pipelines and see how they fail when not encoded correctly – when &ldquo;broken&rdquo;, any way we can think of breaking them. Then build good habits by repairing the damage. Experiment and observation bring learning.

After reading this page and [the project readme](../../../projects/oscal-convert/readme.md), run the pipelines while performing some more disassembly / reassembly. Here are a few ideas:

* Switch out the value of an `@href` on a `p:document` or `p:load` step. See what happens when the file it points to is not actually there.
* There is a difference between `p:input`, used to configure a pipeline in its prologue, and `p:load`, a step that loads data. Ponder what these differences are. Try changing a pipeline that uses one into a pipeline that uses the other.
* Similarly, there is a difference between a `p:output` configuration for a pipeline, and a `p:store` step executed by that pipeline. Consider this difference and how we might define a rule for when to prefer one or the other. How is the pipeline used – is it called directly, or intended for use as a step in other pipelines? How is it to be controlled at runtime?
* Try inserting `p:store` steps into a pipeline to capture intermediate results, that is, the output of any step before they are processed by the next step. Such steps can aid in debugging, among other uses.
* `@message` attributes on steps provide messages for the runtime traceback. They are optional but this repo follows a rule that any `p:load` or `p:store` should be provided with a message. Why?
* A `p:identity` step passes its input unchanged to the next step. It can also be provided with a `@message`. The two commonest uses of `p:identity` are probably to provide for a &ldquo;no-op&rdquo; option, for example within a conditional or try/catch – and to provide runtime messages to the console.

After breaking anything, restore it to working order. Create modified copies of any pipelines for further analysis and discussion.

* Concept: copy and change one of the pipelines provided to acquire a software library or resource of your choice.

## Value templates in attributes and text: { XPath-expr }

A feature was [mentioned earlier](../walkthrough/walkthrough_401.md) that warrants caution when embedding code in code: when producing string values dynamically (i.e., at runtime), XProc supports a *template syntax* borrowed from XSLT and XQuery, as [attribute value templates](https://www.w3.org/TR/xslt-10/#dt-attribute-value-template), [text value templates](https://www.w3.org/TR/xslt-30/#text-value-templates), or [enclosed expressions](https://www.w3.org/TR/xquery-31/#id-enclosed-expr). An XPath expression within the brackets is to be evaluated dynamically by the processor. This is one of the most useful convenience features in the language.

[This syntax](https://spec.xproc.org/3.0/xproc/#value-templates) is concise, but expressive. Upon seeing:

```
<p:identity message="Processing { $filename } at { current-date() }"/>
```

the XProc developer understands:

* The date, in some form should be written into the message. (Try it and see.) The XPath function [format-date](https://www.w3.org/TR/xpath-functions-31/#func-format-date) can also be used if we want a different format: for example, `current-date() => format-date('[D] [MNn] [Y]')`.
* The variable reference `$filename` is defined somewhere, and here will expand to a string value due to the operation of the (attribute value) template.

If you need to see actual curly brackets, escape by doubling: `{{` for the single open and `}}` for the single close.

As mentioned earlier, one complication sometimes arises: because XSLT and XQuery support similar syntax, clashes can occur, since their functioning will depend on correctly interpreting the syntax within literal code. One solutions include using double escaping (see examples in [the spec](https://spec.xproc.org/3.0/xproc/#value-templates)). This can be tried with [a worksheet XProc](../../worksheets/NAMESPACE_worksheet.xpl).

A more comprehensive solution is to use an XProc setting: an `expand-text` attribute, or `p:expand-text` when appearing on an element not already bound to the `p`-prefixed namespace, i.e. XProc). Setting this to `false` turns the templating feature off: the brackets become regular brackets again. [The spec                also describes](https://spec.xproc.org/3.0/xproc/#expand-text-attribute) an attribute `p:inline-expand-text` that can be used in places where the regular `expand-text` would interfere with a functional requirement (namely the representation of literal XML provided in your XProc using `p:inline`). Either of these settings can be used inside elements already set, resulting in &ldquo;toggling&rdquo; behavior (it can be turned on and off), as any `expand-text`, by applying to descendants, overrides settings on its ancestors.

For the most part it is enough to know that the `expand-text` setting is &ldquo;on&rdquo; (`true`) by default, but it can be turned off (`false`) – and (for handling edge cases) back on, lower down in the hierarchy. And watch the curly brackets.

## Designating inputs

One feature of the pipelines we have looked at so far is that their inputs are hard-wired. While this is sometimes helpful (such a pipeline can be nicely self-contained), it should also be possible to apply a pipeline to an XML document (or other input) without having to designate the document inside the pipeline itself. The user or calling application should be able to say &ldquo;run this pipeline, but this time with this input&rdquo;.

This is important not only for itself but because it is the key to composability: reusing pipelines as steps in other pipelines.

The input ports for a pipeline, specified using [p:input](https://spec.xproc.org/3.0/xproc/#p.input) within the prologue, provide for this.

For example, the [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl) pipeline defines an input port:

```
<p:input port="source" sequence="true">
    <p:document href="data/catalog-model/xml/cat_catalog.xml"/>
</p:input>
```

By default, this pipeline will pick up and process the data set (here, an XML document) it finds at path `data/catalog-model/xml/cat_catalog.xml`, relative to the pipeline instance (XProc file). But any call to this pipeline, whether directly or as a step in another pipeline, can override this to provide a different input.

An XProc processor defines a command syntax for binding inputs to ports, such as is described in[Morgana documentation](https://www.xml-project.com/manual/ch01.html#R_ch1_s1_2). Morgana's looks like this (when used with the script deployed with this repository):

```
$ ../xp3.sh *PIPELINE.xpl* -input:*portname=path/to/a-document.xml* -input:*portname=path/to/another-document.xml*
```

([XML Calabash 3](https://docs.xmlcalabash.com/userguide/current/running.html#run-run) has analogous but not identical syntax.)

Here, two different `-input` arguments are given for the same port. You can have as many as needed if the port, like this one, has `sequence="true"`, meaning any number of documents (zero, one or more) can be bound to the port, and the pipeline will accommodate. When more than one port is defined for a pipeline, one (only) can be designated as `primary="true"`, allowing it to be provided implicitly when a port connection is required (by a step) but not designated. Notice that the name of the port must also appear in the command argument, as in `-input:portname`, since while pipelines can have ports supporting sequences, they can also have different ports, named differently, for documents playing different roles in the pipeline.

In place of `portname` here, a common name for a port (conventional when it is the pipeline's only or primary input) is `source`. But you can also expect to see ports (especially secondary ports) with names like `schema`, `stylesheet` and `insertion`: port names that offer hints as to what the step does.

A port designated with `sequence="true"` can be empty (no documents at all) and a process will run. But by default, `sequence="false"` is assumed, for a single document, or an error condition when none is provided.

Among other things, this means that a pipeline that has `<p:input name="x"/>` cannot be run unless a (single) document for the `x` port (as it is named here) is provided with the invocation.

For when an empty document binding is wanted (i.e., no document is fine), XProc offers [p:empty](https://spec.xproc.org/3.0/xproc/#p.empty) to make this explicit. Use with `sequence="true"`.

### Lightening the `p:load`

As an alternative to binding inputs to using `p:input/p:document` (on a pipeline definition) or `p:with-input` (on a step invocation), XProc offers another way to acquire data from outside the pipeline: by using a `p:load` step. This is somewhat different in operation: as it is a step in itself, errors produced by `p:load` cannot be detected until the pipeline is run, whereas failures with `p:input` should be detected when the pipeline itself is parsed and compiled (i.e. during *static analysis*), and processors may be able to apply different kinds of exception handling, fallbacks or support for redirects. (As always you can try, test and determine for yourself.) Apart from this distinction the two approaches have similar effects – whether to use one or the other depends often on how you expect the pipeline to be used, distributed, and maintained, since either can work in operation.

Although one distinction is that `p:document` appears on input ports, which can be overridden (or rather, set dynamically), this does not mean that `p:document` cannot be essentially &ldquo;private&rdquo; to a pipeline or pipeline step. For example, if you wish to acquire, without `p:load`, more than a single document known in advance (i.e. the file names can be hard-coded), provide your step (`p:identity` in this case) with inputs like so:

```
<p:identity>
  <p:with-input>
    <p:document href="..."/>
    <p:document href="..."/>
    ...
  </p:with-input>
<p:identity>
```

This binds the documents to the input of the step (as `p:identity` supports a sequence, more than one is fine), without exposing an input port in the main pipeline.

Combining the approaches permits another useful capability: first, acquire a list of file names, for example (here using `p:input/p:inline)`:

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

This has the effect of traversing the document given in line (the file list) and for each of its `FILE` elements, loading the document named as the `FILE` element's string value, that is &ldquo;A&rdquo;, &ldquo;B&rdquo; (in this example) and so on. This is just as if A and B had been bound directly to the port. In either case, what we get is a sequence of XDM *document* objects, one for each of the resources parsed.

One tradeoff is that the override mechanism will be different. We override the first approach by binding the pipeline's `source` port directly to whatever documents we want in place of A and B. We override the second approach by providing a different FILELIST document. Alternatively such a FILELIST can be referenced instead of included … `p:document href="the-filelist.xml`, providing us a resource that we can maintain separately.

This makes the second approach especially appealing if the file list can be derived from some kind of metadata resource or, indeed, `p:directory-list`….

## Warning: do you know where your source files are?

As noted in the [101 Lesson Unit](oscal-convert_101.md), one of the advantages of using URIs, over and above the Internet itself, is that systems can support URI redirection when appropriate. This will ordinarily be in order to provide local (cached) copies of standard resources, thereby mitigating the need for copying files over the Internet. While this is a powerful and useful feature – arguably essential for systems at scale – it can present problems for transparency and debugging if the resource obtained by reference to a URI is not the same as the developer (or &ldquo;contract&rdquo;) expects.

A similar problem results from variations in URI syntax, both due to syntax itself and due to the fact that URIs can be relative file paths, so `file.xml` and `../file.xml` could be the same file, or not, depending on the context of evaluation.

To help avoid or manage problems resulting from this (i.e., from features as bugs), XPath and XProc offer some useful functions:

* XPath [base-uri()](https://www.w3.org/TR/xpath-functions-31/#func-base-uri) will return the (nominal) base URI of a node in an XML document, regarded as an XDM property of nodes. Other XDM objects including maps do not have base URIs, but XML documents do. This is an important and special property in XProc, as it is the basis of its own resource management semantics. Expect to see more of `base-uri()` along with similar (and aligned) XProc functionality such as `document-property(.,'base-uri')`.
* XPath [resolve-uri()](https://www.w3.org/TR/xpath-functions-31/#func-resolve-uri) can be used to expand a relative URI into an absolute URI
* XProc [p:urify](https://spec.xproc.org/3.0/xproc/#f.urify) will normalize URIs and rewrite file system paths as URIs – very useful.
* In XProc 3.1, a new function [p:lookup-uri](https://spec.xproc.org/lastcall-2024-08/head/xproc/#f.lookup-uri) can query the processor's URI resolver regarding a URI, without actually retrieving its resource. This makes available to the developer what address is actually to be used when a URI is followed – detecting any redirection – and permits defensive code to be written when appropriate.

## Probing error space – data conversions

The topic here picks up from the earlier consideration of [What could possibly go wrong](oscal-convert_101.md).

Broadly speaking, problems encountered running these conversions (or indeed, transformations in general) fall into two categories, the distinction being simple, namely whether a bad outcome is due to an error in the processor and its logic, or in the data inputs provided. The term &ldquo;error&rdquo; here hides a great deal. So does &ldquo;bad outcome&rdquo;. One type of bad outcome takes the form of failures at runtime – the term &ldquo;failure&rdquo; again leaving questions open, while at the same time it seems fair to assume that not being able to conclude successfully is a bad thing. But other bad outcomes are not detectable at runtime. If inputs are bad (inconsistent with stated contracts such as data validation), processes can run *correctly* and deliver incorrect results: correctly representing inputs, in their incorrectness. Again, the term *correct* here is underspecified and underdefined, except in the case.

For these and other reasons we sometimes prefer to call them &ldquo;exceptions&rdquo;, while at the same time we know many errors are not actually errors in the process but in the inputs. We need reliable ways to tell this difference. A library of reliable source examples -- a test suite – is one asset that helps a great deal. Even short of unit tests, however, a great deal can be discovered when working with &ldquo;bad inputs&rdquo; interactively. This knowledge is especially valuable once we are dealing with examples that are only &ldquo;normally bad&rdquo;.

Some ideas on how to do this appear below.

### Converting broken XML or JSON

Create a syntactically-invalid (not **well-formed**) XML or JSON document - or rather (more correctly), a text document that might have been XML or JSON but for some incidental problem.

*Try using this as input* to any XProc. Note how the processor delivers error messages bringing attention to problems it discovers.

### Converting not-OSCAL

XML practitioners understand how XML can be well-formed and therefore legible for processing, without being a valid instance of a specific markup vocabulary. You can have XML, for example, without having OSCAL. This was discussed in [the previous lesson                   unit](oscal-convert_101.md).

But a hands-on appreciation, through experience, of how this actually looks, is better than a merely intellectual understanding of why it must be.

When providing XML that is not OSCAL to a process that expects OSCAL inputs, you should properly see either errors (exceptions), or bad results (outputs missing or wrongly expressed) or both. A tutorial is the perfect opportunity to experiment and see.

For example, try using the OSCAL XML-to-JSON pipeline on an XProc document (which is XML, but not OSCAL).

The interesting thing here is how permissive XProc is, unless we code it to be jealous. Detection of bad results is an important capability, which is why we also need to be able to *validate* data against external constraint sets such as schemas, also covered in more detail later.

### Converting broken OSCAL

The same thing applies to attempting to process inputs when OSCAL is expected, yet the data sources fail to meet requirements in some important respect, sometimes even a subtle requirement, depending on the case. The more fundamental problem here is the definition of &ldquo;correct&rdquo; versus &ldquo;broken&rdquo;.

We begin generally with the stipulation that by &ldquo;OSCAL&rdquo; what we mean is, any XML (or JSON or YAML) instance conformant to an OSCAL schema, and thereby defined in such a manner as to enable their convertibility. The reasoning is thus somewhat circular. If we can convert it successfully, we have a basis to claim it is OSCAL, by virtue of its *evident* conformance to OSCAL models in operation. If we know it to be OSCAL by virtue of schema validation, we have assurances also regarding its convertibility.

In contrast, data that is not schema-valid (as can be reasoned) cannot be *confidently* and *completely* qualified or described at all, so only very simple (&ldquo;global&rdquo;, generic or &ldquo;wildcard&rdquo;) mappings from arbitrary inputs can be specified. Almost by definition, these will usually be poor for actual cases. But a mapping can be specified for inputs that are known, such as OSCAL inputs. An OSCAL converter respects the validation rules not by enforcing them directly, but rather by depending on the consistency they describe and constrain.

Fortunately, by means of Schematron and transformations, XProc is an excellent tool not only for altering data sets, but also for imposing such validation rules, by detecting variances, either in inputs or its results. XPath, the query language, becomes key. With XPath to identify features (both good and bad), and XProc for modifications, these capabilities – detection and amelioration – can be used together, and separately. When a pipeline cannot guarantee correct outputs, it can at least provide feedback.

Depending on the application and data sources, XML that is &ldquo;broken&rdquo; in various subtle ways is more or less inevitable. See what it looks like by making this happen on purpose.

## XProc diagnostic how-to

These methods are noted above, but they are so important they should not be skipped.

### Emitting runtime messages

Most XProc steps support a `message` attribute for designating a message to be emitted to the console or log. As shown, these also support Attribute Value Syntax for dynamic evaluation of XPath.

For example, again using `p:identity`:

```
<p:identity message="Processing { p:document-property(.,'base-uri') } with content-type { p:document-property(.,'content-type') }"/>
```

This step does not change the document, but reports its current Base URI and content-type at that point in the pipeline.

This can be useful information since both those properties can (and should) change based on your pipeline's operations.

### Saving out interim results

Learn to use the `p:store` step, if only because it is so useful for saving interim pipeline results to a place where they can be inspected.

[Produce-FM6-22-chapter4](../../../projects/FM6-22-import/PRODUCE_FM6-22-chapter4.xpl) is a demonstration pipeline in this repo with a switch at the top level, in the form of an option named `writing-all`. When set to `true()`, it has the effect of activating a set of `p:store` steps within the pipeline using the XProc [use-when feature](https://spec.xproc.org/3.0/xproc/#use-when) feature, to write intermediate results. The resulting set of files is written into a `temp` directory to keep them separate from final results: they show the changes being made over the input data set, at useful points for tracing the pipeline's progress.

## Validate early and often

One way to manage the problem of ensuring quality is to validate the inputs before processing, either as a dependent (prerequisite) process, or built into a pipeline. This enables a useful separation between problems resulting from bad inputs, and problems within the pipeline. Whatever you want to do with invalid inputs, including skipping or ignoring them, producing warnings or runtime exceptions, or even making corrections when possible and practical – all this can be defined in a pipeline much like anything else.

Keep in mind that since XProc brings support for multiple schema languages plus XPath, &ldquo;validation&rdquo; could mean almost anything. This must be determined for the case.

In the [publishing demonstration project                folder](../../../projects/oscal-publish/publish-oscal-catalog.xpl) is an XProc that valides XML against an OSCAL schema, before running steps to convert it to HTML, for display in a browser. The same could be done for an XProc that converts OSCAL data into JSON -- since OSCAL has both XSD for XML, and JSON Schema for JSON, this could be done before the conversion, after, or both.

Two projects in this repository (at time of writing) deal extensively with validation: [oscal-validate](../../../projects/oscal-validate/) and [schema-field-tests](../../../projects/schema-field-tests/).
