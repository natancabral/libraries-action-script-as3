[<img src="https://raw.githubusercontent.com/natancabral/libraries-action-script-as3/main/adobe-air.png" align="right" width="150">](https://www.adobe.com/products/air.html)

# ActionScript 3 [![Awesome](https://raw.githubusercontent.com/natancabral/libraries-action-script-as3/main/badge-awesome.svg)](https://github.com/natancabral/libraries-action-script-as3)

## Libraries NC

> en: 10 years of AS codes (pt: *10 anos de código ActionsScript*)

**The Adobe® AIR® technology enables developers to create and package cross platform games/apps for major platforms like iOS, Android, Windows and Mac OS.**

> AS3 looks syntactically almost like Java. It also has OO (Object-oriented) structure, organization for packages, classes, methods and fields. A small comparison is highlighted in the picture below – declaring variables and methods. Those two languages are so alike that it takes only few days to get to know what the main differences are.

[Adobe AIR](https://en.wikipedia.org/wiki/Adobe_AIR) provides a single set of APIs to build cross-platform desktop/mobile applications and games. [ActionScript 3](https://en.wikipedia.org/wiki/ActionScript) is the programming language for AIR. Powerful native functionality such as file system, SQLite, sensors are included by default. To add missing functionality, you can build ANEs (Air Native Extensions) coded in the native language (eg VC++ for Windows, Java for Android, Swift/Objective-C for iOS). To build mobile apps/games with GPU-rendered graphics, use the [Starling](https://gamua.com/starling/) framework and optionally the [Feathers UI](https://feathersui.com/). Adobe AIR is very popular in the mobile gaming space.

> AIR **unfortunately** is a deprecated multimedia software platform used for production of animations, ... It introduced the ActionScript 3.0 programming language, which supported modern programming practices and enabled business applications.


## Code Sprite Sample

```as
package com.example
{
    /*
    * Imports
    */
    import flash.text.TextField;
    import flash.display.Sprite;

    public class Greeter extends Sprite
    {
        /*
        * Variables
        */
        public var variableNumber:Number; //type Number
        public var fullName:String; //type String
        
        public function Greeter()
        {
            super();
            var txtHello: TextField = new TextField();
            txtHello.text = "Hello World";
            txtHello.x = txtHello.y = 100;
            this.addElement(txtHello);
        }
        /**
        *  public set | get
        *  call:
        *  Greeter.myNumber = 123; //input
        *  print Greeter.myNumber; //output
        **/
        public set function myNumber(n:Number)
        {
            variableNumber = n;
        }
        public get function myNumber():Number
        {
            return variableNumber;
        }
        /**
        *  static public
        *  call:
        *  Greeter.myFullName()
        **/
        static public function myFullName():String
        {
            return fullName;
        }
    }
}
```

# Tree 

```txt
├── application
│   ├── ExtendedNativeWindow.as
│   ├── ExtendedNativeWindowOptions.as
│   ├── gnncApp
│   ├── gnncAppIcons.as
│   ├── gnncAppIconTray.as
│   ├── gnncApplication.as
│   ├── gnncAppNetConnect.as
│   ├── gnncAppOS.as
│   ├── gnncAppResize.as
│   ├── gnncAppUpdateRuntime.as
│   ├── gnncAppWindow.as
├── audio
│   ├── gnncAudio.as
│   └── micrecorder
│       ├── encoder
│       │   ├── WaveEncoder.as
│       │   └── wavSound
│       │       ├── WavSound.as
│       │       ├── WavSoundChannel.as
│       │       ├── WavSoundPlayer.as
│       │       └── WavToMp3.as
│       ├── events
│       │   └── RecordingEvent.as
│       ├── IEncoder.as
│       └── MicRecorder.as
├── data
│   ├── bitmap
│   │   ├── gnncBitmap.as
│   │   ├── gnncBitmapDraw2.as
│   │   ├── gnncBitmapDraw.as
│   │   ├── gnncBitmapGif.as
│   │   ├── gnncBitmapScale.as
│   │   └── NonTransparentPNGEncoder.as
│   ├── collection
│   │   ├── HashMapCollection.as
│   │   ├── HashMapManager.as
│   │   └── IMap.as
│   ├── conn
│   │   ├── gnncAmfPhp3.as
│   │   ├── gnncAMFPhp3Config.as
│   │   ├── gnncAMFPhp.as
│   │   ├── gnncCrypt.as
│   │   └── xml
│   │       ├── instruction.txt
│   │       └── services-config.xml
│   ├── data
│   │   ├── gnncClipBoard.as
│   │   ├── gnncDataArray.as
│   │   ├── gnncDataArrayCollection.as
│   │   ├── gnncData.as
│   │   ├── gnncDataBindable.as
│   │   ├── gnncDataHtml.as
│   │   ├── gnncDataHtmlStyles.txt
│   │   ├── gnncDataNumber.as
│   │   ├── gnncDataNumberConvert.as
│   │   ├── gnncDataObject.as
│   │   ├── gnncDataRand.as
│   │   ├── gnncDataRegExp.as
│   │   ├── gnncDataUpdateItens.as
│   │   ├── gnncDataVector.as
│   │   ├── gnncDataXml.as
│   │   └── json
│   │       ├── gnncJSON.as
│   │       ├── gnncJSONDecoder.as
│   │       ├── gnncJSONEncoder.as
│   │       ├── gnncJSONParseError.as
│   │       ├── gnncJSONToken.as
│   │       ├── gnncJSONTokenizer.as
│   │       └── gnncJSONTokenType.as
│   ├── date
│   │   ├── BusinessDay.as
│   │   ├── DateUtils.as
│   │   ├── DaylightSavingTimeUS.as
│   │   ├── gnncDate.as
│   │   └── Holiday.as
│   ├── element
│   │   └── gnncElement.as
│   ├── encrypt
│   │   ├── gnncEncryptKey.as
│   │   ├── gnncHMAC.as
│   │   ├── gnncIntUtil.as
│   │   ├── gnncMD5.as
│   │   ├── gnncMD5Stream.as
│   │   ├── gnncSHA1.as
│   │   ├── gnncSHA224.as
│   │   ├── gnncSHA256.as
│   │   └── gnncWSSEUsernameToken.as
│   ├── file
│   │   ├── gnncFileCookie.as
│   │   ├── gnncFileCsv.as
│   │   ├── gnncFileMimeType.as
│   │   ├── gnncFilePdf.as
│   │   ├── gnncFileReport.as
│   │   ├── gnncFilesInative.as
│   │   ├── gnncFilesNative.as
│   │   ├── gnncFileSqlLite2.as
│   │   ├── gnncFileSqlLite.as
│   │   ├── gnncFilesRemote.as
│   │   ├── gnncFileUpload.as
│   │   ├── gnncFileXml.as
│   ├── globals
│   │   ├── gnncGlobalArrays.as
│   │   ├── gnncGlobalLog.as
│   │   ├── gnncGlobalStatic.as
│   │   └── gnncGlobalStaticProjects.as
│   ├── mailer
│   │   └── gnncMailer.as
│   ├── permission
│   │   ├── gnncPermission.as
│   │   ├── gnncPermissionSet.as
│   ├── securityService
│   │   ├── gnncSecurityDate.as
│   │   ├── gnncSecurityService.as
│   │   ├── gnncSecurityService.new.txt
│   │   ├── gnncSecurityUserLogin.as
│   │   └── gnncSocket.as
│   ├── sql
│   │   ├── gnncSql.as
│   │   ├── gnncSqlCreation.as
│   │   ├── gnncSqlModel.as
│   │   └── gnncSqlTable.as
│   ├── validator
│   │   ├── gnncValidatorCnpj.as
│   │   ├── gnncValidatorCpf.as
│   │   ├── gnncValidatorPhoneBr.as
│   │   └── gnncValidatorRg.as
│   ├── vCard
│   │   ├── gnncDataVCard.as
│   │   ├── vCardAddress.as
│   │   ├── vCardData.as
│   │   ├── vCardEmail.as
│   │   └── vCardPhone.as
│   └── zip
│       └── gnncZip.as
├── event
│   ├── gnncCloseEvent.as
│   ├── gnncEventGeneral.as
│   └── gnncUncaughtErrorEvent.as
├── keyboard
│   ├── gnncKeyboard.as
│   ├── gnncKeyboardCommand.as
│   └── gnncKeyboardPaste.as
├── main
│   ├── gnncMain.as
│   ├── gnncStartAIR.as
│   ├── gnncStart.as
│   ├── gnncStartStyle.as
│   └── gnncStartValues.as
├── mouse
│   ├── gnncMouseIncludeDisplayObject.as
│   └── gnncMousePoint.as
├── others
│   ├── gnncFocus.as
│   ├── gnncScrollPosition.as
│   ├── gnncToolTip.as
│   ├── gnncUpdateItemList.as
│   ├── gnncUrlNavegator.as
│   └── gnncViewStackCommand.as
├── system
│   ├── gnncMemonyEventListener.as
│   ├── gnncMemory.as
│   └── gnncParent.as
├── time
│   ├── DeferredFunctionCall.as
│   ├── gnncFunctions.as
│   └── gnncTime.as
└── UI
    ├── gnncAlert
    │   ├── gnncAlert.as
    │   └── gnncAlertEvent.as
    │   └── utils
    │       ├── ArrayTool.as
    │       ├── ChildTool.as
    │       └── MathTool.as
    ├── gnncFxgConverter
    │   ├── FXGStringConverter.as
    │   └── SupportedClassesAndProperties.as
    ├── gnncImage
    │   ├── gnncImageCD.mxml
    │   └── gnncImageProgress.as
    ├── gnncList
    │   └── gnncList.as
    ├── gnncMenuRight
    │   └── gnncMenuRight.as
    ├── gnncNotification
    │   ├── event
    │   │   └── gnncNotificationEvent.as
    │   ├── gnncNotification.as
    │   ├── gnncNotificationConst.as
    │   ├── gnncNotificationManager.as
    │   ├── gnncNotificationValues.as
    │   ├── sound
    │   │   └── drop.mp3
    │   └── ui
    │       └── gnncNotificationWindow.mxml
    └── gnncViewStack
        └── gnncViewStack.as

```
