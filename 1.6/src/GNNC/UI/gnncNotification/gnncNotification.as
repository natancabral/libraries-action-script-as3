package GNNC.UI.gnncNotification
{
	public class gnncNotification 
	{

		public function gnncNotification()
		{
		}
		/**
		 * display_  = gnncNotificationConst.DISPLAY_LENGTH_DEFAULT
		 * position_ = gnncNotificationConst.DISPLAY_LOCATION_AUTO
		 */
		public function __show(title_:String, message_:String, ImageOrUrl_:Object=null, url_:String = null, isCompact_:Boolean = false, isSticky_:Boolean = false, isReplayable_:Boolean = false, bgLite_:Boolean = true, displayTime_:uint = 5, position_:String = '',sound_:*=null):void
		{
			//nativeWindow.notifyUser(NotificationType.INFORMATIONAL);
			//nativeWindow.notifyUser(NotificationType.CRITICAL);
			
			// create engine with default settings
			var _nManager:gnncNotificationManager = new gnncNotificationManager
				(
					'',//"/assets/style/dark.swf",						// default style
					null,   											// default notification image
					null,   											// default compact notification image
					sound_,//drop.mp3",									// (optional) default notification sound
					displayTime_ ? displayTime_  : gnncNotificationConst.DISPLAY_LENGTH_DEFAULT,		// (optional) default display length
					position_    ? position_     : gnncNotificationConst.DISPLAY_LOCATION_AUTO			// (optional) default display location
				);
			
			//bgLite_
			
			// now that we have an engine, let's create a notification and show it
			var _notif:gnncNotificationValues 	= new gnncNotificationValues();
			_notif.title 						= title_;
			_notif.message 						= message_;
			_notif.image 						= ImageOrUrl_;
			_notif.link 						= url_;//"http://www.youtube.com/watch?v=_6GqqIvfSVQ";
			_notif.isCompact 					= isCompact_;
			_notif.isSticky 					= isSticky_; //permanece na tela
			_notif.isReplayable 				= isReplayable_;
			
			// we can also show notifications quickly using this API too
			_nManager.showNotification			(_notif);
			
			//_nManager.show						("Derek Zoolander Foundation", "Now open!", "");		
		}
		
	}
}