<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">
          
          
   
	<p:output port="result" serialization="map{'indent' : true()}" />
	
   <p:xslt name="smoketest" message="[HELLO-MORGANA] Applying transformation ...">
      <p:with-input port="source">
         <p:inline>
            <CONGRATULATIONS>Congratulations on running an XProc 3 pipeline.</CONGRATULATIONS>
         </p:inline>
      </p:with-input>
      <!-- inline XSLTs don't apparently work so well inside Morgana? -->
      <p:with-input port="stylesheet">
         <p:inline><!-- This works - note it is XSLT 1.0 -->
            <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               version="1.0" exclude-result-prefixes="#all">
               <!-- Using the old 1.0 arguments for system-property -->
               <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
               <xsl:variable name="version" select="system-property('xsl:version')"/>
               
               <xsl:template match="/CONGRATULATIONS">
                  <xsl:copy>
                     <LINE><xsl:apply-templates/></LINE>
                     <LINE>
                        <xsl:text>You have successfully executed an XSL transformation, using </xsl:text>
                        <xsl:value-of select="$vendor"/>
                        <xsl:text>, under  XSLT version </xsl:text>
                        <xsl:value-of select="$version"/>
                     </LINE>
                  </xsl:copy>
               </xsl:template>
               
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

</p:declare-step>
