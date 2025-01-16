<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PROCESSOR-REPORT"
   name="PROCESSOR-REPORT">
      
   <!--
      
     This XProc produces two results:
     
     'result' is an XML summary of findings from system-property function calls
     
     'summary' comes as plain text provided with labels and an English-language time stamp
     
   -->  
   
   <p:output port="result" pipe="@basic" primary="true" 
      serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />  
   
   <p:output port="summary" pipe="@labeled" serialization="map{'method': 'text' }" />
   
   <!-- /prologue	-->
   
   <p:variable name="timestamp-format" select="'[h01]:[m01] [P] on [FNn] [MNn] [D1o], [Y]'"/>
   
   <p:group name="basic"  message="[PROCESSOR-REPORT] XPROC 3 Processor Report">
      <p:identity>
         <!-- p:inline is implicit w/in p:with-input containing an element not in the p: namespace -->
         <!-- Also note the whitespace in the XProc file comes with the XML tagging -->
         <p:with-input>
            <PROCESSOR reporting="{ current-dateTime() }">
               <product-name>{    p:system-property('p:product-name') }</product-name>
               <product-version>{ p:system-property('p:product-version') }</product-version>
               <vendor>{          p:system-property('p:vendor') }</vendor>
               <vendor-uri>{      p:system-property('p:vendor-uri') }</vendor-uri>
               <version>{         p:system-property('p:version') }</version>
               <xpath-version>{   p:system-property('p:xpath-version') }</xpath-version>
               <psvi-supported>{  p:system-property('p:psvi-supported') }</psvi-supported>
            </PROCESSOR>
         </p:with-input>
      </p:identity>
      
      <p:namespace-delete prefixes="ox"/>
   </p:group>
   
   <p:group name="labeled">
      <p:insert match="/PROCESSOR" position="last-child">
         <!--Unlike XSLT, the context for path expressions is the root of a tree, not an element  -->
         <p:with-input port="insertion">
            <p:inline>
               <report-time>REPORTING AT {
                  /PROCESSOR/@reporting => format-dateTime($timestamp-format) }</report-time>
            </p:inline>
         </p:with-input>
      </p:insert>
      
      <p:string-replace match="/PROCESSOR/*/text()" replace="(local-name(parent::*), string(.)) => string-join(': ')"/>
      
      <p:string-replace match="/PROCESSOR/text()[matches(.,'^\s+$')]" replace="'&#xA;  '"/>
      
      <p:string-replace match="/PROCESSOR/text()[last()]" replace="'&#xA;'"/>
      
      <p:namespace-delete prefixes="ox"/>
   </p:group>
   
</p:declare-step>
