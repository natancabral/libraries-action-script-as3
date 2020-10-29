package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;

	public class gnncFileCookie
	{
		static private var _COOKIE:SharedObject;
		
		public function gnncFileCookie()
		{
			super();
			// EncryptedLocalStore.
		}

		static private function __create(_cookieName:String,_localPath:String=null,_secure:Boolean=false):void
		{
			//SharedObjectFlushStatus.PENDING;
			_localPath = _localPath ? _localPath : "/";
			gnncFileCookie._COOKIE 			= SharedObject.getLocal(_cookieName,_localPath,_secure);
		}
		
		static public function __setInList(_cookieName:String,_variable:String,_value:Object,_localPath:String=null,_secure:Boolean=false):void
		{
			gnncFileCookie.__create			(_cookieName,_localPath,_secure);
			
			var _list:ArrayCollection		= gnncFileCookie.__getInList(_cookieName,_variable).length>0?__getInList(_cookieName,_variable	):new ArrayCollection();
			
			if(_list.source.indexOf(_value)==-1)
				_list.addItem				(_value);
			
			_COOKIE.data[_variable] 		= _list;
			_COOKIE.flush					();
		}

		static public function __getInList(_cookieName:String,_variable:String,_localPath:String=null,_secure:Boolean=false):ArrayCollection 
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure); 
			
			var _list:ArrayCollection 	= new ArrayCollection();
			
			if(_COOKIE.size > 0 && _COOKIE.data.hasOwnProperty(_variable))
				_list = _COOKIE.data[_variable];
			
			return _list;
		}

		static public function __delInList(_cookieName:String,_variable:String,_value:Object,_localPath:String=null,_secure:Boolean=false):void
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure);
			
			var _list:ArrayCollection 	= _COOKIE.data[_variable];
			
			delete _list.source[_list.source.indexOf(_value)];
			
			_COOKIE.data[_variable] 	= _list;
			_COOKIE.flush				();

		}
		
		static public function __set(_cookieName:String,_variable:String,_value:Object,_localPath:String=null,_secure:Boolean=false):void
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure);
			
			_COOKIE.data[_variable] 	= _value;
			_COOKIE.flush				();
		}

		static public function __get(_cookieName:String,_variable:String,_localPath:String=null,_secure:Boolean=false):Object
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure);
			
			if(_COOKIE. size > 0 && _COOKIE.data.hasOwnProperty(_variable))
				var _obj:String 		= _COOKIE.data[_variable];

			return _obj;
		}
		
		static public function __clear(_cookieName:String,_localPath:String=null,_secure:Boolean=false):void
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure);
			
			_COOKIE.clear				();
		}
		
		static public function __list(_cookieName:String,_localPath:String=null,_secure:Boolean=false):void
		{
			gnncFileCookie.__create		(_cookieName,_localPath,_secure);
			
			var _obj:String 			= '';
			
			for (var i:String in _COOKIE.data) 
			{ 
				_obj += i + ":\t\t\t" + _COOKIE.data[i] + "\n"; 
			}
			
			new gnncAlert().__alert(_obj);
		}
		
	}
}