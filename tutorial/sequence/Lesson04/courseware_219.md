

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../../source/courseware/courseware_219_src.html](../../../source/courseware/courseware_219_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# Courseware 219: Learn by Teaching

## Goals

Help yourself, your team and allies.

Produce a useful spin-off from a task or problem you need to master anyway.

Learn not only by doing but by writing it down for yourself and others.

## Prerequisites

Those with no prior experience in XML-based publishing or declarative markup might be venturing into deep waters. At the same time there is nothing here that will faze readers who have experience editing HTML or XML.

Writing HTML by hand can be arduous; accordingly, for producing tutorial pages we have used a structured XML authoring environment [(oXygen XML Author)](https://www.oxygenxml.com/xml_author.html). While this excellent software is not necessary, it provides with many features including styling in display; full control over styling; testing Schematron rules in the background along with UI support for content corrections according to those rules; etc. A tool such as this or its functional equivalent is highly recommended – again demonstrating the value of a standards-based encoding.

However, any text editor or programmers' coding environment also works (to whatever extent generic HTML is supported), and Schematrons applied to HTML files can be run in XProc (as described).

## Resources

* Everything in the course you have seen so far
* Everything else you have seen relating to XProc
* Your own problems
* Your own examples

## Improve or enhance a lesson or lesson unit

Alert readers will have observed that a Markdown-based deployment invites editing. But the authoring or data acquisition model of this tutorial is not Markdown-based - Markdown is being used here in its usual way, instead serving as one of several publication formats for this data set. Source data itself is being written and maintained in in an XML-based HTML5 tag set defined for the project. By writing, querying and indexing in XHTML we can use XProc from the start. The HTML dialect means things &ldquo;just work&rdquo; using HTML tools such as web browsers, while we have transformations (provided in pipelines) to render into any other publication format we may happen to need. Markdown is one of a range of choices.

Extensibility and flexibility is one of the strengths of this approach: to publish a new or rearranged tutorial sequence can be done with a few lines and commands. A drag and drop interface supporting XProc makes this even easier, while again XProc is already supported under CI/CD, meaning both editorial and code quality checks can be done with every commit by simply listing the appropriate pipeline with others.

The workflow supporting this publication model is simple. A set of lessons (lesson units) is gathered together in a single folder. That folder is listed in [a directory file](../../lesson-plan.xml). To publish the tutorial, an XProc pipeline is executed that polls these directories and produces Markdown files corresponding to the inputs, only in a new sequence with links rewritten.

Adding a page is as simple as copying and altering a page in place, and seeing to it the new page is valid to both HTML5 and project requirements, and running the production pipeline with the new or edited sources.

Other pipelines can be run to update the directory to lesson units and other higher-level production such as a single-page HTML reading preview version. See [the                earlier treatment](courseware_101.md) for more details.

Improving a page is as simple as editing the HTML source in the folder and running pipelines to refresh its results.

### Apply Schematron to your edits

[A Schematron for lesson unit files](../../src/lesson-html.sch) also ensures that links are in place and project conventions are observed.

You will be grateful to do this interactively in an editor that supports Schematron in the background.

## Create a new set of lessons

Create a new folder in the `tutorial/source` subdirectory, and list it in[the tutorial lesson plan XML](../../lesson-plan.xml). Provide your new lesson plan with a new title and version.

(You may find other work-in-progress already there: feel free to help.)

When production pipelines are run, all HTML files present in the newly-listed folders will be included to the tutorial as lesson units. Within the folder they will be listed alphabetically. Be sure that your new HTML is also Schematron-valid to [the Schematron here](../../src/lesson-html.sch).

## Produce a new project and document it with a tutorial

You could make a new lesson topic with lessons on your own new project.

This repository is provided with a [project template](../../../project-template/readme.md) to make it easier to get started with new pipelines for new applications. Start a new project by copying this folder into the `projects` folder, renaming it, and proceeding to edit its file contents.
