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

The pipeline produces OSCAL in two steps, for transparency. The first step acquires and saves a local copy of source; the second produces OSCAL from it.

An integrated pipeline would be easy to do but harder to diagnose when the source data moves or disappears.

### Pipeline [GRAB-PLAYBOOK.xpl](GRAB-PLAYBOOK.xpl)

- Pulls a copy of the Digital Services Playbook (an HTML resource) from the Internet
- [Saves it locally](archive/playbook-source.html) in the 'archive' folder

This can be adapted to cache any page from the Internet.

### Pipeline [OSCAL-PLAYBOOK.xpl](OSCAL-PLAYBOOK.xpl)

- Reads file cached in the last operation (with errors when it is missing)
- Converts into clean semantic tagging (ad hoc)
- Validates this against [a schema](src/playbook.rnc) that codifies expectations
- Converts into an OSCAL catalog, with fresh timestamp and UUID
- Saves on the file system

This pipeline should fail with errors when results are not as expected.

## How to use it

Run the pipelines with an XProc 3 engine and examine contents of `archive`.

Rename 'archive' to produce a fresh archive by running the pipeline again, in 'archive'.

## Credits for contributors

Wendell Piez, oscal-xproc3 PI

started 20250111

---


