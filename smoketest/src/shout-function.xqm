module namespace ox = "http://csrc.nist.gov/ns/oscal-xproc3";

(: Simple function providing string manipulation :)
declare function ox:SHOUT ($s as xs:string?) as xs:string? { upper-case($s) || '!!!' };

(: ox:SHOUT('Hey world') :)