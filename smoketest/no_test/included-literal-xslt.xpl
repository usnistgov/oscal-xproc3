<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0">
          
          
<!-- Note: This pipeline currently throws an error in Morgana (20240422)         -->
   
	<p:output port="result" serialization="map{'indent' : true()}" />
	
   <p:xslt name="smoketest" message="[HELLO-MORGANA] Applying transformation ...">
      <p:with-input port="source">
         <p:inline>
            <CONGRATULATIONS>Congratulations on running an XProc 3 pipeline!</CONGRATULATIONS>
         </p:inline>
      </p:with-input>
      <!-- inline XSLTs don't apparently work so well inside Morgana? -->
      <p:with-input port="stylesheet">
         <p:inline><!-- This doesn't work -->
            <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               version="3.0" exclude-result-prefixes="#all">
               <xsl:variable name="product-name" select="system-property('xsl:product-name')"/>
               <xsl:variable name="product-version" select="system-property('xsl:product-version')"/>
               
               <xsl:template match="/CONGRATULATIONS">
                  <!--<xsl:variable name="product-name">Engine</xsl:variable>
                  <xsl:variable name="product-version">One-oh</xsl:variable>-->
                  <xsl:copy>
                     <LINE><xsl:apply-templates/></LINE>
                     <LINE>
                        <xsl:text expand-text="true">You have successfully executed an XSL transformation, using { $product-name }, version { $product-version }</xsl:text>
                     </LINE>
                  </xsl:copy>
               </xsl:template>
               
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

</p:declare-step>
