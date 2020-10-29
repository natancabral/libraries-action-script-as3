package GNNC.UI.gnncVideo
{
	import flash.events.Event;
	
	public class gnncVideoYoutubeEvents extends Event
	{
		public static const NAME:String	= 'YouTubePlayerEvent';
		
		public static const CONNECTED:String	= NAME + 'Connected';
		public static const READY:String	= NAME + 'Ready';
		public static const STATE_CHANGED:String	= NAME + 'StateChange';
		public static const ERROR:String	= NAME + 'Error';
		public static const PLAYING:String	= NAME + 'Playing';
		public static const ENDED:String	= NAME + 'Ended';
		public static const PAUSED:String	= NAME + 'Paused';
		public static const QUEUED:String	= NAME + 'Queued';
		public static const BUFFERING:String	= NAME + 'Buffering';
		public static const NOT_STARTED:String	= NAME + 'NotStarted';
		public static const QUALITY_CHANGED:String	= NAME + 'QualityChanged';
		
		public var data:Object;
		
		public function gnncVideoYoutubeEvents(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
			
			this.data = data;
		}
	}
}