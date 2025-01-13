# USDS Playbook Import

Use this file to document the project in the containing folder.

See the repository [README](../README.md) along with [repository guidelines](../CODE_OF_CONDUCT.md).

## Project purpose, scope and goals

Convert a small, readily-available (public) document (on the web) into OSCAL, to show a rudimentary OSCAL "up-conversion" (value-add conversion, 'qualification' or semantic enhancement).

Provide a working model in miniature of the same architecture as other XProc-based data enhancement, qualification or rectification pipelines in this repo and elsewhere.

## Who might find this useful

Student of XProc looking for a demo of data extraction from HTML.

Student of OSCAL learning its semantics and mappings.

## What is provided

### Pipeline [GRAB-PLAYBOOK.xpl](GRAB-PLAYBOOK.xpl)

- Pulls a copy of the Digital Services Playbook from the Internet (an HTML resource)
- Saves it locally in 'archive' folder

### Pipeline [OSCAL-PLAYBOOK.xpl](OSCAL-PLAYBOOK.xpl)

- Reads file cached in the last operation (with errors when it is missing)
- Converts and saves as an OSCAL catalog, with fresh timestamp and UUID

## How to use it

Run the pipelines with an XProc 3 engine and examine contents of `archive`.

Rename 'archive' to produce a fresh archive by running the pipeline again, in 'archive'.

## Credits for contributors

Wendell Piez, oscal-xproc3 PI

started 20250111

---


