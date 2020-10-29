package GNNC.others
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class gnncUrlNavegator
	{
		private static var _parent:Object;
		public  static var _try:Boolean = false;
		
		public function gnncUrlNavegator(parentApplication_:Object=null,try_:Boolean=false)
		{
			_parent 	= (parentApplication_)?parentApplication_:gnncGlobalStatic._parent;
			_try		= try_;
		}
		
		static public function __navegatorUrl(httpUrl_:String='http://www.gnnc.com.br/',target_:String='_blank'):void
		{
			if(_try)
				new gnncAlert().__alert('url:'+httpUrl_);
			
			if(!httpUrl_)
			{
				new gnncAlert(_parent).__error('Não há Url.');
				return;
			}
			
			if(httpUrl_.length<10)
			{
				new gnncAlert(_parent).__error('Url incorreta.');
				return;
			}

			var Url:URLRequest = new URLRequest(httpUrl_);
			navigateToURL(Url,target_);
		}
		
	}
}