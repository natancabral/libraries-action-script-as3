package GNNC.data.mailer
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.application.gnncAppNetConnect;
	import GNNC.data.conn.gnncCrypt;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArray;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.data.json.gnncJSON;
	import GNNC.data.file.gnncFilesNative;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import air.net.URLMonitor;
	
	import flash.events.StatusEvent;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;

	public class gnncMailer
	{
		private var file:gnncFilesNative = new gnncFilesNative();
		private var conn:URLMonitor;
		
		public  var limitTimesTryConnect:uint = 3;
		public  var connStatus:Boolean = false;
		private var connTimesOut:uint = 0;

		public  var result:String = '';
		public  var log:ArrayCollection = new ArrayCollection();

		/** Visualizar HTML antes de enviar. Não será enviado. **/
		public var view:Boolean = false;
		/** Visualizar os campos a serem preenchidos do HTML. Não será enviado. **/
		public var inputs:Boolean = false;
		public var key:String = '';
		public var confirmReading:Boolean = false;
		
		public var host:String       = '';
		public var port:uint         = 0;
		public var SMTPSecure:String = '';
		public var SMTPAuth:Boolean  = true;
		
		public var name:String     = '';
		public var user:String     = '';
		public var email:String    = '';
		public var reply:String    = '';
		public var password:String = '';
		public var crypt:Boolean   = true;
		
		public var subject:String  = '';
		public var body:String     = '';
		public var altBody:String  = '';
		public var httpBody:String = '';

		protected var urlServer:String = '';
		protected var debug:uint = 0;
		protected var to:ArrayCollection = new ArrayCollection();
		protected var attach:ArrayCollection = new ArrayCollection();
		protected var findAndReplaceText:ArrayCollection = new ArrayCollection();
		
		/**
		 * Acesso gMail
		 * Permissão de Envio
		 * https://myaccount.google.com/lesssecureapps
		 * 
		 * **/
		public function gnncMailer()
		{
			file._allowGlobalError = false;
			file._allowGlobalLoading = true;
			file._noCacheFile = true;
			config();
		}

		
		/**
		 * 'http://gnnc.com.br/librarys/collection/data/files/mailer/index.php' //fast - but no gmail
		 * 'http://gnnc.epizy.com/index.php'; //slow
		 * 'http://gnnc.000webhostapp.com/index.php'; //fast
		 **/
		public function config():void
		{
			//producao
			urlServer = gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverMailer; //fast - no gmail
			//url = 'http://127.0.0.1/' + gnncGlobalArrays.serverMailer; //fast - no gmail
			//url = 'https://gnnc.com.br/' + gnncGlobalArrays.serverMailer; //no gmail
			//urlServer = 'http://gnnc.000webhostapp.com/index.php'; //fast
		}
		
		/**
		* 'http://gnnc.com.br/librarys/collection/data/files/mailer/index.php' //fast - but no gmail
		* 'http://gnnc.unaux.com/index.php'; //need javascript
		* 'http://gnnc.epizy.com/index.php'; //slow | need javascript
		* 'http://gnnc.000webhostapp.com/index.php'; //fast
		 **/
		public function set setServer(url:String):void
		{
			//urlServer = 'http://gnnc.000webhostapp.com/index.php' + '?' + gnncDataRand.__key();
			urlServer = url;
		}

		/**
		Enable SMTP debugging
		0 = off (for production use)
		1 = client messages
		2 = client and server messages
		**/
		public function set SMTPDebug(v:uint):void
		{
			debug = v;
		}

		public function setConnection(setHost:String,setPort:uint,setSMTPSecure:String,setSMTPAuth:Boolean):void
		{
			host = setHost;
			port = setPort;
			SMTPSecure = setSMTPSecure;
			SMTPAuth = setSMTPAuth;
		}

		/**
		 * host = 'smtp.gmail.com';
		 * port = 587;
		 * SMTPSecure = 'tls';
		 * SMTPAuth = true;
		 * **/
		public function setConnectionGMail():void
		{
			host = 'smtp.gmail.com';
			port = 587;
			SMTPSecure = 'tls';
			SMTPAuth = true;
		}

		/**
		 * host = 'mail.gnnc.com.br';
		 * port = 465;
		 * SMTPSecure = 'ssl';
		 * SMTPAuth = true;
		 * **/
		public function setConnectionGNNCServer():void
		{
			host = 'mail.gnnc.com.br';
			port = 465;
			SMTPSecure = 'ssl';
			SMTPAuth = true;
		}

		public function sendGmail(fComplete:Function=null,fError:Function=null):void
		{
			result = '';

			if(!host || !SMTPSecure || port == 0){
				var o:Object = new Object();
				o.email = '';
				o.data  = 'error';
				result  = 'No Server. Please, use setConnection(), setConnectionGMail() or setConnectionGNNCServer().';
				return;
			}
			
			var p:Object = new Object();

			p.key  = this.key;
			p.view = this.view;
			p.confirmReading = this.confirmReading;

			p.host       = this.host;
			p.port       = this.port;
			p.SMTPSecure = this.SMTPSecure;
			p.SMTPAuth   = this.SMTPAuth;
			
			p.name 		 = this.name;
			p.email 	 = this.email;
			p.reply 	 = this.reply;
			p.user 	     = this.user;
			p.password   = this.password;
			p.crypt      = this.crypt;

			//-------------------------------------------------------------
			//p.name      = 'DayByDay App';
			//p.email 	  = 'daybyday.apps@gnnc.com.br';
			//p.reply 	  = 'daybyday.apps@gnnc.com.br';
			//p.user 	  = 'daybyday.apps@gnnc.com.br';
			//p.password  = 'Zm6qKZLzKmsg4mNfAGVk';
			//-------------------------------------------------------------

			p.subject    = this.subject;
			p.body       = this.body;
			p.altBody    = this.altBody;
			p.httpBody   = this.httpBody;

			p.SMTPDebug  = this.debug;

			p.to 		         = gnncJSON.encode(this.to.source as Object);
			p.attach             = gnncJSON.encode(this.attach.source as Object);
			p.findAndReplaceText = gnncJSON.encode(this.findAndReplaceText.source as Object);

			urlCheckConnect(urlServer,function(e:StatusEvent):void{
				file._noCacheFile = true;
				file.__loadUrl(urlServer,ifComplete,ifError,p,'POST',false);
			},1500,limitTimesTryConnect);
			
			function ifComplete(e:*=null):void
			{
				result = file._DATA_UTF;
				
				//remove tag web000 logo
				//-----------------------------------------------------------------
				var arr:Array = result.split('<!-- finish -->');
				result = arr.length==1 ? result : arr[0]+'</body></html>';
				//-----------------------------------------------------------------
				
				var o:Object = new Object();
				o.email = p.email;
				o.data = 'success';
				log.addItem(o);
				
				if(fComplete!=null)
					fComplete.call();
			}
			
			function ifError(e:*=null):void
			{
				result = file._DATA_UTF;

				var o:Object = new Object();
				o.email = p.email;
				o.data = 'error';
				log.addItem(o);

				if(fError!=null)
					fError.call();
			}
		}
		
		public function addFindAndReplaceText(find:String,replace:String):void
		{
			var o:Object = new Object();
			o.find = find;
			o.replace = replace;
			this.findAndReplaceText.addItem(o);
		}
		
		public function addAttach(name:String,http:String):void
		{
			var o:Object = new Object();
			o.name = name;
			o.http = http;
			this.attach.addItem(o);
		}

		public function getTo():ArrayCollection
		{
			return to;
		}
		
		public function addTo(email:String,name:String=''):void
		{
			email = gnncData.__trimText(email).toLowerCase();
			
			if(!email)
				return
			if( email.indexOf('@')<0 || email.indexOf(' ')>-1 || email.split('@').length>2 || email.length < 10 )
				return;
			
			var o:Object = new Object();
			o.name  = name ? name : '';
			o.email = email;
			
			this.to.addItem(o);
		}

		/**
		 * Only after all set data
		 * before sent()
		 * **/
		public function getKey():String
		{
			var s:String = '';
			s += gnncJSON.encode(this.findAndReplaceText.source as Object);
			return encrypt(s);
		}
		
		public function decrypt(e:String):String
		{
			return gnncCrypt.decrypt(e,'gnncMailer');
		}

		public function encrypt(e:String):String
		{
			return gnncCrypt.encrypt(e,'gnncMailer');
		}
		
		/**
		 * 
		 * function callback(e:StatusEvent):void {
		 *   if(conn.available==true){}
		 * }
		 * 
		 * **/
		public function urlCheckConnect(url:String,callBack:Function=null,pollInterval:uint=1500,times:uint=3):void
		{
			if(!url)
				return;
			
			conn = new URLMonitor(new URLRequest(url));
			conn.addEventListener(StatusEvent.STATUS, statusConnect);
			conn.pollInterval = pollInterval;
			
			if(callBack!=null)
				conn.addEventListener(StatusEvent.STATUS, callBack);

			conn.start();
			
			function statusConnect(e:StatusEvent):void 
			{
				if(connTimesOut == times){
					stop();
					return;
				}
				
				var available:Boolean = false;
				
				switch(e.code)
				{
					case "Service.available":
						available = true;
						break;
					case "Service.unavailable":
						available = false;
						break;
				}
				
				gnncGlobalLog.__add(e.code,'e:StatusEvent,e.code');
				
				if(conn.hasOwnProperty('available')==false)
					available = false;
				else if(conn.available==false)
					available = false;
				else if(conn.available==true)
					available = true;
				
				if(available==true){
					connStatus = true;
					connTimesOut = 0;
					gnncGlobalLog.__add('ping[success:'+connTimesOut+']:'+url);
					stop();
				}
				else if(available==false){
					connStatus = false;
					connTimesOut = connTimesOut+1;
					gnncGlobalLog.__add('ping[error:'+connTimesOut+']:'+url);
					urlCheckConnect(url,callBack,pollInterval,times);
				}
			}

		}

		private function stop():void
		{
			if(conn.hasOwnProperty('running')){
				if(conn.running){
					conn.stop();
					conn = null;
				}
			}
		}

		
	}
}