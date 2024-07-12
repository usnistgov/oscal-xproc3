<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:REPOSITORY-STEP-INDEX-HTML" name="REPOSITORY-STEP-INDEX-HTML">


   <!-- If the source document does not exist, or to refresh it, try running XProc COLLECT-XPROC-STEPS.xpl -->
   
   <!--<p:output port="result"  serialization="map{'indent' : true()}"/>-->
   
   <!-- todo: change the name of this pipeline -->
   <p:directory-list path=".." max-depth="unbounded" include-filter="\.xpl$" exclude-filter=".*no[-_]test.*"/>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/filter-directory.xsl"/>
   </p:xslt>
   <p:xslt>
      <p:with-input port="stylesheet" href="src/expand-steps.xsl"/>
   </p:xslt>
   
   <p:namespace-delete prefixes="p xsl ox xs"/>
   
   <!-- Next: XSLT to produce HTML for the step digest, with links back to the Recs
        and XSpec for this XSLT -->
   <p:xslt message="[REPOSITORY-STEP-INDEX-HTML] Producing HTML from XML step definitions">
      <p:with-input port="stylesheet" href="src/repository-survey.xsl"/>
   </p:xslt>
      
   <p:store href="out/repository-step-list.html" message="[REPOSITORY-STEP-INDEX-HTML] Storing repository-step-list.html"/>
   
</p:declare-step>