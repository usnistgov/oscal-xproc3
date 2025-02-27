# USDS Playbook Import

Reformatting a simple web resource as an OSCAL catalog, using XProc 3.

See the repository [README](../README.md) along with [repository guidelines](../CODE_OF_CONDUCT.md).

## Project purpose, scope and goals

Show a rudimentary OSCAL "up-conversion" (value-add conversion, 'qualification' or semantic enhancement) by converting a small, readily-available document (public, on the web) into OSCAL.

Provide a working model in miniature of the same architecture as other XProc-based data enhancement, qualification or rectification pipelines in this repository and elsewhere.

## Who might find this useful

Students of XProc looking for a simple demo of data extraction from HTML.

Students of OSCAL learning its semantics and (XML) tagging.

## What is provided

Three pipelines share the load, mainly for transparency. A pipeline acquires and saves a local copy of source data; a second pipeline fings a schema; the third performs a conversion of the source data into a schema-valid form, and validates it.

A single integrated pipeline would be straightforward -- and could avoid all local caching -- but harder to diagnose when the source data moves or disappears.

### Pipeline [GRAB-RESOURCES.xpl](GRAB-RESOURCES.xpl)

- Pulls a copy of the OSCAL XSD Schema
- Stores it locally in `lib`

You can skip this step if you wire [the next pipeline](OSCAL-PLAYBOOK.xpl) to find a schema at a different location, or skip OSCAL validation.

### Pipeline [GRAB-PLAYBOOK.xpl](GRAB-PLAYBOOK.xpl)

Run this pipeline only if you need to compare to or replace the provided copy.

- Pulls a copy of the Digital Services Playbook (an HTML resource) from the Internet
- [Saves it locally](archive/playbook-source.html) in the 'archive' folder

This pipeline can be adapted to cache any page from the Internet. Use it responsibly!

### Pipeline [OSCAL-PLAYBOOK.xpl](OSCAL-PLAYBOOK.xpl)

- Reads file cached in the last operation (producing an error when it is missing)
- Converts into clean semantic tagging (ad hoc) using XSLT
- Validates this against [a schema](src/playbook.rnc) that codifies expectations
- Converts into an OSCAL catalog, with fresh timestamp and UUID
- Validates as an OSCAL Catalog against the OSCAL XSD schema
- Saves on the file system

This pipeline should fail with errors when results are not as expected.

## How to use it

Run the pipelines with an XProc 3 engine and examine contents of `archive`.

Rename 'archive' to produce a fresh archive by running the pipeline again, in 'archive'.

## Credits for contributors

Wendell Piez, oscal-xproc3 PI

started 20250111

---


