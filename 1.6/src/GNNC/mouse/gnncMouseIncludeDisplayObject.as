package GNNC.mouse
{
	import GNNC.mouse.gnncMousePoint;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.supportClasses.DisplayLayer;
	
	public class gnncMouseIncludeDisplayObject
	{
		private static var _PARENT:Object;
		private static var DOMO:Object			= null;
		private static var ICON:Image 			= new Image();
		private static var GROUP:Group 		= new Group();
		private static var _X:int				= 20;
		private static var _Y:int				= 0;
		
		public function gnncMouseIncludeDisplayObject(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;
		}
		
		public static function __setIcon(DISPLAY_OBJECT_MOUSE_OVER_:Object,ICON_:Class,X_:int=20,Y_:int=0):void
		{
			ICON.source = ICON_;
			__setDisplay(DISPLAY_OBJECT_MOUSE_OVER_,ICON,X_,Y_);
		}
		
		public static function __setDisplay(DISPLAY_OBJECT_MOUSE_OVER_:Object,DISPLAY_OBJECT_:Object,X_:int=20,Y_:int=0):void
		{
			_X 						= X_;
			_Y 						= Y_;
			DOMO 					= DISPLAY_OBJECT_MOUSE_OVER_;
			GROUP.addElement		(DISPLAY_OBJECT_ as IVisualElement);
			DOMO.addEventListener	(MouseEvent.ROLL_OVER,			__MOUSE_OVER);
			DOMO.addEventListener	(MouseEvent.ROLL_OUT,			__MOUSE_OUT);
			DOMO.addEventListener	(MouseEvent.MOUSE_MOVE,			__MOUSE_MOVE);
			GROUP.addEventListener	(MouseEvent.ROLL_OVER,			__OBJ_MOUSE_OVER);
			GROUP.addEventListener	(MouseEvent.MOUSE_DOWN,			__OBJ_MOUSE_DOWN);
		}
		
		private static function __MOUSE_OVER(event:MouseEvent):void{		try{_PARENT.addElement(GROUP);		__MOVE(event)}catch(e:*){}	}
		private static function __MOUSE_OUT(event:MouseEvent):void	{		try{_PARENT.removeElement(GROUP);	__MOVE(event)}catch(e:*){}	}
		private static function __MOUSE_MOVE(event:MouseEvent):void{		try{__MOVE(event)								 }catch(e:*){}	}
		private static function __OBJ_MOUSE_OVER(event:MouseEvent):void{	try{__OBJ_MOVE(event)	 						 }catch(e:*){}	}
		private static function __OBJ_MOUSE_DOWN(event:MouseEvent):void{	try{_PARENT.removeElement(GROUP)				 }catch(e:*){}	}
		
		private static function __MOVE(event:MouseEvent):void
		{
			try{
			GROUP.move(gnncMousePoint.__local2Global(event).x+_X,gnncMousePoint.__local2Global(event).y+_Y);
			}catch(e:*){}
		}

		private static function __OBJ_MOVE(event:MouseEvent):void
		{
			try{
			GROUP.move(GROUP.x+_X,GROUP.y+_Y);
			}catch(e:*){}
		}
		
		private static function __REMOVE_Event():void
		{
			DOMO.removeEventListener  (MouseEvent.ROLL_OVER,		__MOUSE_OVER);
			DOMO.removeEventListener  (MouseEvent.ROLL_OUT,			__MOUSE_OUT);
			DOMO.removeEventListener  (MouseEvent.MOUSE_MOVE,		__MOUSE_MOVE);
			GROUP.removeEventListener (MouseEvent.ROLL_OVER,		__OBJ_MOUSE_OVER);
			GROUP.removeEventListener (MouseEvent.MOUSE_DOWN,		__OBJ_MOUSE_DOWN);
		}
		
	}
	
	
}