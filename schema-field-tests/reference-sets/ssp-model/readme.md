# The bug

Rules given by the SSP metaschema as respects `port-range` are *contradictory*, because rules 2 and 3 are inverted, expressing not the correct condition but the error condition.

The correct condition in each case reduces to rule 1.

Metaschema definition for `port-range` https://github.com/usnistgov/OSCAL/blob/4f02dac6f698efda387cc5f55bc99581eaf494b6/src/metaschema/oscal_implementation-common_metaschema.xml#L280

```xml
<constraint>
   <expect level="WARNING" id="port-range-start-and-end-not-specified" target="." test="exists(@start) and exists(@end)">
         <message>If a protocol is defined, it should include a start and end port range. To define a single port, the start and end should be the same value.</message>
   </expect>
   <expect level="WARNING" id="port-range-start-specified-with-no-end" target="." test="exists(@start) and not(exists(@end))">
         <message>A start port exists, but an end point does not. To define a single port, the start and end should be the same value.</message>
   </expect>
   <expect level="WARNING" id="port-range-end-specified-with-no-start" target="." test="not(exists(@start)) and exists(@end)">
         <message>An end point exists, but a start port does not. To define a single port, the start and end should be the same value.</message>
   </expect>
   <expect level="WARNING" id="port-range-end-date-is-before-start-date" target="." test="@start &lt;= @end">
         <message>The port range specified has an end port that is less than the start port.</message>
   </expect>
</constraint>
```


Please see attached the sample SSP, FedRAMP’s template, and the port-range WARNINGS 

[WARNING] [/system-security-plan/system-implementation[1]/component[2]/protocol[1]/port-range[1]] A start port exists, but an end point does not. To define a single port, the start and end should be the same value.

[WARNING] [/system-security-plan/system-implementation[1]/component[2]/protocol[1]/port-range[1]] An end point exists, but a start port does not. To define a single port, the start and end should be the same value.

[WARNING] [/system-security-plan/system-implementation[1]/component[2]/protocol[2]/port-range[1]] A start port exists, but an end point does not. To define a single port, the start and end should be the same value.

[WARNING] [/system-security-plan/system-implementation[1]/component[2]/protocol[2]/port-range[1]] An end point exists, but a start port does not. To define a single port, the start and end should be the same value.

PROPOSED:

```xml
<constraint>
   <expect level="WARNING" target="." test="exists(@start)" id="port-range-has-start">
         <message>A port range must have a start port given.</message>
   </expect>
   <expect level="WARNING" target="." test="exists(@end)" id="port-range-has-end">
         <message>A port range must have an end port given. To define a single port, the start and end should be the same value.</message>
   </expect>
   <expect level="WARNING" target="." test="not(@start > @end)" id="port-range-starts-before-end">
         <message>The port range specified has an end port that is less than the start port.</message>
   </expect>
</constraint>
```
