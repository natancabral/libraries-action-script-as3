package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncLoading.gnncLoading;
	import GNNC.data.bitmap.gnncBitmap;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.core.ByteArrayAsset;
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;
	import mx.managers.PopUpManager;
	import mx.rpc.CallResponder;
	import mx.utils.Base64Decoder;
	
	public dynamic class gnncFilesRemote
	{
		protected var _parent:Object						= null;
		protected var _try:Boolean							= false;
		
		public static const _ATTACHMENT:String 				= "attachment";
		public static const _INLINE:String 					= "inline";
		public static var   _separator:String				= '/';
		
		protected var _fileRef:FileReference				= new FileReference();
		public    var _fileFilter:FileFilter 				= new FileFilter("Todos","*.*");
		
		public var 	_DATA_CONTENT:Object					= null;
		public var 	_DATA_UTF:String						= '';
		public var 	_DATA_EXTENSION:String					= '';
		
		public var  _dataListFiles:Array                    = new Array();
		
		public var  _noCacheFile:Boolean					= false;
		public var 	_allowGlobalLoading:Boolean 			= true;
		public var  _allowGlobalError:Boolean				= true;
		public var  _hideCloseButtonLoading:Boolean			= false;
		
		protected var _ok2Download:Boolean 					= false; //progressbar need
		protected var _pageLoading:gnncLoading;
		
		[Bindable] public var _percent:Number 				= 0;
		[Bindable] public var _percentLabel:String 			= '';
		
		public function gnncFilesRemote(parentApplication_:Object=null,try_:Boolean=false)
		{
			//_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
			_parent = gnncGlobalStatic._parent ;
			_try = try_;
		}
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * DATA - START
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/

		static public function __bytes2Legend(valueInBytes_:uint,returnFalse_:String='-'):String 
		{
			if(!valueInBytes_)
				return returnFalse_;
			
			var s:Array = ['bytes', 'kb', 'MB', 'GB', 'TB', 'PB'];
			var e:Number = Math.floor(Math.log(valueInBytes_)/Math.log(1024));
			
			return (valueInBytes_/Math.pow(1024, Math.floor(e))).toFixed(1)+" "+s[e];
		}
		
		static public function __clearSeparator(string_:String):String 
		{
			//clear spaces
			string_ = gnncData.__trimText(string_);
			
			//remove slash
			string_ = gnncData.__replace(string_,gnncData.__trimText(' \\\\ '),_separator); // two slash
			string_ = gnncData.__replace(string_,gnncData.__trimText(' // '),_separator); // two slash
			string_ = gnncData.__replace(string_,gnncData.__trimText(' \\ '),_separator); // one slash
			string_ = gnncData.__replace(string_,gnncData.__trimText(' / '),_separator); // one slash
			
			//set last slash
			string_ = string_ + _separator;
			
			//replace two slash
			string_ = gnncData.__replace(string_,_separator+_separator,_separator);
			
			//remove last and first slash
			string_ = string_.substr(0,1)  == _separator ? string_.substring(1) : string_; //first Separatin
			string_ = string_.substr(-1,1) == _separator ? string_.substring(0,string_.length-1) : string_; //last Separatin
			
			//new gnncAlert().__alert(string_);
			
			return string_;
		}
		
		public static function __byteArray2UTF(fileRef_:FileReference,orByteArray_:ByteArray=null,isoInput:String='iso-8859-1'):String
		{
			var data:ByteArray = new ByteArray();
			data.endian = Endian.BIG_ENDIAN;
			
			if(fileRef_){
				fileRef_.load();
				data = fileRef_.data;
			}else if(orByteArray_){
				data = orByteArray_;
			}else{
				return '';
			}
			
			if( isoInput == 'utf8' || isoInput == 'utf')
				return data.readUTFBytes(data.bytesAvailable);
			else if( isoInput == 'iso-8859-1' || isoInput.indexOf('iso-8859') > -1 )
				return data.readMultiByte(data.bytesAvailable,"iso-8859-1");
			else
				return data.readMultiByte(data.bytesAvailable,isoInput);
		}
		
		public static function __getExtension(n:String):String
		{
			var a:Array = new Array();
			a = n.split("?");
			n = a[0] as String;
			a = n.substring(-10).split('.');
			a.reverse();
			return String(a[0]).toLowerCase();
		}
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * DATA - END
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * EVENTS - START
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		protected function __eventIOErrorLoad(e:*):void 
		{
			//if(_fIOError != null)
			//	_fIOError.call(null);
			
			if(_allowGlobalError)
				new gnncAlert(_parent).__error('Falha ao carregar o arquivo. Verifique o endereço Url.');
			
			PopUpManager.removePopUp(_pageLoading);
		}
		
		protected function __eventIOErrorUpLoad(e:*):void 
		{
			//if(_fIOError != null)
			//	_fIOError.call(null);
			
			gnncGlobalLog.__add(e,'eventIOErrorUpLoad');
			
			if(_allowGlobalError)
				new gnncAlert(_parent).__alert('Ocorreu algum erro no arquivo, tente enviar novamente.');
			
			PopUpManager.removePopUp(_pageLoading);
		}
		
		protected function __eventSecurityError(e:*):void 
		{
			//if(_fIOError != null)
			//	_fIOError.call(null);
			
			if(_allowGlobalError)
				new gnncAlert(_parent).__error('Não foi permitido essa execução, por segurança o processo foi bloqueado.');
			
			PopUpManager.removePopUp(_pageLoading);
		}
		
		protected function __eventComplete(evt:*=null):void 
		{
			//if(_fComplete != null)
			//	_fComplete.call(null);
			
			_ok2Download = false;
			PopUpManager.removePopUp(_pageLoading);
		}
		
		protected function __eventFileRefSelected(event:Event):void 
		{
			//var file:FileReference = FileReference(event.target);
			//trace("selectHandler: name=" + file.name );
			
			_fileRef.load();
		}
		
		protected function __eventFileSelected(event:Event):void 
		{
		}
		
		protected function __eventFileRef(evt:Event):void 
		{
			_fileRef = evt.currentTarget as FileReference;
			_fileRef.load();
			
			try {
				
			} catch (err:*) {
				//new gnncAlert(_parent).__error('Impossível fazer download deste arquivo.');
			}
		}
		
		protected function __eventProgress(event:ProgressEvent):void
		{

			_percent = event.bytesTotal ? Math.round(event.bytesLoaded / event.bytesTotal * 100) : 1.12345;
			_percentLabel = _percent==1.12345 ? 'Download... ' + __bytes2Legend(event.bytesLoaded) : 'Download... ' + _percent + '%';

			if(_percent >= 100)
				__eventComplete.call(null);

			if(!_allowGlobalLoading)
				return;
			
			if(!_ok2Download)
			{
				_pageLoading 							= new gnncLoading();
				_pageLoading._hideCloseButtonLoading 	= _hideCloseButtonLoading;
				PopUpManager.addPopUp					(_pageLoading,_parent as DisplayObject,true);
				_ok2Download							= true;
			}
			
			if(_percent < 100)
			{
				_pageLoading._percent 					= _percent;
				_pageLoading._textLoading 				= _percentLabel;
				PopUpManager.centerPopUp				(_pageLoading);
				PopUpManager.bringToFront				(_pageLoading);
			} 
		}
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * EVENTS - END
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * WRITE AND DOWNLOAD - START
		 * 
		 * load file 	<- load file in application
		 * upload file 	<- upload file to remote web
		 * select file 	<- open box and select
		 * save file 	<- get file and save
		 * write file 	<- write content and save
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		/**
		 * 
		 * load url file to _DATA_CONTENT (byteArray)
		 * load url file to _DATA_UTF (UTF)
		 * 
		 * url_: 'filePhpGetAndPostTrial'
		 * thisPhpFilesDaybyday_ = true
		 * 
		 * **/
		public function __loadUrl(fileName_Path_or_Url_:String,fComplete_:Function=null,fIOError_:Function=null,paramsNamesAndValues_:Object=null,method_:String='POST',thisPhpFilesDaybyday_:Boolean=false,fPercentProgress_:Function=null):void
		{
			var _filePathServer:String		= '/collection/'; // '/services/files/filesPhp/' // '/services/PHP_FILES/'
			var _fileExtension:String		= '.php';
			var _urlFileNamePhp:String 		= (thisPhpFilesDaybyday_) ? gnncGlobalStatic._httpDomain + _filePathServer + fileName_Path_or_Url_ + _fileExtension : fileName_Path_or_Url_ ;
			
			gnncGlobalLog.__add('url:'+_urlFileNamePhp);
			
			if(!_urlFileNamePhp) 
			{
				new gnncAlert(_parent).__error('Não há Url.');
				return;
			}
			
			if(_urlFileNamePhp.length<10)
			{
				new gnncAlert(_parent).__error('Url incorreta.');
				return;
			}
			
			/*
			
			//send with HTTPService
			
			var service : HTTPService = new HTTPService();
			service.url = "http://localhost/getData.php";
			service.method = "POST";			
			
			var parameters:Object = new Object();
			parameters["action"] = "getitems";
			parameters["class"] = "fruit";
			
			service.send(parameters);
			
			*/
			
			var e:URLRequest 					= new URLRequest(_urlFileNamePhp + (!_noCacheFile?'':'?'+ Math.random() + new Date().time));			
			e.method							= method_;
			e.data								= gnncDataObject.__object2URLVariables(paramsNamesAndValues_);
			
			try { /* largeFile */ e['idleTimeout'] = 15000000; } catch (e:*){}
			
			var loader:URLLoader 				= new URLLoader();
			loader.dataFormat 					= URLLoaderDataFormat.BINARY;
			loader.addEventListener				(ProgressEvent.PROGRESS				,__eventProgress);
			loader.addEventListener				(IOErrorEvent.IO_ERROR				,__eventIOErrorLoad);
			loader.addEventListener				(SecurityErrorEvent.SECURITY_ERROR	,__eventSecurityError);
			loader.addEventListener				(Event.COMPLETE						,__eventComplete);
			loader.addEventListener				(Event.COMPLETE						,__completeToData);

			if(fPercentProgress_!=null)
				loader.addEventListener(ProgressEvent.PROGRESS,fPercentProgress_);

			if(fComplete_ != null)
				loader.addEventListener(Event.COMPLETE,fComplete_);
			
			if(fIOError_ != null)
				loader.addEventListener(IOErrorEvent.IO_ERROR,fIOError_);
			
			//loader.load(new URLRequest(url_ + (!_noCacheFile?'':'?'+ Math.random())));
			loader.load(e);
			
			function __completeToData(e:Event):void
			{
				//var loader:URLLoader 	= URLLoader(e.target);
				_DATA_EXTENSION			= gnncFilesRemote.__getExtension(_urlFileNamePhp);
				_DATA_CONTENT			= loader.data;
				_DATA_UTF 				= String(loader.data);
			}
		}
		
		/**
		 * 
		 * dont load content
		 * 
		 * **/
		public function __saveUrlWithBrowser(url_:String,fileName_:String,fileExtension_:String,fComplete_:Function=null,fIOError_:Function=null):void 
		{
			var _fileNameAndPath:String			= __clearSeparator(fileName_ + "." + String(fileExtension_).toLowerCase());
			
			_fileRef 							= new FileReference();
			_fileRef.addEventListener			(Event.CANCEL, 						__eventFileRef);
			_fileRef.addEventListener			(Event.OPEN, 						__eventFileRef);
			_fileRef.addEventListener			(Event.SELECT, 						__eventFileRef);
			_fileRef.addEventListener			(HTTPStatusEvent.HTTP_STATUS, 		__eventFileRef);
			_fileRef.addEventListener			(ProgressEvent.PROGRESS, 			__eventProgress);
			_fileRef.addEventListener			(IOErrorEvent.IO_ERROR, 			__eventIOErrorLoad);
			_fileRef.addEventListener			(SecurityErrorEvent.SECURITY_ERROR, __eventSecurityError);
			_fileRef.addEventListener			(Event.COMPLETE, 					__eventComplete);
			_fileRef.addEventListener			(Event.COMPLETE, 					__completeToData);
			
			if(fComplete_ != null)
				_fileRef.addEventListener(Event.COMPLETE,fComplete_);
			
			if(fIOError_ != null)
				_fileRef.addEventListener(IOErrorEvent.IO_ERROR,fIOError_);
			
			_fileRef.download					(new URLRequest(url_),_fileNameAndPath);
			
			function __completeToData(e:Event):void
			{
			}
		}
		
		/**
		 * 
		 * load url file to _DATA_CONTENT (byteArray)
		 * load url file to _DATA_UTF (UTF)
		 * 
		 * **/
		public function __selectWithBrowser(fComplete_:Function=null,fIOError_:Function=null):void
		{
			_fileRef							= new FileReference();
			_fileRef.browse						([_fileFilter]);
			_fileRef.addEventListener			(Event.SELECT						,__eventFileRefSelected);
			_fileRef.addEventListener			(HTTPStatusEvent.HTTP_STATUS		,__eventFileRef);
			_fileRef.addEventListener			(ProgressEvent.PROGRESS				,__eventProgress);
			_fileRef.addEventListener			(IOErrorEvent.IO_ERROR				,__eventIOErrorUpLoad);
			_fileRef.addEventListener			(SecurityErrorEvent.SECURITY_ERROR	,__eventSecurityError);
			_fileRef.addEventListener			(Event.COMPLETE						,__eventComplete);
			_fileRef.addEventListener			(Event.COMPLETE						,__completeToData);
			
			if(fComplete_ != null)
				_fileRef.addEventListener(Event.COMPLETE,fComplete_);
			
			if(fIOError_ != null)
				_fileRef.addEventListener(IOErrorEvent.IO_ERROR,fIOError_);
			
			
			function __completeToData(e:Event):void
			{
				_DATA_EXTENSION			= gnncFilesRemote.__getExtension(_fileRef.extension);
				_DATA_CONTENT 			= _fileRef.data; //e.target.data //data.bytesAvailable);
				_DATA_UTF 				= gnncFilesRemote.__byteArray2UTF(_fileRef);
				
				_dataListFiles = new Array();
				_dataListFiles.push(_fileRef);
			}
		}
		
		/**
		 * 
		 * dont load content
		 * 
		 * **/
		public function __saveWithBrowser(fileName_:String,fileExtension_:String,fileContent_:Object,fComplete_Event_:Function=null):void 
		{
			var _fileNameAndPath:String = __clearSeparator(fileName_ + "." + String(fileExtension_).toLowerCase());
			
			if(!fileName_ && !fileExtension_ && !fileContent_)
				_fileRef = new FileReference();
			
			if(fComplete_Event_ != null)
				_fileRef.addEventListener(Event.COMPLETE,fComplete_Event_);
			
			_fileRef.save(fileContent_,_fileNameAndPath);
		}
		
		public function __uploadComponentFlex(fileName_:String,path_:String,bitmapData_:BitmapData,fComplete_Event_:Function=null):void
		{
			new gnncAlert().__error('Inativo.');
		}
		
		public function __uploadJpg(fileName_:String,path_:String,bitmapData_:BitmapData,quality_:uint=90,fComplete_Event_:Function=null,fError_Event_:Function=null):void
		{
			var byteImage:ByteArray			= new ByteArray(); 
			var encoderJpg:JPEGEncoder 		= new JPEGEncoder(quality_);
			byteImage						= encoderJpg.encode(bitmapData_);
			
			var byteArray:ByteArray 		= new ByteArray();
			byteArray.writeMultiByte		(gnncBitmap.__encode64(byteImage),gnncFileMimeType.__getMimeType('jpg'));
			
			__upload						(fileName_,'jpg',path_,byteArray,fComplete_Event_,fError_Event_);
		}
		
		public function __uploadPng(fileName_:String,path_:String,bitmapData_:BitmapData,fComplete_Event_:Function=null,fError_Event_:Function=null):void
		{
			var byteImage:ByteArray			= new ByteArray(); 
			var pngEnc:PNGEncoder 			= new PNGEncoder();
			byteImage						= pngEnc.encode(bitmapData_);
			
			var byteArray:ByteArray 		= new ByteArray();
			byteArray.writeMultiByte		(gnncBitmap.__encode64(byteImage),gnncFileMimeType.__getMimeType('png'));
			
			__upload						(fileName_,'png',path_,byteArray,fComplete_Event_,fError_Event_);
		}
		
		public function __uploadWav(fileName_:String,path_:String,byteArray:ByteArray,fComplete_Event_:Function=null):void
		{
			__upload						(fileName_,'wav',path_,byteArray,fComplete_Event_);
		}
		
		public function __uploadUTF(fileName_:String,path_:String,contentText_:String):void
		{
			//trace("bytes.position is initially: " + bytes.position);     	// 0
			//trace("bytes.position is now: " + bytes.position);    		// 12
			
			var _byteArray:ByteArray 		= new ByteArray();
			_byteArray.writeUTFBytes		(contentText_);
			
			__upload						(fileName_,'txt',path_,_byteArray);
		}
		
		public function __upload(fileName_:String,fileExtension_:String,path_:String,content_:ByteArray,fComplete_Event_:Function=null,fError_Event_:Function=null):void
		{
			if(!fileName_ || !fileExtension_)
			{
				new gnncAlert().__error('Faltam parâmetros.');
				return;
			}
			
			path_ = (!path_) ? '' : path_ ;
			
			var urlServer:String 			= gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverFileUpload + '?' + Math.random() + 
				"&_filePathServer="			+ path_ + 
				"&_dataBaseName=" 			+ gnncGlobalStatic._dataBase +
				"&_fileName=" 				+ fileName_+'.'+String(fileExtension_).toLowerCase();
			
			gnncGlobalLog.__add(urlServer,'uploadFile');
			
			var request:URLRequest 			= new URLRequest(urlServer);
			var loader:URLLoader 			= new URLLoader();
			
			request.contentType				= gnncFileMimeType.__getMimeType(fileExtension_);		
			request.method 					= URLRequestMethod.POST;
			request.data 					= content_;

			gnncGlobalLog.__add(gnncFileMimeType.__getMimeType(fileExtension_),'getMime');

			if(fComplete_Event_!=null)
				loader.addEventListener(Event.COMPLETE,fComplete_Event_);
			if(fError_Event_!=null)
				loader.addEventListener(IOErrorEvent.IO_ERROR,fError_Event_);
			
			loader.addEventListener			(Event.COMPLETE				,__eventComplete);
			loader.addEventListener			(IOErrorEvent.IO_ERROR		,__eventIOErrorUpLoad);
			loader.addEventListener			(ProgressEvent.PROGRESS		,__eventProgress);
			loader.load						( request );
		}
		
		public function __sendAndOpenRemote(fileName_:String,fileExtension_:String,content_:ByteArray,methodWrite_:String='inline',target_:String='_blank'):void
		{
			var urlServer:String 			= gnncGlobalStatic._httpHost + gnncGlobalArrays.serverFileOpenRemote + '?' + Math.random() + 
				"&_fileName=" 				+ fileName_+'.'+String(fileExtension_).toLowerCase()+
				"&_method=" 				+ methodWrite_;
			
			gnncGlobalLog.__add(urlServer,'sendAndOpenRemote');
			
			var header:URLRequestHeader 	= new URLRequestHeader ("Content-type","application/octet-stream");
			var myRequest:URLRequest 		= new URLRequest (urlServer);
			
			myRequest.requestHeaders.push 	(header);
			myRequest.method 				= URLRequestMethod.POST;
			myRequest.data 					= content_;
			
			navigateToURL 					( myRequest, target_ );
		}
		
		/**
		 * source: source.bitmapData (sorce is id name)
		 * fileName: 'onlyName'
		 * DPI: 0
		 * qualityPercent: 50
		 * */
		public function __saveJpg(sourceComponentFlexId_:IBitmapDrawable,fileName_:String,DPI_:uint=0,qualityPercent_:uint=50):void
		{
			if(qualityPercent_>=100) qualityPercent_ = 100;
			
			var imageBitmapData:ImageSnapshot = ImageSnapshot.captureImage(sourceComponentFlexId_,DPI_,new JPEGEncoder(qualityPercent_),true);
			
			_fileRef.save(imageBitmapData.data, fileName_+'.jpg');
			_fileRef.addEventListener(ProgressEvent.PROGRESS,__eventProgress);
		}
		
		/**
		 * source: source.bitmapData (sorce is id name)
		 * fileName: 'onlyName'
		 * DPI: 0
		 * */
		public function __savePng(sourceComponentFlexId_:IBitmapDrawable,fileName_:String,DPI_:uint=0):void
		{
			//BitmapDataChannel.ALPHA pesquisar
			var imageBitmapData:ImageSnapshot = ImageSnapshot.captureImage(sourceComponentFlexId_,DPI_,new PNGEncoder(),true);
			
			_fileRef.save(imageBitmapData.data, fileName_+'.png');
		}

		/**
		 * source: source.bitmapData (sorce is id name)
		 * DPI: 0
		 * qualityPercent: 50
		 * */
		public function __componentFlex2byteArray_jpg(source:IBitmapDrawable,DPI:uint=0,qualityPercent:uint=50):ByteArray 
		{
			if(qualityPercent>=100) qualityPercent = 100;
			var imageBitmapData:ImageSnapshot = ImageSnapshot.captureImage(source,DPI,new JPEGEncoder(qualityPercent),true);
			return imageBitmapData.data;
		}
		
		/**
		 * source: source.bitmapData (sorce is id name)
		 * DPI: 0
		 * qualityPercent: 80
		 * */
		public function __componentFlex2byteArray_png(source:IBitmapDrawable,DPI:uint=0):ByteArray 
		{
			var imageBitmapData:ImageSnapshot = ImageSnapshot.captureImage(source,DPI,new PNGEncoder(),true);
			return imageBitmapData.data;
		}

		
	}
}