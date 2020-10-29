package GNNC.application
{
	import flash.desktop.NativeApplication;
	import flash.display.Screen;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	public class gnncApplication
	{
		static private var _parent:Object;

		static public var _screenWidth:uint 			= flash.display.Screen.mainScreen.bounds.width;
		static public var _screenHeight:uint 			= flash.display.Screen.mainScreen.bounds.height;

		static public var _stageWidth:uint 				= FlexGlobals.topLevelApplication.parent.width;
		static public var _stageHeight:uint 			= FlexGlobals.topLevelApplication.parent.height;

		static public var _restored:Boolean				= false;
		static public var _maximized:Boolean			= false;
		static public var _minimized:Boolean			= false;
		static public var _fullscreen:Boolean			= false;
		
		public function gnncApplication(parentApplication_:Object=null)
		{
			//super();
			_parent = parentApplication_ ? parentApplication_ : FlexGlobals.topLevelApplication;
		}

		public static function __clearVarsWindows():void 
		{
			gnncApplication._restored					= false;
			gnncApplication._maximized					= false;
			gnncApplication._minimized					= false;
			gnncApplication._fullscreen					= false;
		}

		public static function __getDescriptor():XML
		{
			return NativeApplication.nativeApplication.applicationDescriptor;
		}
		
		public static function __getNamespace():Namespace
		{
			return __getDescriptor().namespace();
		}
		
		public static function __getName():String
		{
			var ns:Namespace=__getNamespace();
			return __getDescriptor().ns::name;
		}
		
		public static function __getVersionNumber():String
		{
			var ns:Namespace=__getNamespace();
			return __getDescriptor().ns::versionNumber;
		}
		
		public static function __getCopyright():String
		{
			var ns:Namespace=__getNamespace();
			return __getDescriptor().ns::copyright;
		}
		
		static public function __windowsMove(positionType_center_a_b_c_d_:String,xMore_:Number=0,yMore_:Number=0):void
		{
			var X:int = 0;
			var Y:int = 0;
			
			switch(positionType_center_a_b_c_d_)
			{
				//case 'CENTER': 	X = (_screenWidth/2)-(_parent.width/2)+(X_MORE); 	Y = (_screenHeight/2)-(_parent.height/2)+(Y_MORE); 	break;
				case 'A': 		X = 0+(xMore_);										Y = 0+(yMore_); 									break;
				case 'B': 		X = (_screenWidth)-(_parent.width)+(xMore_); 		Y = 0+(yMore_); 									break;
				case 'C': 		X = (_screenWidth)-(_parent.width)+(xMore_);		Y = (_screenHeight)-(_parent.height)+(yMore_);	 	break;
				case 'D': 		X = 0+(xMore_);										Y = (_screenHeight)-(_parent.height)+(yMore_); 		break;
				default: 		X = 0+(xMore_);										Y = 0+(yMore_); 
			}
			
			_parent.move(X,Y);
		}
		
		static public function __windowsFullScreen(event:Event):void
		{
			__windowsRestore(event);
			
			//NativeApplication.nativeApplication.activeWindow.stage.align 		= flash.display.StageAlign.TOP_LEFT;
			NativeApplication.nativeApplication.activeWindow.stage.scaleMode 	= flash.display.StageScaleMode.NO_SCALE;
			
			NativeApplication.nativeApplication.activeWindow.stage.displayState = ( NativeApplication.nativeApplication.activeWindow.stage.displayState == flash.display.StageDisplayState.FULL_SCREEN_INTERACTIVE ) ?
				flash.display.StageDisplayState.NORMAL :
				flash.display.StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			gnncApplication.__clearVarsWindows()
			gnncApplication._fullscreen = true;
			gnncApplication._maximized = true;
		}
		
		static public function __windowsCenter():void
		{
			try
			{
				NativeApplication.nativeApplication.activeWindow.x 				= (_screenWidth/2)-(_parent.width/2);
				NativeApplication.nativeApplication.activeWindow.y 				= (_screenHeight/2)-(_parent.height/2);
				
			}catch(error:Error)
			{
				_parent.move 							((_screenWidth/2)-(_parent.width/2),(_screenHeight/2)-(_parent.height/2));
			}

			gnncApplication.__clearVarsWindows()
			gnncApplication._restored = true;
		}
		
		static public function __windowsResize(w_:uint,h_:uint,center_:Boolean):void
		{
			try
			{
				NativeApplication.nativeApplication.activeWindow.width		= w_;
				NativeApplication.nativeApplication.activeWindow.height		= h_;
				
			}catch(error:Error)
			{
				_parent.width	= w_;
				_parent.height	= h_;
			}
			
			if(center_)
				gnncApplication.__windowsCenter();
			
			gnncApplication.__clearVarsWindows()
			gnncApplication._restored = true;

		}
		
		static public function __windowsClose(event:*=null):void
		{
			NativeApplication.nativeApplication.activeWindow.close();
			_parent.close();
			_parent.exit();
			NativeApplication.nativeApplication.exit();
		}
		
		static public function __windowsCloseAll(event:*=null):void
		{
			//the Setup Install kill run process of this application
			
			NativeApplication.nativeApplication.autoExit = true;
			NativeApplication.nativeApplication.activate();
			
			NativeApplication.nativeApplication.exit();
			NativeApplication.nativeApplication.activeWindow.close();
			FlexGlobals.topLevelApplication.exit();
			FlexGlobals.topLevelApplication.close();
			
			var opened:Array = NativeApplication.nativeApplication.openedWindows;
			
			for (var i:int = 0; i < opened.length; i ++) 
			{
				opened[i].exit();
				opened[i].close();
			}
			_parent.close();
			_parent.exit();
		}

		static public function __windowsRestore(event:*=null):void
		{ 
			NativeApplication.nativeApplication.activeWindow.stage.nativeWindow.restore();					

			gnncApplication.__clearVarsWindows()
			gnncApplication._restored = true;
		}
		
		static public function __windowsMinimize(event:*=null):void
		{ 
			NativeApplication.nativeApplication.activeWindow.stage.nativeWindow.minimize();
			
			gnncApplication.__clearVarsWindows()
			gnncApplication._minimized = true;
		}
		
		static public function __windowsMaximize(event:*=null):void
		{ 
			//NativeApplication.nativeApplication.activeWindow.stage.nativeWindow.maximize();
			FlexGlobals.topLevelApplication.maximize();


			gnncApplication.__clearVarsWindows()
			gnncApplication._maximized = true;
		}
		
		static public function __windowsDrag(event:*=null):void
		{
			NativeApplication.nativeApplication.activeWindow.stage.nativeWindow.startMove();
		}
		
		static public function __windowsResizeManual(event:*=null):void
		{
			if(NativeApplication.nativeApplication.activeWindow.stage.displayState == flash.display.StageDisplayState.NORMAL)
				NativeApplication.nativeApplication.activeWindow.stage.nativeWindow.startResize();
		}
		
		static public function __inFront(auto_:Boolean=true,front_:Boolean=false):Boolean
		{
			if(!auto_)
			{
				_parent.alwaysInFront = front_;
			}
			else
			{
				_parent.alwaysInFront = (_parent.alwaysInFront == true) ? false : true;
			}
			
			return _parent.alwaysInFront;
		}
		
		static public function __statusBar(text_:String='',height_:uint=0):void
		{
			try
			{
				_parent.statusBar.visible 	= height_ ? true : false;
				_parent.status 				= text_;
				_parent.statusBar.height 	= height_; //25
			}
			catch(e:*)
			{
			}
		}
		
	}
}