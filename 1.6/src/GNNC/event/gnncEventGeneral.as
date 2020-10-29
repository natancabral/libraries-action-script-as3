package GNNC.event
{
	import flash.events.Event;

	public class gnncEventGeneral extends Event
	{
		public static const _clear:String 		= "CLEAR";

		public static const _complete:String 		= "COMPLETE";
		public static const _error:String 			= "ERROR";
		
		public static const _new:String 			= "NEW";
		public static const _edit:String 			= "EDIT";
		public static const _update:String 			= "UPDATE";
		public static const _delete:String 			= "DELETE";

		public static const _removeItemList:String 	= "REMOVE_ITEM_LIST";
				
		public static const _loading:String 		= "LOADING";
		public static const _loading_off:String 	= "LOADING_OFF";

		public static const _view:String 			= "VIEW";
		public static const _refresh:String 		= "REFRESH";
		public static const _free:String 			= "FREE";
		public static const _control:String 		= "CONTROL";

		public static const _copy:String 			= "COPY";
		public static const _paste:String 			= "PASTE";

		public static const _mouseClick:String 		= "MOUSE_CLICK";
		public static const _mouseDown:String 		= "MOUSE_DOWN";
		public static const _mouseUp:String 		= "MOUSE_UP";

		public static const _mouseDoubleClick:String = "MOUSE_DOUBLE_CLICK";

		public static const _rightMouseDown:String 	= "RIGHT_MOUSE_DOWN";
		public static const _rightMouseUp:String 	= "RIGHT_MOUSE_UP";
		public static const _rightMouseClick:String = "RIGHT_MOUSE_CLICK";

		public static const _selectItem:String 		= "SELECT_ITEM";

		public static const _star:String 			= "STAR"; 
		public static const _key:String 			= "KEY"; //get key register

		public static const _dateFinalAdd:String 	    = "DATE_FINAL_ADD";
		public static const _dateFinalRemove:String     = "DATE_FINAL_REMOVE";
		public static const _dateFinalAuto:String 	    = "DATE_FINAL_AUTO";

		public static const _dateCanceledAdd:String 	= "DATE_CANCELED_ADD";
		public static const _dateCanceledRemove:String 	= "DATE_CANCELED_REMOVE";
		public static const _dateCanceledAuto:String 	= "DATE_CANCELED_AUTO";

		public static const _hierarchyNextLevel:String 	= "HIERARCHY_NEXT_LEVEL";
		public static const _hierarchyPrevLevel:String 	= "HIERARCHY_PREV_LEVEL";

		public var data: Object;

		public function gnncEventGeneral(type:String, data: Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new gnncEventGeneral(type, data, bubbles, cancelable);
		}
		
		/*
		override public function hasOwnProperty(variableExists_:):Boolean
		{
			var arr:Array = gnncDataObject.__getPropertysNames(new gnncEventGeneral());
			return gnncDataArray.__getItemIndex(arr,variableExists_) < 0 ? false : true;
		}
		*/

	}
}