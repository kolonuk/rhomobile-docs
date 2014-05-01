# Build time configuration
Build time settings are dictated by a file in your app directory called `build.yml`. By default, this file has the most commonly used settings and some defaults that will work fine for most platforms. However, you may need to modify it at certain points. For example, if you need to build for an iOS device, you'll need to change the iphone: sdk: section to use an `iphoneos` SDK instead of an `iphonesimulator` SDK. This doc will provide guidelines and examples of how to modify this file without jeopardizing your app.

## Default build.yml Settings
When you create your app, a default version of the build.yml file will be generated and it will look like this:

    :::yaml
    #sdk: "<Path to Rhodes Gem>"
    sdkversion: <Rhodes Gem Version>
    name: <App Name>
    version: 1.0
    vendor: rhomobile
    build: debug
    applog: rholog.txt
    iphone:
      configuration: Release
      sdk: iphonesimulator7.0
      provisionprofile:
      codesignidentity: iPhone Developer
      entitlements: ""
      BundleIdentifier: com.rhomobile.<App Name>
      BundleURLScheme: <App Name>
    wp:
      productid: '17d460b0-701f-0131-ea62-482a14303cd5'
    symbian:
      uid: '0xe4ceb9bc'
    android:
      version: 2.3.3

    extensions: ["rhoconnect-client"]

### Settings Details

<table class="table table-striped table-bordered table-condensed">
  <tr>
    <th>Group\\Setting</th>
    <th>Description</th>
    <th width="12%">Possible Values</th>
  </tr>
  <tr>
    <td class="clsEvenRow">sdk</td>
    <td class="clsEvenRow">Path to your rhodes gem. This is commented out by default to let rhodes determine the latest gem and use that. If you have multiple rhodes gems and you wish to use one that is not the latest one, specify that here.</td>
    <td class="clsEvenRow">String</td>
  </tr>
  <tr>
    <td>sdkversion</td>
    <td>The version of your Rhodes gem.</td>
    <td>Rhodes Version</td>
  </tr>
  <tr>
    <td class="clsEvenRow">name</td>
    <td class="clsEvenRow">The name of your app.</td>
    <td class="clsEvenRow">String</td>
  </tr>
  <tr>
    <td>version</td>
    <td>The version of your app.</td>
    <td>App Version</td>
  </tr>
  <tr>
    <td class="clsEvenRow">vendor</td>
    <td class="clsEvenRow">The name that will be set as the vendor of your app. Usually this will be your Company's name.</td>
    <td class="clsEvenRow">String</td>
  </tr>
  <tr>
    <td>build</td>
    <td>Build configuration of this version of your app.</td>
    <td>Debug<br>development<br>release</td>
  </tr>
  <tr>
    <td class="clsEvenRow">applog</td>
    <td class="clsEvenRow">Name of app log file on the device.</td>
    <td class="clsEvenRow">Log file name</td>
  </tr>
  <tr>
    <td>iphone\\configuration</td>
    <td>Build configuration to pass to XCode.</td>
    <td>Debug<br>Distribution<br>Release</td>
  </tr>
  <tr>
    <td class="clsEvenRow">iphone\\sdk</td>
    <td class="clsEvenRow">The version of the sdk used to build. Typically, iphonesimulatorX.X or iphoneosX.X.</td>
    <td class="clsEvenRow">iPhone SDK Version</td>
  </tr>
  <tr>
    <td>iphone\\provisionprofile</td>
    <td>The UUID of your provisioning profile to use when signing.</td>
    <td>UUID</td>
  </tr>
  <tr>
    <td class="clsEvenRow">iphone\\codesignidentity</td>
    <td class="clsEvenRow">The name of the code signing identity to use when signing for device.</td>
    <td class="clsEvenRow">Code Sign Identity, String</td>
  </tr>
  <tr>
    <td>iphone\\entitlements</td>
    <td>Property list file for entitlements for your build. Typically, Entitlements.plist.</td>
    <td>.plist file</td>
  </tr>
  <tr>
    <td class="clsEvenRow">iphone\\BundleIdentifier</td>
    <td class="clsEvenRow">Bundle identifier – used in provisioning profile.</td>
    <td class="clsEvenRow">String</td>
  </tr> 
  <tr>
    <td>iphone\\BundleURLScheme</td>
    <td>Bundle URL scheme of your app (used for opening your application from another application by using custom URL scheme).</td>
    <td>String</td>
  </tr>
  <tr>
    <td class="clsEvenRow">wp\\productid</td>
    <td class="clsEvenRow">A productid GUID to application build.yml.</td>
    <td class="clsEvenRow">GUID</td>
  </tr>
  <tr>
    <td>symbian\\uid</td>
    <td>The UID of your Symbian app</td>
    <td>Varying Hex value</td>
  </tr>
  <tr>
    <td class="clsEvenRow">android\\version</td>
    <td class="clsEvenRow">The version of Android for which you will be building.</td>
    <td class="clsEvenRow">Android version</td>
  </tr>
  <tr>
  <td>extensions</td>
  <td>Comma-separated list of extensions your app will be using.</td>
  <td>Comma-separated list</td>
  </tr>
</table>

## Other Build-time Settings

### App Type
If you are building an app for Windows Mobile or Windows CE you must specify the app_type as RhoElements in your build.yml as follows:

    :::yaml
    app_type: "rhoelements"

### JS API Bridge
This option is typically only used for debugging purposes. If your AJAX-based app is not working properly, you can set this to true. If your application code resides on a remote server (as opposed to running locally), the Rhomobile Javascript APIs will not be available when this settings = `true`

    :::yaml
    ajax_api_bridge: true

***NOTE: When you have this option set to `true`, the [File API](../api/File) will not work on Android or iOS. It will work on Windows mobile/CE***

### JavaScript and CSS Obfuscation
To enable JavaScript and/or CSS code obfuscation of the files in the `public` folder of your app, just add the following lines to the build.yml:

    :::yaml
    obfuscate:
      js: yes
      css: yes
      exclude_dirs: ["jqmobile", "jqtouch", "jquery"]

If JavaScript or CSS code obfuscation is not required, then just omit `js` or `css` line accordingly.
**NOTE: The `jqmobile`, `jqtouch`, and `jquery` folders <b>must</b> be excluded when obfuscation is enabled, because the obfuscated versions of these libraries are there already.**

### Building for Intel-Based Processors on Android
By default, the build process will build only for ARM-based processors but, Rhodes can be configured to build for Intel-based processors instead. To build for such a device, you must set a flag in your build.yml file.

    :::yml
    android:
      abis: [x86]

You can also elect to build for both arm AND Intel-based processor by specifying `abis: [arm, x86]`.

## Capabilities
There are two ways of modifying your app's capabilities:

* Direct Edit - Just open the file and edit it.
* RhoStudio Modification - The RhoStudio IDE provides a GUI for modifying the capabilities using check-boxes.

### Direct edit
You can easily change specific settings in your build.yml file by simply opening it in you favorite text editor and modifying the text.

To enable specific device capabilities, edit your application's build.yml as follows:

    :::yaml
    capabilities:
      - camera
      - gps
    android:
      capabilities:
        - network_state

Rhodes support common plus platform-specific capabilities. They are merged into a single list at build time.

** NOTE: Right now only Android recognizes these platform specific configuration options. However, we are planning to enable these options across all platforms. **

List of supported capabilities:

* audio: allow using of audio hardware (record audio, modify audio settings)
* camera: allow use of hardware camera
* gps: allow use of geo location service
* network_state: allow read device network state (connected/disconnected)
* phone: allow make calls/read phone state
* pim: allow read/modify personal information and contacts
* push: allow to use PUSH on device
* record_audio: allow recording audio ('audio' implies it)
* vibrate: allow to use hardware vibration mechanism
* bluetooth: allow to use bluetooth hardware
* calendar: allow access to default device calendar
* sdcard: allow writing to SD card on Android devices

#### Windows Mobile Specific Settings
    :::yaml
    wm:
      rhoelements:
        config: "/Config/Config.xml"

* config : path to the custom [Config.xml](runtime_config#configxml) file to use. This path is relative to the Rhomobile Project.

#### Android Specific Settings
The capabilities listed above are directly related to the Android device capabilities that your app will require and that the user will be asked to give permission to when installing the app. You can add capabilities to your Android app by adding a capabilities section to your build.yml in the android heading as such:

    :::yaml
    android:
      capabilities:
          - hardware_acceleration
      mapping: yes
      extensions:
          - gmaps

* hardware_acceleration: enables the hardware_acceleration capability for Android applications
* mapping: enables the use of mapping apps.
* gmaps extension: enables the use of Google maps for mapping. In RhoStudio, you can double-click on your application's build.yml and edit from the text editor; otherwise, you can edit build.yml directly.

### RhoStudio Modification
You can also edit the capabilities that your app will have access to through RhoStudio. To do this, double click your build.yml in your app's project in the project explorer pane in RhoStudio.

<img src="https://s3.amazonaws.com/rhodocs/guide/build_config/open-build-yml-4.1.png">

Once you have done this, you should see the following screen wherein you can modify your build.yml settings, mainly, the capabilities.

<img src="https://s3.amazonaws.com/rhodocs/guide/build_config/build-yml-edit-window-4.1.png">

Click the add button next to the capabilities field to bring up this window and add capabilities by clicking the corresponding check-box.

<img src="https://s3.amazonaws.com/rhodocs/guide/build_config/select-capabilities-rhostudio-none-selected-4.1.png"><img src="https://s3.amazonaws.com/rhodocs/guide/build_config/select-capabilities-rhostudio-camera-and-bt-4.1.png">

You'll notice that as you add capabilities to your app, the build.yml text file will change to reflect these added capabilities.

<img src="https://s3.amazonaws.com/rhodocs/guide/build_config/added-capabilities-in-build-yml-4.1.png">

## RhoGallery Security Token

To restrict access to the application you may have it built with a security token. Specify the security token in the build.yml and build the app. Apps built with a security token can be started in normal mode only if you provide this token as a parameter.
If you do not specify the correct security token in the start params, the app will close on start by default. If you want do something instead of exit (for example show special message or run application in limited mode etc.) you can define another start_path for your application in "rhoconfig.txt":

    :::term
    invalid_security_token_start_path = '/app/InvalidSecurityTokenStartPage'

Specify security token in build.yml:

    :::yml
    security_token: 123

Run application with special parameter:

    :::ruby
    System::run_app( 'app_name', "security_token=123" )