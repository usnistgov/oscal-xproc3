<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PROCESSOR-REPORT"
   name="PROCESSOR-REPORT">
      
   <p:output port="result"
      serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />
	
   <!-- /prologue	-->
   
   <p:identity message="[PROCESSOR-REPORT] XPROC 3 Processor Report">
      <!-- p:inline is implicit w/in p:with-input containing an element not in the p: namespace -->
      <!-- Also note the whitespace in the XProc file comes with the XML tagging -->
      <!-- we provide xml:space="preserve" which should inhibit munge the code -->
      <p:with-input xml:space="preserve">
<PROCESSOR reporting="{ current-dateTime() }">
   <product-name>{    p:system-property('p:product-name') }</product-name>
   <product-version>{ p:system-property('p:product-version') }</product-version>
   <vendor>{          p:system-property('p:vendor') }</vendor>
   <vendor-uri>{      p:system-property('p:vendor-uri') }</vendor-uri>
   <version>{         p:system-property('p:version') }</version>
   <xpath-version>{   p:system-property('p:xpath-version') }</xpath-version>
   <psvi-supported>{  p:system-property('p:psvi-supported') }</psvi-supported>
</PROCESSOR></p:with-input>
   </p:identity>

   <p:insert match="/PROCESSOR" position="last-child">
      <!--Unlike XSLT, we use an absolute XPath, there is no relative context just a tree  -->
      <p:with-input port="insertion">
         <p:inline xml:space="preserve">   <report-time>{ string(/*/@reporting) }</report-time>
</p:inline>
      </p:with-input>
   </p:insert>

<!-- Fancy XPath!
     || is a string concatenator
     format-dateTime() is a function with a 'picture' argument -->
   <p:string-replace match="/PROCESSOR/report-time/text()"
      replace="'REPORTING AT ' || format-dateTime(.,
      '[h01]:[m01] [P] on [FNn] [MNn] [D1o], [Y]')"/>

   <!-- making labels explicit in content -->
   <p:string-replace match="/PROCESSOR/*/text()"
      replace="(local-name(parent::*), string(.)) => string-join(': ')"/>
   
   <!-- Wiping markup by replacing the element with its string value -->
   <p:string-replace match="/*" replace="string(.)"/>
   
</p:declare-step>
