

## lib

* [GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl): `p:declare-step`, `p:variable`, `p:load`, `p:store`, `p:unarchive`, `p:identity`
* [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl): `p:for-each`
* **GRAB-XSPEC.xpl**


## smoketest

* [POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl): `p:output`, `p:with-input`, `p:inline`, `p:namespace-delete`
* [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl): `p:validate-with-schematron`
* [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl): `p:xslt`
* [SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl): `p:import`, `p:input`, `p:document`


## oscal-convert

* [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl): `p:directory-list`, `p:add-attribute`, `p:with-option`
* [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl): `p:documentation`


## oscal-validate

* **GRAB-OSCAL.xpl**
* [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl): `p:pipe`
* [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl): `p:validate-with-xml-schema`
* **XSD-VALIDATE-EXAMPLE.xpl**
* [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl): `p:if`, `p:cast-content-type`, `p:wrap-sequence`


## oscal-publish

* [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl): `p:choose`, `p:when`, `p:otherwise`


## profile-resolution

* **RESOLVE-FISMA-PROFILES.xpl**
* **RESOLVE-KITTEN-CONTROLS.xpl**
* [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl): `p:sink`


### profile-resolution/src

* **apply-profile-resolver-remotely.xpl**
* [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl): `p:try`, `p:group`, `p:catch`
* **apply-profile-resolver.xpl**


## xproc-doc

* [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl): `p:filter`, `p:empty`
* **REPOSITORY-STEP-INDEX-HTML.xpl**
* **xproc-paint-html.xpl**
* [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl): `p:insert`


# Index to XProc elements

#### p:add-attribute

[CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:cast-content-type

[XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl)

#### p:catch

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:choose

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:declare-step

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl), [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:directory-list

[CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl)

#### p:document

[SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:documentation

[GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl)

#### p:empty

[COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:filter

[COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:for-each

[GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:group

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:identity

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:if

[XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl)

#### p:import

[SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:inline

[POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl), [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:input

[SMOKETEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSPEC.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:insert

[XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:load

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:namespace-delete

[POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl), [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl)

#### p:otherwise

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:output

[POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl), [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl)

#### p:pipe

[REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl)

#### p:sink

[resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:store

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:try

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:unarchive

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl)

#### p:validate-with-schematron

[SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl)

#### p:validate-with-xml-schema

[xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl)

#### p:variable

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl)

#### p:when

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:with-input

[POWER-UP.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/POWER-UP.xpl), [SMOKETEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-SCHEMATRON.xpl), [SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:with-option

[CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:wrap-sequence

[XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:xslt

[SMOKETEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/SMOKETEST-XSLT.xpl), [CONVERT-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-XML-DATA.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)