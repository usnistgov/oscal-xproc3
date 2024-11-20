

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 350: Namespaces in XML and XProc

## Goals

Learn enough about namespaces in XML to be able to make sense of XProc's handling of embedded vocabularies, whether extending its capabilities or for the purpose of embedding (literal) data sets.

Be no longer mystified by prefixed names such as `p:sleep`, `xsl:template` or `ox:oscal-xml-as-json` as a technology-wide convention for helping to disambiguate the semantics of different vocabularies, when mixed and in general.

## Prerequisites

None. If you don't need to know about XML's namespace mechanism, you can gladly skip this coverage.

## Resources

A [technical specification](https://www.w3.org/TR/REC-xml-names) of this mechanism was published by W3C in 2009, and remains the authoritative source.

XXX A namespaces worksheet XProc provides a place to experiment....

## XML and namespaces

XProc like many XML technologies uses the XML namespace mechanism to disambiguate between mixed vocabularies.

Using namespace-qualified names in the form of *colonized names* (such as `p:try`) makes it possible to distinguish between `p:try` and `xsl:try` reliably (to use a real example).

Moreover, a formal mechanism defined in XML syntax (*namespace declaration* by way of attributes) enables associating the prefixes in a given scope with a controlled set of authority references (in the form of namespace URIs). Thus any namespace, considered as set of prefixed names under by a given declaration) can easily with its putative owner, proprietor or maintainer, in a way that lets them decide the fine distinctions: so `http://www.w3.org/1999/XSL/Transform` for XSLT, `http://www.w3.org/ns/xproc` for XProc and so forth: same maintainance umbrella, different applications.

## Namespace fixup and namespace cleanup steps

XProc specifies a process called *namespace fixup* that constitutes essentially a set of rewrite rules for a tree of elements and attributes with qualified names, in order to normalize and streamline the deployment of namespaces, with benefits in file size and legibility. You should think of namespace fixup as something the processor might do on your behalf at any time, and a good thing. Minimize its impacts by avoiding new namespaces where possible, and controlling namespaces in use.

While namespace fixup will help, it cannot optimize for your case. The step `p:delete-namespace` is a common remedy for *inflamed namespaces*, a condition that happens to XML that has been handled recklessly by too many handlers with too many namespaces. Also, `p:namespace-rename`.

## Namespace tips and tricks XXX

### Coining new namespaces

### On-the-fly namespace declarations

### Overloading prefixes

### Matching with namespace wildcard

For example, `match="*:p"` will match any `p` element in any namespace.
