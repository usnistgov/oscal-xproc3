

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

They are also useful for testing features, for example features for resource acquisition and disposition. These are fancy ways to describe how you get data into your pipeline and then out again.

Additionally, there are actually useful operations supported by a pipeline that pretends to change nothing. For example, it can transcode a file from one encoding to another – changing nothing in the data, but rewriting it into a different character set.

### 0.01 - what is a &ldquo;document&rdquo;

### 0.1 - loading documents known or determinable in advance

The XProc step `p:load` can be used to load the resource indicated into the pipeline.

Watch out, since `p:load` with `href=''` – loading the resource at the location indicated by the empty string, `""` – will load the XProc file itself. This is conformant with rules for URL resolution.

### 0.2 - binding a document to an input port

### 0.3 - loading documents dynamically on discovery with `p:directory-list`

### 0.4 - saving results to the file system

### 0.5 - exposing results on an output port

## Probing error space - data conversions

Broadly speaking, problems encountered running these conversions fall into two categories, the distinction being simple, namely whether a bad outcome is due to an error in the processor and its logic, or in the data inputs provided. The term &ldquo;error&rdquo; here hides a great deal. So does &ldquo;bad outcome&rdquo;. One type of bad outcome takes the form of failures at runtime - the term &ldquo;failure&rdquo; again leaving questions open. Other bad outcomes are not detectable at runtime. If inputs are bad (inconsistent with stated contracts such as data validation), processes can run *correctly* and deliver incorrect results: correctly representing inputs, in their incorrectness. Again, the term *correct* here is underspecified and underdefined, except in the case.

### Converting broken XML or JSON

### Converting broken OSCAL

### Converting not-OSCAL

## XProc diagnostic how-to

### Emitting runtime messages

### Saving out interim results

`p:store`

## Validate early and often
