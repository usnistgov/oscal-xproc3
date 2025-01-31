<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   version="3.0">
  
  <!-- Processes the results of reduce-xproc.xsl into an HTML div structure with annotating p annotations -->
   <xsl:output indent="true"/>
   
   <!--TEST OUT WITH ALL THE COMPOUND STEPS
     group
     for-each
     if
     choose/when/otherwise
     try/catch/finally
     viewport-->
   
   <xsl:mode use-accumulators="#all"/>
   
   <xsl:strip-space elements="*"/>
  
   <xsl:template match="/*">
      <html>
         <head>
            <xsl:call-template name="css"/>
         </head>
         <body>
            <xsl:call-template name="go"/>
         </body>
      </html>
   </xsl:template>
  
   <xsl:template match="*" name="go">
      <div class="{ local-name() }">
         <xsl:apply-templates select="@*" mode="propagate"/>
         <xsl:apply-templates mode="style" select="."/>
         <xsl:apply-templates select="@name | @port | @*[starts-with(local-name(),'_')]" mode="label"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <xsl:template mode="style" match="*"/>
   
   <xsl:template mode="style" match="/*">
      <xsl:attribute name="style">width: min-content</xsl:attribute>
   </xsl:template>
   
   <xsl:template mode="style" match="subpipline/*">
      <xsl:param name="grid-area"/>
      <xsl:attribute name="style">{}</xsl:attribute>
   </xsl:template>
   
   
   <xsl:template match="subpipeline">
      <xsl:variable name="step-count" select="count(*)"/>
      <div class="subpipeline" data-PLACES="{ count(*) }" style="display: grid;grid-template-columns: repeat({ $step-count + 1 },auto); grid-template-rows: repeat({ $step-count },auto)">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <xsl:template match="subpipeline/*">
      <xsl:variable name="p" select="position()"/>
      <xsl:variable name="v" select="$p"/>
      <!--<xsl:variable name="v" select="last() - $p + 1"/>-->
      <xsl:variable name="end" select="last() + 1"/>
      <xsl:variable name="grid-area" expand-text="true">{$v} / {$p} / {$v} / {min((($p + 2),$end))}</xsl:variable>
      <div class="{ @name } { local-name() }" data-PLACEMENT="{ $p }" data-AMONG="{ last() }"
         style="grid-area: { $grid-area }">
         <xsl:apply-templates select="@*" mode="propagate"/>
         <xsl:apply-templates select="." mode="style">
            <xsl:with-param name="grid-area" select="$grid-area"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="@name | @*[starts-with(local-name(),'_')]" mode="label"/>
         <xsl:apply-templates/>
      </div>
   </xsl:template>   
 
   <!--
      
      <xsl:key name="step-by-name" match="declare-step/(* except (declare-step|input|output))"
      use="@name"/>
   
   <xsl:key name="connector-by-port" match="input | output | with-input" use="@port || '@' ../@name"/>
   
   
   -->
   <xsl:template match="@*" mode="propagate"/>
      
   <xsl:template match="@*[starts-with(local-name(),'_')]" mode="propagate">
      <xsl:attribute name="data-{ substring-after(local-name(),'_') }">
         <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
   
   <xsl:template match="@*" mode="label" expand-text="true">
      <p class="label">{ . }</p>
   </xsl:template>
   
   <xsl:template match="@*[starts-with(local-name(),'_')]" mode="label" expand-text="true">
      <p class="label"><b>{ substring-after(local-name(),'_') }</b>: <span class="v">{ . }</span></p>
   </xsl:template>
   
   <xsl:template match="@_message" priority="5" mode="label"/>
      
      <!-- 
         try/catch
         choose/when/otherwise
         
         marking connections
      connections are multi-way at the step level
          (except declare-step/(input|output)
        all steps connect to other steps, with both incoming and outgoing connections
        any with-input can connect to a step (somewhere)
          via pipe/@port or @pipe/substring-after(.,'@') 
        any step lacking with-input[@port='result'] connects to the immediately preceding step
          or if none, to the parent::*/input[@port='source' or @primary='true']
          
        input|output connects to any step with a @pipe pointing to it
          
      -->
   
   <xsl:template name="css">
      <style type="text/css" xml:space="preserve">
         body { font-family: sans-serif }
div { border: medium outset grey; padding: 0.37em; margin-top: 0.4em }
div.subpipeline { border: medium inset steelblue; background: lightsteelblue }
div *.compound { background-color: whitesmoke; font-size: 95% }
*.atomic { background-color: gainsboro } 
p { margin: 0em }
.v { font-family: monospace; font-size: 90% }
div.input, div.output { display: inline-block; max-width: fit-content; vertical-align: text-top }
.label { white-space: nowrap; overflow: visible }
      </style>
   </xsl:template>
</xsl:stylesheet>