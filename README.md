# Arqma GUI

Copyright (c) 2018-2019, ArQmA Project

Copyright (c) 2014-2018, The Monero Project

## Compiling the Arqma GUI from source

### On Linux:

(Tested on Ubuntu 17.10 x64, Ubuntu 18.04 x64 and Gentoo x64)

1. Install Arqma dependencies

  - For Debian/Ubuntu Distributions

	`sudo apt install build-essential cmake libboost-all-dev miniupnpc libunbound-dev graphviz doxygen libunwind8-dev pkg-config libssl-dev libsodium-dev libzmq3-dev libudev-dev libhidapi-libusb0 libhidapi-dev libhidapi-hidraw0`

  - For Gentoo

	`sudo emerge app-arch/xz-utils app-doc/doxygen dev-cpp/gtest dev-libs/boost dev-libs/expat dev-libs/openssl dev-util/cmake media-gfx/graphviz net-dns/unbound net-libs/ldns net-libs/miniupnpc net-libs/zeromq sys-libs/libunwind dev-libs/hidapi`

2. Install Qt:

   - For Ubuntu 17.10+

   `sudo apt install qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-xmllistmodel qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel qttools5-dev-tools qml-module-qtquick-templates2 qtmultimedia5-dev qml-module-qtmultimedia libzbar-dev libqt5svg5-dev`

   - For Gentoo

   The *qml* USE flag must be enabled.

   `sudo emerge dev-qt/qtcore:5 dev-qt/qtdeclarative:5 dev-qt/qtquickcontrols:5 dev-qt/qtquickcontrols2:5 dev-qt/qtgraphicaleffects:5 dev-qt/qtmultimedia:5 media-gfx/zbar`


3. Clone Arqma GUI Repository

	  `git clone https://github.com/arqma/arqma-gui.git`

4. Build the GUI

    ```
    cd arqma-gui
    git checkout release-v0.6
    QT_SELECT=5 ./build.sh
    ```

The executable can be found in the build/release/bin folder.

### On OS X:

1. Install Xcode from AppStore

2. Install [homebrew](http://brew.sh/)

3. Install [arqma](https://github.com/arqma/arqma) dependencies:

  `brew install boost`

  `brew install openssl` - to install openssl headers

  `brew install pkgconfig`

  `brew install cmake`

  `brew install zeromq`

  `brew install zbar`

  `brew install hidapi`

  `brew install libsodium`

  `brew install protobuf`

  `brew install git`


  *Note*: If cmake can not find zmq.hpp file on OS X, installing `zmq.hpp` from https://github.com/zeromq/cppzmq to `/usr/local/include` should fix that error.

4. Install Qt:

  `brew install qt5`  (or download QT 5.9+ from [qt.io](https://www.qt.io/download-open-source/))

  If you have an older version of Qt installed via homebrew, you can force it to use 5.x like so:

  `brew link --force --overwrite qt5`

5. Add the Qt bin directory to your path

    Example: `export PATH=$PATH:$HOME/Qt/5.9/clang_64/bin`

    This is the directory where Qt 5.x is installed on **your** system

6. Grab an up-to-date copy of the arq-gui repository

  `git clone https://github.com/arqma/arqma-gui.git`

7. Go into the repository

  ```
  cd arqma-gui
  git checkout release-v0.6
  ```

8. Start the build

  `./build.sh`

The executable can be found in the `build/release/bin` folder.

**Note:** Workaround for "ERROR: Xcode not set up properly"

Edit `$HOME/Qt/5.8/clang_64/mkspecs/features/mac/default_pre.prf`

replace
`isEmpty($$list($$system("/usr/bin/xcrun -find xcrun 2>/dev/null")))`

with
`isEmpty($$list($$system("/usr/bin/xcrun -find xcodebuild 2>/dev/null")))`

More info: http://stackoverflow.com/a/35098040/1683164


#### On Windows:

Binaries for Windows are built on Windows using the MinGW toolchain within
[MSYS2 environment](http://msys2.github.io). The MSYS2 environment emulates a
POSIX system. The toolchain runs within the environment and *cross-compiles*
binaries that can run outside of the environment as a regular Windows
application.

**Before start GUI on Win 10 allow arqmad in firewall**

Run cmd as Administrator:
	
	netsh advfirewall firewall add rule name="allow arqmad" dir=in program="C:\Program Files\Arqma GUI Wallet\arqmad.exe" security=authnoencap action=allow
	
This script allow arqmad.exe communication in case You use default installation directory. In case You use other installation dir modify path (program="installation dir\arqmad.exe")
	
**Preparing the build environment**

1 Download and install the [MSYS2 installer](http://msys2.github.io).
  * Open the MSYS shell via the `MSYS2 Shell` shortcut
  * Update packages using pacman:  

        pacman -Syu  

  * Exit the MSYS shell using Alt+F4  
  * Edit the properties for the `MSYS2 Shell` shortcut changing "msys2_shell.bat" to "msys2_shell.cmd -mingw64"
  * Restart MSYS shell via modified shortcut and update packages again using pacman:  

        pacman -Syu  

2. Install dependencies

    ```
    pacman -S git mingw-w64-x86_64-toolchain make mingw-w64-x86_64-cmake mingw-w64-x86_64-boost mingw-w64-x86_64-openssl mingw-w64-x86_64-zeromq mingw-w64-x86_64-libsodium mingw-w64-x86_64-hidapi mingw-w64-x86_64-zbar mingw-w64-x86_64-protobuf-c mingw-w64-x86_64-protobuf
    ```

3. Install Qt5

   ```
   pacman -S mingw-w64-x86_64-qt5 mingw-w64-x86_64-qtbinpatcher
   ```

  * There is no more need to download some special installer from the Qt website, the standard MSYS2 package for Qt will do in almost all circumstances.

  * Newest QT-5.12.3 has bug that prevent GUI from normal work. Workaround for resolving it is simply to downgrade 3 packages:

  ```
  pacman -U http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-icu-62.1-1-any.pkg.tar.xz http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-boost-1.68.0-2-any.pkg.tar.xz http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-qt5-5.11.2-3-any.pkg.tar.xz
  ```

4. Clone repository

    `git clone https://github.com/arqma/arqma-gui.git`

5. Build the GUI

Latest Msys2 and QT-5.12 has issue with bad_address at qml_cache. Workaround to get it compile without any issues is as follows:

    ```
    cd arqma-gui
    git checkout release-v0.6
    source ./build.sh
    ```

The executable can be found in the ```.\build\release\bin``` directory.
