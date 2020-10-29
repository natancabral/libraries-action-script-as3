package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncDataRand;
	import GNNC.data.encrypt.gnncMD5;
	import GNNC.data.file.itemRender.itemRender_files_forList;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.sql.gnncSql;
	import GNNC.gnncEmbedBlackWhite;
	import GNNC.sqlTables.table_attach;
	
	import flash.desktop.ClipboardFormats;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.controls.ProgressBar;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	import mx.graphics.SolidColor;
	import mx.managers.DragManager;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.List;
	import spark.primitives.Rect;
	
	[Event(name="uploadComplete", type="flash.events.Event")]
	
	public class gnncFileUpload extends Canvas
	{
		
		public static const IMAGEFILES:String 			= 'allowOnlyImages';
		public static const ADOBEFILES:String 			= 'allowOnlyAdobeFiles';
		public static const TEXTFILES:String 			= 'allowOnlyText';
		public static const ALLFILES:String 			= 'allowAllFiles';
		
		public var allowFileType:String 				= ALLFILES;
		
		public  var _parent:Object						= null;
		public  var _change:Boolean						= false;
		public  var _functionAfter_DataEvent:Function	= null;
		public  var _MIX:String 						= 'ATTACH';
		public  var _tableAttach:table_attach			= new table_attach();
		private var _connAttach:gnncAMFPhp				= new gnncAMFPhp();
		
		private var _allowMultiFilesSelects:Boolean 	= true;
		private var _allowOnlyAdobeFiles:Boolean 		= false;
		private var _allowOnlyImages:Boolean 			= false;
		private var _allowOnlyText:Boolean 				= false;
		private var _allowAllFiles:Boolean 				= true;
		private var _deniedFiles:Array					= [
			'bat','php','asp','cfm','java','exe','php3','php4','php5','php6','php7','php8','vbs','vb','vbe','htaccess','ini','cmd','inc','bash','bashrc',
			'csh','dash','ksh','sh','tcsh','zsh','py','jar','js','jse','vsmacros','com'
		];

		private var fileNativeList:File                 = new File();
		private var fileNativeListArray:Array           = new Array();
		
		private var fileRefList:FileReferenceList       = new FileReferenceList();
		private var currentFile:FileReference;
		private var currentFileIndex:Number 			= 0;
		private var filesToUpload:Array 				= new Array();
		private var uploadErrors:Array 					= new Array();
		private var uploadErrorsNoAllow:Array 			= new Array();
		//private var fileMegs:Number;
		
		private var bg:VBox;
		private var group:Group;
		private var Rec:Rect;
		private var TextDragDrop:Label;
		private var uploadButton:Button;
		private var selectButton:Button;
		private var removeButton:Button;
		private var closeButton:Button					= new Button();
		private var fileList:List;
		
		private var progressBox:VBox;
		private var progBar:ProgressBar;
		
		public var alertAllowDragDrop:String			= 'Você também pode arrastar e soltar os arquivos acima.';//, '+maxFileCount+' no máximo.';
		public var uploadButtonLabel:String 			= 'Enviar';
		public var selectButtonLabel:String 			= 'Selecionar Arquivos';
		public var removeButtonLabel:String 			= 'Remover da lista';
		public var buttonClose:String 					= "Fechar"
		public var maxFileCount:Number 					= 10;
		public var maxFileSize:Number 					= 5; // In megs (2*(1024*1024))
		public var requestUrl:String;
		public var barColor:String 						= '#F778DD';
		
		public function gnncFileUpload(parentApplication_:Object=null)
		{
			super();
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
			
		}
		
		public function get allowOnlyImages():Boolean
		{
			return _allowOnlyImages;
		}
		public function set allowOnlyImages(value:Boolean):void
		{
			this._allowOnlyImages 					= value;
			if ( value ){
				this.allowFileType 					= IMAGEFILES;
			}
		}
		
		public function get allowOnlyAdobeFiles():Boolean
		{
			return _allowOnlyAdobeFiles;
		}
		public function set allowOnlyAdobeFiles(value:Boolean):void
		{
			this._allowOnlyAdobeFiles 				= value;
			if ( value ){
				this.allowFileType 					= ADOBEFILES;
			}
		}
		
		public function get allowOnlyText():Boolean
		{
			return _allowOnlyText;
		}
		public function set allowOnlyText(value:Boolean):void
		{
			this._allowOnlyText 					= value;
			if ( value ){
				this.allowFileType 					= TEXTFILES;
			}
		}
		
		public function get allowAllFiles():Boolean
		{
			return _allowAllFiles;
		}
		public function set allowAllFiles(value:Boolean):void
		{
			this._allowAllFiles 					= value;
			if ( value ){
				this.allowFileType 					= TEXTFILES;
			}
		}
		
		/** Stage 1 **/
		/** Drag and Drop **/
		private function nativeDragEnter(e:NativeDragEvent) :void
		{
			if (e.clipboard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)){
				var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
				if (files.length <= maxFileCount){
					DragManager.acceptDragDrop(fileList)
				}
			}
		}
		
		/** Stage 1 **/
		/** Drag and Drop **/
		private function nativeDragDrop(e:NativeDragEvent) :void
		{
			// filereferencelist é utilizado somente pra browser, para dragdrop precias fazaer com filereference 
			var filesInArray:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			fileUpInListLoop(filesInArray,filesInArray.length);
		}
		
		/** Stage 2 **/
		private function fileMultiSelectHandler( event:FileListEvent ):void
		{
			var s:String = '';
			fileNativeListArray = event.files;
			
			if(fileNativeListArray.length==0)
				return;
			
			for (var i:uint = 0; i < event.files.length; i++){
				s += event.files[i].name+"\n";
				s += event.files[i].size+"\n";
				s += event.files[i].type+"\n";
				s += event.files[i].extension+"\n";
				//s += event.files[i].data+"\n"; //byteArray
			}
			gnncGlobalLog.__add(s,'multi selectFiles');

			//var fileRef:FileReference = new FileReference();
			//for (var e:uint = 0; e< && e<maxFileCount; e++){
			//	fileRef = fileNativeListArray[e];
			//	fileUpInList(fileRef);
			//}
			fileUpInListLoop(fileNativeListArray,fileNativeListArray.length);
		}
		
		/** Stage 2 **/
		private function fileSelectHandler( event:Event ):void
		{
			var s:String = '';
			var f:File = event.target as File;
			var files:Array = f.getDirectoryListing();
			for(var e:uint = 0; e < files.length; e++){
				s += files[e].name+"\n";
				s += files[e].size+"\n";
				s += files[e].type+"\n";
				s += files[e].extension+"\n";
				//s += event.files[i].data+"\n"; //byteArray
			}
			gnncGlobalLog.__add(s,'single selectFiles');
			
			//var fileRef:FileReference = new FileReference();
			//for (var i:uint = 0; i<fileRefList.fileList.length && i<maxFileCount; i++) {
			//	fileRef = fileRefList.fileList[i];
			//	fileUpInList (fileRef);
			//}
			fileUpInListLoop(fileRefList.fileList,fileRefList.fileList.length);
		}
		
		private function fileUpInListLoop(list:*,len:uint):void
		{
			var fileRef:FileReference = new FileReference();
			for (var i:uint = 0; i<len && i<maxFileCount; i++){
				fileRef = list[i] as FileReference;
				fileUpInList(fileRef);
			}
			
			var a:gnncAlert = new gnncAlert();
			a._width = 650;
			
			//if( len > maxFileCount || filesToUpload.length >= maxFileCount )
			//	uploadErrorsNoAllow.push("Há um limite de <b>"+maxFileCount+"</b> arquivos para envio.");
			if( uploadErrorsNoAllow.length > 0 )
				a.__alert(uploadErrorsNoAllow.join("\n"),'Arquivos não permitidos');
			if( filesToUpload.length > 0 )
				uploadButton.enabled = true;
			
			uploadErrorsNoAllow = new Array();
		}
		
		private function fileUpInList(fileRef:FileReference):void
		{
			gnncGlobalLog.__add(
				'FileSize:'+fileRef.size+"\n"+
				'Volume:'+gnncFilesRemote.__bytes2Legend(fileRef.size)+"\n"+
				'MaxFileSize:'+maxFileSize+"\n"+
				'|'+(maxFileSize*1024)+"\n"+
				'|'+(maxFileSize*(1024*1024))+"\n"+
				''
			);

			/** confirm file **/
			if( fileRef.size > (maxFileSize*(1024*1024)) ){
				uploadErrorsNoAllow.push("O arquivo <b>\""+String(fileRef.name).toLowerCase()+"\"</b> ultrapassou "+maxFileSize+" MB.");
				//gnncAlert.__alert("Você selecionou "+fileNativeListArray.length+" arquivos para enviar, sendo o máximo "+maxFileCount+" arquivos permitidos. Os primeiros "+maxFileCount+" serão enviados.");
			}
			else if( _deniedFiles.indexOf(fileRef.extension.toLowerCase()) > -1 ){
				uploadErrorsNoAllow.push("O arquivo <b>\""+String(fileRef.name).toLowerCase()+"\"</b> com extensão <b>"+fileRef.extension+"</b> é proibido pelo sistema.");
			}
			else if( filesToUpload.length >= maxFileCount ){
				uploadErrorsNoAllow.push("Há um limite de <b>"+maxFileCount+"</b> arquivos para envio.");
			}
			else{
				
				var name:String	= gnncMD5.hash(fileRef.name + Math.random()) + '.' + fileRef.extension;
				var _table:table_attach 	= new table_attach();
				_table.ID_KEY				= _tableAttach.ID_KEY ? _tableAttach.ID_KEY : gnncDataRand.__key();
				_table.ID_CLIENT 			= _tableAttach.ID_CLIENT;
				_table.ID_PROJECT			= _tableAttach.ID_PROJECT;
				_table.ID_STEP				= _tableAttach.ID_STEP;
				_table.ID_USER				= gnncGlobalStatic._userId;
				_table.ID_MIX				= _tableAttach.ID_MIX;
				_table.MIX					= _MIX;
				_table.NAME					= fileRef.name;
				_table.FILE_LINK			= name;
				_table.URL_LINK				= _tableAttach.URL_LINK;
				_table.FILE_HTTP			= gnncGlobalStatic._httpHost;
				_table.EXTENSION			= fileRef.extension;
				_table.SIZE					= fileRef.size;
				_table.DOWNLOAD_ENABLE		= 1;
				
				//set in array
				filesToUpload.push			({label:fileRef.name, data:fileRef, ext: fileRef.extension, size:fileRef.size,newFileName:name, table:_table});
				fileList.dataProvider		= new ArrayCollection(filesToUpload);
				fileList.selectedIndex 		= -1;
			}			
		}
		
		private function browseForFile(event:Event):void
		{
			if(filesToUpload.length >= maxFileCount ){
				new gnncAlert().__alert("É permitido enviar no máximo "+maxFileCount+" arquivos.",'Limite de envio');
				return;
			}
			
			fileNativeList = new File();
			
			if(_allowMultiFilesSelects==true){
				fileNativeList.browseForOpenMultiple('Selecione...',getTypes()); //multi
				fileNativeList.addEventListener     (FileListEvent.SELECT_MULTIPLE      ,fileMultiSelectHandler);
			}else{
				fileNativeList.browseForOpen		('Selecione...',getTypes()); //open
				fileNativeList.addEventListener		(Event.SELECT						,fileSelectHandler);
			}
			
			fileNativeList.addEventListener			(IOErrorEvent.IO_ERROR				,eventIOErrorUpLoad);
			fileNativeList.addEventListener			(SecurityErrorEvent.SECURITY_ERROR	,eventSecurityError);
			fileNativeList.addEventListener			(Event.COMPLETE						,completeToData);

			function completeToData(e:Event):void
			{
				fileNativeList.load();
				fileNativeList.data;
			}
		}
		
		protected function eventIOErrorUpLoad(e:*):void 
		{
			gnncGlobalLog.__add(e,'eventIOErrorUpLoad');
		}
		
		protected function eventSecurityError(e:*):void 
		{
		}
		
		private function uploadFiles( event:Event ):void
		{
			requestUrl 	= gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverFileUploadList + '?' + Math.random() + 
				"&_filePathServer="	+ '' + 
				"&_dataBaseName=" 	+ gnncGlobalStatic._dataBase +
				"&_fileName=" 		+ filesToUpload[currentFileIndex].newFileName;
			
			gnncGlobalLog.__add(requestUrl,'uploadFiles');
			
			if( gnncGlobalStatic._httpDomain == ''){
				new gnncAlert().__alert("O sistema não encontra o caminho do envio");
				return;
			}
			if ( currentFileIndex == 0 ){
				showProgress();
			}
			
			var request:URLRequest 					= new URLRequest();
			request.url 							= requestUrl;
			request.method 							= URLRequestMethod.POST;
			
			/** send vars **/
			/*var vars:URLVariables = new URLVariables();
			vars.name = 'NATAN IMAGEM';
			vars.bindata = Base64.encode64(imageData);
			request.method = "POST";
			//request.requestHeaders.push(sendHeader);
			var loader:URLLoader = new URLLoader();               
			loader.addEventListener(Event.COMPLETE, uploadPhotoHandler);
			request.data = vars;*/
			
			currentFile 							= new FileReference();
			currentFile 							= filesToUpload[currentFileIndex].data;
			currentFile.addEventListener			(ProgressEvent.PROGRESS, uploadProgressHandler);
			currentFile.addEventListener			(DataEvent.UPLOAD_COMPLETE_DATA, uploadCompleteHandler );    
			currentFile.addEventListener			(SecurityErrorEvent.SECURITY_ERROR, uploadIoErrorHandlerSecurity);
			
			// NO ULTIMO, executa a function
			if ( currentFileIndex == filesToUpload.length-1 && _functionAfter_DataEvent != null )
				currentFile.addEventListener		(DataEvent.UPLOAD_COMPLETE_DATA, _functionAfter_DataEvent);
			
			closeButton.enabled						= true;
			currentFile.addEventListener			(IOErrorEvent.IO_ERROR, uploadIoErrorHandler);
			
			try{
				gnncGlobalLog.__add('Up1','');
				currentFile.upload(request, "file", false);
			}catch(e:*){
				gnncGlobalLog.__add('Up2','');
				currentFile.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			}
		}
		
		private function uploadProgressHandler(event:ProgressEvent):void
		{
			var numPerc:Number 		= Math.round((Number(event.bytesLoaded) / Number(event.bytesTotal)) * 100);
			var fileCount:String 	= String( (currentFileIndex+1) +'/'+ filesToUpload.length );
			var fileName:String 	= filesToUpload[currentFileIndex].label;
			progBar.setProgress		(numPerc, 100);
			progBar.label 			= "Enviando " + fileCount + "  '"+fileName+"'     " + numPerc + "%";
			progBar.validateNow		();			
		}

		private function uploadCompleteHandler(event:DataEvent):void
		{
			var strData:String = String(event.data);
			var sql:String = '';
			
			if ( strData == 'result' ){
				sql = new gnncSql().__INSERT(filesToUpload[currentFileIndex].table);
				_connAttach.__sql(sql,'','');//Ocorreu um problema no registro do arquivo '+filesToUpload[currentFileIndex].label+'.'
				//ROWS_ATTACH_++;
				_change = true;
			}else{
				uploadErrors.push( ( String(strData) == 'fault' ? "Falha no envio:\n" : "Erro inesperado ("+strData+"):\n" ) + filesToUpload[currentFileIndex].label );
			}
			
			gnncGlobalLog.__add('fileUploadComplete:'+strData);
			currentFileIndex = currentFileIndex + 1;
			
			if ( currentFileIndex == filesToUpload.length ){
				this.uploadsCompleted();
			} else {
				this.uploadFiles(event);
			}
		}
		
		private function uploadsCompleted():void
		{
			var t:uint = filesToUpload.length;
			var e:uint = uploadErrors.length;
			if ( e > 0 ){
				new gnncAlert().__alert( "Erros ocorridos: " +  uploadErrors.join(";\n") );
				resetUploader();
			} else if( t > e ){
				var i:uint = ( t - e );
				var s:String = i > 1 ? ' arquivos enviados' : ' arquivo enviado' ;
				new gnncNotification().__show('Upload',i+s,gnncEmbedBlackWhite.check_32_green_ok);
			}
			this.dispatchEvent( new Event("uploadComplete", true) );
			resetUploader();
		}
		
		public function resetUploader():void
		{
			currentFileIndex 			= 0;
			filesToUpload 				= new Array();
			uploadErrors                = new Array();
			fileList.dataProvider 		= new ArrayCollection(filesToUpload);
			fileList.selectedIndex 		= -1;
			this.invalidateProperties	();
		}
		
		private function uploadIoErrorHandler(event:IOErrorEvent):void
		{
			gnncGlobalLog.__add('fileUploadError:'+event.text);
			this.dispatchEvent( new IOErrorEvent("uploadIoError", false,false,event.text) );
			new gnncNotification().__show('Tente mais tarde','Ocorreu um erro no envio do arquivo.',gnncEmbedBlackWhite.app_close_32_clean);
			resetUploader();
		}
		
		private function uploadIoErrorHandlerSecurity(event:SecurityErrorEvent):void
		{
			gnncGlobalLog.__add('fileUploadErrorSecurity:'+event.text);
		}
		
		private function showProgress():void
		{
			selectButton.enabled 			= false;
			uploadButton.enabled 			= false;
			removeButton.enabled 			= false;
			closeButton.enabled				= false;
			progressBox.visible 			= true;
			progressBox.includeInLayout 	= true;
			progressBox.width 				= fileList.width;
			progressBox.height 				= fileList.height;
			progressBox.x 					= fileList.x;
			progressBox.y 					= fileList.y;
			fileList.visible 				= false;
			fileList.includeInLayout 		= false;
			group.visible					= false;
		}
		
		private function removeFiles( event:Event ):void
		{
			var newArr:Array = new Array();
			for( var i:uint = 0; i<filesToUpload.length; i++){
				if ( i != fileList.selectedIndex ){
					newArr.push( filesToUpload[i] );
				}
			}
			filesToUpload 			= newArr;
			fileList.dataProvider 	= new ArrayCollection(filesToUpload);
			fileList.selectedIndex 	= -1;
			removeButton.enabled 	= false;
			if(filesToUpload.length == 0)
				uploadButton.enabled = false;
			
		}
		
		private function close():void
		{
			new gnncPopUp().__close(_parent);
		}
		
		private function closeWindow( event:MouseEvent ):void
		{
			close();
		}
		
		private function listSelectHandler( event:Event ):void
		{
			if ( fileList.selectedIndex >= 0 ) 
				removeButton.enabled = true;
		}
		
		private function getTypes():Array 
		{
			var allowTypes:Array;
			switch( this.allowFileType ){
				case ALLFILES:
				default:
					allowTypes = new Array(getImageTypeFilter(), getTextTypeFilter(), getAdobeTypeFilter());
					break;
				case IMAGEFILES:
					allowTypes = new Array(getImageTypeFilter());
					break;
				case TEXTFILES:
					allowTypes = new Array(getTextTypeFilter());
					break;
				case ADOBEFILES:
					allowTypes = new Array(getAdobeTypeFilter());
					break;
			}
			return allowTypes;
		}
		
		private function getImageTypeFilter():FileFilter {
			return new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png;*.*");
		}
		
		private function getTextTypeFilter():FileFilter {
			return new FileFilter("Text Files (*.txt, *.rtf)", "*.txt;*.rtf;*.*");
		}
		
		private function getAdobeTypeFilter():FileFilter {
			return new FileFilter("Adobe Files (*.ai, *.pdf, *.psd, *.flv, *.fla, *.swf, *.as)" , "*.ai;*.pdf;*.psd;*.flv;*.fla;*.swf;*.as;*.*");
		}
		
		override protected function createChildren():void
		{ 
			super.createChildren();
			
			bg 					= new VBox();
			addChild			( bg );
			
			fileList 			= new List();
			bg.addChild			( fileList );
			fileList.itemRenderer = new ClassFactory(itemRender_files_forList);
			
			fileList.setStyle	('padding-top',2);
			fileList.setStyle	('padding-left',2);
			fileList.setStyle	('padding-right',2);
			fileList.setStyle	('padding-botton',2);
			fileList.setStyle	('border-visible',false);
			fileList.setStyle	('borderVisible',false);
			
			/** Alert Drag Drop **/
			group 				= new Group();
			bg.addChild			( group );
			
			Rec 				= new Rect();
			group.addElement	( Rec );
			
			TextDragDrop		= new Label();
			group.addElement	( TextDragDrop );
			
			progressBox 		= new VBox();
			progBar 			= new ProgressBar();
			progressBox.addChild( progBar );
			bg.addChild			( progressBox );
			
			var hb:HGroup 		= new HGroup();
			hb.percentWidth 	= 100;
			hb.gap 				= 1;
			
			selectButton 		= new Button();
			hb.addElement		( selectButton );
			
			var rectg:Rect		= new Rect();
			rectg.percentWidth	= 100;
			hb.addElement		( rectg );
			
			removeButton 		= new Button();
			hb.addElement		( removeButton );
			
			uploadButton 		= new Button();
			hb.addElement		( uploadButton );
			
			//closeButton		= new Button();
			//hb.addElement		( closeButton );
			
			//var s:Spacer 		= new Spacer();
			//s.percentWidth 	= 100;
			//hb.addChild		( s );
			
			//close = new Button();
			//hb.addChild( close );
			
			bg.addChild			( hb );
			
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			//bg.width = 550;
			//bg.height = 350;
			bg.right 								= 0;
			bg.top 									= 0;
			bg.bottom 								= 0;
			bg.left 								= 0;
			bg.setStyle								("backgroundAlpha",0);
			
			group.percentWidth 						= 100;
			group.visible 							= true;
			group.height							= 30;
			Rec.fill								= new SolidColor(0x999999,1);//(0x00cc00,1); //(0x000000,.5)
			Rec.percentWidth						= 100;
			Rec.height								= 30;
			TextDragDrop.text						= alertAllowDragDrop;
			TextDragDrop.setStyle					('color',0xFFFFFF);
			TextDragDrop.setStyle					('fontSize',12);
			TextDragDrop.setStyle					('font-size',12);
			TextDragDrop.setStyle					('textAlign','center');
			TextDragDrop.setStyle					('text-align','center');
			TextDragDrop.verticalCenter				= 0;
			TextDragDrop.left						= 0;
			TextDragDrop.right						= 0;
			
			/*var imageUp:DIRECTION_UP				= new DIRECTION_UP();
			imageUp._COLOR							= 0xFFFFFF;
			imageUp.left							= 8;
			imageUp.verticalCenter					= 0;
			//imageUp.scaleX						= .8;
			group.addElement						(imageUp);*/
			
			selectButton.label 						= selectButtonLabel;
			selectButton.setStyle					("icon",gnncEmbedBlackWhite.bw_search_16);
			selectButton.setStyle					('fontWeight','bold');
			selectButton.setStyle					('font-weight','bold');
			selectButton.height						= 25;
			selectButton.enabled 					= true;
			selectButton.addEventListener			( MouseEvent.CLICK, browseForFile );
			
			uploadButton.label 						= uploadButtonLabel;
			uploadButton.setStyle					("icon",gnncEmbedBlackWhite.bw_ok_16);
			uploadButton.height 					= 25;
			uploadButton.enabled 					= false;
			uploadButton.addEventListener			( MouseEvent.CLICK, uploadFiles );
			uploadButton.setStyle					('fontWeight','bold');
			uploadButton.setStyle					('font-weight','bold');
			
			removeButton.label 						= removeButtonLabel;
			removeButton.setStyle					("icon",gnncEmbedBlackWhite.bw_delete_16);
			removeButton.height 					= 25;
			removeButton.enabled 					= false;
			removeButton.addEventListener			( MouseEvent.CLICK, removeFiles );
			
			closeButton.label 						= buttonClose;
			closeButton.setStyle					("icon",gnncEmbedBlackWhite.app_close_16_clean);
			closeButton.height 						= 25;
			closeButton.addEventListener			( MouseEvent.CLICK, closeWindow );
			
			fileList.percentWidth 					= 100;
			fileList.percentHeight 					= 100;
			fileList.setStyle						("backgroundAlpha",0.5);
			//fileList.rowCount 					= maxFileCount;
			fileList.visible 						= true;
			fileList.includeInLayout 				= true;
			fileList.addEventListener				( ListEvent.CHANGE, listSelectHandler );
			fileList.addEventListener				( NativeDragEvent.NATIVE_DRAG_ENTER, nativeDragEnter );
			fileList.addEventListener				( NativeDragEvent.NATIVE_DRAG_DROP, nativeDragDrop );
			
			progressBox.setStyle					('horizontalAlign','center');
			progressBox.setStyle					('verticalAlign','middle');
			progressBox.setStyle					('backgroundAlpha', 0 );
			progressBox.setStyle					('barColor','#FFFFFF');
			progressBox.visible 					= false;
			progressBox.includeInLayout 			= false;
			
			progBar.setStyle						('trackHeight',10);
			progBar.percentWidth 					= 90;
			progBar.mode 							= 'manual';
			progBar.setStyle						('barColor', barColor );
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
		
	}
}