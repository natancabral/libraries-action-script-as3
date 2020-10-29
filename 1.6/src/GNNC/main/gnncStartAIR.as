package GNNC.main
{
	import GNNC.application.gnncAppIconTray;
	import GNNC.application.gnncAppIcons;
	import GNNC.application.gnncAppResize;
	import GNNC.application.gnncAppUpdateRuntime;
	import GNNC.application.gnncApplication;
	import GNNC.data.bitmap.gnncBitmap;
	import GNNC.data.data.gnncDataBindable;
	import GNNC.data.file.gnncFileCookie;
	import GNNC.data.file.gnncFilesNative;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.others.gnncUrlNavegator;
	import GNNC.system.gnncMemory;
	
	import flash.display.NativeMenu;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	
	public class gnncStartAIR
	{
		/** ********************************************************* **/
		/** LIBRARY ************************************************* **/
		/** ********************************************************* **/
		
		private var _topLevel:Object 				= FlexGlobals.topLevelApplication;
		private var _parent:Object					= null;
		private var _startValues:gnncStartValues	= null;

		public function gnncStartAIR(parentApplication_:Object,programName_:String='',startValues_:gnncStartValues=null)
		{
			_startValues 							= startValues_;
			_parent 								= parentApplication_;
			
			gnncGlobalStatic._programName			= programName_; //Dont remove
			gnncGlobalStatic._programVersion		= gnncApplication.__getVersionNumber();

			super();
		}
		
		public function __preInitializeAIR():void
		{
			_topLevel.addEventListener				(FlexEvent.INITIALIZE,			__initializeAIR);
			_topLevel.addEventListener				(FlexEvent.APPLICATION_COMPLETE,__creationCompleteAIR);
			_topLevel.addEventListener				(Event.NETWORK_CHANGE,			__networkChangeAIR);
			_topLevel.addEventListener				(Event.CLOSE,					__closeAIR);
			_topLevel.addEventListener				(MouseEvent.RIGHT_MOUSE_DOWN,	__rightMouseDown);
			
			_topLevel.frameRate 					= _startValues.globalFrameRate;
		}
		
		private function __initializeAIR(e:FlexEvent):void
		{
			if(_startValues.windowsIcons) 			new gnncAppIcons				(_parent);
			if(_startValues.windowsResize) 			new gnncAppResize				(_parent);
			if(_startValues.windowsIconTry) 		new gnncAppIconTray				(_parent).__create();
			
			//clear all files in DOCS
			if(gnncFileCookie.__get('DAYBYDAY','DELETE_ALL_DOCS') == 'true') 		new gnncFilesNative().__removePath(gnncFilesNative._documentDirectory,"/GNNC");
		}
		
		private function __creationCompleteAIR(e:*):void
		{
			if(_startValues.windowsHideStatusBar)	gnncApplication.__statusBar();
			if(_startValues.windowsResize)			gnncApplication.__windowsResize(_startValues.windowsWidth,_startValues.windowsHeight,_startValues.windowsCenter);
			if(_startValues.windowsMaximized)		gnncApplication.__windowsMaximize(null);
			
			//update appVersion
			gnncGlobalStatic._programVersion		= gnncApplication.__getVersionNumber();

			//new session appUpdate
			//if(_topLevel.hasOwnProperty('_START'))
			new gnncDataBindable().__monitoring(_topLevel._START._gnncGlobal,'_session',__appUpdate);
			
			//buttom right mouse
			__rightMouseDown(null);
		}
		
		private function __appUpdate(e:*=null):void
		{
			if(_startValues.windowsUpdate) 
				new gnncAppUpdateRuntime().checkUpdate();
		}
		
		private function __networkChangeAIR(e:Event):void
		{
		}
		
		private function __closeAIR(e:Event):void
		{
			if(_startValues.windowsCloseAllInExit) 	
				gnncApplication.__windowsCloseAll(e);
			else
				gnncApplication.__windowsClose(e);
		}
		
		private function __rightMouseDown(e:MouseEvent):void
		{
			function __printScreen(event:Event):void
			{
				//new gnncBitmapSave().__savePng(_parent.parent,'PrintScreen',0);
				var _localSystemSave:String		= gnncFileCookie.__get('FILE_PRINTSCREEN','PATH') ? gnncFileCookie.__get('FILE_PRINTSCREEN','PATH').toString() : gnncFilesNative._documentDirectory;
				var _data:ByteArray 			= gnncBitmap.__captureBitmap2ByteArray(_parent.parent,0,true);
				var _nameFile:String			= 'PrintScreen - '+gnncGlobalStatic._programName+' - v'+gnncGlobalStatic._programVersion;

				new gnncFilesNative().__writeNative(_nameFile,'png','GNNC/PrintScreen',false,true,_localSystemSave,'',null,_data)
			}

			function __itemCompany(event:Event):void
			{
				gnncUrlNavegator.__navegatorUrl();
			}

			function __close(event:Event):void
			{
				gnncApplication.__windowsClose(event);
			}

			function __clearMemory(event:Event):void
			{
				gnncMemory.__clear();
			}

			var program:ContextMenuItem 		= new ContextMenuItem(gnncGlobalStatic._programName+' v'+gnncApplication.__getVersionNumber()	,false ,false);
			var memory:ContextMenuItem 			= new ContextMenuItem("Liberar Memória: " + gnncMemory.__used()									,true  ,true );
			var printSreen:ContextMenuItem 		= new ContextMenuItem("PrintScreen"																,true  ,true );
			//var itemApplication:ContextMenuItem = new ContextMenuItem("Aplicativo: " + gnncGlobalStatic._programName							,true  ,false);
			var itemPackage:ContextMenuItem 	= new ContextMenuItem("Pacote: DAYBYDAY"														,false ,false);
			var itemCompany:ContextMenuItem 	= new ContextMenuItem("Empresa: GNNC - Estratégia Empresarial"									,false ,true );
			var close:ContextMenuItem 			= new ContextMenuItem("Sair"																	,true  ,true );
			
			memory		.addEventListener		(Event.SELECT,__clearMemory);
			printSreen	.addEventListener		(Event.SELECT,__printScreen);
			//itemCompany	.addEventListener		(Event.SELECT,__itemCompany);
			close		.addEventListener		(Event.SELECT,__close);
			
			var IO:NativeMenu					= _parent.contextMenu;
			var contextMenuCustomItems:Array 	= IO.items;
			var i:uint							= 0;
			
			for(i=0; i<10; i++)
				contextMenuCustomItems.pop();
			
			contextMenuCustomItems.unshift		(program,memory,printSreen,/*itemApplication,*/itemPackage,itemCompany,close);
		}
	}
}
