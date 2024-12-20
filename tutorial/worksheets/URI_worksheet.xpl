<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:NAMESPACE_worksheet" name="NAMESPACE_worksheet"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   >

<!-- Worksheet for messing with URIs and base URIs in XProc

To use the worksheet:

Switch out different values for p:input, using both inline documents and document/@href
Observe what is reported by the pipeline when run
  The base URI of an XDM element given as literal input is the pipeline (XProc) document itself
  The base URI of a resource acquired via href should reflect how it was acquired
  

Try inputs of various types, both JSON and plain text.

Note errors if XDM properties are requested where none exist
(e.g. a 'content-type' on an atomic value) when for example calling in JSON data.
   
   -->

   <p:input port="source">
      <p:inline>
         <doc/>
      </p:inline>
      <!--<p:document href="../lesson-plan.xml"/>-->
   </p:input>
   
   
   
   <p:output port="result" serialization="map{ 'indent': true(), 'method': 'text' }" sequence="true"/>

   <!-- /end prologue -->
   
   <p:identity>
      <p:with-input port="source">
         <p:inline xml:space="preserve">
   Base URIs of inputs are tracked with properties both in XProc
     and on XDM nodes (where applicable)            
            
   p:document-property(.,'content-type'): { p:document-property(.,'content-type') }      
   p:document-property(.,'base-uri')    : { p:document-property(.,'base-uri') }
   base-uri(/*)                         : { base-uri(/*) }
   base-uri(/*) => resolve-uri()        : { base-uri(/*) => resolve-uri() }
   
   p:urify attempts to expand and normalize any string as a URI,
     given the XProc execution context not the file context
   
   p:urify('.')                         : { p:urify('.') }
   p:urify('some/fictional/directory')  : { p:urify('some/fictional/directory') }
   base-uri(.) => p:urify()             : { p:urify('.') }
   
   just for interest ...
   
   p:lookup-uri( xs:anyURI('path') )    : { p:lookup-uri( xs:anyURI('path') ) }
      </p:inline>
      </p:with-input>
   </p:identity>
   
</p:declare-step>