# USDS Playbook Import

Use this file to document the project in the containing folder.

See the repository [README](../README.md) along with [repository guidelines](../CODE_OF_CONDUCT.md).

## Project purpose, scope and goals

Convert a small, readily-available (public) document (on the web) into OSCAL, to show a rudimentary OSCAL "up-conversion" (value-add conversion, 'qualification' or semantic enhancement).

Serve as a "mini" with the same architecture as other data enhancement, qualification or rectification pipelines in this repo and elsewhere.

## Who might find this useful

Student of XProc looking for a demo of data extraction from HTML.

Student of OSCAL learning its semantics and mappings.

## What is provided

### Pipeline [PULL-USDS-PLAYBOOK.xpl](PULL-USDS-PLAYBOOK.xpl)

- Pulls copy of the Digital Services Playbook from the Internet or from local cache
- Maps HTML into OSCAL XML using XSLT
- Saves OSCAL XML version in 'archive' folder

See [the archive folder](archive/) for copies of data sources and saved results of earlier runs.

## How to use it

Run the pipeline with an XProc 3 engine and examine contents of `archive`.

Rename this folder to produce a fresh archive by running the pipeline again.

## Credits for contributors

Wendell Piez, oscal-xproc3 PI

started 20250111

---


