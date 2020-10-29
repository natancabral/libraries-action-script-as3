package GNNC.data.conn
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.system.gnncMemory;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.messages.IMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public dynamic class gnncAmfPhp3
	{
		/*
		//Existem duas maneira para iniciar uma conexão. 
		Static e New

		//Ambas precisam iniciar a instância
		gnncAmfPhp3.getInstance()
		new gnncAmfPhp3().getInstance()
		
		----------------------------------------------------------------------------
		* init amfphp
		----------------------------------------------------------------------------
		* getInstance : Start connection
		* file|class : php file on server, amfphp.php, myClass.php
		* func : function name on php file
		* arg : arguments String|int|Number|Object
		----------------------------------------------------------------------------

		sample 1
		gnncAmfPhp3.getInstance().send('file|class','func',[arg,arg]);
		
		sample 2
		new gnncAmfPhp3().getRemoteObject('file|class').getOperation('func').send(arg,arg);
		
		sample 3
		var b:gnncAMFPhp3Config = new gnncAMFPhp3Config();
		b._after_ResultEvent = function(e:*):void{ [list].dataProvider = gnncDataObject.__object2ArrayCollection(e.result); };
		b._after_FaultEvent  = function(e:*):void{ };
		b._logReference = 'logReference';
		b._logLegend    = 'logLegend';
		
		var a:gnncAmfPhp3 = gnncAmfPhp3.getInstance();
		a.setConfig(b);
		a.send('file|class','func',[arg,arg]);

		sample 4
		var b:gnncAMFPhp3Config = new gnncAMFPhp3Config();
		b._after_ResultEvent = function(e:*):void{ [list].dataProvider = gnncDataObject.__object2ArrayCollection(e.result); };
		b._after_FaultEvent  = function(e:*):void{ };
		b._logReference = 'logReference';
		b._logLegend    = 'logLegend';
		
		var a:gnncAmfPhp3 = gnncAmfPhp3.getInstance();
		a.setConfig(b);
		a.getRemoteObject('file|class').getOperation('func').send(arg,arg);
		
		sample 7
		var ro:RemoteObject = new RemoteObject;	
		ro.destination = "gnncServerNameSample"; 
		ro.source = "file|class";
		ro.addEventListener(ResultEvent.RESULT, handleResult);		
		function handleResult(event:ResultEvent):void{ [list].dataProvider = gnncDataObject.__object2ArrayCollection(e.result); }
		//or
		ro.func(arg,arg);
		//or
		ro.getOperation('func').send(arg,arg);
		
		*/
		
		//---------------------------------------------------------------------
		private var _parent:Object         			= null;
		//---------------------------------------------------------------------
		private static var instance:gnncAmfPhp3;
		protected var channelSet:ChannelSet         = null;
		protected var remoteObject:RemoteObject     = new RemoteObject();
		protected var makeObjectsBindable:Boolean   = false;
		protected var url:String                    = '';
		//---------------------------------------------------------------------
		public var connMessageId:String             = ''; //first Key/Id send to cliente remote connection
		public var connCorrelationId:String         = ''; //reponse to system with igual Key/Id
		public var connClientId:String              = ''; //everywere a new Id sented by remote server
		public var connTimestamp:Number             = 0; //last time
		//---------------------------------------------------------------------
		public const connectionUserLogin:String     = '[#011] Efetue o login com seu usuário e sua senha corretamente ou verifique sua internet.';
		public const connectionFaultInternet:String = '[#012] Falha ao estabelecer uma conexão simples.'; //Couldn't establish a connection to
		public const connectionFaultConnect:String  = '[#013] Falha ao estabelecer uma conexão com o servidor de arquivos. Verifique sua internet.';
		public const connectionFaultService:String  = '[#014] Falha no arquivo de conexão.';
		public const connectionFaultDetail:String   = '[#015] Falha na execução da Classe de conexão, solicite a verificação no arquivo.';
		public const connectionFaultMethod:String   = '[#016] Falha na execução do Método no arquivo de conexão.';
		//---------------------------------------------------------------------
		//AmfPhp 2.2.2
		//---------------------------------------------------------------------		
		public var errorMessConnect:String          = 'Send failed';          // (Send failed) - Nao conseguiu estabelecer conexão
		public var errorMessService:String          = 'service not found';    // (gnncAmfPhp service not found ) - Arquivo nao encontrado
		public var errorMessDetail:String           = 'Channel disconnected'; // (Channel disconnected)
		public var errorMessMethod:String           = 'not found on';         // (method gnncAmfPhp not found on gnncAmfPhp object )
		//---------------------------------------------------------------------
		public var config:gnncAMFPhp3Config         = new gnncAMFPhp3Config();
		//---------------------------------------------------------------------		
		
		public var dataObj:Object          			= null;
		public var dataArr:ArrayCollection 			= new ArrayCollection();
		public var dataStr:String          			= '';
		public var dataRows:uint           			= 0;
		
		public var dataErr:Object          			= null; // error
		public var dataRes:Object          			= null; // result
		public var dataMss:Object          			= null; // message
		
		public var _try:Boolean 					= false;
		public var _allowGlobalLoading:Boolean 		= true;
		public var _allowGlobalError:Boolean 		= true;
		
		[Bindable] public var _loading:Boolean 		= false;
		[Bindable] public var _connections:uint		= 0;
		
		protected var _sqlCache:String				= '';
		
		public var _after_ResultEvent:Function	= function(event:ResultEvent):void{};
		public var _after_FaultEvent:Function	= function(event:FaultEvent ):void{};
		
		//http://stackoverflow.com/questions/9416867/multiple-calls-to-amfphp-using-singleton-pattern-on-netconnection
		//gnncAmfPhp3.getInstance().getNewRemoteObject()
		//gnncAmfPhp3.getInstance().getNewRemoteObject().getOperation("multipleSql").send(new table_sql("select * from dbd_login where ID > 0 ; select * from dbd_login where ID > 0"));
		
		public function gnncAmfPhp3(parentApplication_:Object=null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;

			var chanel:AMFChannel = new AMFChannel("gnnc-amfphp-v2.2.2-AMFChannel", getUrl());
			this.channelSet       = new ChannelSet();
			this.channelSet.addChannel(chanel);
		}
		
		private function getUrl():String
		{
			url = gnncGlobalStatic._httpDomain + gnncGlobalArrays.serverGateway;
			//url = 'http://127.0.0.1/' + gnncGlobalArrays.serverGateway;
			return url;
		}
		
		static public function getInstance(force:Boolean=false):gnncAmfPhp3
		{
			if(force){ //to multi connections send all time
				instance = new gnncAmfPhp3();
			}else if(instance == null){
				instance = new gnncAmfPhp3();
			}
			//instance = new gnncAmfPhp3();
			//remoteObject = new RemoteObject();
			return instance;
		}
		
		/*public function getInstance():gnncAmfPhp3
		{
			if(instance == null){
				instance = new gnncAmfPhp3();
				gnncGlobalLog.__add('NULL--------------------------------------------------');
			}else{
				gnncGlobalLog.__add('TRUE--------------------------------------------------');
				instance = new gnncAmfPhp3();
			}				
			//remoteObject = new RemoteObject();
			return instance;
		}*/
		
		/*
		protected function getChannelSet():ChannelSet{
		  return channelSet;
		}
		*/

		public function setConfig(obj:gnncAMFPhp3Config):gnncAmfPhp3
		{
			config = obj;
			
			if(remoteObject.willTrigger(ResultEvent.RESULT) && _after_ResultEvent != null) remoteObject.removeEventListener(ResultEvent.RESULT, _after_ResultEvent);
			if(remoteObject.willTrigger(FaultEvent.FAULT)   && _after_FaultEvent  != null) remoteObject.removeEventListener(FaultEvent.FAULT,   _after_FaultEvent);
			
			_after_ResultEvent  = config._after_ResultEvent;
			_after_FaultEvent   = config._after_FaultEvent;
			
			if(config._after_ResultEvent != null) remoteObject.addEventListener(ResultEvent.RESULT, config._after_ResultEvent ,false,0,true);
			if(config._after_FaultEvent != null)  remoteObject.addEventListener(FaultEvent.FAULT,   config._after_FaultEvent  ,false,0,true);
			
			return instance;
		}

		public function getRemoteObject(channel:String=''):RemoteObject
		{
			if(instance == null)
				getInstance();
				//new gnncAlert().__alert('Start getInstance first.');

			if(remoteObject == null)
				remoteObject = new RemoteObject();

			if(!channel && !config._channel && !remoteObject.source)
				new gnncAlert().__alert('Set channel on file config.');
			else
				remoteObject.source = channel ? channel : config._channel ? config._channel : remoteObject.source ; //file/class

			remoteObject.destination         = 'gnnc-destination';
			remoteObject.concurrency         = 'single'; // single | multiple | last
			remoteObject.requestTimeout      = 120;
			remoteObject.makeObjectsBindable = this.makeObjectsBindable;
			
			// new connection id
			if(channelSet)
				remoteObject.channelSet = channelSet;

			initEventListener();

			return remoteObject;
		}

		/**
		 * channel:String   = file php and class name\n
		 * method:String    = function on class file\n
		 * arguments:Array  = parans array send to function\n
		 * 
		 */
		public function send(channel:String = '',method:String = '' , arguments:Array=null):void
		{
			if(_connections>20)
				return;
			
			getRemoteObject();
			
			//_className = TABLE_.hasOwnProperty('_TABLE') ? TABLE_['_TABLE'] : TABLE_.hasOwnProperty('_className') ? TABLE_._className : new table_sql()._TABLE;			
			// Specify the PHP class //arquivo php que estou tentando conectar, sem .php. [ arquivo.php = arquivo ]
			
			if(!channel && !config._channel && !remoteObject.source)
				new gnncAlert().__alert('Set channel on file config.');
			else
				remoteObject.source = channel ? channel : config._channel ? config._channel : remoteObject.source ; //file/class

			if(method)
				remoteObject.getOperation(method).send.apply(null,arguments);
			//remoteObject.getOperation(method).send(arguments);

			/*
			//remoteObject.gnncAmfPhp(); //get function
			if(method && arguments == null)
				remoteObject.getOperation(method);
				//remoteObject.gnncAmfPhp(); //get function AND paramns
			else if(method && arguments)
				remoteObject.getOperation(method).send(arguments);
			*/
			
			//remoteObject.initialize();
		}

		public function set query(o:Object):void
		{
		}
		
		public function set select(o:Object):void
		{
		}
		
		public function set remove(o:Object):void
		{
		}
		
		public function set update(o:Object):void
		{
		}

		protected function IMessageEvent(event:*):void
		{
			var IM:IMessage        = IMessage(event.message);
			this.connClientId      = Object(IM).hasOwnProperty('clientId')  ? IM.clientId  : 'no-clientId' ;
			this.connCorrelationId = Object(event.message).hasOwnProperty('correlationId')?Object(event.message).correlationId:''; 
			this.connMessageId     = Object(IM).hasOwnProperty('messageId') ? IM.messageId : 'no-messageId' ; //id solicitation
			this.connTimestamp     = Object(IM).hasOwnProperty('timestamp') ? IM.timestamp : 0 ; 
		}
		
		
		protected function eventInvoke(event:InvokeEvent):void
		{
			loadingData(true);
			IMessageEvent(event);
			
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss = String(event.message);

			gnncGlobalLog.__add("Invoke: "+this.dataMss);
		}
		
		protected function eventResult(event:ResultEvent):void 
		{
			this.dataObj  = event.result;
			
			if(this.dataObj){
				this.dataArr  = gnncDataObject.__object2ArrayCollection(dataObj);
				this.dataStr  = dataObj.toString();
				this.dataRows = dataArr.length; //gnncDataObject.__getTotalAMFPhp(dataObj);
			}else{
				this.clear();
			}

			if(gnncGlobalStatic._debug == true){
				IMessageEvent(event);
			}

			//if(this.connMessageId != this.connCorrelationId)
			//	this.connMessageId     = IM.messageId; //id solicitation 

			//confere se a mesma reposta é da mesma instancia
			/*if(this.connMessageId == this.connCorrelationId){
				new gnncAlert().__alert(this.dataStr,this.connMessageId);
			}else{
				new gnncAlert().__alert(this.connMessageId,this.connCorrelationId);
			}*/

			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = String(event.message);

			if(gnncGlobalStatic._debug == true){

				this.dataRes  += "\n------------------------------------------\n";
				this.dataRes  += 'StatusCode: ' + event.statusCode         + '\n';
				this.dataRes  += 'Rows:       ' + this.dataRows            + '\n';
				this.dataRes  += 'Result:     ' + event.result.toString()  + '\n';
				this.dataRes  += 'Message:    ' + ( event.hasOwnProperty('message') ? String(event.message) : '' ) + '\n';				

				gnncGlobalLog.__addSuccess(this.dataRes);

				/*
				gnncGlobalLog.__add(gnncDataObject.__getClassName(dataObj),'__getClassName');
				gnncGlobalLog.__add(gnncDataObject.__getPropertysNames(dataObj),'__getPropertysNames');
				gnncGlobalLog.__add(gnncDataObject.__getPropertysNamesAMFPhp(dataObj),'__getPropertysNamesAMFPhp');

				if(this.dataRows>1){
				new gnncAlert().__dataGrid(this.dataArr,'Arr:'+this.connCorrelationId);
				//new gnncAlert().__dataGrid(this.dataObj,'Obj:'+this.connCorrelationId);
				}
				*/

			}
			
			loadingData(false);
			//clear memory
			gnncMemory.__clear();
		}
		
		protected function eventFault(event:FaultEvent):void 
		{
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = String(event.message);

			IMessageEvent(event);

			/*if(!gnncGlobalStatic._userId){
			new gnncAlert().__error(this.connectionUserLogin);
			return;
			}*/
			
			this.dataErr += "\n-----------------------------------------------\n";
			this.dataErr += 'MessageId: ' + event.messageId                  + '\n';
			this.dataErr += 'Headers:   ' + event.headers                    + '\n';
			this.dataErr += 'ErrorID:   ' + event.fault.errorID              + '\n';
			this.dataErr += 'Detail:    ' + event.fault.faultDetail          + '\n';
			this.dataErr += 'Fault:     ' + event.fault.toString()  	     + '\n';
			this.dataErr += 'Error:     ' + event.fault.faultString  		 + '\n';
			this.dataErr += 'Code:      ' + event.fault.faultCode.toString() + '\n';
			this.dataErr += 'Message:   ' + dataMss + '\n';

			//if(this.connMessageId != this.connCorrelationId)
			//	this.connMessageId = IM.messageId; //id solicitation 
			
			gnncGlobalLog.__addError(this.dataErr);
			
			if(_allowGlobalError      && event.fault.faultString.indexOf(this.errorMessConnect) > -1 )
				new gnncAlert().__error(connectionFaultConnect);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessService) > -1 )
				new gnncAlert().__error(connectionFaultService);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessDetail)  > -1 )
				new gnncAlert().__error(connectionFaultDetail);
			else if(_allowGlobalError && event.fault.faultString.indexOf(this.errorMessMethod)  > -1 )
				new gnncAlert().__error(connectionFaultMethod);
			else if(_allowGlobalError)
				new gnncAlert().__error(this.connectionFaultInternet);

			//clear memory
			gnncMemory.__clear();
			loadingData(false);
		}
		
		public function clear():void
		{
			//System.disposeXML(DATA_XML);
			
			this.dataObj  = null;
			this.dataArr  = new ArrayCollection();
			this.dataStr  = ''; 
			this.dataRows = 0;
			
			this.dataErr  = new Object();
			this.dataRes  = new Object();
			this.dataMss  = new Object();
			
			this.connClientId      = ''; 
			this.connCorrelationId = ''; 
			this.connMessageId     = ''; 
			this.connTimestamp     = 0; 

			//gnncGlobalLog.__add	('AmfClearAll');
		}
		
		private function initEventListener():void
		{
			//clear();
			//remoteObject = new RemoteObject();
			if(remoteObject.willTrigger(InvokeEvent.INVOKE)==false){
				remoteObject.addEventListener(InvokeEvent.INVOKE, eventInvoke ,false, 1, true);
				remoteObject.addEventListener(ResultEvent.RESULT, eventResult ,false, 1, true);
				remoteObject.addEventListener(FaultEvent.FAULT,   eventFault  ,false, 1, true);
			}
		}
		
		public function destroy():void
		{
			if(remoteObject.willTrigger(InvokeEvent.INVOKE)){
				remoteObject.removeEventListener(InvokeEvent.INVOKE, eventInvoke ,false);
				remoteObject.removeEventListener(ResultEvent.RESULT, eventResult ,false);
				remoteObject.removeEventListener(FaultEvent.FAULT,   eventFault  ,false);
			}
			if(_after_ResultEvent != null) remoteObject.removeEventListener	(ResultEvent.RESULT, _after_ResultEvent	,false);
			if(_after_FaultEvent  != null) remoteObject.removeEventListener	(FaultEvent.FAULT, 	 _after_FaultEvent	,false);
			if(_loading) loadingData(false);
			
			//__initialize();
			clear();
		}
		
		public function refresh():void
		{
			var _arrCache:Array = null;
			_arrCache = _sqlCache.split(gnncGlobalStatic._breakSql);
			_sqlCache = String(_arrCache[0]);
			if( _sqlCache.substr(0,10).toUpperCase().indexOf('SELECT')>-1 ){
				//var config:gnncAMFPhp3Config = new gnncAMFPhp3Config();
				//config._query = 
				//query(_sqlCache,'','',_after_ResultEvent,_after_FaultEvent);
			}
		}
		
		protected function loadingData(load:Boolean):void 
		{
			load == true ? _connections++ : _connections-- ;
			if(_allowGlobalLoading){
				if(FlexGlobals.topLevelApplication.hasOwnProperty('_START'))
					// start global _loading
					FlexGlobals.topLevelApplication._START._gnncGlobal._loading = _loading = (_connections>0)?true:false;
				else
					// no global neither start
					_loading = (_connections>0)?true:false;
			}else{
				_loading = (_connections>0)?true:false;
			}
		}	
		
	}
}


/*

//var channelSet:ChannelSet = new ChannelSet();
protected var remoteObject:RemoteObject = new RemoteObject();

<mx:ChannelSet id="channelSet">
<mx:channels>
<mx:AMFChannel uri="http://localhost/amfphp/gateway.php"/>
</mx:channels>
</mx:ChannelSet>
<mx:RemoteObject source="TestService" destination="amfphp" 
channelSet="{channelSet}" id="remoteObject"
fault="trace('Fault: '+event.fault)" 
result="trace('Result: '+event.result)"/>

public function test():void
{
channelSet.channels = [new AMFChannel('id',getUrl())];

remoteObject.source      = 'TestService';
remoteObject.destination = 'amfphp';
remoteObject.channelSet  = channelSet;
remoteObject.addEventListener(FaultEvent.FAULT,remoteObjectFault);
remoteObject.addEventListener(ResultEvent.RESULT,remoteObjectResult);

function remoteObjectFault(e:FaultEvent):void
{

}

function remoteObjectResult(e:FaultEvent):void
{

}

var channel:AMFChannel    = new AMFChannel("my-amfphp", getUrl());
var channelSet:ChannelSet = new ChannelSet();
channelSet.addChannel(channel);
//channel name - 
var ro:RemoteObject = new RemoteObject("amfphp");
ro.channelSet = channelSet;
// Specify the PHP class
ro.source = "TestService";
ro.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void {
Alert.show("Fault: " + event.fault);
});
ro.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void {
Alert.show("Result: " + event.result);
});
// the TestService class must have a public helloWorld function
ro.helloWorld();
}*/