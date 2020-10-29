package GNNC.data.securityService
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalStatic;

	public class gnncSecurityDate
	{
		private var _r:Function 	  = function(e:*):void{};
		private var _f:Function 	  = function(e:*):void{};

		private var _t:String         = gnncGlobalArrays.serverTime;
		private var _tX:uint          = 0;
		
		public var serverSync:Boolean = false;
		public var cantSync:Boolean   = false;
		
		public function gnncSecurityDate(r:Function=null,f:Function=null)
		{
			_r = r;
			_f = f
			__getServerDateConfig();
		}
		
		/** 
		 * ####################################
		 * get date server
		 * ####################################
		 * **/
		private function __getServerDateConfig():void
		{
			var e:URLRequest 		= new URLRequest(gnncGlobalStatic._httpDomain + _t + '?' + Math.random());
			e.method				= 'POST';
			
			var load:URLLoader      = new URLLoader(e);
			load.addEventListener	(Event.COMPLETE,__fResultDateConfig);
			load.addEventListener	(IOErrorEvent.IO_ERROR,__fFaultDateConfig);
			load.addEventListener	(SecurityErrorEvent.SECURITY_ERROR,__fFaultDateConfig);
		}
				
		private function __fResultDateConfig(event:*):void
		{
			var loader:URLLoader 	= URLLoader(event.target);
			var d:Date              = new Date();
			var l:String 	        = String(loader.data);
			var dateServer:String 	= l.substr(0,10);
			var datePC:String 		= d.fullYear + '-' + ((d.month+1)>9?(d.month+1):'0'+(d.month+1)) + '-' + (d.date>9?d.date:'0'+d.date);
			
			//substr(11,2)) //hour
			gnncGlobalStatic._dateToday = gnncDate.__string2Date(dateServer);
			
			if(dateServer !== datePC){
				serverSync = false;
				cantSync   = false;
				_f.call();
			}else{
				serverSync = true; 
				cantSync   = false;
				_r.call();
			}
		}

		private function __fFaultDateConfig(event:*):void
		{
			_tX++;
			if(_tX>7){
				serverSync = false; 
				cantSync   = true;
				_f.call();
				return;
			}
			__getServerDateConfig();
		}
		
	}
}