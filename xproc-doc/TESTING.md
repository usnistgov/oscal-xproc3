# TESTING XProc doc

This project is at an early stage of development, but it is already apparent it may not lend itself to test-driven development in the same way as other projects.

This is largely due to the *sensitivity* of the pipeline here in its relation to external resources.

Briefly put: if and when the XProc specification documents move or change internally, these processes are likely to break, either lapsing or failing completely.

And while corrective adjustment may be straightforward, detecting this breakage must occur first.

Accordingly, testing is currently *interactive* - examine process results to determine process correctness.

In formalizing and abstracting the process, the first question to be asked is how to detect variances in the sources that might require updates.

A pipeline to do this could rely on making caches of local copies for later comparison. It could even check before updating a cache.

This suggests that detecting change in Sources, and updating Views (for any reason), should be considered as separate operations.

And only when we can do the first reliably does it makes much sense to stabilize transformations using formal means (XSpec), since all the inputs will be stable or manageable.

TODO: WRITE XProc to report diff issues? (Without a full diff?) this could be broadly useful not only for maintaining this kind of dependency.


