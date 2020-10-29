package GNNC.application
{
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.geom.Point;

	public class ExtendedNativeWindowOptions
	{
		/**
		 * if true only stage virtual, without bar windows. ex: 800x580
		 * if false, get resolution screen. ex: 800x600
		 * **/
		public var _screenVirtualDesktop:Boolean	= true;
		
		private var _screenWidth:uint 				= 0;
		private var _screenHeight:uint 				= 0;

		public var _positionScrennLeft:Boolean 		= false;
		public var _positionScrennRight:Boolean 	= false;
		public var _positionScrennTop:Boolean 		= false;
		public var _positionScrennBottom:Boolean 	= false;
		
		public var _x:int							= 0;
		public var _y:int							= 0;

		public var _width:int						= 0;
		public var _height:int						= 0;
		
		public var _windowType:String 				= NativeWindowType.NORMAL;				//normal | lightweight
		public var _windowSystemChrome:String 		= NativeWindowSystemChrome.STANDARD; 	//standard | none
		public var _windowTransparent:Boolean 		= false; 								//true (lightweight)

		public var _minimizable:Boolean				= true;
		public var _maximizable:Boolean				= false;
		public var _resizable:Boolean 				= false;

		public function ExtendedNativeWindowOptions()
		{
			var screen:Screen = Screen.mainScreen;

			_screenWidth 	= _screenVirtualDesktop ? gnncAppWindow.__getDesktopWidth()  /*Screen.mainScreen.bounds.width*/ : gnncAppWindow.__getScreenWidth();
			_screenHeight 	= _screenVirtualDesktop ? gnncAppWindow.__getDesktopHeight() /*Screen.mainScreen.bounds.width*/ : gnncAppWindow.__getScreenHeight();
		}
		
		public function __get(WindowsOrNativeWindow_:Object):Point
		{
			var _point:Point = new Point(0,0);
			
			//CENTER
			if(
				(!_positionScrennLeft && !_positionScrennTop && !_positionScrennRight && !_positionScrennBottom) ||
				(_positionScrennLeft && _positionScrennTop && _positionScrennRight && _positionScrennBottom)
			)
			{
				_point = new Point((_screenWidth/2)-(WindowsOrNativeWindow_.width/2)+(_x),(_screenHeight/2)-(WindowsOrNativeWindow_.height/2)+(_y));
			}

			//A - Left and Top
			else if(_positionScrennLeft && _positionScrennTop && !_positionScrennRight && !_positionScrennBottom)
			{
				_point = new Point(0+(_x),0+(_y));
			}

			//B - Right and Top
			else if(!_positionScrennLeft && _positionScrennTop && _positionScrennRight && !_positionScrennBottom)
			{
				_point = new Point((_screenWidth)-(WindowsOrNativeWindow_.width)+(_x),0+(_y));
			}

			//C - Right and Bottom
			else if(!_positionScrennLeft && !_positionScrennTop && _positionScrennRight && _positionScrennBottom)
			{
				_point = new Point((_screenWidth)-(WindowsOrNativeWindow_.width)+(_x),(_screenHeight)-(WindowsOrNativeWindow_.height)+(_y));
			}

			//D - Left and Bottom
			else if(_positionScrennLeft && !_positionScrennTop && !_positionScrennRight && _positionScrennBottom)
			{
				_point = new Point(0+(_x),(_screenHeight)-(WindowsOrNativeWindow_.height)+(_y));
			}

			return _point;
		}
		
	}
}