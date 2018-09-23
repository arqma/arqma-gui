# ArQmA GUI Wallet Windows Installer #

Copyright (c) 2018, The ArQmA Network

Copyright (c) 2014-2018, The Monero Project

## Introduction ##

This is a *Inno Setup* script `Arqma.iss` plus some related files
that allows you to build a standalone Windows installer (.exe) for
the GUI wallet that comes with the Devils Touch release of ArQmA.

This turns the GUI wallet into a more or less standard Windows program,
by default installed into a subdirectory of `C:\Program Files`, a
program group with some icons in the *Start* menu, and automatic
uninstall support. It helps lowering the "barrier to entry"
somewhat, especially for less technically experienced users of
ArQmA.


## License ##

See [LICENSE](LICENSE).

## Building ##

You can only build on Windows, and the result is always a
Windows .exe file that can act as a standalone installer for the
Devils Touch GUI wallet.
