<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">

  <xsl:template match="/">
     <html>
        <head>
           <title></title>
        </head>
        <xsl:call-template name="css-style"/>
        <xsl:apply-templates/>
     </html>
  </xsl:template>
   
  <xsl:template match="oscal:catalog">
    <body class="catalog">
       <header>
          <xsl:apply-templates select="oscal:metadata/oscal:title"/>
       </header>
       <main>
          <xsl:apply-templates/>
       </main>
    </body>
  </xsl:template>

  <xsl:template match="oscal:metadata"/>

   <xsl:template match="oscal:title">
      <h2 class="title">
         <xsl:apply-templates/>
      </h2>
   </xsl:template>
   
   <xsl:template match="oscal:part/oscal:title">
      <h2 class="part-title">
         <xsl:apply-templates/>
      </h2>
   </xsl:template>
   
   <xsl:template match="oscal:part/oscal:part/oscal:title">
      <h3 class="part2-title">
         <xsl:apply-templates/>
      </h3>
   </xsl:template>
   
   <xsl:template match="oscal:part/oscal:part/oscal:part/oscal:title">
      <h4 class="part3-title">
         <xsl:apply-templates/>
      </h4>
   </xsl:template>
   
   <xsl:template match="oscal:part/oscal:part/oscal:part/oscal:part/oscal:title">
      <h5 class="part4-title">
         <xsl:apply-templates/>
      </h5>
   </xsl:template>
   
   <xsl:template match="oscal:group">
     <section class="group { @class }">
        <xsl:copy-of select="@id"/>
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:key name="by-id" match="*[@id]" use="@id"/>

   <xsl:template match="oscal:control">
      <section class="control { @class }">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates/>
      </section>
   </xsl:template>
   
   <xsl:template match="oscal:control[@class='requirement']" priority="1">
      <details class="control { @class }"
         onfocus="window.getElementById('{@id}').open = true;">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates/>
      </details>
   </xsl:template>
   
   <xsl:template match="oscal:control[@class='requirement']/oscal:title" priority="1">
      <summary class="h3">
         <xsl:for-each select="../oscal:prop[@name='label']">
               <xsl:value-of select="@value"/>
              <xsl:text>. </xsl:text>
         </xsl:for-each>
         <xsl:apply-templates/>
      </summary>
   </xsl:template>
   
   <xsl:template match="oscal:control[@class='requirement']/oscal:prop[@name='label']"/>
      
   <xsl:template match="oscal:group[@class='requirement-category']/oscal:title"
     priority="3"/>
   
   <xsl:template match="oscal:group[@class='requirement-category']/oscal:group/oscal:title"
      priority="5">
      <h2 class="group-title">
         <xsl:for-each select="parent::oscal:group/ancestor::oscal:group/oscal:title">
            <xsl:apply-templates/>
            <xsl:text> - </xsl:text>
         </xsl:for-each>
         <xsl:apply-templates/>
      </h2>
   
   </xsl:template>
   
   <xsl:template priority="7" match="oscal:group[@class='requirement-category']/oscal:group/oscal:group/oscal:title">
      <h3 class="requirements-group-title">
         <xsl:apply-templates/>
      </h3>
   </xsl:template>
      
   
   <xsl:template match="oscal:part">
      <div class="part { @class } { @name }">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   
   <xsl:template match="oscal:part[@id='table4_1']/oscal:table/oscal:tr[1]/oscal:td |
      oscal:part[@id='table4_3']/oscal:table/oscal:tr[1]/oscal:td" priority="10">
      <th>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </th>
   </xsl:template>
   
   <xsl:template match="oscal:part[@id='table4_4']" priority="101">
      <div class="part { @class } { @name }">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates select="oscal:title"/>
         <xsl:apply-templates select="/*/oscal:group[@id='attributes']" mode="directory"/>
      </div>
   </xsl:template>
   
   <!-- In the OSCAL data, tables 4-4 and 4-5 are defective, since they don't have
   rowspans indicated on cells - rather than fix this up, we generate
   the tables fresh from the control set.
   They are directories, after all!-->
   
   <xsl:template match="oscal:part[@id='table4_5']" priority="101">
      <div class="part { @class } { @name }">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates select="oscal:title"/>
         <xsl:apply-templates select="/*/oscal:group[@id='competencies']" mode="directory"/>
      </div>
   </xsl:template>
   
   <xsl:template match="oscal:part[@id='table4_2']" priority="10">
      <div class="part { @class } { @name }">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates select="oscal:title | oscal:caption"/>
         <xsl:call-template name="table4_2"/>
      </div>
      
   </xsl:template>
   
   <xsl:template match="oscal:part[starts-with(@id,'table4')]/oscal:title" priority="11">
      <h3 class="part2-title">
         <xsl:for-each select="../oscal:prop[@name='label']">
            <xsl:value-of select="@value"/>
            <xsl:text>. </xsl:text>
         </xsl:for-each>
         <xsl:apply-templates/>
      </h3>
   </xsl:template> 
   
   <xsl:template match="oscal:part[@id='table4_1']/oscal:title" priority="11">
      <h3 class="part3-title">
         <xsl:for-each select="../oscal:prop[@name='label']">
            <xsl:value-of select="@value"/>
            <xsl:text>. </xsl:text>
         </xsl:for-each>
         <xsl:apply-templates/>
      </h3>
   </xsl:template> 
   
   <xsl:template match="oscal:part[@id='table4_1']/oscal:prop[@name='label'] |
                        oscal:part[@id='table4_2']/oscal:prop[@name='label'] |
                        oscal:part[@id='table4_3']/oscal:prop[@name='label']" priority="11"/>
   
   <xsl:template match="oscal:control/oscal:title">
      <h3 class="control-title">
         <xsl:apply-templates/>
      </h3>
   </xsl:template>
   
   
   <xsl:template match="oscal:control/oscal:control/oscal:title">
      <h4 class="enhancement-title">
         <xsl:apply-templates/>
      </h4>
   </xsl:template>
   
   <xsl:template match="oscal:prop" mode="run-in">
    <span class="run-in subst">
      <xsl:value-of select="@value"/>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="oscal:param">
    <p class="param">
      <span class="subst">
        <xsl:for-each select="@id">
          <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="oscal:prop">
    <p class="prop {@name}">
      <span class="subst">
        <xsl:value-of select="@name"/>
        <xsl:text>: </xsl:text>
      </span>
      <xsl:apply-templates select="@value"/>
    </p>
  </xsl:template>

  <xsl:template match="oscal:p">
    <p class="p">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="oscal:insert" priority="101">
    <xsl:variable name="param-id" select="@param-id"/>
    <span class="insert">
      <xsl:variable name="param" select="key('by-id',@id-ref)"/>
      <xsl:apply-templates select="$param" mode="param-insert"/>
        <xsl:if test="not($param)"><i>broken parameter reference</i></xsl:if>
    </span>
  </xsl:template>

  <xsl:template mode="param-insert" match="oscal:param">
    <xsl:apply-templates mode="param-insert" select="oscal:value"/>
  </xsl:template>
  
  <xsl:template mode="param-insert" match="oscal:param[not(oscal:value)]">
    <xsl:apply-templates mode="param-insert" select="oscal:label"/>
  </xsl:template>
  
  
  <xsl:template match="oscal:ol">
    <ol class="ol">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  
  <xsl:template match="oscal:li">
    <li class="li">
      <xsl:apply-templates/>
    </li>
  </xsl:template>

   <xsl:template match="oscal:link">
      <p class="link">
         <a class="xref exernal">
            <xsl:copy-of select="@href"/>
            <xsl:apply-templates/>
         </a>
      </p>
   </xsl:template>
   
   <xsl:template priority="10" match="oscal:link[starts-with(@href,'#table4_')]">
      <xsl:variable name="t" select="substring-after(@href,'#')"/>
      <p class="link">
         <a class="xref" onclick="document.getElementById('{$t}').open = true;">
            <xsl:copy-of select="@href"/>
            <xsl:apply-templates/>
         </a>
      </p>
   </xsl:template>
   
   <xsl:template match="oscal:ref">
    <div class="ref">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="oscal:table | oscal:p | oscal:li | oscal:ul | oscal:pre |
    oscal:table//* | oscal:p//* | oscal:li//* | oscal:pre//*">
    <xsl:element name="{ local-name()}" namespace="http://www.w3.org/1999/xhtml">
       <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>


  <xsl:template priority="5" match="oscal:a[starts-with(@href,'#table4_')]">
     <xsl:variable name="t" select="substring-after(@href,'#')"/>
     <a href="{@href}" onclick="document.getElementById('{$t}').open = true;">
        <xsl:apply-templates/>
     </a>
  </xsl:template>
   
   <xsl:template match="oscal:part[@name='enumeration']/oscal:prop[@name='label'] | oscal:part[@name='tip']/oscal:prop[@name='label']"/>
   
   <xsl:template match="oscal:part[@name='enumeration']/oscal:p[1] | oscal:part[@name='tip']/oscal:p[1]" priority="10">
      <p>
         <xsl:for-each select="../oscal:prop[@name='label']">
            <b>
               <xsl:value-of select="@value"/>
            </b>
         </xsl:for-each>
         <xsl:text> </xsl:text>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template match="oscal:part[@name='enumeration']/oscal:p[1]" priority="10">
      <p>
         <xsl:for-each select="../oscal:prop[@name='label']">
            <b>
               <xsl:value-of select="@value"/>
            </b>
         </xsl:for-each>
         <xsl:text> </xsl:text>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template name="table4_2">
      <!--Context is part[@id='table4_2']-->
      <table>
         <colgroup>
         <col width="15%"/>
         <col width="15%"/>
         <col width="70%"/>
         </colgroup>
         <tr>
            <th>Developmental<br class="br"/>Activity</th>
            <th>Options to take</th>
            <th>Method</th>
         </tr>
            <xsl:for-each select="oscal:part[@name='activity']">
               <tr>
                  <td rowspan="{count(oscal:part[@name='option'])}" class="lbl">
                     <xsl:value-of select="child::oscal:title"/>
                  </td>
                  <xsl:for-each select="oscal:part[@name='option'][1]">
                        <td>
                           <xsl:value-of select="child::oscal:title"/></td>
                        <td>
                           <xsl:value-of select="child::oscal:p"/></td>                     
                  </xsl:for-each>
               </tr>
                  <xsl:for-each select="oscal:part[@name='option'][position() > 1]">
                     <tr>
                     <td>
                        <xsl:value-of select="child::oscal:title"/></td>
                     <td>
                        <xsl:value-of select="child::oscal:p"/></td>
                     </tr>
                  </xsl:for-each>
                  
            </xsl:for-each>
      </table>
   </xsl:template>
   
   <xsl:template match="oscal:catalog/oscal:group" mode="directory">
      <xsl:variable name="groupname" select="@id"/>
      <!--Context is part[@id='table4_2']-->
      <table>
         <colgroup>
            <col width="5%" style="text-orientation: sideways"/>
            <col width="15%"/>
            <col width="65%"/>
            <col width="15%"/>
         </colgroup>
         <tr>
            <th colspan="3" align="left">To find developmental activities for ...</th>
            <th>Go to...</th>
         </tr>
         <xsl:for-each select="oscal:group">
            <tr>
               <td rowspan="{count(.//oscal:control)}" class="dir lbl tipped">
                  <xsl:value-of select="child::oscal:title"/>
               </td>
               <xsl:for-each select="oscal:group[1]">
                  <td rowspan="{count(.//oscal:control)}">
                     <xsl:value-of select="child::oscal:title"/>
                  </td>                  
                  <xsl:for-each select="oscal:control[1]">
                     <xsl:call-template name="control-cells"/>
                  </xsl:for-each>
               </xsl:for-each>
            </tr>
            <xsl:for-each select="oscal:group[1]/oscal:control[position() > 1]">
               <tr>
                  <xsl:call-template name="control-cells"/>
               </tr>
            </xsl:for-each>
            <xsl:for-each select="oscal:group[position() > 1]">
               <tr>
                  <td rowspan="{count(.//oscal:control)}" class="dir lbl">
                     <xsl:value-of select="child::oscal:title"/>
                  </td>
                  <xsl:for-each select="oscal:control[1]">
                     <xsl:call-template name="control-cells"/>
                  </xsl:for-each>                  
               </tr>
               <xsl:for-each select="oscal:control[position() > 1]">
                  <tr>
                     <xsl:call-template name="control-cells"/>
                  </tr>
               </xsl:for-each>
               
            </xsl:for-each>
         </xsl:for-each>
      </table>
   </xsl:template>
   
   <xsl:template name="control-cells">
      <xsl:variable name="tableNo" select="substring-after(@id,'table4_')"/>
      <td>
         <xsl:value-of select="child::oscal:title"/>
      </td>
      <td class="control-link">
         <a href="#{@id}" onclick="document.getElementById('{@id}').open = true;">
            <xsl:text>Table&#xA0;4-</xsl:text>
            <xsl:value-of select="$tableNo"/>
         </a>
      </td>
   </xsl:template>
   
  <xsl:template name="css-style">
     <style type="text/css" xml:space="preserve">
body { font-family: sans-serif; padding-left: 1em; background-color: #454545  }

p, li { font-family: serif }

header { max-width: 50rem; text-align: center; color: white }

#full-text { max-width: 54rem; background-color: white; padding: 0.8rem;
  margin-bottom: 2rem; border: thin inset black }

.requirements.group { background-color: whitesmoke; padding: 0.8rem }

h4, h6 { font-style: italic }

#full-text section { margin-left: 1.2em }

.requirement { margin-bottom: 1.2em }

.requirement div     { margin-left: 1.6em; max-width: 40em; background-color: white }
.requirement div div { margin-left: 0em }

.requirement div.evaluation { margin-top: 0.4em }

.requirement div div { border: thin solid black  }

.requirement h3,
.requirement p { padding-left: 0.2em }

.requirement h3 { margin-top: 0em; padding-bottom: 0.6em; padding-top: 0.6em }

div.evaluation, div.growth_activities { display: grid; grid-template-columns: 1fr 1fr }

div.underlying_causes,
div.feedback,
div.study,
div.practice { grid-column-end: span 2 }

.boxed { border: medium inset black; padding: 0.4em; margin-top: 1.2em }
.boxed *:first-child { margin-top:0em }

.quoted { margin-left: 1.4em; padding: 0.4em }

.tip { border-top: thin solid black; border-bottom: thin solid black;
  padding: 0.4em 0em; margin: 1.2em auto; width: 80% }
.tip * { margin: 0em }

.tipped { rotate: -90deg; font-weight: bold; font-style: italic }

.requirement div.part h3 { font-size: 90%; font-weight: bold; background-color: gainsboro; font-style: italic }

table { border-collapse:collapse; border: thin solid black; font-family: sans-serif }

th, td { border: thin solid black; padding: 0.2em }

td.control-link { text-align: center }

td { font-size: 90% }

th { background-color: gainsboro }


     </style>
  </xsl:template>
   
</xsl:stylesheet>
