# CPRT Import pipeline

Converting data as distributed by CPRT

Example: [SP 800-171](https://csrc.nist.gov/projects/cprt/catalog#/cprt/framework/version/SP_800_171_3_0_0/home)

A dataset downloaded by hand is stored in [data/cprt/cprt_SP_800_171_3_0_0_11-12-2024.json](data/cprt/cprt_SP_800_171_3_0_0_11-12-2024.json)

The demo pipeline [PRODUCE_SP800-171-OSCAL.xpl](PRODUCE_SP800-171-OSCAL.xpl) is hard wired to this input - while the same pipeline should work (with allowances made for adjustments) on any CPRT data set published in JSON format, or at any rate any data set with this arrangement of elements.

For other JSON feeds especially other CPRT feeds, some of this logic should be reusable, while a prudent approach will still regard any new input as a one-off requiring careful inspection and validation.

The pipeline produces outputs in a `temp` directory and also an OSCAL file in the main directory, stamped with a distinctive identifier (first token in its top-level UUID).

## Run the converter pipeline

If not set up to run Morgana or some other XProc processor, see the [top-level setup instructions](../../setup-notes.md).

To run (bash):

```
$ ../xp3.sh PRODUCE_SP800-171-OSCAL.xpl
```

(Windows CMD):

```
> ..\xp3 PRODUCE_SP800-171-OSCAL.xpl
```

## How does it work

This pipeline has real-world complexity. At the same time it is self-contained enough to provide a sensible example.

### Mapping challenges

Full details can be discerned by reading [the pipeline instance](PRODUCE_SP800-171-OSCAL.xpl).

This particular JSON extraction from the Reference Tool has two weaknesses in particular:

####  Flattened hierarchy

The document being represented has a complex structure in which controls are articulated into parts, grouped into families, and linked to external controls and references. This structure is not shown in the JSON 'dump', in which everything is decomposed to the same level.

From this flat list, the converter produces a hierarchically-structured output in XML, in which the control families, controls and their parts show again in their 'natural' arrangement, with links as cross-references.

#### Implicit markup of inline semantics

Some semantic structures in the inputs are not represented in the data except implicitly, by notational conventions within the data stream.

For example, the string "&lt;A.03.14.01.ODP[01]: time period>" is an inline reference to a parameter (ODP). The pipeline renders this with markup:

```
<odp-ref ref-id="A.03.14.01.ODP[01]">time period</odp-ref>
```

These semantics include:
  - specifications and links to parameters (ODPs) in two different forms
  - internal cross-references marked as escaped HTML ("&lt;a>" elements)

The pipeline handles these inputs in two steps. First the string is rewritten (if/as necessary) as a well-formed XML string. Second, it is parsed. If the string is found to be XML and parses, these XML results are added. Otherwise the string is simply added as usual.

Over controlled inputs this process can be monitored and validated for correctness and comprehensiveness. The pipeline uses Schematron to help with this assurance testing.

### Handling results

The pipeline produces a main OSCAL result but also writes interim results to a `temp` folder, which can be discarded. The file outputs there are placed in sequence to help tracing the process.









---

