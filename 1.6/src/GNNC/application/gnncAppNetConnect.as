package GNNC.application
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.globals.gnncGlobalLog;
	
	import air.net.URLMonitor;
	
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	public class gnncAppNetConnect
	{
		//[Bindable] 
		public var status:Boolean = false;
		
		private var conn:URLMonitor;
		private var connTimesOut:uint = 0;
		
		public function gnncAppNetConnect()
		{
		}
		
		/**
		 * 
		 * function callback(e:StatusEvent):void {
		 *   if(conn.available==true){}
		 * }
		 * 
		 * **/
		public function urlCheckConnect(url:String,callBack:Function=null,pollInterval:uint=1500,times:uint=3,showAlert:Boolean=false):void
		{
			if(!url)
				return;
			
			conn = new URLMonitor(new URLRequest(url));
			conn.addEventListener(StatusEvent.STATUS, s);
			conn.pollInterval = pollInterval;
			
			if(callBack!=null)
				conn.addEventListener(StatusEvent.STATUS, callBack);
			
			conn.start();
			
			function s(e:StatusEvent):void 
			{
				if(connTimesOut == times){
					stop();
				}else if(conn.available==true){
					status = true;
					connTimesOut = 0;
					gnncGlobalLog.__add('ping[success:'+connTimesOut+']:'+url);
					stop();
					
					if(showAlert)
						gnncAlert.__alert('Connnect and online.');
					
				}else{
					status = false;
					connTimesOut = connTimesOut+1;
					gnncGlobalLog.__add('ping[error:'+connTimesOut+']:'+url);
					urlCheckConnect(url,callBack,pollInterval,times,showAlert);
				}
			}			
		}
		
		public function stop():void
		{
			if(conn.running){
				conn.stop();
				conn = null;
			}
		}
		
	}
}