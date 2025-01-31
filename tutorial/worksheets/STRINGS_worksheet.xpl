<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:p="http://www.w3.org/ns/xproc" 
   version="3.0">
   
   <!-- Iterating over strings -->
   <!-- With help from contributors to XML.com Slack (ST and GB)-->
   
   <p:variable name="drivers"
      select="('one', 'two', 'three')"/> 
   
   <!-- If a select expression is specified, it is effectively a filter on the input. The expression will be evaluated once for each document that appears on the port, using that document as the context item. The result of evaluating the expression (on each document that appears, in the order they arrive) will be the sequence of items that the step receives on the port.
      
   https://spec.xproc.org/3.0/xproc/#p.with-input
   -->

   <p:for-each>
      <!-- However many documents are bound, the @select is evaluated with each bound document as context
           so we get that many iterations over $drivers -->
      <p:with-input select="$drivers">
         <p:inline/>
         <!-- this could be <doc/> i.e. a dummy document -->
      </p:with-input>
      <p:identity message="identity: '{ . }' position { p:iteration-position() } / { p:iteration-size() }"/>
      
   </p:for-each>
   
</p:declare-step>