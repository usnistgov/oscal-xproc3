# Setup notes

With Java and `bash`, run `./setup.sh` to set up. `curl` and `unzip` must be available on your command line.

See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md) for licensing information on these products and open-source initiatives.

Or, by hand ...

## Set up Morgana XProc IIIse

Morgana can be downloaded from  https://sourceforge.net/projects/morganaxproc-iiise/files

  - Get the latest `.zip`, don't worry about source code
  - Unzip it into a top-level `lib` directory
    - Create the directory if necessary
    - Take care to place in the repository `lib`, not in a project folder's `lib`.

## Drop in Saxon-HE

The utility pipeline [lib/GRAB-SAXON.xpl](lib/GRAB-SAXON.xpl) is provided to download and extract Saxon-HE for Morgana.

Or, by hand - download Saxon-HE 12.3 at https://www.saxonica.com/download/SaxonHE12-3J.zip

  - Unzip and copy `saxon-he-12.3.jar` into the new `MorganaXProc-IIIse-{version}/MorganaXProc-IIIse_lib`
  - Take care no other versions of Saxon are present (which might conflict)
  - Discard the rest if unwanted - keeping the zip file intact for the license information etc.

### Note on Saxon versions

We have successfully run with Saxon-HE 12.3 and the runtime flag ` -xslt-connector=saxon12-3` when invoking Morgana.

Developers who have success with later versions and reasons to need a Saxon upgrade should [please make an Issue](https://github.com/usnistgov/oscal-xproc3/issues) or (better) [a PR](https://github.com/usnistgov/oscal-xproc3/pulls).

## Acquire SchXSLT for Schematron support

Use [lib/GRAB-SCHXSLT.xpl](lib/GRAB-SCHXSLT.xpl) to pull down SchXSLT.

Or, by hand - find [David Maus's SchXSLT](https://github.com/schxslt/schxslt) on Github. The [distribution you want](https://github.com/schxslt/schxslt/releases/download/v1.9.5/schxslt-1.9.5-xproc.zip) provides XProc support.

## Acquire XSpec for XSpec support

Use [lib/GRAB-XSPEC.xpl](lib/GRAB-XSPEC.xpl) to pull down XSpec.

## Skip these downloads

Alternatively, developers who already have these libraries can configure to use available copies rather than downloading them - see the [lib/readme.md](lib/readme.md).

- For Saxon, provide the Saxon `jar` to the Morgana runtime (the pipeline does this by copying it into Morgana's `lib` directory; classpath incantations also work).

- For SchXSLT, edit the [Morgana configuration](lib/morgana-config.xml) or use a different configuration when invoking Morgana.

- for XSpec, edit the top-level [XSpec execution pipeline](xspec/xspec-execute.xpl) or any pipeline that calls into XSpec directly.

## Check your paths

The scripts [xp3.sh](xp3.sh) and [xp3.bat](xp3.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the path to the Morgana configuration file, these scripts must be updated to work.

See [Morgana documentation](https://www.xml-project.com/manual/index.html) for more support on running Morgana and XProc, including [Saxon configuration](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2).

## Run the smoke tests

Because it reduces to (nearly) the most minimal use of XProc, if the [smoke test](./smoketest/smoketest/POWER-UP.xpl) application doesn't work, nothing can be expected to work.

Likewise, tests are provided that can show that XSLT and Schematron capabilities are correctly provided for (by the Saxon and SchXSLT libraries). See [TESTING.md](TESTING.md) for more information.

- [smoketest/SMOKETEST-XSLT.xpl](smoketest/SMOKETEST-XSLT.xpl)
- [smoketest/SMOKETEST-SCHEMATRON.xpl](smoketest/SMOKETEST-SCHEMATRON.xpl)
- [smoketest/SMOKETEST-SCHEMATRON.xpl](smoketest/SMOKETEST-XSPEC.xpl)

Note that since Schematron and XSpec depend on XSLT and hence invoke Saxon, the Saxon-only smoketest can often be skipped.

### Smoke tests are working but a pipeline doesn't

If the smoke tests work, but a pipeline does not function correctly, any problem is most likely not with installation or configuration, but with the pipeline itself, or in a resource that it reads or requires.

Morgana returns information about errors and warnings in XML format. While this compromises their legibility on the screen, generally speaking the messages embedded are fairly helpful. And this XML is very useful for other purposes, as it can be trapped and processed further.

Any problems with any pipelines on this site (or any pipelines not otherwise called out in documentation or comments) should be [reported](https://github.com/usnistgov/oscal-xproc3/issues), as it is not our aim to distribute broken software. Of course, if your aim is to learn XProc and XSLT, we also hope you are looking at useful error messages very soon - signposts on your journey.

---

