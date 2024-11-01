<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:IDENTITY_" name="IDENTITY_">

<!--
      
Command to run, binding a file to 'input' port:

bash$ ../../xp3.sh IDENTITY_.xpl -input:source=path/to/file.xml

cmd> ..\..\xp3 IDENTITY_.xpl -input:source=path\to\file.xml

You should see your input file echoed to the terminal,
or post to a file with -output:result="destination.xml"

   -->

   <!--<p:input port="source"/>-->

   <!-- with no pipe attachment, the output port captures the final result -->
   <p:output port="result" serialization="map{ 'indent': true() }"/>

<!-- /end prologue -->

   <p:identity/>

</p:declare-step>