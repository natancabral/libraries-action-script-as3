package GNNC.application //import flash.net.navigateToURL; //LINK
{
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.gnncEmbedLogo;
	
	import com.hurlant.math.bi_internal;
	
	import flash.desktop.DockIcon;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.events.Event;
	import flash.events.ScreenMouseEvent;
	
	import mx.core.FlexGlobals;
	
	public class gnncAppIconTray
	{
		public var icon16:Class;
		public var icon32:Class;
		public var icon48:Class;
		public var icon128:Class;

		private var nativeMenu:NativeMenu;
		private var subMenu:NativeMenu;
		private var appWindow:gnncAppWindow = new gnncAppWindow()
		
		public function gnncAppIconTray(parentApplication_:Object)
		{
		}
		
		public function __create():void
		{	
			gnncEmbedLogo.__programName(gnncGlobalStatic._programName);
			icon16  = gnncEmbedLogo.LOGO_16;
			icon32  = gnncEmbedLogo.LOGO_32;
			icon48  = gnncEmbedLogo.LOGO_48;
			icon128 = gnncEmbedLogo.LOGO_128;
			
			/** Set up the icon and menus. **/
			__setUpIcon();
			
			nativeMenu = new NativeMenu();
			subMenu    = new NativeMenu();
			
			var _version:NativeMenuItem 		= nativeMenu.addItem(new NativeMenuItem(gnncGlobalStatic._programName+' v'+gnncApplication.__getVersionNumber()));
			_version.enabled 					= false;

			nativeMenu.addItem(new NativeMenuItem('w',true));

			var MENU1:NativeMenuItem 			= nativeMenu.addItem(new NativeMenuItem('Sobre'));
			MENU1.enabled 						= false;

			var MENU2:NativeMenuItem 			= nativeMenu.addItem(new NativeMenuItem('Ajuda'));
			MENU2.enabled 						= false;
			
			nativeMenu.addItem(new NativeMenuItem('w',true));
			
			var MENU_REFRESH:NativeMenuItem 	= nativeMenu.addItem(new NativeMenuItem('Atualizar'));
			MENU_REFRESH.addEventListener		(Event.SELECT,function(evt:Event):void{ gnncGlobalStatic.__reload() });
			//MENU_REFRESH.keyEquivalentModifiers = [Keyboard.CONTROL,Keyboard.SHIFT];
			
			/*var subMenuMoney:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('MONEY'));
			var subMenuProject:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('PROJECT'));
			var subMenuClient:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('CLIENT'));
			var subMenuNextDay:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('NEXTDAY'));
			var subMenuDay:NativeMenuItem 		= SUBnativeMenu.addItem(new NativeMenuItem('DAY'));
			var subMenuUser:NativeMenuItem 		= SUBnativeMenu.addItem(new NativeMenuItem('USER'));
			var subMenuEducation:NativeMenuItem = SUBnativeMenu.addItem(new NativeMenuItem('EDUCATION'));
			var subMenuProduct:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('PRODUCT'));
			var subMenuDocument:NativeMenuItem 	= SUBnativeMenu.addItem(new NativeMenuItem('DOCUMENT'));*/
			
			
			/*for(var i:uint=0; i<gnncGlobalArrays._PROGRAMS.length; i++){
				subMenu.addItem(new NativeMenuItem(gnncGlobalArrays._PROGRAMS.getItemAt(i).NAME));
			}
			
			nativeMenu.addSubmenu(subMenu,'Aplicativos DAYBYDAY');
			nativeMenu.addItem(new NativeMenuItem('_',true));
			*/

			var menuLock:NativeMenuItem = nativeMenu.addItem(new NativeMenuItem('Travar'));
			menuLock.addEventListener(Event.SELECT,function(evt:Event):void
			{
				if(FlexGlobals.topLevelApplication.document.enabled==true){
					FlexGlobals.topLevelApplication.document.enabled=false;
				}else{
					FlexGlobals.topLevelApplication.document.enabled=true;
				}
			});

			nativeMenu.addItem(new NativeMenuItem('_',true));

			var menuExit:NativeMenuItem = nativeMenu.addItem(new NativeMenuItem('Sair'));
			menuExit.addEventListener(Event.SELECT, gnncApplication.__windowsCloseAll);
			
			
			if (NativeApplication.supportsDockIcon){
				DockIcon(NativeApplication.nativeApplication.icon).menu = nativeMenu;
			}
			else if (NativeApplication.supportsSystemTrayIcon){
				SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(ScreenMouseEvent.CLICK,__iconClick);
				SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = nativeMenu
				SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "DayByDay - App "+gnncGlobalStatic._programName;
			}
		}
		
		private function __iconClick(event:ScreenMouseEvent):void
		{
			if(gnncGlobalStatic._popDisplayIconTry==null)
				return;

			appWindow.__closeNative();
			
			var _gnncNativeOptions:ExtendedNativeWindowOptions 	= new ExtendedNativeWindowOptions();
			_gnncNativeOptions._positionScrennRight 			= true;
			_gnncNativeOptions._positionScrennBottom 			= true;
			_gnncNativeOptions._windowType						= NativeWindowType.LIGHTWEIGHT;
			_gnncNativeOptions._windowSystemChrome				= NativeWindowSystemChrome.NONE; 	//standard | none
			_gnncNativeOptions._x								= -10;
			_gnncNativeOptions._y								= -10;

			appWindow.__creationWindows(gnncGlobalStatic._popDisplayIconTry,300,500,'JOBS',true,_gnncNativeOptions);
		}

		/** Set up the icon which appears in the sytem tray (Win) or the dock (Mac). **/
		private function __setUpIcon():void 
		{
			if (NativeApplication.supportsDockIcon)
			{
				NativeApplication.nativeApplication.icon.bitmaps = [new icon128().bitmapData];
			}
			else if (NativeApplication.supportsSystemTrayIcon)
			{
				NativeApplication.nativeApplication.icon.bitmaps = [
					new icon16().bitmapData
				];
			}
		}
				


	}
}