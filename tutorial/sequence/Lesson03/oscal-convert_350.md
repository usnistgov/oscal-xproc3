

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/oscal-convert/oscal-convert_350_src.html](../../source/oscal-convert/oscal-convert_350_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 350: Namespaces in XML and XProc

## Goals

Learn enough about namespaces in XML to be able to make sense of XProc's handling of embedded vocabularies, whether extending its capabilities or for the purpose of embedding (literal) data sets.

Become comfortable with prefixed names such as `p:sleep`, `xsl:template` or `ox:oscal-xml-as-json` as a technology-wide convention for helping to disambiguate the semantics of different vocabularies, when mixed and in general.

## Prerequisites

None. If you don't need to know about XML's namespace mechanism, you can gladly skip this coverage.

## Resources

The [Namespaces in XML Recommendation](https://www.w3.org/TR/REC-xml-names) was published by W3C in 2009, and remains the authoritative source.

[A namespaces worksheet XProc](../../worksheets/NAMESPACE_worksheet.xpl)provides a place to experiment with namespaces in XProc.

## XML and namespaces

XProc like many XML technologies uses the XML namespace mechanism to disambiguate between mixed vocabularies.

Using namespace-qualified names in the form of *colonized names* (such as `p:try`) makes it possible to distinguish between `p:try` and `xsl:try` reliably (to use a real example).

Moreover, a formal mechanism defined in XML syntax (*namespace declaration* by way of attributes) enables associating the prefixes in a given scope with a controlled set of authority references (in the form of namespace URIs). Thus any namespace, considered as set of prefixed names under by a given declaration) can easily with its putative owner, proprietor or maintainer, in a way that lets them decide the fine distinctions: so `http://www.w3.org/1999/XSL/Transform` for XSLT, `http://www.w3.org/ns/xproc` for XProc and so forth: same maintainance umbrella, different applications.

## Namespace fixup and namespace cleanup steps

Because they are heavily used in XSD and XPath for data typing, in XPath, XSLT and XQuery for extension functionality, XProc itself, and all its XML-based inputs and outputs, namespaces are inescapable – and they can be messy.

To help, XProc specifies a process called *namespace fixup* that constitutes essentially a set of rewrite rules for a tree of elements and attributes with qualified names, in order to normalize and streamline the deployment of namespaces, with benefits in file size and legibility. You should think of namespace fixup as something the processor might do on your behalf at any time, and a good thing. Minimize its impacts by avoiding new namespaces where possible, and controlling namespaces in use.

While namespace fixup will help, it cannot optimize for your case. The step `p:delete-namespace` is a common remedy for *inflamed namespaces*, a condition that happens to XML that has been handled recklessly by too many handlers with too many namespaces. Also, `p:namespace-rename`.

## Namespace tips and tricks

A few small points to make namespace handling easier.

### Steps for namespaces

In addition to the built-in namespace fixup, two XProc steps are invaluable for managing namespaces:

* [p:namespace-delete](https://spec.xproc.org/3.0/steps/#c.namespace-delete)
* [p:namespace-rename](https://spec.xproc.org/3.0/steps/#c.namespace-rename)

A couple of things to note about these:

#### Namespace prefixes

XProc typically uses the namespace prefixes declared in the XProc XML file, in order to address namespaces. So `p:namespace-delete prefixes="ox"` will delete whatever namespace is bound by the XProc itself to the prefix `ox` – it is a feature, not a bug, that this namespace (it would be `http://csrc.nist.gov/ns/oscal-xproc3` in this repository) might be prefixed differently in out-of-line XML.

#### Greedy renaming

When using `p:namespace-rename` you need to be careful to rename (by changing their namespaces) only the nodes you want! Typically this means you will need `apply-to="elements"` to prevent attributes as well as XML elements from being assigned to the namespace. This is a subtle difference, but it can affect both XPath matching and schema validation – and resulting problems can be hard to debug.

### Coining new namespaces

Do not be misled by the fact that namespaces are defined by means of URIs. The URIs point to pages that often do not exist. Making new namespaces to provide a rational scope for a new set of elements or functions is normal, and nothing needs to appear at that URI.

Developers may have non-technical reasons for using or avoiding certain URIs when doing so, but creating new XML namespaces is something that simply has to be done, if we are to use them as intended and consistently.

### On-the-fly namespace declarations

When doing so, or when deploying any namespace declarations (the HTML namespace `http://www.w3.org/1999/xhtml` is a frequent offender), the associated `xmlns:` attribute does *not* have to be placed only at the document root. Pipelines in the repository sometimes show namespaces declared internally, since it can be convenient to limit their scope of application.

**Tip:** try using `p:group` as a handy way of managing scoping of XML namespaces as well as XProc variables.

### Overloading prefixes

One problem presented by namespaces is the flip side of one of their most important features, that prefixes can be bound to names dynamically.

Consider this XML start tag for an XProc pipeline:

```
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:a-step" name="a-step">
```

Within the scope of this element, both unprefixed names such as `div` or `p` will identify the same elements as `ox:div` and `ox:p`. None of these elements are the familiar HTML `div` and `p` since the namespace is wrong – for HTML we would expect the HTML namespace, or none.

This pipeline might wish to scrub its namespaces with a [p:namespace-delete](https://spec.xproc.org/3.0/steps/#c.namespace-delete) XProc step. Without such cleanup, since declarations are provided for the XSLT and XSD namespaces, these will accordingly appear (and be propagated) into literal elements given in the pipeline and hence, pipeline results.

### Matching with namespace wildcard

In XPath since version 2.0, `*:p` will identify any `p` element in any namespace – not always pretty, but useful.
