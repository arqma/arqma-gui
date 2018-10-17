# Arqma GUI

Copyright (c) 2018, ArQmA Project

Copyright (c) 2014-2018, The Monero Project

## Compiling the Arqma GUI from source

### On Linux:

(Tested on Ubuntu 17.10 x64, Ubuntu 18.04 x64 and Gentoo x64)
Tip: results displayed on transactions, prove, address, and other results can be copied to the clipboard by double left click, or double tap on mobile platforms.

1. Install Arqma dependencies

  - For Debian/Ubuntu Distributions

	`sudo apt install build-essential cmake libboost-all-dev miniupnpc libunbound-dev graphviz doxygen libunwind8-dev pkg-config libssl-dev libzmq3-dev`

  - For Gentoo

	`sudo emerge app-arch/xz-utils app-doc/doxygen dev-cpp/gtest dev-libs/boost dev-libs/expat dev-libs/openssl dev-util/cmake media-gfx/graphviz net-dns/unbound net-libs/ldns net-libs/miniupnpc net-libs/zeromq sys-libs/libunwind`

2. Install Qt:

   - For Ubuntu 17.10+

   `sudo apt install qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-xmllistmodel qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel qttools5-dev-tools`

   - For Gentoo

   `sudo emerge dev-qt/qtcore:5 dev-qt/qtdeclarative:5 dev-qt/qtquickcontrols:5 dev-qt/qtquickcontrols2:5 dev-qt/qtgraphicaleffects:5`

   - Optional : To build the flag `WITH_SCANNER`

      - For Debian/Ubuntu

        `sudo apt install qtmultimedia5-dev qml-module-qtmultimedia libzbar-dev`

      - For Gentoo - The qml USE flag must be enabled.

        `emerge dev-qt/qtmultimedia:5 media-gfx/zbar`


3. Clone Arqma GUI Repository

	  `git clone https://github.com/arqma/arqma-gui.git`

4. Build the GUI

    `cd arqma-gui
    QT_SELECT=5 ./build.sh`

The executable can be found in the build/release/bin folder.

### On OS X:

1. Install Xcode from AppStore

2. Install [homebrew](http://brew.sh/)

3. Install [arqma](https://github.com/arqma/arqma) dependencies:

  `brew install boost --c++11`

  `brew install openssl` - to install openssl headers

  `brew install pkgconfig`

  `brew install cmake`

  `brew install zeromq`

  `brew install zbar`


  *Note*: If cmake can not find zmq.hpp file on OS X, installing `zmq.hpp` from https://github.com/zeromq/cppzmq to `/usr/local/include` should fix that error.

4. Install Qt:

  `brew install qt5`  (or download QT 5.8+ from [qt.io](https://www.qt.io/download-open-source/))

  If you have an older version of Qt installed via homebrew, you can force it to use 5.x like so:

  `brew link --force --overwrite qt5`

5. Add the Qt bin directory to your path

    Example: `export PATH=$PATH:$HOME/Qt/5.8/clang_64/bin`

    This is the directory where Qt 5.x is installed on **your** system

6. Grab an up-to-date copy of the arq-gui repository

  `git clone https://github.com/arqma/arqma-gui.git`

7. Go into the repository

  `cd arqma-gui`

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

**Preparing the build environment**

1 Download and install the [MSYS2 installer](http://msys2.github.io).
  * Open the MSYS shell via the `MSYS2 Shell` shortcut
  * Update packages using pacman:  

        pacman -Syuu  

  * Exit the MSYS shell using Alt+F4  
  * Edit the properties for the `MSYS2 Shell` shortcut changing "msys2_shell.bat" to "msys2_shell.cmd -mingw64"
  * Restart MSYS shell via modified shortcut and update packages again using pacman:  

        pacman -Syuu  

2. Install dependencies

    ```
    pacman -S git mingw-w64-x86_64-toolchain make mingw-w64-x86_64-cmake mingw-w64-x86_64-openssl mingw-w64-x86_64-zeromq mingw-w64-x86_64-libsodium mingw-w64-x86_64-qt-creator mingw-w64-x86_64-qt5-static
    ```

3. Clone repository

    `git clone https://github.com/arqma/arqma-gui.git`

4. Build the GUI
    ```
    cd arqma-gui
    ./build.sh
    cd build
    make deploy
    ```

The executable can be found in the ```.\release\bin``` directory.
Tip: results displayed on transactions, prove, address, and other results can be copied to the clipboard by double left click, or double tap on mobile platforms.
