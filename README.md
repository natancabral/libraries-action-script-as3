[<img src="https://raw.githubusercontent.com/natancabral/libraries-action-script-as3/main/adobe-air.png" align="right" width="150">](https://www.adobe.com/products/air.html)

# ActionScript 3 [![Awesome](https://raw.githubusercontent.com/natancabral/libraries-action-script-as3/main/badge-awesome.svg)](https://github.com/natancabral/libraries-action-script-as3)

## Libraries Natan Cabral 

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

# Connection AMF

**AmfPhp**

> AMFPHP is a widely used OS remoting server that allows  send and receive data to and from your web server and interact with your scripts. Data to/from is automatically converted into the appropriate Flash variable type and communication is fast because the format data is sent in is compact and is handled efficiently (large XML files can sometimes take time to be processed).

```as

package GNNC.data.conn
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.system.gnncMemory;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.messages.IMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public dynamic class gnncAmfPhp3
	{
		/*
		* ----------------------------------------------------------------------------
		* init amfphp
		* ----------------------------------------------------------------------------
		* getInstance : Start connection
		* file|class : php file on server, amfphp.php, myClass.php
		* func : function name on php file
		* arg : arguments String|int|Number|Object
		* ----------------------------------------------------------------------------
		* sample 1
		* gnncAmfPhp3.getInstance().send('file|class','func',[arg,arg]);
		* sample 2
		* new gnncAmfPhp3().getRemoteObject('file|class').getOperation('func').send(arg,arg);
		* sample 3
		* var b:gnncAMFPhp3Config = new gnncAMFPhp3Config();
		* b._after_ResultEvent = function(e:*):void{ [list].dataProvider = gnncDataObject.__object2ArrayCollection(e.result); };
		* b._after_FaultEvent  = function(e:*):void{ };
		* b._logReference = 'logReference';
		* b._logLegend    = 'logLegend';
		* sample 4
		* var a:gnncAmfPhp3 = gnncAmfPhp3.getInstance();
		* a.setConfig(b);
		* a.send('file|class','func',[arg,arg]);
		* sample 5
		* var b:gnncAMFPhp3Config = new gnncAMFPhp3Config();
		* b._after_ResultEvent = function(e:*):void{ [list].dataProvider = gnncDataObject.__object2ArrayCollection(e.result); };
		* b._after_FaultEvent  = function(e:*):void{ };
		* b._logReference = 'logReference';
		* b._logLegend    = 'logLegend';		
		*/
		
		//---------------------------------------------------------------------
		private var _parent:Object         			= null;
		//---------------------------------------------------------------------
		private static var instance:gnncAmfPhp3;
		protected var channelSet:ChannelSet         = null;
		protected var remoteObject:RemoteObject     = new RemoteObject();
		protected var makeObjectsBindable:Boolean   = false;
		protected var url:String                    = '';
		//---------------------------------------------------------------------
		public var connMessageId:String             = ''; //first Key/Id send to cliente remote connection
		public var connCorrelationId:String         = ''; //reponse to system with igual Key/Id
		public var connClientId:String              = ''; //everywere a new Id sented by remote server
		public var connTimestamp:Number             = 0; //last time
		//---------------------------------------------------------------------
		public const connectionUserLogin:String     = '[#011] Efetue o login com seu usuário e sua senha corretamente ou verifique sua internet.';
		public const connectionFaultInternet:String = '[#012] Falha ao estabelecer uma conexão simples.'; //Couldn't establish a connection to
		public const connectionFaultConnect:String  = '[#013] Falha ao estabelecer uma conexão com o servidor de arquivos. Verifique sua internet.';
		public const connectionFaultService:String  = '[#014] Falha no arquivo de conexão.';
		public const connectionFaultDetail:String   = '[#015] Falha na execução da Classe de conexão, solicite a verificação no arquivo.';
		public const connectionFaultMethod:String   = '[#016] Falha na execução do Método no arquivo de conexão.';
		//---------------------------------------------------------------------
		//AmfPhp 2.2.2
		//---------------------------------------------------------------------		
		public var errorMessConnect:String          = 'Send failed';          // (Send failed) - Nao conseguiu estabelecer conexão
		public var errorMessService:String          = 'service not found';    // (gnncAmfPhp service not found ) - Arquivo nao encontrado
		public var errorMessDetail:String           = 'Channel disconnected'; // (Channel disconnected)
		public var errorMessMethod:String           = 'not found on';         // (method gnncAmfPhp not found on gnncAmfPhp object )
		//---------------------------------------------------------------------
		public var config:gnncAMFPhp3Config         = new gnncAMFPhp3Config();
		//---------------------------------------------------------------------		
		
		public var dataObj:Object          			= null;
		public var dataArr:ArrayCollection 			= new ArrayCollection();
		public var dataStr:String          			= '';
		public var dataRows:uint           			= 0;
		
		public var dataErr:Object          			= null; // error
		public var dataRes:Object          			= null; // result
		public var dataMss:Object          			= null; // message
		
		public var _try:Boolean 					= false;
		public var _allowGlobalLoading:Boolean 		= true;
		public var _allowGlobalError:Boolean 		= true;
		
		[Bindable] public var _loading:Boolean 		= false;
		[Bindable] public var _connections:uint		= 0;
		
		protected var _sqlCache:String				= '';
		
		public var _after_ResultEvent:Function	= function(event:ResultEvent):void{};
		public var _after_FaultEvent:Function	= function(event:FaultEvent ):void{};

		public function gnncAmfPhp3(parentApplication_:Object=null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
			var chanel:AMFChannel = new AMFChannel("gnnc-amfphp-v2.2.2-AMFChannel", getUrl());
			this.channelSet       = new ChannelSet();
			this.channelSet.addChannel(chanel);
		}
		
		private function getUrl():String
		{
			url = gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverGateway;
			return url;
		}
		
		static public function getInstance(force:Boolean=false):gnncAmfPhp3
		{
			if(force){ //to multi connections send all time
				instance = new gnncAmfPhp3();
			}else if(instance == null){
				instance = new gnncAmfPhp3();
			}
			return instance;
		}

        public function setConfig(obj:gnncAMFPhp3Config):gnncAmfPhp3
		{
			config = obj;
			
			if(remoteObject.willTrigger(ResultEvent.RESULT) && _after_ResultEvent != null) 
            remoteObject.removeEventListener(ResultEvent.RESULT, _after_ResultEvent);
			if(remoteObject.willTrigger(FaultEvent.FAULT)   && _after_FaultEvent  != null) 
            remoteObject.removeEventListener(FaultEvent.FAULT,   _after_FaultEvent);
			
			_after_ResultEvent  = config._after_ResultEvent;
			_after_FaultEvent   = config._after_FaultEvent;
			
			if(config._after_ResultEvent != null) remoteObject.addEventListener(ResultEvent.RESULT, config._after_ResultEvent ,false,0,true);
			if(config._after_FaultEvent != null)  remoteObject.addEventListener(FaultEvent.FAULT,   config._after_FaultEvent  ,false,0,true);
			
			return instance;
		}

		public function getRemoteObject(channel:String=''):RemoteObject
		{
			if(instance == null)
				getInstance();
				//new gnncAlert().__alert('Start getInstance first.');

			if(remoteObject == null)
				remoteObject = new RemoteObject();

			if(!channel && !config._channel && !remoteObject.source)
				new gnncAlert().__alert('Set channel on file config.');
			else
				remoteObject.source = channel ? channel : config._channel ? config._channel : remoteObject.source ; //file/class

			remoteObject.destination         = 'gnnc-destination';
			remoteObject.concurrency         = 'single'; // single | multiple | last
			remoteObject.requestTimeout      = 120;
			remoteObject.makeObjectsBindable = this.makeObjectsBindable;
			
			// new connection id
			if(channelSet)
				remoteObject.channelSet = channelSet;

			initEventListener();

			return remoteObject;
		}

		/**
		 * channel:String   = file php and class name\n
		 * method:String    = function on class file\n
		 * arguments:Array  = parans array send to function\n
		 * 
		 */
		public function send(channel:String = '',method:String = '' , arguments:Array=null):void
		{
			if(_connections>20)
				return;
			
			getRemoteObject();
						
			if(!channel && !config._channel && !remoteObject.source)
				new gnncAlert().__alert('Set channel on file config.');
			else
				remoteObject.source = channel ? channel : config._channel ? config._channel : remoteObject.source ; //file/class

			if(method)
				remoteObject.getOperation(method).send.apply(null,arguments);
		}

		protected function IMessageEvent(event:*):void
		{
			var IM:IMessage        = IMessage(event.message);
			this.connClientId      = Object(IM).hasOwnProperty('clientId')  ? IM.clientId  : 'no-clientId' ;
			this.connCorrelationId = Object(event.message).hasOwnProperty('correlationId')?Object(event.message).correlationId:''; 
			this.connMessageId     = Object(IM).hasOwnProperty('messageId') ? IM.messageId : 'no-messageId' ; //id solicitation
			this.connTimestamp     = Object(IM).hasOwnProperty('timestamp') ? IM.timestamp : 0 ; 
		}

		protected function eventInvoke(event:InvokeEvent):void
		{
			loadingData(true);
			IMessageEvent(event);
			
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss = String(event.message);

			gnncGlobalLog.__add("Invoke: "+this.dataMss);
		}
		
		protected function eventResult(event:ResultEvent):void 
		{
			this.dataObj  = event.result;
			
			if(this.dataObj){
				this.dataArr  = gnncDataObject.__object2ArrayCollection(dataObj);
				this.dataStr  = dataObj.toString();
				this.dataRows = dataArr.length; //gnncDataObject.__getTotalAMFPhp(dataObj);
			}else{
				this.clear();
			}

			if(gnncGlobalStatic._debug == true){
				IMessageEvent(event);
			}

			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = String(event.message);

			if(gnncGlobalStatic._debug == true){

				this.dataRes  += "\n------------------------------------------\n";
				this.dataRes  += 'StatusCode: ' + event.statusCode         + '\n';
				this.dataRes  += 'Rows:       ' + this.dataRows            + '\n';
				this.dataRes  += 'Result:     ' + event.result.toString()  + '\n';
				this.dataRes  += 'Message:    ' + ( event.hasOwnProperty('message') ? String(event.message) : '' ) + '\n';				

				gnncGlobalLog.__addSuccess(this.dataRes);
			}
			
			loadingData(false);
			//clear memory
			gnncMemory.__clear();
		}
		
		protected function eventFault(event:FaultEvent):void 
		{
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = String(event.message);

			IMessageEvent(event);

			/*if(!gnncGlobalStatic._userId){
			new gnncAlert().__error(this.connectionUserLogin);
			return;
			}*/
			
			this.dataErr += "\n-----------------------------------------------\n";
			this.dataErr += 'MessageId: ' + event.messageId                  + '\n';
			this.dataErr += 'Headers:   ' + event.headers                    + '\n';
			this.dataErr += 'ErrorID:   ' + event.fault.errorID              + '\n';
			this.dataErr += 'Detail:    ' + event.fault.faultDetail          + '\n';
			this.dataErr += 'Fault:     ' + event.fault.toString()  	     + '\n';
			this.dataErr += 'Error:     ' + event.fault.faultString  		 + '\n';
			this.dataErr += 'Code:      ' + event.fault.faultCode.toString() + '\n';
			this.dataErr += 'Message:   ' + dataMss + '\n';

			//if(this.connMessageId != this.connCorrelationId)
			//	this.connMessageId = IM.messageId; //id solicitation 
			
			gnncGlobalLog.__addError(this.dataErr);
			
			if(_allowGlobalError      && event.fault.faultString.indexOf(this.errorMessConnect) > -1 )
				new gnncAlert().__error(connectionFaultConnect);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessService) > -1 )
				new gnncAlert().__error(connectionFaultService);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessDetail)  > -1 )
				new gnncAlert().__error(connectionFaultDetail);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessMethod)  > -1 )
				new gnncAlert().__error(connectionFaultMethod);
			else if(_allowGlobalError)
				new gnncAlert().__error(this.connectionFaultInternet);

			//clear memory
			gnncMemory.__clear();
			loadingData(false);
		}
		
		public function clear():void
		{
			//System.disposeXML(DATA_XML);
			
			this.dataObj  = null;
			this.dataArr  = new ArrayCollection();
			this.dataStr  = ''; 
			this.dataRows = 0;
			
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = new Object();
			
			this.connClientId      = ''; 
			this.connCorrelationId = ''; 
			this.connMessageId     = ''; 
			this.connTimestamp     = 0; 

			//gnncGlobalLog.__add	('AmfClearAll');
		}
		
		private function initEventListener():void
		{
			//clear();
			//remoteObject = new RemoteObject();
			if(remoteObject.willTrigger(InvokeEvent.INVOKE)==false){
				remoteObject.addEventListener(InvokeEvent.INVOKE, eventInvoke ,false, 1, true);
				remoteObject.addEventListener(ResultEvent.RESULT, eventResult ,false, 1, true);
				remoteObject.addEventListener(FaultEvent.FAULT,   eventFault  ,false, 1, true);
			}
		}
		
		public function destroy():void
		{
			if(remoteObject.willTrigger(InvokeEvent.INVOKE)){
				remoteObject.removeEventListener(InvokeEvent.INVOKE, eventInvoke ,false);
				remoteObject.removeEventListener(ResultEvent.RESULT, eventResult ,false);
				remoteObject.removeEventListener(FaultEvent.FAULT,   eventFault  ,false);
			}
			if(_after_ResultEvent != null) remoteObject.removeEventListener	(ResultEvent.RESULT, _after_ResultEvent	,false);
			if(_after_FaultEvent  != null) remoteObject.removeEventListener	(FaultEvent.FAULT, 	 _after_FaultEvent	,false);
			if(_loading) loadingData(false);
			
			//__initialize();
			clear();
		}
		
		public function refresh():void
		{
			var _arrCache:Array = null;
			_arrCache = _sqlCache.split(gnncGlobalStatic._breakSql);
			_sqlCache = String(_arrCache[0]);
			if( _sqlCache.substr(0,10).toUpperCase().indexOf('SELECT')>-1 ){
				//var config:gnncAMFPhp3Config = new gnncAMFPhp3Config();
				//config._query = 
				//query(_sqlCache,'','',_after_ResultEvent,_after_FaultEvent);
			}
		}
		
		protected function loadingData(load:Boolean):void 
		{
			load == true ? _connections++ : _connections-- ;
			if(_allowGlobalLoading){
				if(FlexGlobals.topLevelApplication.hasOwnProperty('_START'))
					// start global _loading
					FlexGlobals.topLevelApplication._START._gnncGlobal._loading = _loading = (_connections>0)?true:false;
				else
					// no global neither start
					_loading = (_connections>0)?true:false;
			}else{
				_loading = (_connections>0)?true:false;
			}
		}	
		
	}
}

```
