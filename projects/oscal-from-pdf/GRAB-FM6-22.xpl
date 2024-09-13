<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-FM6-22"
   name="GRAB-FM6-22">
   
  <!-- For samples and boilerplate see file ../projects/xproc-doc/xproc-snippets.xml -->

<!-- https://rdl.train.army.mil/catalog-ws/view/100.ATSC/3110F413-E915-47C1-85AA-DD4065C654C3-1274570636396/fm6_22.pdf -->
   
   <p:variable name="FM_6-22" select="'https://rdl.train.army.mil/catalog-ws/view/100.ATSC/3110F413-E915-47C1-85AA-DD4065C654C3-1274570636396/fm6_22.pdf'"/>
   
   <!--   p:file-copy not working on remote PDF  -->
   <p:load href="{$FM_6-22}" message="[GRAB-FM6-22] Loading fm6_22.pdf ..."/>
   <p:store href="lib/fm6_22.pdf" message="[GRAB-FM6-22] Saving fm6_22.pdf"/>
      
</p:declare-step>