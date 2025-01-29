<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:PRODUCE-EVERYTHING" name="PRODUCE-EVERYTHING">
   
   <p:import href="PRODUCE-TUTORIAL-PREVIEW.xpl"/>
   <p:import href="PRODUCE-TUTORIAL-MARKDOWN.xpl"/>
   <p:import href="PRODUCE-TUTORIAL-TOC.xpl"/>
   <p:import href="PRODUCE-PROJECTS-ELEMENTLIST.xpl"/>
   
   
   <!-- Most production steps run from the lesson-plan.xml sketch -->
   <p:input port="source" href="lesson-plan.xml"/>
   
   <!-- Let's go! -->
   
   <ox:PRODUCE-TUTORIAL-PREVIEW/>
   
   <ox:PRODUCE-TUTORIAL-MARKDOWN>
      <p:with-input pipe="source@PRODUCE-EVERYTHING"/>
   </ox:PRODUCE-TUTORIAL-MARKDOWN>
      
   <ox:PRODUCE-TUTORIAL-TOC>
      <p:with-input pipe="source@PRODUCE-EVERYTHING"/>
   </ox:PRODUCE-TUTORIAL-TOC>

   <!-- The element directory, however, is produced from a spec of its own -->
   <ox:PRODUCE-PROJECTS-ELEMENTLIST>
      <p:with-input>
         <SEQUENCE><!-- should align with lesson-plan.xml -->
            <project dir="../lib"/>
            <project dir="../smoketest"/>
            <project dir="../projects/oscal-convert/"/>
            <project dir="../projects/usds-playbook-import/"/>
            <project dir="../projects/CPRT-import/"/>
            <project dir="../projects/FM6-22-import/"/>
            <project dir="../projects/oscal-validate/"/>
            <project dir="../projects/oscal-publish/"/>
            <project dir="../projects/profile-resolution/"/>
            <project dir="../projects/xproc-doc/"/>
         </SEQUENCE>
      </p:with-input>
   </ox:PRODUCE-PROJECTS-ELEMENTLIST>
   
</p:declare-step>