<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://csrc.nist.gov/ns/cprt"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   expand-text="true"
   version="3.0">
   

   <!--Was doing this in XProc, but started getting out-of-memory errors from Java -! -->
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="bracketed">
      <xsl:text>[</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   
   <xsl:template match="bracketed[starts-with(.,'Selection (one or more):')]">
      <selection how-many="one-or-more">
        <xsl:apply-templates/>
      </selection>
   </xsl:template>
   
   <!-- Distinguishing these cases so as to keep element types clear for subsequent parameter matching -->
   <xsl:template priority="101" match="(examine | interview | test)/text/bracketed[starts-with(.,'SELECT FROM:')]">
      <select_from>         
         <xsl:apply-templates/>
      </select_from>
   </xsl:template>
   
   <xsl:template match="bracketed[starts-with(.,'SELECT FROM:')]">
      <selection>         
         <xsl:apply-templates/>
      </selection>
   </xsl:template>
   
   <xsl:template match="bracketed[starts-with(.,'Assignment:')]">
      <assignment>
         <xsl:apply-templates/>
      </assignment>
   </xsl:template>
   
   <xsl:template match="bracketed/text()[1][starts-with(.,'Selection (one or more):')]">
      <xsl:text>{ replace(.,'^Selection (one or more):\s*','') }</xsl:text>
   </xsl:template>
   
   <xsl:template match="bracketed/text()[1][starts-with(.,'SELECT FROM:')]">
      <xsl:text>{ replace(.,'^SELECT FROM:\s*','') }</xsl:text>
   </xsl:template>
   
   <xsl:template match="bracketed/text()[1][starts-with(.,'Assignment:')]">
      <xsl:text>{ replace(.,'^Assignment:\s*','')  }</xsl:text>
   </xsl:template>
   
   
</xsl:stylesheet>