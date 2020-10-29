package GNNC.application
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.data.data.gnncClipBoard;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.data.gnncDataXml;
	import GNNC.data.data.json.gnncJSON;
	import GNNC.data.file.gnncFileCookie;
	import GNNC.data.file.gnncFilesNative;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.gnncEmbedBlackWhite;
	import GNNC.gnncEmbedImage;
	import GNNC.others.gnncUrlNavegator;
	import GNNC.time.gnncTime;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.graphics.SolidColor;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;
	import spark.primitives.Rect;
	
	public class gnncAppUpdateRuntime 
	{
		private var _parent:Object				= null;
		private var _gnncFile:gnncFilesNative	= new gnncFilesNative();
		private var _gnncAppWin:gnncAppWindow	= null;
		
		/** 
		 * _cookieBeforeAction
		 * 
		 * E 	= Executable Open
		 * P 	= Path Open
		 * EP 	= Executable and Path Open
		 * N 	= None
		 * **/

		private var _cookieBeforeAction:String	= '';
		private var _saveUpdateDocument:String	= '';
		private var _urlDownload:String			= '';
		private var _urlDynamic:String			= '';

		public  var _appVersion:Number 			= 0;	
		public  var _newVersion:Number 			= 0;
		public  var _minVersion:Number 			= 0; //min version
		
		private var openFile:Boolean			= true;
		private var fileName:String			    = '';

		private var forceDownload:Boolean		= false;
		private var forceFromNavigator:Boolean  = false;
		private var showAlert:Boolean			= false;
		
		private var ALL:Group 					= new Group();
		private var BLK:Group					= new Group();
		private var BOX:Rect					= new Rect();
		private var VGR:VGroup					= new VGroup();
		private var HGR:HGroup					= new HGroup();
		//private var IMG:Image					= new Image();
		private var LBT:Label					= new Label();
		private var LBL:Label					= new Label();
		private var LB2:Label					= new Label();
		private var BTN:Button					= new Button();
		private var BTC:Button					= new Button();
				
		public function gnncAppUpdateRuntime(parentApplication_:Object=null)
		{
			/**
			 * 
			 * var updater:Updater = new Updater();
			 * var airFile:File = File.desktopDirectory.resolvePath("Sample_App_v2.air");
			 * var version:String = "2.01";
			 * updater.update(airFile, version);
			 *  
			 * **/
			
			_parent 		= parentApplication_?parentApplication_:gnncGlobalStatic._parent;
			_gnncAppWin		= new gnncAppWindow(_parent);
			
			_cookieBeforeAction = gnncFileCookie.__get('DAYBYDAY','UPDATE')  ? gnncFileCookie.__get('DAYBYDAY','UPDATE').toString()  : 'E';
			_saveUpdateDocument = gnncFileCookie.__get('FILE_UPDATE','PATH') ? gnncFileCookie.__get('FILE_UPDATE','PATH').toString() : gnncFilesNative._documentDirectory;

		}

		private function getUrlVersion():String
		{
			return gnncGlobalArrays.serverUpdatePath + gnncGlobalArrays.serverUpdateFile;
			return gnncGlobalArrays.serverUpdatePath + 'gnnc-daybyday-update-' + String(gnncGlobalStatic._programName).toLowerCase() + '.xml';
		}

		public function checkUpdate(showMessage_:Boolean=false,forceDownload_:Boolean=false,forceFromNavigator_:Boolean=false):void
		{
			forceDownload = forceDownload_;
			forceFromNavigator = forceFromNavigator_;
			
			if(_gnncAppWin)
				_gnncAppWin.__closeNative();
			
			//_gnncFileXml._allowGlobalError = false;
			//_gnncFileXml.__load(getUrlVersion(),false,null,checkFResult,checkFFault);
			
			_gnncFile._allowGlobalError = false;
			//_gnncFile._allowGlobalLoading = false;
			_gnncFile.__loadUrl(getUrlVersion(),checkFResult,checkFFault);

			gnncGlobalLog.__add(getUrlVersion(),'CheckUpdateURL');
		}

		private function checkFResult(event:*):void
		{
			/*
			<url>        https://gnnc.com.br/daybyday/download/SetupDaybydayProject.exe</url>
			<urlAir>     https://gnnc.com.br/daybyday/download/SetupDaybydayProject.air</urlAir>
			<urlUpdate>  https://gnnc.com.br/daybyday/download/SetupDaybydayProject.exe</urlUpdate>
			<urlDynamic> https://gnnc.com.br/daybyday/download/?f=Project</urlDynamic>
			*/

			var updStr:String   = '';

			if(gnncDataXml.__isValidXML(_gnncFile._DATA_UTF))
			{
				//var updXML:XML 	= new XML(_gnncFileXml.DATA_XML);
				var updXML:XML 		= new XML(_gnncFile._DATA_UTF);
				var updNs:Namespace = updXML.namespace();

				_appVersion	= Number(gnncApplication.__getVersionNumber());
				_newVersion	= Number(updXML.updNs::versionNumber[0]);
				_minVersion	= Number(updXML.updNs::minVersionNumberAllowed[0]); //min versao aceita, bloqueia os anteriores
				
				if(gnncAppOS.__get('win')){
					_urlDownload = updXML.updNs::urlUpdate[0];
					_urlDownload = updXML.updNs::url[0];
				}else if(gnncAppOS.__get('mac')){
					_urlDownload = updXML.updNs::urlAir[0];
				}
				
				_urlDynamic = updXML.updNs::urlDynamic[0];
				
				updStr += 'AppName: ' 		+ gnncApplication.__getName()	+ "\n";
				updStr += 'appVersion: ' 	+ _appVersion					+ "\n";
				updStr += 'newVersion: ' 	+ _newVersion					+ "\n";
				updStr += 'minVersion: ' 	+ _minVersion                   + "\n";
				updStr += 'url: ' 			+ updXML.updNs::url[0]			+ "\n";
				updStr += 'urlAir: '		+ updXML.updNs::urlAir[0]		+ "\n";
				updStr += 'urlUpdate: '		+ updXML.updNs::urlUpdate[0]	+ "\n";
				updStr += 'urlDynamic: '	+ updXML.updNs::urlDynamic[0]	+ "\n";
			}
			else
			{
				var o:Object = gnncJSON.decode(_gnncFile._DATA_UTF); //JSON.parse(_gnncFile._DATA_UTF);
				var updJson:ArrayCollection = gnncJSON.object2ArrayCollection(o);
				var updApps:ArrayCollection = gnncDataObject.__object2ArrayCollection(updJson.getItemAt(0)['apps'] as Object);
				var updName:ArrayCollection = new gnncDataArrayCollection().__filter(updApps,'name',gnncGlobalStatic._programName);
				var updData:Object = updName.length == 1 ? updName.getItemAt(0) : null ;

				//new gnncAlert().__dataGrid(updJson,'updJson');
				//new gnncAlert().__dataGrid(updApps,'updApps');
				//new gnncAlert().__dataGrid(updName,'updName');

				/*
				var o:Object = gnncJSON.decode(_gnncFile._DATA_UTF); //JSON.parse();
				var updJson:Object = o['apps'] as Object;
				var updApps:Object = gnncDataObject.__objectFilter(updJson,'name',gnncGlobalStatic._programName);
				var updData:Object = updApps == null ? null : updApps[0] ;
				*/
				
				if( updData == null ){
					afterError();
					gnncGlobalLog.__add(_gnncFile._DATA_UTF);
					return;
				}

				_appVersion	= Number(gnncApplication.__getVersionNumber());
				_newVersion	= Number(updData['lastVersion']);
				_minVersion	= Number(updData['minVersionAllowed']); //min versao aceita, bloqueia os anteriores
				
				if(gnncAppOS.__get('win')){
					_urlDownload = updData['url'];
				}else if(gnncAppOS.__get('mac')){
					_urlDownload = updData['urlAir'];
				}
				
				_urlDynamic = updData['urlDynamic'];
				
				updStr += 'AppName: ' 		+ gnncApplication.__getName() 	+ "\n";
				updStr += 'appVersion: ' 	+ _appVersion					+ "\n";
				updStr += 'newVersion: ' 	+ _newVersion					+ "\n";
				updStr += 'minVersion: ' 	+ _minVersion         			+ "\n";
				updStr += 'url: ' 			+ updData['url']				+ "\n";
				updStr += 'urlAir: '		+ updData['urlAir']				+ "\n";
				updStr += 'urlDynamic: '	+ updData['urlDynamic']			+ "\n";
			}

			direction();
			
			gnncGlobalLog.__add(updStr,'LoadUpdateFile');
		}

		private function direction():void
		{
			fileName = gnncGlobalArrays.appUpdateFileName;
			fileName = fileName.replace('{{programName}}',gnncGlobalStatic._programName);
			fileName = fileName.replace('{{version}}',_newVersion);
			
			if(_appVersion < _minVersion){
				_parent.enabled = false;
				new gnncAlert(_parent).__alert('Versão mínima: ' + _minVersion + ".\nSua versão atual é " + _appVersion );
			}

			if(forceDownload)
			{
				download(_parent);
			}
			else if(_appVersion < _newVersion)
			{
				_gnncAppWin.__creationWindows(__block() as IVisualElement,400,400,'Update - '+gnncGlobalStatic._programName,true);
			}
			else if(_appVersion == _newVersion)
			{
				if(showAlert) new gnncAlert(_parent).__alert('Sua versão é atualizada: v' + _appVersion );
			}
			else if(_appVersion > _newVersion)
			{
				if(showAlert) new gnncAlert(_parent).__alert('Sua versão é mais atual que a disponível.');
			}
			else{
				new gnncAlert(_parent).__alert("Não foi possível verificar atualização.\nAcesse: www.gnnc.com.br","Atualização");
			}
		}
		
		private function existsRunTime():Boolean
		{
			var gnncRunTimeExist:Boolean = false;
			//file update and directory download v
			var gnncN:String = gnncGlobalArrays.appProgramFilesGroup;
			var pathN:String = gnncData.__replace(gnncGlobalArrays.appProgramFiles,'{{programName}}',String(gnncGlobalStatic._programName).toUpperCase());
			var fileN:String = gnncGlobalArrays.appAdobeRunTime;
			var listN:Array  = [ gnncN+pathN+fileN , pathN+fileN , fileN ];
			
			//Check if exist Air Runtime
			for(var i:uint=0; i<listN.length; i++){
				var fileSetting:File = File.applicationDirectory.resolvePath(listN[i]);
				if(fileSetting.exists)
					gnncRunTimeExist = true;
			}
			
			return gnncRunTimeExist;
		}
		
		private function checkFFault(event:*):void
		{
			BTN.enabled = true;
		}

		private function download(parentApplication_:Object):void
		{
			if( !_urlDownload ){
				afterError();
				return;
			}

			if(_cookieBeforeAction.indexOf('N') > -1 || _cookieBeforeAction == 'N' || forceFromNavigator == true ){
				new gnncNotification().__show('Download','O download iniciará pelo navegador.', gnncEmbedBlackWhite.bw_global_32,null,false,true,false,true,60);
				gnncUrlNavegator.__navegatorUrl(_urlDownload);
				_gnncAppWin.__closeWindow();
				return;
			}
						
			BTN.enabled = false;  //false
			BTC.enabled = false; 
			LB2.text = "Carregando...";

			var ext:Array = String(_urlDownload).split('.'); ext.reverse();
			
			openFile = _cookieBeforeAction.indexOf('E') > -1 ? true : false;
			
			_gnncFile = new gnncFilesNative(parentApplication_);
			_gnncFile._allowGlobalLoading = forceDownload ? true : false ;
			_gnncFile._hideCloseButtonLoading = true;
			_gnncFile.__loadUrlAndWriteFile( 
				_urlDownload, 
				fileName, 
				ext[0], 
				gnncGlobalArrays.appUpdateDownload, 
				true, 
				openFile, 
				_saveUpdateDocument, 
				afterDownload,
				afterError,
				fPercentProgress
			);
			
			function fPercentProgress(e:*=null):void
			{
				LB2.text = _gnncFile._percentLabel;
			}
			
			//if(_gnncAppWin && !forceDownload)
			//	_gnncAppWin._window.minimize();

			gnncGlobalLog.__add(_urlDownload,'DownloadFile');
		}
		
		private function afterDownload(event:*=null):void
		{
			var directoryApp:File = new gnncFilesNative().__selectedLocationToSavePath(gnncGlobalArrays.appUpdateDownload,_saveUpdateDocument);
			if(directoryApp.exists && _cookieBeforeAction.indexOf('P') > -1){
				//directoryApp.load();
				directoryApp.openWithDefaultApplication();
			}
			new gnncTime().__start(3000,__closeApp,5);
			LBL.text = '';
			LB2.text = 'Aguarde, iniciando atualização...';
		}
		
		private function afterError(event:*=null):void
		{
			new gnncNotification().__show('Falha no download','Url do arquivo não encontrada',gnncEmbedBlackWhite.app_close_32_clean);
			if(_gnncAppWin && !forceDownload)
				_gnncAppWin.__closeWindow();
		}
		
		private function __closeApp():void
		{
			if(gnncAppOS.__get('win')){
				_gnncAppWin.__closeWindow();
				return;
			}
			gnncApplication.__windowsCloseAll();
		}
		
		private function __block():DisplayObject
		{
			ALL.percentHeight 		= 100;
			ALL.percentWidth 		= 100;

			BLK.percentWidth		= 100;
			BLK.percentHeight		= 100;
			BLK.addEventListener	(MouseEvent.RIGHT_MOUSE_DOWN,function(e:MouseEvent):void{  }); //Dont Remove!
			
			BOX.percentHeight 		= 100;
			BOX.percentWidth 		= 100;
			BOX.fill				= new SolidColor(0xFFFFFF,.9);
			
			VGR.width				= 240;
			VGR.horizontalCenter	= 0;
			VGR.verticalCenter		= 0;
			VGR.gap					= 10;
			
			//IMG.source				= gNial.EMBEDS.IMAGE.UPDATE_BUTTON;
			
			LBT.text				= 'Atualização';
			LBT.setStyle			('color',0x000000);
			LBT.setStyle			('fontSize',22);
			
			LBL.setStyle			('color',0x000000);
			LBL.setStyle			('fontSize',12);
			LBL.setStyle			('fontWeight','bold')
			LBL.percentWidth		= 100;
			LBL.text				= "Sua atual versão é  " + _appVersion + " , atualize para  " + _newVersion + ".";
			
			LB2.setStyle			('color',0x000000);
			LB2.setStyle			('fontSize',12);
			LB2.setStyle			('fontWeight','bold')
			LB2.percentWidth		= 100;
			LB2.text				= "A atualização é necessária para o completo funcionamento do aplicativo "+gnncGlobalStatic._programName+". \n\nDeseja atualizar este aplicativo?";
			
			BTN.label				= "Não. Fechar janela.";
			BTN.height				= 40;
			//BTN.setStyle			('icon',gNial.EMBEDS.IMAGE.REMOVE_16);
			//BTN.addEventListener	(MouseEvent.CLICK,function(event:MouseEvent):void{ _parent.removeElement(BLK); _parent.removeElement(VGR); });
			BTN.addEventListener	(MouseEvent.CLICK,function(event:MouseEvent):void{ _gnncAppWin.__closeWindow(); });
			
			BTC.label				= "Sim, desejo atualizar";
			BTC.setStyle			('fontSize',11);
			BTC.setStyle			('fontWeight','bold')
			BTC.height				= 40;
			//BTC.setStyle			('icon',gNial.EMBEDS.IMAGE.OK_16_BLUE); 
			BTC.addEventListener	(MouseEvent.CLICK,__goUpdate);
			
			function __goUpdate(event:MouseEvent):void
			{ 
				download(ALL); 
			}
			
			var labelNavigator:Label = new Label();
			labelNavigator.text      = 'Download pelo navegador (recomendado)';
			labelNavigator.setStyle  ('color',0x3785e2);
			labelNavigator.setStyle	 ('fontWeight','bold')
			labelNavigator.setStyle	 ('verticalAlign','middle')
			labelNavigator.height   = 20;
			labelNavigator.buttonMode = true;
			labelNavigator.percentWidth = 100;
			labelNavigator.addEventListener	(MouseEvent.CLICK,downloadNavigator);

			function downloadNavigator(event:MouseEvent):void
			{ 
				gnncUrlNavegator.__navegatorUrl(_urlDownload);
				gnncClipBoard.__copyText(_urlDynamic);
				_gnncAppWin.__closeWindow();
			}
			
			HGR.percentWidth		= 100;
			HGR.setStyle			('fontSize',11);
			HGR.setStyle			('fontWeight','bold')
			HGR.gap					= 1;
			
			HGR.addElement			(BTC);
			HGR.addElement			(BTN);
			
			VGR.addElement			(LBT);
			VGR.addElement			(LBL);
			//VGR.addElement			(IMG);
			VGR.addElement			(LB2);
			VGR.addElement			(HGR);

			VGR.addElement			(labelNavigator);

			BLK.addElement			(BOX);
			
			//new gnncAppWindow().__creationNative(
			ALL.addElement			(BLK);
			ALL.addElement			(VGR);
			
			return ALL;
		}
		
	}
}