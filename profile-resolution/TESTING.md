# TESTING OSCAL Profile Resolution

This project is presented as a test and testing harness for the prototype XSLT Profile Resolver made available in the OSCAL repository.

See the [readme](readme.md) for more information and links on this process.

The scripts here invoke an XProc pipeline with the profile to be resolved bound to the 'oscal-profile' input port.

This binding can be provided by a static XProc as shown in the following standalone pipelines:

- RESOLVE-AT-SOME-PROFILE.xpl
- RESOLVE-FISMA-LOW-BASELINE.xpl
- RESOLVE-CAT-PROFILE.xpl

If any of these fail on execution, either:

- they were changed and broken somehow on your system or upstream - refresh?
- the XSLT transformations are no longer functioning - maybe you found a bug?

*However* note that any of these may depend on resources available only after the setup pipelines `GRAB-PROFILE-RESOLVER-XSLT.xpl` and `GATHER-OSCAL-DATA.xpl` are run. These may help to trace and repair any issues relating to missing resources.

What testing is provided by, for, and in the project may be documented here.

## Validation of profiles and catalogs

Naturally things only work if documents are actually correctly encoded, as represented.

Invalid profiles and catalogs (or put another way, things called or calling themselves profiles and catalogs, that are not recognizable as such to an OSCAL processor) by definition cannot be guaranteed to function at all, or if they function, to provide useful results.

Providing for live validation -- as opposed to validating materials committed here -- remains a tbd in this project.

TODO: provide more help to users and devs on validating their OSCAL as a proactive defense against error?

TODO: build a validator application project - not schema-field-testing but more lightweight - and point users to it?

- Batch validate OSCAL in different models and formats
   - Validate to 'all' schema or dynamic dispatch?
- run under CI/CD

## XSpec

XSpec unit tests over the operation of this Profile Resolver are not on this site, but the soundness of the transformations are well tested by [XSpec in the home repository](https://github.com/usnistgov/OSCAL/tree/main/src/utils/resolver-pipeline/testing).
