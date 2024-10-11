


# First appearances

## lib

* [GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl): `p:declare-step`, `p:variable`, `p:load`, `p:store`, `p:unarchive`, `p:identity`
* [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl): `p:for-each`
* **GRAB-XSPEC.xpl**

## smoketest

* [TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl): `p:output`, `p:validate-with-schematron`, `p:with-input`, `p:inline`, `p:namespace-delete`
* **TEST-XPROC3.xpl**
* [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl): `p:xslt`
* [TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl): `p:import`, `p:input`, `p:document`

## oscal-convert

* [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl): `p:documentation`, `p:cast-content-type`
* **BASIC_XML-TO-JSON.xpl**
* [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl): `p:with-option`
* [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl): `p:directory-list`
* [document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl): `p:sink`
* **GRAB-RESOURCES.xpl**
* **IDENTITY_.xpl**
* [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl): `p:markdown-to-html`

## oscal-validate

* **GRAB-OSCAL.xpl**
* [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl): `p:pipe`
* [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl): `p:validate-with-xml-schema`
* **XSD-VALIDATE-EXAMPLE.xpl**
* [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl): `p:if`, `p:wrap-sequence`

## oscal-publish

* [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl): `p:choose`, `p:when`, `p:otherwise`

## oscal-import

* **GRAB-FM6-22.xpl**
* **GRAB-NISO_STS-RNG.xpl**
* **GRAB-RESOURCES.xpl**
* [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl): `p:option`, `p:validate-with-relax-ng`, `p:string-replace`, `p:insert`

### oscal-import/src

* [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl): `p:library`, `p:empty`
* **validation-summarize.xpl**

## profile-resolution

* **RESOLVE-FISMA-PROFILES.xpl**
* **RESOLVE-KITTEN-CONTROLS.xpl**
* **resolve-profile-and-save.xpl**

### profile-resolution/src

* **apply-profile-resolver-remotely.xpl**
* [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl): `p:try`, `p:group`, `p:catch`
* **apply-profile-resolver.xpl**

## xproc-doc

* [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl): `p:filter`, `p:add-attribute`
* **REPOSITORY-STEP-INDEX-HTML.xpl**
* **xproc-paint-html.xpl**
* **XPROC-STEP-INDEX-HTML.xpl**

# Index to XProc elements

#### p:add-attribute

[COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:cast-content-type

[BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl)

#### p:catch

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:choose

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:declare-step

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [IDENTITY_.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/IDENTITY_.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-FM6-22.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-FM6-22.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:directory-list

[CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl)

#### p:document

[TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:documentation

[BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl)

#### p:empty

[validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:filter

[COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:for-each

[GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:group

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:identity

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl), [document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl), [IDENTITY_.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/IDENTITY_.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:if

[XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:import

[TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:inline

[TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:input

[TEST-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl), [IDENTITY_.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/IDENTITY_.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [RESOLVE-FISMA-PROFILES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl), [RESOLVE-KITTEN-CONTROLS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:insert

[PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:library

[validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl)

#### p:load

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-FM6-22.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-FM6-22.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:markdown-to-html

[MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl)

#### p:namespace-delete

[TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl)

#### p:option

[PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl)

#### p:otherwise

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:output

[TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [IDENTITY_.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/IDENTITY_.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl)

#### p:pipe

[REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:sink

[document-properties-testing.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/document-properties-testing.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:store

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-FM6-22.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-FM6-22.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:string-replace

[PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:try

[apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl)

#### p:unarchive

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl)

#### p:validate-with-relax-ng

[PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:validate-with-schematron

[TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:validate-with-xml-schema

[xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl)

#### p:variable

[GRAB-SAXON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SAXON.xpl), [GRAB-SCHXSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-SCHXSLT.xpl), [GRAB-XSPEC.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/lib/GRAB-XSPEC.xpl), [BASIC_JSON-TO-XML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_JSON-TO-XML.xpl), [BASIC_XML-TO-JSON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/BASIC_XML-TO-JSON.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-OSCAL-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl), [GRAB-FM6-22.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-FM6-22.xpl), [GRAB-NISO_STS-RNG.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-NISO_STS-RNG.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [GRAB-PROFILE-RESOLVER-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl)

#### p:when

[publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [resolve-profile-and-save.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/resolve-profile-and-save.xpl)

#### p:with-input

[TEST-SCHEMATRON.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-SCHEMATRON.xpl), [TEST-XPROC3.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XPROC3.xpl), [TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/GRAB-RESOURCES.xpl), [MARKDOWN_TO_HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/MARKDOWN_TO_HTML.xpl), [GRAB-OSCAL.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/GRAB-OSCAL.xpl), [REPORT-VALIDATION-EXAMPLE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl), [xsd-validate-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/xsd-validate-catalog.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [GRAB-OSCAL-CATALOG-SCHEMA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl), [GRAB-RESOURCES.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/GRAB-RESOURCES.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [validation-summaries.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summaries.xpl), [validation-summarize.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/src/validation-summarize.xpl), [ACQUIRE-OSCAL-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)

#### p:with-option

[CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:wrap-sequence

[XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl)

#### p:xslt

[TEST-XSLT.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/smoketest/TEST-XSLT.xpl), [CONVERT-OSCAL-XML-DATA.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl), [CONVERT-OSCAL-XML-FOLDER.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl), [XSD-VALIDATE-OFFSITE.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl), [publish-oscal-catalog.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-publish/publish-oscal-catalog.xpl), [PRODUCE_FM6-22-chapter4.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl), [apply-profile-resolver-remotely.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-remotely.xpl), [apply-profile-resolver-stepwise.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl), [apply-profile-resolver.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/profile-resolution/src/apply-profile-resolver.xpl), [COLLECT-XPROC-STEPS.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/COLLECT-XPROC-STEPS.xpl), [REPOSITORY-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl), [xproc-paint-html.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/xproc-paint-html.xpl), [XPROC-STEP-INDEX-HTML.xpl](file:/C:/Users/wap1/Documents/usnistgov/oscal-xproc3/projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)
