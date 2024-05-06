# Schema field tests - lib

This directory has its contents excluded from git, to be provided as needed by users or developers who wish to run the utility.

This is to ensure that packages used to test and cross-test are maintained and actively curated.

To find where `lib` is populated, look for XProc `p:store` steps that either indicate `lib` in their target location (`@href`), or whose `@href` contains a variable reference that might be expanded to reference `lib`.

Or look for comments or `p:store/@message`. A house rule for `p:store` is that it always emit a message when storing a local copy of anything.

Examples -

[../GRAB-OSCAL.xpl](../GRAB-OSCAL.xpl) - pulls down OSCAL utlities (schemas and converters)

[../GRAB-OSCAL-CLI.xpl](../GRAB-OSCAL-CLI.xpl) - pulls down **oscal-cli** tooling (for cross-checking)
