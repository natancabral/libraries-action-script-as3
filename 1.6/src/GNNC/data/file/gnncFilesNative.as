package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.data.data.gnncData;
	import GNNC.data.date.gnncDate;
	import GNNC.data.encrypt.gnncMD5;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import com.adobe.images.PNGEncoder;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.graphics.ImageSnapshot;
	
	public class gnncFilesNative extends gnncFilesRemote
	{
		static public const _desktop:String 				= 'DSK';
		static public const _applicationDirectory:String 	= 'APP';
		static public const _applicationStorage:String 		= 'APS';
		static public const _documentDirectory:String 		= 'DOC';
		static public const _userDirectory:String 			= 'USE';
		static public const _tempPath:String 				= 'TMP';
		
		private var _file:File								= new File();
		private var _fileStream:FileStream					= new FileStream();
		private var _filePathNative:String					= ''; //C://user/ etc..

		public function gnncFilesNative(parentApplication_:Object=null,try_:Boolean=false)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
			_try = try_;
			_separator = File.separator;
		}
		
		static public function __string2ByteArray(s:String):ByteArray
		{
			var bArr:ByteArray = new ByteArray();
			bArr.writeUTF(s);
			return bArr;
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
		
		public function __selectedLocationToSavePath(pathOrPathAndFile_:String,locationSystem_:String='TMP'):File
		{
			/*var file:File = new File(); 
			file.nativePath = "C:\\AIR Test\\";*/
			
			_file = new File();
			
			if(pathOrPathAndFile_)
				
				switch(locationSystem_)
				{
					case 'DSK':		_file = File.desktopDirectory				.resolvePath(pathOrPathAndFile_);		break;
					case 'APP':		_file = File.applicationDirectory			.resolvePath(pathOrPathAndFile_);		break;
					case 'APS':		_file = File.applicationStorageDirectory	.resolvePath(pathOrPathAndFile_);		break;
					case 'DOC':		_file = File.documentsDirectory				.resolvePath(pathOrPathAndFile_);		break;
					case 'USE':		_file = File.userDirectory					.resolvePath(pathOrPathAndFile_);		break;
					case 'TMP':		_file = File.createTempDirectory()			.resolvePath(pathOrPathAndFile_);		break;
					default:		_file.nativePath = locationSystem_+'\\'+pathOrPathAndFile_; 								break;
				}
				
			else
				
				switch(locationSystem_)
				{
					case 'DSK':		_file = File.desktopDirectory;				break;
					case 'APP':		_file = File.applicationDirectory;			break;
					case 'APS':		_file = File.applicationStorageDirectory;	break;
					case 'DOC':		_file = File.documentsDirectory;			break;
					case 'USE':		_file = File.userDirectory;					break;
					case 'TMP':		_file = File.createTempDirectory();			break;
					default:		_file.nativePath = locationSystem_; 		break;
				}
			
			return _file;
		}
		
		public function __selectedLocationToSaveFile(fileName_:String,fileExtension_:String,filePath_:String,locationSystem_:String='TMP',deleteIfExistsFiles_:Boolean=false,forceChangeName_:Boolean=true,createIfNotExists_:Boolean=false):File
		{
			filePath_ 						= filePath_ ? filePath_ + File.separator : '';
			fileExtension_ 					= gnncData.__replace(fileExtension_,".","");
			
			var _fileNameAndPath:String		= __clearSeparator(filePath_ + fileName_ + "." + fileExtension_);
			_fileStream 					= new FileStream();
			var _data:String 				= '';
			
			_file = __selectedLocationToSavePath(_fileNameAndPath,locationSystem_);
			
			//_file.nativePath; 	//C:\a\b\c.jpg
			//_file.url; 			//app-storage:/c.jpg

			if(createIfNotExists_ && !_file.exists)
			{
				_fileStream.open			(_file, FileMode.WRITE);
				_fileStream.writeBytes		(new ByteArray());
				_fileStream.close			();
				
				_file = __selectedLocationToSavePath(_fileNameAndPath,locationSystem_);
			}
			
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
				
				return __selectedLocationToSaveFile(fileName_+_data,fileExtension_,filePath_,locationSystem_,deleteIfExistsFiles_,forceChangeName_);
			}
			
			return _file;
		}
		
		public function __fileExists(fileName_:String,fileExtension_:String,filePath_:String,locationSystem_:String='DOC'):Boolean
		{
			_file = __selectedLocationToSaveFile(fileName_,fileExtension_,filePath_,locationSystem_,false,false,false);
			return _file.exists;
		}
		
		public function __pathExists(filePath_:String,locationSystem_:String='DOC'):Boolean
		{
			_file = __selectedLocationToSavePath(filePath_,locationSystem_);
			return _file.exists;
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
		
		//gnncFilesRemote
		override protected function __eventFileSelected(event:Event):void 
		{
			_file.load();
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
		
		/**
		 * 
		 * load url file to _DATA_CONTENT (byteArray)
		 * load url file to _DATA_UTF (UTF)
		 * 
		 * **/
		public function __selectWithBrowserNative(fComplete_:Function=null,fIOError_:Function=null,title_:String='',multiSelectFiles_:Boolean=false):void 
		{
			_file		 						= new File();
			
			if(multiSelectFiles_){
				_file.browseForOpenMultiple		(title_ ? title_ : 'Selecione...'	,[_fileFilter]);
				_file.addEventListener          (FileListEvent.SELECT_MULTIPLE      ,__eventFileMultiSelected);
			}else{
				_file.browseForOpen				(title_ ? title_ : 'Selecione...'	,[_fileFilter]);
				_file.addEventListener			(Event.SELECT						,__eventFileSelected);
				_file.addEventListener			(Event.COMPLETE						,__completeToData);
			}
			
			_file.addEventListener				(IOErrorEvent.IO_ERROR				,__eventIOErrorUpLoad);
			_file.addEventListener				(SecurityErrorEvent.SECURITY_ERROR	,__eventSecurityError);
			_file.addEventListener				(Event.COMPLETE						,__eventComplete);
			
			if(fComplete_ != null)
				_file.addEventListener(Event.COMPLETE,fComplete_);
			
			if(fIOError_ != null)
				_file.addEventListener(IOErrorEvent.IO_ERROR,fIOError_);

			function __eventFileMultiSelected(event:FileListEvent):void
			{
				//_file.load();
				var s:String = '';
				_dataListFiles = event.files;
				for (var i:uint = 0; i < _dataListFiles.length; i++){
					s += _dataListFiles[i].name+"\n";
					s += _dataListFiles[i].size+"\n";
					s += _dataListFiles[i].type+"\n";
					s += _dataListFiles[i].extension+"\n";
					//s += event.files[i].data+"\n"; //byteArray
				}
				gnncGlobalLog.__add(s,'multi');

				_dataListFiles = new Array();
				if (event.files.length >= 1){
					_fileRef = new FileReference();
					for (var e:uint = 0; e<event.files.length; e++){
						_fileRef = _dataListFiles[e];
						_dataListFiles.push(_fileRef);
					}
				}
			}

			function __completeToData(e:Event):void
			{
				_DATA_EXTENSION					= _file.extension;
				_DATA_CONTENT 					= _file.data;
				_DATA_UTF 						= String(_file.data);
				//_DATA_UTF 						= gnncFilesRemote.__byteArray2UTF(null,_file.data);
			}

		}
		/*
		
		import flash.filesystem.*;
		import flash.events.FileListEvent;
		
		var docsDir:File = File.documentsDirectory;
		try
		{
		docsDir.browseForOpenMultiple("Select Files");
		docsDir.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);
		}
		catch (error:Error)
		{
		trace("Failed:", error.message);
		}
		
		function filesSelected(event:FileListEvent):void 
		{
		for (var i:uint = 0; i < event.files.length; i++) 
		{
		trace(event.files[i].nativePath);
		}
		}
		*/
		
		public function __saveWithBrowserNative(fileName_:String,fileExtension_:String,fileContent:Object,locationSystem_:String,title_:String='',openAfterSave_:Boolean=false):void 
		{	
			if(!fileName_ && !fileExtension_ && !fileContent)
				return;
			
			_file = new File();
			_file					= __selectedLocationToSaveFile(fileName_,fileExtension_,'',locationSystem_,false,true,false);
			_file.addEventListener	(Event.SELECT,__fSelect);
			_file.browseForSave		(title_ ? title_ : 'Salvar...');
			
			function __fSelect(e:*):void
			{
				_fileStream						= new FileStream();
				_fileStream.open				(_file, FileMode.WRITE);
				
				if(fileContent is ByteArray)
					_fileStream.writeBytes		(fileContent as ByteArray);
				else if(fileContent is String)
					_fileStream.writeMultiByte	(fileContent as String,'iso-8859-1');
				else
					_fileStream.writeObject		(fileContent);
				
				_fileStream.close				();
				
				if(openAfterSave_) 		
					_file.openWithDefaultApplication();
			}
			
			//_file = new File();
			//_file.save(fileContent_, _fileNameAndPath);
		}
		
		public function __loadUrlAndWriteFile(url_:String,fileName_:String,fileExtension_:String,filePath_:String,deleteIfExistsFiles_:Boolean,openAfterDownload_:Boolean=true,locationSystem_:String='TMP',fComplete_:Function=null,fIOError_:Function=null,fPercentProgress_:Function=null):void
		{
			__loadUrl(url_,__fComplete,fIOError_,null,'POST',false,fPercentProgress_);
			
			function __fComplete(e:*):void
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
				
				__writeNative(fileName_,fileExtension_,filePath_,deleteIfExistsFiles_,openAfterDownload_,locationSystem_,'',null,_DATA_CONTENT as ByteArray,fComplete_);
			}
		}
		
		public function __saveUrlWithBrowserNative(url_:String,fileName_:String,fileExtension_:String,locationSystem_:String,title_:String='',openAfterSave_:Boolean=false):void 
		{
			var _fileNameAndPath:String			= __clearSeparator(fileName_ + "." + fileExtension_);
			
			if(!fileName_ && !fileExtension_ && !url_)
				return;
			
			__loadUrl(url_,__fComplete,__fIOError);
			
			function __fComplete(e:*):void
			{
				//_file							= __selectedLocationToSavePath(_fileNameAndPath,locationSystem_);
				//_file							= __selectedLocationToSaveFile(fileName_,fileExtension_,'',locationSystem_);
				_file = new File();
				_file							= File.documentsDirectory.resolvePath(_fileNameAndPath);
				_file.addEventListener			(Event.SELECT, __onBrowse);
				_file.browseForSave				(title_ ? title_ : 'Salvar...');
				
				function __onBrowse(e:*):void
				{
					var _fileFinal:File = File(e.target); 
					//_file = File(e.target);
					_fileStream = new FileStream();
					
					try
					{
						_fileStream.open(_fileFinal,FileMode.WRITE);
						_fileStream.writeBytes(_DATA_CONTENT as ByteArray);                    
						_fileStream.close();
						
						if(openAfterSave_)
							_file.openWithDefaultApplication();
						
					}
					catch(e:Error)
					{
						gnncGlobalLog.__add(url_);
						gnncGlobalLog.__add(''+e.message);
						new gnncAlert().__error(String(e.message),'Problema ao salvar o arquivo #1');
					}
					
				}
			}
			
			function __fIOError(e:IOErrorEvent):void
			{
				gnncGlobalLog.__add(url_);
				gnncGlobalLog.__add(''+e.text);
				new gnncAlert().__error(String(e.text),'Problema ao salvar o arquivo #2');
			}
		}
		
		public function __writeNative(fileName_:String,fileExtension_:String,filePath_:String,deleteIfExistsFiles_:Boolean,openAfterSave_:Boolean,locationSystem_:String,contentUtf8_:String,contentObject_:Object=null,contentBytes_:ByteArray=null,functionUploadCompleteData_Event_:Function=null):void
		{
			_file							= new File();
			_fileStream						= new FileStream();
			
			_file							= __selectedLocationToSaveFile(fileName_,fileExtension_,filePath_,locationSystem_,deleteIfExistsFiles_);
			_file.downloaded 				= true;
			
			//async -> Read or UpDate
			if(functionUploadCompleteData_Event_ != null)
			{
				_fileStream.addEventListener(Event.COMPLETE,functionUploadCompleteData_Event_);
			}
			
			_fileStream.addEventListener	(Event.COMPLETE,__fComplete);
			_fileStream.open				(_file, FileMode.WRITE);
			//_fileStream.open				(_file, FileMode.UPDATE);
			
			function __fComplete(e:*):void
			{
				if(contentObject_)
					_fileStream.writeObject		(contentObject_);
				else if(contentBytes_)
					_fileStream.writeBytes		(contentBytes_);
				else
					_fileStream.writeMultiByte	(contentUtf8_,'iso-8859-1');
				
				_fileStream.close				();
				
				if(openAfterSave_) 		
					_file.openWithDefaultApplication();				
			}
			
			_fileStream.dispatchEvent	(new Event(Event.COMPLETE));
		}
		
		public function __save2Upload(
			fileName:String,
			fileExtension:String,
			filePath:String,
			locationSystem:String,
			contentByteArray:ByteArray=null,
			functionUploadComplete:Function=null,
			functionUploadError:Function=null,
			deleteAfterUpload:Boolean=true
		):void
		{
			var extension:String = fileExtension;
			var imageBitmapData:ImageSnapshot;
			
			__writeNative(fileName,fileExtension,filePath,true,false,locationSystem,'',null,contentByteArray,fComplete);
			
			function fComplete(e:Event):void
			{
				var name:String = fileName+'.'+fileExtension;
				var requestUrl:String;
				var file:File = __selectedLocationToSavePath('',locationSystem); 
				file = file.resolvePath(filePath+'/'+name);
				
				//file.nativePath; //(read local);
				//file.data; //();
				//file.name

				requestUrl = gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverFileUploadList + '?' + Math.random() + 
					"&_filePathServer="		+ '' + 
					"&_dataBaseName=" 		+ gnncGlobalStatic._dataBase +
					"&_fileName=" 			+ name;
				
				var request:URLRequest 	= new URLRequest();
				request.url 			= requestUrl;
				request.method 			= URLRequestMethod.POST;
				
				//new URLRequest(File.documentsDirectory.resolvePath('image.jpg').url )
				
				_fileRef = new FileReference();
				_fileRef = file;
				_fileRef.addEventListener			(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteHandler );
				
				_fileRef.addEventListener			(HTTPStatusEvent.HTTP_STATUS, 		__eventFileRef);
				_fileRef.addEventListener			(ProgressEvent.PROGRESS, 			__eventProgress);
				_fileRef.addEventListener			(IOErrorEvent.IO_ERROR, 			__eventIOErrorLoad);
				_fileRef.addEventListener			(SecurityErrorEvent.SECURITY_ERROR, __eventSecurityError);
				_fileRef.addEventListener			(Event.COMPLETE, 					__eventComplete);

				try{
					_fileRef.upload(request,"file",false);
				}catch(e:*){
					_fileRef.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				}
				
				function uploadCompleteHandler(event:DataEvent):void
				{
					var strData:String = String(event.data);
					if (strData == 'result'){
						gnncGlobalLog.__add('uploadComplete');
						if(functionUploadComplete!=null){
							if(event==null || !event){
								functionUploadComplete.call();
							}else{
								event = null
								functionUploadComplete.call(event);
							}
						}
						if(deleteAfterUpload)
							file.deleteFile();
					}else{
						gnncGlobalLog.__add('uploadError:'+strData);
						if(functionUploadError!=null){
							if(event==null || !event){
								functionUploadError.call();
							}else{
								event = null
								functionUploadError.call(event);
							}
						}
					}
				}

			}
			
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
		
		public function __removePath(locationSystem_:String,path_:String,deleteOnlyContentNoPath_:Boolean=true):Boolean
		{
			path_ = path_ ? __clearSeparator(path_): '';
			_file = __selectedLocationToSavePath(path_,locationSystem_);
			
			if(deleteOnlyContentNoPath_){
				var _list:Array = _file.getDirectoryListing();
				for (var i:uint = 0; i < _list.length; i++) {
					_file = __selectedLocationToSavePath(path_+"/"+_list[i].name,locationSystem_);
					if(_file.isDirectory)
						_file.deleteDirectory(true);
					else
						_file.deleteFile(); 
				}
				return true;
			}
			
			if(_file.exists){
				_file.deleteDirectory(true);
				return true;
			}
			return false;
		}
		
		public function __openPath(locationSystem_:String,path_:String):void
		{
			var directoryApp:File = new gnncFilesNative().__selectedLocationToSavePath(path_,locationSystem_);
			
			if(directoryApp.exists)
			{
				//directoryApp.load();
				directoryApp.openWithDefaultApplication();
			}
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