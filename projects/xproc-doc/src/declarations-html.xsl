<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" 
   xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="#all" expand-text="true"
   version="3.0">
   
   <!--
   Punchlist
   
   ToC/directory
   CSS
   - grid?
   -->
   

   <xsl:variable name="page-title">XProc 3.1 Steps: an index</xsl:variable>
   
   <xsl:template match="/*">
      <html>
         <head>
            <title>{ $page-title }</title>
            <xsl:call-template name="make-style"/>
            <xsl:call-template name="make-script"/>
         </head>
         <body>
            <aside class="directory">
               <xsl:apply-templates select="//declare-step" mode="directory">
                  <xsl:sort select="@type"/>
               </xsl:apply-templates>
            </aside>
            <main>
               <xsl:call-template name="lede"/>
            <xsl:for-each-group select="declare-step" group-by="(@library,'standard')[1]">
               <section class="library" id="{current-grouping-key()}">
                  <h2>{ current-grouping-key() ! upper-case(.) } library</h2>
                  <xsl:apply-templates select="current-group()"/>
               </section>
            </xsl:for-each-group>
            </main>
         </body>
      </html>
   </xsl:template>
   
   <xsl:function name="ox:morgana-supports" as="xs:boolean">
      <xsl:param name="step" as="element(declare-step)"/>
      <!-- Morgana coverage is documented at https://www.xml-project.com/morganaxproc-iiise.html -->
      <xsl:sequence select="$step/@library=('standard','validation','file','ixml') and not($step/@type='p:validate-with-nvdl')"/>
   </xsl:function>
   
   <xsl:template match="declare-step" mode="directory">
      <p class="index">
         <xsl:apply-templates select="." mode="internal-link"/>
      </p>
   </xsl:template>
   
      <xsl:template match="declare-step">
         <details id="{ ox:step-name(.) }" class="step { @library[.='standard']/' standard' } { if (ox:morgana-supports(.)) then 'supported' else 'unsupported'}" open="open">
         <summary>
            <div class="linkout">
               <xsl:apply-templates select="." mode="specification-link">
                  <xsl:with-param name="linktext">
                     <b>{ @library }</b>
                     <xsl:text> library</xsl:text>
                  </xsl:with-param>
               </xsl:apply-templates>
            </div>
            <xsl:text>{ @type} </xsl:text>
         </summary>
            <xsl:if test="ox:morgana-supports(.) => not()">
               <p class="warning">Unsupported in MorganaXProc-IIIse</p></xsl:if>
         <xsl:apply-templates select="." mode="syntax-map"/>
         <xsl:apply-templates select="option">
            <xsl:sort select="@name"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="input">
            <xsl:sort select="@primary" order="descending"/>
            <xsl:sort select="@port"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="output">
            <xsl:sort select="@primary" order="descending"/>
            <xsl:sort select="@port"/>
         </xsl:apply-templates>         
      </details>
   </xsl:template>
   
   <xsl:variable name="copy-button">
      <button class="cp" onclick="copyToClipboard(this.nextElementSibling)"
         onmouseover="this.nextElementSibling.classList.add('seeme')"
         onmouseout="this.nextElementSibling.classList.remove('seeme')">Copy</button>
   </xsl:variable>
      
   <xsl:template match="declare-step" mode="syntax-map">
      <xsl:call-template name="syntax-block">
         <xsl:with-param name="codeblock">
            <xsl:text>&lt;{ @type} name="STEP_{ ox:step-name(.) }"</xsl:text>
            <xsl:apply-templates mode="#current" select="option">
               <xsl:sort select="@name"/>
            </xsl:apply-templates>
            <xsl:text>{ if (empty(input)) then '/>' else '>'}</xsl:text>
            <xsl:apply-templates mode="#current" select="input"/>
            <xsl:if test="exists(input)">
               <xsl:text>&#xA;&lt;/{ @type}&gt;</xsl:text>
            </xsl:if>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="output">
         <xsl:variable name="implicit" select="empty(../output except .)"/>
         <xsl:call-template name="syntax-block">
            <xsl:with-param name="codeblock">
               <xsl:text>&lt;p:with-input port="..." pipe="{@port[not($implicit)]}@STEP_{ ox:step-name(parent::declare-step) }"/></xsl:text>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
   </xsl:template>

   <xsl:template name="syntax-block">
      <xsl:param name="codeblock"/>
      <div class="syntax-block">
         <xsl:variable name="implicit" select="empty(../output except .)"/>
         <xsl:copy-of select="$copy-button"/>
         <pre class="syntax-map">
            <xsl:sequence select="$codeblock"/>
         </pre>
      </div>
   </xsl:template>
   
   <xsl:template mode="syntax-map" match="declare-step/option[@required='true']" priority="10">
      <b>
         <xsl:next-match/>         
      </b> 
   </xsl:template>
   
   
   <xsl:template match="declare-step/option" mode="syntax-map">
      <xsl:text>&#xA;  {@name}="</xsl:text>
      <span class="ss">[{ @as }]</span>
      <xsl:text>{ @select!(' ' || .) }"</xsl:text>
   </xsl:template>
   
   <xsl:template match="declare-step/input" mode="syntax-map">
      <xsl:text>&#xA;  &lt;p:with-input</xsl:text>
      <xsl:for-each select="@*">
         <xsl:text> { local-name() }="{ . }"</xsl:text>
      </xsl:for-each>
      <xsl:text>/></xsl:text>
   </xsl:template>

   <xsl:function name="ox:step-name" as="xs:string?">
      <xsl:param name="step" as="element(declare-step)"/>
      <xsl:sequence select="$step ! substring-after(@type,'p:')"/>
   </xsl:function>
     
   
   <xsl:template match="declare-step[@library='standard']" mode="specification-link" priority="10">
      <xsl:param name="linktext">{ @type }</xsl:param>
      <a class="steplink speclink" target="spec" href="https://spec.xproc.org/3.0/steps/#c.{ox:step-name(.)}">
         <xsl:sequence select="$linktext"/>
      </a>
      <xsl:call-template name="xprecref-link"/>
   </xsl:template>
   
   <xsl:template match="declare-step" mode="specification-link">
      <xsl:param name="linktext">{ @type }</xsl:param>
      <a class="steplink speclink" target="spec" href="https://spec.xproc.org/master/head/{@library}/#c.{ox:step-name(.)}">
         <xsl:sequence select="$linktext"/>
      </a>
      <xsl:call-template name="xprecref-link"/>
   </xsl:template>  

   <xsl:template name="xprecref-link">
      <!--Still getting some 404s -->
      <a class="steplink speclink" target="spec" href="https://xprocref.org/3.1/p.{ox:step-name(.)}.html">XProcRef description</a>
   </xsl:template>
      

   <xsl:template match="declare-step" mode="internal-link">      
      <a href="#{ox:step-name(.)}" class="steplink internal{ @library[.='standard']/' standard-step' } {
         if (ox:morgana-supports(.)) then 'supported' else 'unsupported' }">{ @type }</a>
   </xsl:template>  
   
   <xsl:template match="declare-step/*">
      <p class="{local-name()}{ @primary[.='true']/' primary' }{ @required[.='true']/' required' }">
         <xsl:text>{ local-name() }</xsl:text>
         <xsl:for-each select="@*">
            <xsl:text> { local-name() }="</xsl:text>
            <code>{.}</code>
            <xsl:text>"</xsl:text>
         </xsl:for-each>
      </p>
   </xsl:template>
    
   
   <xsl:template name="make-style" expand-text="false">
      <style xml:space="preserve">

aside.directory { position: fixed; top: 1vh; right: 1vw; height: 90%; background-color: gainsboro; border: thin solid black; padding: 1.6em;
  margin: 0em; overflow-y: scroll }
.directory p { margin: 0em; margin-top: 0.3em }

main { max-width: 50em }

div.linkout { float: right; font-size: 80% }

.primary, .required { font-weight: bold }
.ss { font-family: sans-serif; font-size: 75% }
details.step { background-color: whitesmoke; outline: thin solid black; padding: 0.8em; margin-top: 1em }
details.step.supported { background-color: lavender }
details.step *:last-child  { margin-bottom: 0em }
.step summary { font-size: 130%; font-family: sans-serif }
.boxed { outline: thin solid black; background-color: white; padding: 0.4em; max-width: fit-content }
pre.syntax-map { outline: thin solid black; background-color: white; padding: 1em; max-width: fit-content; margin-right: 4em }
pre.syntax-map.seeme { outline: medium dotted black; background-color: #d0f0c0  }
div.syntax-block { max-width: fit-content }
p.warning { font-style: italic }
p.option, p.input, p.output { padding: 0.2em; border: thin solid inherit; width: fit-content } 
p.option:hover, p.input:hover, p.output:hover { background-color: whitesmoke; outline: medium solid white } 

a { text-decoration: none; color: midnightblue }
a:hover { text-decoration: underline }
p.index a { display: inline-block; border: thin outset black; border-bottom: medium solid black; background-color: white; padding: 0.2em }
p.index a:hover { text-decoration: underline; outline: medium solid grey }

div.linkout a { padding: 0.4em; font-size: 80% }
div.linkout a:hover { outline: medium dotted steelblue }

.unsupported { color: grey }
button.cp { float: right }
         </style>
   </xsl:template>
   
   <xsl:template name="make-script" expand-text="false">
      <script>
         /* selects textarea#linkcopy and copies it to the system clipboard */
         function copyToClipboard(block) {
         window.getSelection().selectAllChildren(block);
         document.execCommand('copy');
         }
      </script>
   </xsl:template>

   <xsl:template name="lede">
      <h1>{ $page-title }</h1>
      <section class="introduction">
         <p>This directory to XProc steps was generated by querying the specification documents.</p>
         <p><i>Standard</i> steps in this list are the core atomic steps required by the <a href="https://spec.xproc.org/master/head/xproc/">XProc Specification</a> for all XProc engines.</p>
         <p>Additionally the page lists all the steps defined in community specifications but not required for compliance.</p>
         <p>At the top, find links for the core compound steps, <code>for-each</code>, <code>try/catch</code> etc.</p>
         <p>The following documents define the optional, community-standard steps (and are also linked from their steps):</p>
         <div id="specification-links">
            <!-- insertion point for specification links -->
         </div>
         <p>The step list here is derived from the XProc code base and may show steps not yet added to the published specification, because still in process.</p>
         <details class="boxed">
            <summary>To use</summary>
            <p>XProc Steps are shown with links to their definitions in the libraries, at top right.</p>
            <p>Visual indications (grey fading) show if a step is not implemented or not yet offered in <a href="https://www.xml-project.com/morganaxproc-iiise.html">MorganaXProc-IIIse</a>. Because this logic determining this property may fall behind the product offering, some diligence is also called for.</p>
            <p>The <button>Copy</button> buttons provide for copying code blocks to the user's clipboard (on up-to-date browsers).</p>
         </details>
            
      </section>
   </xsl:template>
</xsl:stylesheet>