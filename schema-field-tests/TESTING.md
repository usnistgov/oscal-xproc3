# TESTING validation-field-testing

The application is itself a testing framework, and in that sense it needs to be self-testing.

I.e. its own outputs validate its correctness, if necessary by comparison to other tech that does the same thing.

Since this is really just a harness for validations applied by Morgana XProc III, a generic and standards-conformant XProc 3 engine, we are thereby well-covered, inasmuch as Morgana also relies on commodity tools such as Xerces and Saxon.

For Morgana - components and testing - see 

## XSLT Testing

TBD ... Bare-bones XSpec tests are offered for utility XSLTS ...