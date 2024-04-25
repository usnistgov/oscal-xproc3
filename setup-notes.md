# Setup notes

With Java and `bash`, run `./setup.sh` to set up. `curl` and `unzip` must be available on your command line.

See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md) for licensing information on these products and open-source initiatives.

Or, by hand ...

## Set up Morgana XProc IIIse

Morgana can be downloaded from  https://sourceforge.net/projects/morganaxproc-iiise/files

  - Get the latest `.zip`, don't worry about source code
  - Unzip it in the `lib` directory

## Drop in Saxon-HE

Download Saxon at https://www.saxonica.com/download/SaxonHE12-3J.zip (or adjust for version)

  - Unzip and copy `saxon-he-12.3.jar` into the new `MorganaXProc-IIIse-{version}/MorganaXProc-IIIse_lib`
  - Discard the rest as unneeded

## Adjust your paths

The scripts [xp3.sh](xp3.sh) and [xp3.bat](xp3.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the Saxon version configuration, these scripts must be updated to work.

See [Morgana documentation](https://www.xml-project.com/manual/index.html) for more support on running Morgana and XProc.