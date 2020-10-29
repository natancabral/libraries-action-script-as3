package GNNC.UI.gnncAlert
{
	import flash.events.Event;
	
	public class gnncAlertEvent extends Event
	{
		public static const _ok:String 			= "OK";
		public static const _yes:String 		= "YES";
		public static const _no:String 			= "NO";
		public static const _cancel:String 		= "CANCEL";
		public static const _delete:String 		= "DELETE";

		public static const _free:String 		= "FREE";

		public var data: Object;
		
		public function gnncAlertEvent(type:String, data: Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new gnncAlertEvent(type, data, bubbles, cancelable);
		}
		
	}
}