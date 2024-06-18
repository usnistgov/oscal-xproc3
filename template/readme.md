# OSCAL XProc3 Project Template

Use this file to document the project in the containing folder.

For an outline of full (minimal) project documentation, see the [NIST Open-Source Software Repository Template](https://github.com/usnistgov/opensource-repo/blob/main/README.md).

The repository [README](../README.md) addresses all these points on a general level (repository-wide). Given the assumption that all projects are abiding by [repository guidelines](../CODE_OF_CONDUCT.md), each project readme (this file) is available for documenting its specifics.

Consider describing the following here:

## Project purpose, scope and goals

## Who might find this useful

The project is centered on an application or family of applications. Who will use it?

## What is provided

Describe, with supporting links, the software, data sets or other assets provided with the project.

## How to use it

With links. (If help is extensive consider maintaining it outside the readme.)

## Credits for contributors

And don't forget contact information, form for citation, etc.

# Checklist checklist

To use this template for a new project &mdash;

- [ ] Copy this folder
- [ ] Rename the copy for your project
- [ ] Is [GRAB-RESOURCES.xpl](GRAB-RESOURCES.xpl) useful, or something like it?
   - **yes** Rename, comment and edit
     - Validate your new pipeline using the [House Rules Schematron](../testing/xproc3-house-rules.sch)

   - **no** Delete
- [ ] (If 'no' and even if 'yes' on last question) Do you need a `lib` folder?
   - **yes** All is fine
   - **no** Delete and clean up [.gitignore](.gitignore)
- [ ] Update [TESTING.md](TESTING.md)
- [ ] Update [this file](readme.md) including the date at the bottom

started 20240522

---


