XProc 102: Project setup and installation

# XProc 102: Project setup and installation



## Goals
 
* Some exposure to XProc 3 organization and syntax on the inside 
* Some experience with success and failure invoking XProc pipelines -- learning to die fast and well 


## Resources

Same as [Setup 101](setup_101_src.html).

## Prerequisites

Please complete the repository setup and smoke tests as described in the [101 lesson](setup_101_src.html). In this lesson, we will run these pipelines with adjustments, or similar pipelines.

This discussion assumes basic knowledge of coding, the Internet (including retrieving resources via `file` and `http` protocols, and web-based technologies including HTML.

XML knowledge is also assumed, while at the same time we are interested to know where this gap needs to be filled.

## Step One: Inspect the pipelines

The two groupings of pipelines used in setup and testing should be discussed separately.

The key to understanding both groups is to know that one the initial [Setup script](../../setup.sh) is run, Morgana can be invoked directly, as paths and scripts are already in place. In doing so it can use only basic XProc steps, but those are enough for these purposes.

Specifically, the pipelines can acquire resources from the Internet, save them locally, and perform unarchiving (unzipping). In this case, the downloaded resources provide software that the pipeline engine (Morgana) can use to do more.

Accordingly, the first group of pipelines (in the [lib](../lib/) directory has a single purpose, namely (together and separately) to download software for Morgana.
 
* [lib/GRAB-SAXON.xpl](../../lib/GRAB-SAXON.xpl) 
* [lib/GRAB-SCHXSLT.xpl](../../lib/GRAB-SCHXSLT.xpl) 
* [lib/GRAB-XSPEC.xpl](../../lib/GRAB-XSPEC.xpl) 


These pipelines use different strategies for resource acquisition, depending on the case, where and in what form the resource is available.

The second group of pipelines also has a single purpose, namely to exercise and test the capabilities provided by the software downloaded by the first group.
 
* [smoketest/SMOKETEST-XSLT.xpl](../../smoketest/SMOKETEST-XSLT.xpl) tests Saxon 
* [smoketest/SMOKETEST-SCHEMATRON.xpl](../../smoketest/SMOKETEST-SCHEMATRON.xpl) tests SchXSLT 
* [smoketest/SMOKETEST-XSPEC.xpl](../../smoketest/SMOKETEST-XSPEC.xpl) tests XSpec 


## Step Two: Modify the pipelines

Use a text editor or IDE for this exercise.

If you have any concepts for improvements to the pipelines, or other resources that might be acquired this way, copy and modify one of the pipelines given to achieve those results.

Even if not - be sure to break the pipelines given -- or of copies under new names -- in any of several ways. Then run them, as a *safe way* to familiarize yourself with error messages:
 
* Break the XML syntax of a pipeline and try to run it 
* Leave XML syntax intact (well-formed), but break something in the XProc   * An element name, attribute or attribute setting  * A namespace  
* Try to retrieve something from a broken link 


Make sure that pipelines are back in working order when this exercise is complete.

## For consideration

Developers coming to this technology need to consider who would use it, and whether it is useful mainly at the back end, or also directly in the hands of professionals who must work with the data, bringing expertise in subject matter (such as, for OSCAL, systems security documentation) but not in data processing as such. Key to this question is not only whether attractive and capable user interfaces (or other mediators) can be developed (this is a known problem) but more importantly whether the systems themselves are adaptable enough so they can be deployed, used, refitted and maintained not just for repetitive generic tasks, but for *particular*, *special* and *local* problems discovered only at the points where information is gathered and codified. This larger fitting of solutions to problems is a responsibility for both CMEs (content matter experts) and developers together, who must define problems to be solved before finding approaches to them.

The open questions are: who can use XProc pipelines; and how can they be made more useful? The questions come up in an OSCAL context or any context where XML is demonstrably capable.