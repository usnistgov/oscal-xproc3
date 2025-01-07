<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PROCESSOR-REPORT"
   name="PROCESSOR-REPORT">
      
   <!--  This XProc delivers plain text as produced by the last step -->
   <!-- If XML is wanted:
      <p:output port="result-xml" pipe="" />
   -->
   
   <p:output port="basic" pipe="@basic" 
      serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />
   
   
   <p:output port="plaintext" pipe="@pretty" serialization="map{'method': 'text' }" />
   
   <!-- /prologue	-->
   
   
   <p:group name="basic"  message="[PROCESSOR-REPORT] XPROC 3 Processor Report">
      <p:identity>
         <!-- p:inline is implicit w/in p:with-input containing an element not in the p: namespace -->
         <!-- Also note the whitespace in the XProc file comes with the XML tagging -->
         <p:with-input>
            <PROCESSOR reporting="{ current-dateTime() }">
               <product-name>{ p:system-property('p:product-name') }</product-name>
               <product-version>{ p:system-property('p:product-version') }</product-version>
               <vendor>{ p:system-property('p:vendor') }</vendor>
               <vendor-uri>{ p:system-property('p:vendor-uri') }</vendor-uri>
               <version>{ p:system-property('p:version') }</version>
               <xpath-version>{ p:system-property('p:xpath-version') }</xpath-version>
               <psvi-supported>{ p:system-property('p:psvi-supported') }</psvi-supported>
            </PROCESSOR>
         </p:with-input>
      </p:identity>
      <p:namespace-delete prefixes="ox"/>
   </p:group>
   
   <p:insert match="/PROCESSOR" position="last-child">
      <!--Unlike XSLT, we use an absolute XPath, there is no relative context just a tree  -->
      <p:with-input port="insertion">
         <p:inline>
            <report-time>REPORTING AT { /*/@reporting => format-dateTime('[h01]:[m01] [P] on [FNn] [MNn] [D1o], [Y]') }</report-time>
         </p:inline>
      </p:with-input>
   </p:insert>

   <!-- making labels explicit in content -->
   <p:string-replace match="/PROCESSOR/*/text()"
      replace="(local-name(parent::*), string(.)) => string-join(': ')"/>
   
   <!-- trimming whitespace back to uniform length directly inside /*
        so as to look nice as plain text -->
   <p:string-replace name="pretty" match="/PROCESSOR/text()[matches(.,'^\s+$')]"
      replace="'&#xA;  '"/>

</p:declare-step>
