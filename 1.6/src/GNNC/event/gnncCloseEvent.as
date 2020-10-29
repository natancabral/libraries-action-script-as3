package GNNC.event
{
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	public class gnncCloseEvent extends FlexEvent
	{

		public static const CLOSE:String = "close";
		public var detail: int;
		public var detaus: Object;

		public function gnncCloseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, detail:int = -1)
		{
			super(type, bubbles, cancelable);
			this.detail = detail;
		}
		
		override public function clone():Event
		{
			return new gnncCloseEvent(type, bubbles, cancelable, detail);
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