<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:single_xml-to-json" name="single_xml-to-json">


<!-- Experimental! like single_json-to-xml.xpl this is intended as a 'wrapper pipeline'
     Maybe useful to defend batch processors from erroring on a single bad input?     
   -->

   
   <p:input port="source" content-types="application/xml">
      <p:document href="../data/misc/xml/hello.xml"/>
   </p:input>

   <p:output port="result"/>

   <!-- /prologue -->

   <!-- Choices for screening include validating against the schema for XPath-JSON
         but since we want try/catch anyway, the pre-check is an easy one - is the XML
         coming in with the correct namespace?
   -->
   
   <p:choose>
      <p:when test="empty(/xp:*)" xmlns:xp="http://www.w3.org/2005/xpath-functions">
         <p:error code="ox:source-validation-fail">
            <p:with-input port="source">
               <message>XML is not in the XPath namespace and cannot be cast to JSON using generic logic</message>
            </p:with-input>
         </p:error>
      </p:when>
      <p:otherwise>
         <p:try>
            <p:group>
               <p:cast-content-type content-type="application/json"/>      
            </p:group>
            <p:catch name="reformat-error">
               <p:identity>
                  <p:with-input pipe="error@reformat-error"/>
               </p:identity>
            </p:catch>
         </p:try>
      </p:otherwise>
   </p:choose>
   
</p:declare-step>