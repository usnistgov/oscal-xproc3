# TESTING OSCAL Profile Resolution

This project is presented as a test and testing harness for the prototype XSLT Profile Resolver made available in the OSCAL repository.

See the [readme](readme.md) for more information and links on this process.

The scripts here invoke an XProc pipeline with the profile to be resolved bound to the 'oscal-profile' input port.

This binding can be provided by a static XProc as shown in the following standalone pipelines:

- [RESOLVE-CAT-PROFILE.xpl](RESOLVE-CAT-PROFILE.xpl) - a small example with walnut-sized brain
- [RESOLVE-FISMA-PROFILES.xpl](RESOLVE-FISMA-PROFILES.xpl) - a more 'real world' example showing an actual FISMA profile - depends on [setup/ACQUIRE-OSCAL-DATA.xpl](setup/ACQUIRE-OSCAL-DATA.xpl) to populate `lib`.

If a pipeline fails on execution, either:

- A file was changed or moved somehow on your system or upstream - refresh or adjust?
- The XSLT transformations do not function correctly on your inputs - maybe you found a bug?

If a pipeline succeeds in producing an XML document, it can still fail for inputs that do not conform to expectations. Be sure your data is valid and correct going in, and always check.

## Validation of profiles and catalogs

Naturally things only work if documents are actually correctly encoded, as represented.

Invalid profiles and catalogs (or put another way, things called or calling themselves profiles and catalogs, that are not recognizable as such to an OSCAL processor) by definition cannot be guaranteed to function at all, or if they function, to provide useful results.

Providing for live validation -- as opposed to validating materials committed here -- remains a tbd in this project.

### Schemas

The pipeline [../template/GRAB-RESOURCES.xpl](../template/GRAB-RESOURCES.xpl) downloads materials including OSCAL schemas, into a [lib](../lib/) directory. These schemas can be used for validating profiles and catalogs using generic XML tooling, including XProc pipelines composed for that purpose.

Other projects in this repository also offer validation logic useful for developing and debugging OSCAL profiles.

TODO: provide more help to users and devs on validating their OSCAL as a proactive defense against error?

TODO: build a validator application project - not schema-field-testing but more lightweight - and point users to it?

- Batch validate OSCAL in different models and formats
   - Validate to 'all' schema or dynamic dispatch?
- run under CI/CD

### Schematron for OSCAL profiles

The `src` folder has [a Schematron query sheet](src/check-profile-imports.sch) useful for validating the import sequence of an OSCAL profile. The Schematron retrieves all the imports on the chain (profiles importing catalogs and profiles, which import catalogs and profiles) and reports if any are out of order.

This can include:

  - Bad link syntax or broken internal link
  - A referenced resource is not found for importing
  - An referenced resource is not an OSCAL profile or catalog

Additionally, an [XSL transformation](src/trace-profile-imports.xsl) provides support to the Schematron by producing a rendition of a profile's import tree, for inspection. Run directly on a profile document, this gives more information than a simple finding of status (good or not good), for diagnostics.

## Anomalies in results

The [OSCAL profile resolution specification](https://pages.nist.gov/OSCAL/resources/concepts/processing/profile-resolution) is still in draft, and has been found to be ambiguous on a couple of points.

### Orphan links in resolved catalogs

One of these is the treatment of links (`link` objects or elements) pointing to internal resources (typically controls) that are no longer present in the filtered catalog result.

According to https://pages.nist.gov/OSCAL/resources/concepts/processing/profile-resolution/#d2e1438-head these might be removed as 'unused objects'.

If left in place, they cause violations of a constraint (rule) that stipulates that internal links must resolve.

An XSLT filter can be used to remove these links - feel free to ask for guidance, encouragement or assistance if you wish to take this on.

### Other problems in resolution

Since formats are not broadly tested in public and software is experimental, there can of course be problems.

For the user, the critical question is always whether problems are actionable, and how, or whether workarounds must be devised.

Since all OSCAL users have an interest in reliable tools, you help yourself and others when you can find a way to help solve new or old issues, starting with drawing notice to them.

Please feel free to ask questions in OSCAL or XML forums.


## XSpec

XSpec unit tests over the operation of this Profile Resolver are not on this site, but the soundness of the transformations are well tested by [XSpec in the home repository](https://github.com/usnistgov/OSCAL/tree/main/src/utils/resolver-pipeline/testing).
