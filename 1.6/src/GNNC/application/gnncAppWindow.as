package GNNC.application
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.events.*;
	
	import spark.components.Window;

	public class gnncAppWindow
	{
		private var _parent:Object			= FlexGlobals.topLevelApplication;

		//WINDOWS
		public var _window:Window;
		//NATIVE
		public var options:NativeWindowInitOptions;
		public var popupWindow:ExtendedNativeWindow;
		
		static public function __getScreenWidth():Number
		{
			return flash.display.Screen.mainScreen.bounds.width;
		}
		
		static public function __getScreenHeight():Number
		{
			return flash.display.Screen.mainScreen.bounds.height;
		}
		
		static public function __getDesktopWidth():Number
		{
			var screen:Screen = Screen.mainScreen;
			return screen.visibleBounds.width;
		}
		
		static public function __getDesktopHeight():Number
		{
			var screen:Screen = Screen.mainScreen;
			return screen.visibleBounds.height;
		}

		
		
		
		
		public function gnncAppWindow(parentApplication_:Object=null)
		{
			_parent 	= parentApplication_?parentApplication_:gnncGlobalStatic._parent;
			_window 	= new Window();
		}
		
		/**
		 * 
		 *	options.type 					= NativeWindowType.NORMAL				//normal | lightweight
		 *	options.systemChrome 			= NativeWindowSystemChrome.STANDARD; 	//standard | none
		 *	options.transparent 			= false; 								//true (lightweight)
		 * 
		**/
		public function __creationWindows(
											DisplayObject_:IVisualElement,
											width_:uint=300,
											height_:uint=300,
											title_:String='Window',
											alwaysFront_:Boolean=true,
											ExtendedNativeWindowOptions_:ExtendedNativeWindowOptions=null
		):void
		{
			if(_window != null) 				
				_window.close();
			
			if(!DisplayObject_)					
				return;
			
			if(!ExtendedNativeWindowOptions_)
				ExtendedNativeWindowOptions_ = new ExtendedNativeWindowOptions();

			_window								= new Window();
			_window.title 						= title_;
			_window.width 						= width_;
			_window.height 						= height_;

			_window.type 						= ExtendedNativeWindowOptions_._windowType;				//normal | lightweight
			_window.systemChrome 				= ExtendedNativeWindowOptions_._windowSystemChrome; 	//standard | none
			_window.transparent 				= ExtendedNativeWindowOptions_._windowTransparent; 		//true (lightweight)
			//_window.setStyle					("showFlexChrome", false);

			_window.maximizable					= ExtendedNativeWindowOptions_._maximizable;
			_window.minimizable					= ExtendedNativeWindowOptions_._minimizable;
			_window.resizable 					= ExtendedNativeWindowOptions_._resizable;

			_window.alwaysInFront 				= alwaysFront_;
			
			_window.minWidth 					= width_;
			_window.minHeight 					= height_;
			
			try 
			{
				
				_window.open();
				
				//* Add in a resize event listener
				_window.addEventListener(FlexEvent.CREATION_COMPLETE,windowResizeHandler);
				_window.addEventListener(AIREvent.WINDOW_COMPLETE	,windowResizeHandler);
		
				//* Resizes the content in response to a change in size
				function windowResizeHandler(event:*):void
				{
					if(ExtendedNativeWindowOptions_!=null)
					{
						var y:uint = 0;

						//task bar height
						if(ExtendedNativeWindowOptions_._windowType != NativeWindowType.LIGHTWEIGHT)
							y = gnncAppWindow.__getScreenHeight()-gnncAppWindow.__getDesktopHeight();
						
						_window.move(ExtendedNativeWindowOptions_.__get(_window).x,ExtendedNativeWindowOptions_.__get(_window).y-y);
						
						_window.orderToFront();
						_window.activate();
					}

					//* Resize windows to content
					//_window.width 	= _window.stage.nativeWindow.width;
					//_window.height 	= _window.stage.nativeWindow.height;
					//_window.stage.nativeWindow.width = width_;
					//_window.stage.nativeWindow.height = height_;
				}

				_window.statusBar.height		= 0;
				_window.statusBar.visible		= false;
				
				_window.addElementAt			(DisplayObject_,0);
				
			}
			catch (err:Error) 
			{
				new gnncAlert().__error('Problema inesperado ao abrir uma janela: \n' + err.toString());
			}
		}
		
		public function __closeWindow(this_:Object=null):void
		{
			if(this_!=null)
			{
				Object(this_).stage.nativeWindow.close();
				return;
			}
			
			if(_window)
				_window.close();
		}

		public function __closeNative(this_:Object=null):void
		{
			if(this_!=null)
			{
				Object(this_).stage.nativeWindow.close();
				return;
			}
			
			if(popupWindow)
				popupWindow.close();
		}

		public function __creationNative(
											DisplayObject_:IVisualElement,
											width_:uint=300,
											height_:uint=300,
											title_:String='Window',
											alwaysFront_:Boolean=true,
											nativeWindowInitOptions_:NativeWindowInitOptions=null,
											ExtendedNativeWindowOptions_:ExtendedNativeWindowOptions=null
		):void
		{
			if(!nativeWindowInitOptions_)
			{
				//* Set up the NativeWindow options
				options							= new NativeWindowInitOptions();
				options.type 					= NativeWindowType.NORMAL				//normal | lightweight
				options.systemChrome 			= NativeWindowSystemChrome.STANDARD; 	//standard | none
				options.transparent 			= false; 								//true (lightweight)
			}
			else
			{
				options							= nativeWindowInitOptions_;
			}

			//* Create the NativeWindow
			popupWindow 						= new ExtendedNativeWindow(options);
			
			//* Set the height, width and position
			popupWindow.width 					= width_;
			popupWindow.height 					= height_;
			popupWindow.stage.scaleMode 		= StageScaleMode.NO_SCALE;
			popupWindow.stage.align 			= StageAlign.TOP_LEFT;
			popupWindow.title					= title_;

			if(ExtendedNativeWindowOptions_!=null)
			{
				popupWindow.x					= ExtendedNativeWindowOptions_.__get(popupWindow).x;
				popupWindow.y					= ExtendedNativeWindowOptions_.__get(popupWindow).y;
			}

			if(!DisplayObject_)
				return;
			
			//* Pass the content into the native window
			popupWindow.addChildControls		(DisplayObject_);
			
			//* Activate the window
			popupWindow.orderToFront			();
			popupWindow.activate				();
			
			//Manipulatiion
			popupWindow.alwaysInFront 			= alwaysFront_; 

			/**
			popupWindow.close(); 
			popupWindow.maximize(); 
			popupWindow.minimize(); 
			popupWindow.orderInBackOf(otherWin); 
			popupWindow.orderInFrontOf(otherWin); 
			popupWindow.orderToBack(); 
			popupWindow.orderToFront()
			**/
		}
		
	}
}