# Build for Windows

## Setup
Follow the instructions for [setting up the development environment](nativesdksetup#setup-for-windows-desktop) for building Windows applications.

## Build application from the command line

Make sure that path to vcbuild.exe (something like `C:\Program Files\Microsoft Visual Studio 9.0\VC\vcpackages`) is in your PATH env variable. 

The list of paths which should be in PATH env variable:
<i>C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE;C:\Program Files\Microsoft Visual Studio 9.0\VC\BIN;C:\Program Files\Microsoft Visual Studio 9.0\Common7\Tools;C:\Program Files\Microsoft Visual Studio 9.0\Common7\Tools\bin;C:\Program Files\Microsoft Visual Studio 9.0\VC\PlatformSDK\bin;C:\Program Files\Microsoft Visual Studio 9.0\SDK\v3.5\bin</i>

Also check that the vcbuild path is shown in the rhobuild.yml file. The rhobuild.yml file is located in the Rhodes folder (example location: `C:/RhoStudio/ruby/lib/ruby/gems/1.8/gems/rhodes-3.1.1`).

If you use Visual Studio 2008 :

    env:
      paths:
        vcbuild: C:/Program Files/Microsoft Visual Studio 9.0/VC/vcpackages/vcbuild.exe

If you use Visual Studio 2008 on 64-bit installations:

    env:
      paths:
        vcbuild: C:/Program Files (x86)/Microsoft Visual Studio 9.0/VC/vcpackages/vcbuild.exe

If you use Visual Studio 2010 : add path to `msbuild` to `rhobuild.yml` in rhodes folder:

    env:
      paths:
        vcbuild: msbuild

To build and run the application issue command:

    :::term
    $ rake run:win32

*NOTE: To use `rake run:win32` command, add to the `PATH` variable: `<path-to-rhodes>\lib\extensions\openssl.so\ext\win32\bin` (or `<path-to-rhodes>\lib\extensions\openssl.so\ext\win32\msvc2008\bin` if you use Visual Studio 2008)

To clean all temporary and binary files execute command:

    :::term
    $ rake clean:win32

## Create application installer for Windows

Download [NSIS installer tool](http://nsis.sourceforge.net/Download).

Add path to NSIS complier to 'rhobuild.yml' in rhodes folder:

On 32-bit platform:

    env:
      paths:
        nsis: C:/Program Files/NSIS/makensis.exe

On 64-bit platform:

    env:
      paths:
        nsis: C:/Program Files (x86)/NSIS/makensis.exe

### Readme, license and icon
* Application License can be provided by application developer. If file with LICENSE.txt name exists in the root of application folder when Installer will display separate page to confirm the license.
* Application Readme file can be provided by application developer. If file with README.html name exists in the root of application folder when Installer will display show readme at the final page of the Installer
* Application Icon should be used for Installer and application exe

To build installer bundle use command:

    :::term
    $ rake device:win32:production 

There is separate rake command for Windows XP Embedded platform. To build installer bundle use command:

    :::term
    $ rake device:winxpe:production 

After the build process is finished you can find the installer bundle named `<application-name>-setup.exe` in `<application-root>/bin/target/win32` folder.

## Logging

Rholog.txt is placed in `<rhodes folder>\platform\wm\bin\win32\rhodes\Debug\rho`

<a name="build-for-windows-https"></a>
## How to enable HTTPS protocol

If your application needs HTTPS, then you need to build the Qt libraries for Visual Studio 2008 with OpenSSL as described below:

* Download the [Qt 4.7.4 source](ftp://ftp.qt-project.org/qt/source/qt-everywhere-opensource-src-4.7.4.zip) (237 MB) and extract the archive, e.g. into `C:\Qt\4.7.4-src`
* Open Control Panel » System » Advanced system settings » Environment Variables and then:
    * Create new (or update existing) system variable `QTDIR` = `C:\Qt\4.7.4` (this will be the installation folder for the compiled Qt libraries)
    * Add to the `PATH` variable: `C:\Qt\4.7.4\bin` (it doesn't matter that this folder does not exist yet)
    * To make command 'rake run:win32' work - Add to the `PATH` variable: `<path-to-rhodes>\lib\extensions\openssl.so\ext\win32\msvc2008\bin`
    * Either close all command prompts and Visual Studio instances, or reboot the computer so the new settings take effect.
* Open Visual Studio 2008 Command Prompt. This is accomplished using Start » All Programs » Microsoft Visual Studio 2008 » Visual Studio Tools » Visual Studio 2008 Command Prompt. Run in Visual Studio 2008 Command Prompt:

    > vcvarsall.bat x86
    > C:

* To build Qt library run in the same command prompt:
 
    > cd \Qt\4.7.4-src
    > configure -opensource -platform win32-msvc2008
      -nomake examples -nomake demos -nomake docs
      -qt-libpng -qt-libjpeg -qt-libtiff -qt-libmng -qt-gif
      -openssl-linked -no-qt3support -prefix C:/Qt/4.7.4
      -I <path-to-rhodes>/lib/extensions/openssl.so/ext/win32/include
      -L <path-to-rhodes>/lib/extensions/openssl.so/ext/win32/lib
      > nmake
      > nmake install
      > nmake clean

  Be aware that it will take a while to build the Qt libraries from sources (maybe few hours or so). Particularly the `configure` command may run for a few minutes, and the `nmake` command may run for a few hours.
* After the build process is completed exit Visual Studio 2008 Command Prompt

Now when you build your application the usual way, the HTTPS protocol support will be enabled automatically.