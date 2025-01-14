# TESTING USDS HTML to OSCAL

The pipeline tests itself by:

- Erroring when resources are not found
- Validating intermediate results against a [minimalistic schema](src/playbook.rnc)
- Validating final results against OSCAL XSD

## Possible TBD

Some XSpec for the XSLT step.

Since this is a small-and-simple pipeline, think about unit testing its own conversion steps or at any rate inputs/outputs?

Prototype this with p:run?