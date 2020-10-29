package GNNC.data.securityService
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	import flash.system.Security;
	
	public class gnncSocket extends Sprite
	{
		
		private var _parent:Object;
		private var _xmlSocket:XMLSocket;
		private var _host:String = '';
		
		public function gnncSocket(parentApplication_:Object=null) 
		{
			_parent = parentApplication_;
		}
		
		public function __connectSocket(server_:String='www.gnnc.com.br',port_:uint=80):void
		{
			if(port_)
				Security.loadPolicyFile		("xmlSocket://"+server_+":"+port_+"/crossdomain.xml"); 
			else
				Security.loadPolicyFile		("xmlSocket://"+server_+"/crossdomain.xml"); 
			
			_host = server_;

			_xmlSocket						= new XMLSocket();
			
			_xmlSocket.addEventListener		(Event.CONNECT						, __onConnect );
			_xmlSocket.addEventListener		(IOErrorEvent.IO_ERROR				, __errorData );
			_xmlSocket.addEventListener		(SecurityErrorEvent.SECURITY_ERROR	, __errorData );
			_xmlSocket.addEventListener		(DataEvent.DATA						, __onData );
	
			_xmlSocket.connect				(server_,port_);
			_xmlSocket.send('<send/>');
		}

		private function __errorData( event:* ):void 
		{
			new gnncAlert().__error( 'Erro na tentativa de canexão!' );
		}

		private function __onConnect( event:Event ):void 
		{
			_xmlSocket.send( "<test/>" );  
			new gnncAlert().__alert( 'Conexão estabelecida com <b>'+_host+'</b>.' );
		}

		private function __offConnect( event:* ):void 
		{
			new gnncAlert().__error( 'Sem canexão com <b>'+_host+'</b>.' );
		}
		
		private function __onData( event:DataEvent ):void 
		{
			//new gnncAlert().__alert( event.data+'<--' );
			var response:XML = new XML( event.data );
			//new gnncAlert().__alert( response.test.@success );
			//new gnncAlert().__ok( 'Programa conectado!' );
		}
		
	}
}

