package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncLoading.gnncLoading;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;
	import mx.managers.PopUpManager;
	
	import org.alivepdf.encoding.Base64;
	
	public class gnncFilesInative
	{
		private var _parent:Object			= null;
		
		static public const _desktop:String 				= 'DSK';
		static public const _applicationDirectory:String 	= 'APP';
		static public const _applicationStorage:String 		= 'APS';
		static public const _documentDirectory:String 		= 'DOC';
		static public const _userDirectory:String 			= 'USE';
		static public const _tempPath:String 				= 'TMP';
		
		public static const _ATTACHMENT:String 				= "attachment";
		public static const _INLINE:String 					= "inline";
		
		private var fileRefModel:Object;
		private var fileRef:FileReference;
		private var file:File;
		
		public var 	_DATA_CONTENT:Object		= null;
		public var  _noCacheFile:Boolean		= false;
		
		[Bindable] public var _PERCENT:Number = 0;
		private var _ok2Download:Boolean = false;
		private var _pageLoading:gnncLoading = new gnncLoading();
		private var _gnncPopUp:gnncPopUp;
		
		public function gnncFilesInative(parentApplication_:Object=null)
		{
			_parent 	= (parentApplication_)?parentApplication_:gnncGlobalStatic._parent;
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
		
		public static const ALLFILES:String 			= 'allowAllFiles';
		public static const IMAGEFILES:String 			= 'allowOnlyImages';
		public static const ADOBEFILES:String 			= 'allowOnlyAdobeFiles';
		public static const TEXTFILES:String 			= 'allowOnlyText';
		
		private function __getTypes(v:String):Array
		{
			var allowTypes:Array;
			
			switch( v ){
				case ALLFILES:
				default:
					allowTypes 						= new Array(__getImageTypeFilter(), __getTextTypeFilter(), __getAdobeTypeFilter());
					break;
				case IMAGEFILES:
					allowTypes 						= new Array(__getImageTypeFilter());
					break;
				case TEXTFILES:
					allowTypes 						= new Array(__getTextTypeFilter());
					break;
				case ADOBEFILES:
					allowTypes 						= new Array(__getAdobeTypeFilter());
					break;
			}
			
			return allowTypes;
		}
		
		private function __getImageTypeFilter():FileFilter {
			return new FileFilter					("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png;*.*");
		}
		
		private function __getTextTypeFilter():FileFilter {
			return new FileFilter					("Text Files (*.txt, *.rtf)", "*.txt;*.rtf;*.*");
		}
		
		private function __getAdobeTypeFilter():FileFilter {
			return new FileFilter					("Adobe Files (*.ai, *.pdf, *.psd, *.flv, *.fla, *.swf, *.as)" , "*.ai;*.pdf;*.psd;*.flv;*.fla;*.swf;*.as;*.*");
		}

		
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
			string_ = !string_ ? '' : 
				gnncData.__trimText(
					string_
					.replace(gnncData.__trimText(" \\ "),File.separator)
					.replace(gnncData.__trimText(" // "),File.separator)
					.replace(gnncData.__trimText(" \ "),File.separator)
					.replace(gnncData.__trimText(" / "),File.separator)
				) + File.separator;
			
			string_ = string_.replace(File.separator+File.separator,File.separator);
			string_ = string_.substr(0,1)  == File.separator ? string_.substring(1) : string_; //first Separatin
			string_ = string_.substr(-1,1) == File.separator ? string_.substring(0,string_.length-1) : string_; //last Separatin
			
			return string_;
		}
		
		public function __selectedLocationToSavePath(pathOrPathAndFile_:String,locationSystem_:String='TMP'):File
		{
			var _file:File;
			
			switch(locationSystem_)
			{
				case 'DSK':		_file = File.desktopDirectory				.resolvePath(pathOrPathAndFile_);		break;
				case 'APP':		_file = File.applicationDirectory			.resolvePath(pathOrPathAndFile_);		break;
				case 'APS':		_file = File.applicationStorageDirectory	.resolvePath(pathOrPathAndFile_);		break;
				case 'DOC':		_file = File.documentsDirectory				.resolvePath(pathOrPathAndFile_);		break;
				case 'USE':		_file = File.userDirectory					.resolvePath(pathOrPathAndFile_);		break;
				case 'TMP':		
				default:		_file = File.createTempDirectory()			.resolvePath(pathOrPathAndFile_);		break;
			}
			
			return _file;
		}
		
		public function __selectedLocationToSaveFile(fileName_:String,fileExtension_:String,filePath_:String,locationSystem_:String='TMP',deleteIfExistsFiles_:Boolean=false,forceChangeName_:Boolean=true):File
		{
			filePath_ 						= filePath_ ? filePath_ + File.separator : '';
			fileExtension_ 					= gnncData.__replace(fileExtension_,".","");
			
			var _file:File;
			var _fileNameAndPath:String		= __clearSeparator(filePath_ + fileName_ + "." + fileExtension_);
			var _data:String 				= '';
			
			_file = __selectedLocationToSavePath(_fileNameAndPath,locationSystem_);
			
			//_file.nativePath; 	//C:\a\b\c.jpg
			//_file.url; 			//app-storage:/c.jpg
			
			if(_file.exists)
			{
				try
				{
					if(deleteIfExistsFiles_)
						_file.deleteFile()
				}
				catch(e:*){}
				
				if(_file.exists && forceChangeName_)
					_data = ' - ' + gnncData.__replace(gnncDate.__date2String(new Date(),true,false),':','-') + ' - ' + new Date().time;
				
				return __selectedLocationToSaveFile(fileName_+_data,fileExtension_,filePath_,locationSystem_);
			}
			
			return _file;
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
		
		protected function __IOERROR(e:*):void 
		{
		}
		
		protected function __downloadEvent(evt:Event):void 
		{
			var fr:FileReference = evt.currentTarget as FileReference;
			try {
			} catch (err:*) {
				//new DAYBYDAY_ALERT._ERROR(null,'ImpossÃ­vel fazer download deste arquivo.');
			}
		}
		
		protected function __downloadUrlIOError(event:IOErrorEvent):void
		{
			new gnncAlert().__error('Falha no download. Verifique o endereÃ§o Url.');
		}
		
		protected function __downloadProgress(event:ProgressEvent):void
		{
			_PERCENT	= (event.bytesTotal)?Math.round(event.bytesLoaded / event.bytesTotal * 100):1.12345;
			
			if(!_ok2Download)
			{
				_pageLoading 				= new gnncLoading();
				PopUpManager.addPopUp		(_pageLoading,_parent as DisplayObject,true);
				_ok2Download				= true;
			}
			
			if(_PERCENT < 100)
			{
				_pageLoading._percent 		= _PERCENT;
				_pageLoading._textLoading 	= (_PERCENT==1.12345)?'Download... ' + __bytes2Legend(event.bytesLoaded):'Download... ' + _PERCENT + '%';
				PopUpManager.centerPopUp	(_pageLoading);
				PopUpManager.bringToFront	(_pageLoading);
			} 
			else
			{
				PopUpManager.removePopUp	(_pageLoading);
				_ok2Download 				= true;
			}
		}
		
		protected function __uploadIOError(evt:IOErrorEvent):void 
		{
			new gnncAlert().__error('Ocorreu algum erro, tente novamente.');
		}
		
		protected function __uploadComplete(evt:Event):void 
		{
			PopUpManager.removePopUp	(_pageLoading);
			//new DAYBYDAY_ALERT()._ERROR('Ocorreu algum erro, tente novamente.');
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
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		public function __downloadWithBrowser(url_:String,fileName_:String,fileExtension_:String):void 
		{
			var _fileNameAndPath:String		= __clearSeparator(fileName_ + "." + fileExtension_);
			
			fileRef 						= new FileReference();
			fileRef.addEventListener		(Event.CANCEL, 						__downloadEvent);
			fileRef.addEventListener		(Event.COMPLETE, 					__downloadEvent);
			fileRef.addEventListener		(Event.OPEN, 						__downloadEvent);
			fileRef.addEventListener		(Event.SELECT, 						__downloadEvent);
			fileRef.addEventListener		(HTTPStatusEvent.HTTP_STATUS, 		__downloadEvent);
			fileRef.addEventListener		(IOErrorEvent.IO_ERROR, 			__downloadUrlIOError);
			fileRef.addEventListener		(ProgressEvent.PROGRESS, 			__downloadProgress);
			fileRef.addEventListener		(SecurityErrorEvent.SECURITY_ERROR, __downloadEvent);
			fileRef.download				(new URLRequest(url_),_fileNameAndPath);
			
		}
		
		public function __selectWithBrowser(functionComplete_Event_:Function=null,getTypes_:String='allowAllFiles'):void
		{
			//var textFilter:FileFilter 		= new FileFilter(fileTypesDescription_,fileTypes_);
			fileRef							= new FileReference();
			fileRef.browse					(__getTypes(getTypes_));
			fileRef.addEventListener		(Event.SELECT, function (event:Event):void {fileRef.load();});
			
			fileRef.addEventListener(Event.COMPLETE,function(event:Event):void
			{
				new gnncPopUp().__close		(_pageLoading);
				var data:ByteArray 			= fileRef.data;
				_DATA_CONTENT 				= data.readUTFBytes(data.bytesAvailable);
				fileRef 					= null;			
			});
			
			fileRef.addEventListener		(HTTPStatusEvent.HTTP_STATUS, 		__downloadEvent);
			fileRef.addEventListener		(IOErrorEvent.IO_ERROR, 			__downloadEvent);
			fileRef.addEventListener		(ProgressEvent.PROGRESS,			__downloadProgress);
			fileRef.addEventListener		(SecurityErrorEvent.SECURITY_ERROR, __downloadEvent);
			
			if(functionComplete_Event_ != null)
				fileRef.addEventListener(Event.COMPLETE,functionComplete_Event_);
			
		}
		
		public function __writeWithBrowser(fileName_:String,fileExtension_:String,fileContent_:Object):void 
		{
			var _fileNameAndPath:String		= __clearSeparator(fileName_ + "." + fileExtension_);
			
			if(fileName_ && fileExtension_ && fileContent_)
			{
				fileRef	= new FileReference();
				fileRef.save(fileContent_, _fileNameAndPath);
			}
		}
		
		public function __download(url_:String,fileName_:String,fileExtension_:String,filePath_:String,deleteIfExistsFiles_:Boolean,openAfterDownload_:Boolean=true,locationSystem_:String='TMP',functionComplete_Event_:Function=null,functionIOErrorEvent_:Function=null):void
		{
			if(!url_)
			{
				new gnncAlert(_parent).__error('Não há Url.');
				loader.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				return;
			}
			
			if(url_.length<10)
			{
				new gnncAlert(_parent).__error('Url muito curta.');
				loader.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				return;
			}
			
			var loader:URLLoader 				= new URLLoader();
			loader.dataFormat 					= URLLoaderDataFormat.BINARY;
			loader.addEventListener				(ProgressEvent.PROGRESS, __downloadProgress);
			loader.addEventListener				(IOErrorEvent.IO_ERROR,	__downloadUrlIOError);
			loader.addEventListener				(Event.COMPLETE,
				function(e:Event):void
				{
					/*
					var air_file:File			= __selectedLocationToSave(fileName_,fileExtension_,filePath_,locationSystem_);
					var fs:FileStream 			= new FileStream();
					fs.open						(air_file, FileMode.WRITE);
					fs.writeBytes				(loader.data);
					fs.close					();
					air_file.downloaded 		= true;						
					if(openAfterDownload_) 		air_file.openWithDefaultApplication();
					*/
					
					_DATA_CONTENT				= (loader.data).toString();
					
					__write						(fileName_,fileExtension_,filePath_,deleteIfExistsFiles_,openAfterDownload_,locationSystem_,'',null,loader.data);
					
					new gnncPopUp().__close(_pageLoading);
				});
			
			loader.load(new URLRequest(url_ + '?' + Math.random()));
			
			if(functionComplete_Event_ != null)
				loader.addEventListener(Event.COMPLETE,functionComplete_Event_);
			
			if(functionIOErrorEvent_ != null)
				loader.addEventListener(IOErrorEvent.IO_ERROR,functionIOErrorEvent_);
		}
		
		public function __loadLargeFile(url_:String,paramsNamesAndValues_:Object=null,method_:String='POST',fComplete_Event_:Function=null,fIOErrorEvent_:Function=null):void
		{
			
			function __fFault(e:*):void
			{
				if(fIOErrorEvent_ != null)
					fIOErrorEvent_.call(null);
			}
			
			function __fResult(e:Event):void
			{
				var loader:URLLoader 	= URLLoader(e.target);
				_DATA_CONTENT			= loader.data;
				
				if(fComplete_Event_ != null)
					fComplete_Event_.call(null);
			}
			
			var e:URLRequest 			= new URLRequest(_noCacheFile ? url_ + '?' + Math.random() : url_);
			e.idleTimeout 				= 15000000;
			e.method					= method_;
			e.data						= gnncDataObject.__object2URLVariables(paramsNamesAndValues_);
			
			/*try 
			{
			e.load(_fileRequest);
			} 
			catch (error:Error) 
			{
			__handleIOErrorEvent();
			}*/
			
			var _load:URLLoader 		= new URLLoader(e);
			_load.addEventListener		(Event.COMPLETE,__fResult);
			_load.addEventListener		(IOErrorEvent.IO_ERROR,__fFault);
			_load.addEventListener		(SecurityErrorEvent.SECURITY_ERROR,__fFault);
			
		}
		
		public function __write(fileName_:String,fileExtension_:String,filePath_:String,deleteIfExistsFiles_:Boolean,openAfterSave_:Boolean,locationSystem_:String,contentUtf8_:String,contentObject_:Object=null,contentBytes_:ByteArray=null,functionUploadCompleteData_Event_:Function=null):void
		{
			var _fileSave:File				= __selectedLocationToSaveFile(fileName_,fileExtension_,filePath_,locationSystem_,deleteIfExistsFiles_);
			var fs:FileStream 				= new FileStream();
			
			fs.open							(_fileSave, FileMode.WRITE);
			//CONTENT_ 						= CONTENT_.replace(/\r/g, File.lineEnding);
			//fs.writeMultiByte				(CONTENT_, "utf-8"); //ASCII or utf-8
			
			if(contentObject_)
				fs.writeObject				(contentObject_);
			else if(contentBytes_)
				fs.writeBytes				(contentBytes_);
			else
				fs.writeUTFBytes			(contentUtf8_.toString());
			
			fs.close						();
			
			_fileSave.downloaded 			= true;
			
			if(openAfterSave_) 		
				_fileSave.openWithDefaultApplication();
			
			if(functionUploadCompleteData_Event_ != null)
				_fileSave.addEventListener	(DataEvent.UPLOAD_COMPLETE_DATA,functionUploadCompleteData_Event_);
		}
		
		public function __save():void
		{
			var _file:File;
			_file.browseForDirectory('123');
			_file.browseForSave('321');
		}
		
		public function __uploadJpg(fileName_:String,path_:String,bitmapData_:BitmapData,quality_:uint=90):void
		{
			var byteImage:ByteArray			= new ByteArray(); 
			var encoderJpg:JPEGEncoder 		= new JPEGEncoder(quality_);
			byteImage						= encoderJpg.encode(bitmapData_);
			
			var byteArray:ByteArray 		= new ByteArray();
			byteArray.writeMultiByte		(Base64.encode64(byteImage),gnncFileMimeType.__getMimeType('jpg'));
			
			__upload						(fileName_,'jpg',path_,byteArray);
		}
		
		public function __uploadPng(fileName_:String,path_:String,bitmapData_:BitmapData):void
		{
			var byteImage:ByteArray			= new ByteArray(); 
			var pngEnc:PNGEncoder 			= new PNGEncoder();
			byteImage						= pngEnc.encode(bitmapData_);
			
			var byteArray:ByteArray 		= new ByteArray();
			byteArray.writeMultiByte		(Base64.encode64(byteImage),gnncFileMimeType.__getMimeType('png'));
			
			__upload						(fileName_,'png',path_,byteArray);
		}
		
		public function __uploadComponentFlex(fileName_:String,path_:String,bitmapData_:BitmapData):void
		{
		}
		
		public function __uploadWav(fileName_:String,path_:String,byteArray:ByteArray):void
		{
			__upload						(fileName_,'wav',path_,byteArray);
		}
		
		public function __uploadUTF(fileName_:String,path_:String,contentText_:String):void
		{
			//trace("bytes.position is initially: " + bytes.position);     	// 0
			//trace("bytes.position is now: " + bytes.position);    		// 12
			
			var _byteArray:ByteArray 		= new ByteArray();
			_byteArray.writeUTFBytes		(contentText_);
			
			__upload						(fileName_,'txt',path_,_byteArray);
		}
		
		private function __upload(fileName_:String,fileExtension_:String,path_:String,content_:ByteArray):void
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
				"&_fileName=" 				+ fileName_+'.'+fileExtension_;
			
			var request:URLRequest 			= new URLRequest(urlServer);
			var loader:URLLoader 			= new URLLoader();
			
			request.contentType				= gnncFileMimeType.__getMimeType(fileExtension_);		
			request.method 					= URLRequestMethod.POST;
			request.data 					= content_;
			
			loader.addEventListener			(Event.COMPLETE,			__uploadComplete);
			loader.addEventListener			(IOErrorEvent.IO_ERROR,		__uploadIOError);
			loader.addEventListener			(ProgressEvent.PROGRESS,	__downloadProgress);
			loader.load						( request );
			
			return;
		}
		
		public function __remote(fileName_:String,fileExtension_:String,content_:ByteArray,methodWrite_:String='inline',target_:String='_blank'):void
		{
			var urlServer:String 			= gnncGlobalStatic._httpHost + gnncGlobalArrays.serverFileOpenRemote + '?' + Math.random() + 
				"&_fileName=" 				+ fileName_+'.'+fileExtension_ +
				"&_method=" 				+ methodWrite_;
			
			var header:URLRequestHeader 	= new URLRequestHeader ("Content-type","application/octet-stream");
			var myRequest:URLRequest 		= new URLRequest (urlServer);
			
			myRequest.requestHeaders.push 	(header);
			myRequest.method 				= URLRequestMethod.POST;
			myRequest.data 					= content_;
			
			navigateToURL 					( myRequest, target_ );
		}
		
		
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * WRITE AND DOWNLOAD - END
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * DELETE - START
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		public function __removePath(locationSystem_:String,path_:String):Boolean
		{
			path_ = path_ ? __clearSeparator(path_): '';
			
			var _file:File = __selectedLocationToSavePath(path_,locationSystem_);
			
			if(_file.exists)
			{
				_file.deleteDirectory(true);
				return true;
			}
			return false;
		}
		
		/** 
		 * ####################################################################### 
		 * ####################################################################### 
		 * 
		 * DELETE - END
		 * 
		 * ####################################################################### 
		 * ####################################################################### 
		 * **/
		
		
		
	}
}