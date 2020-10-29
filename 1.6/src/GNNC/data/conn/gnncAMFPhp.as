package GNNC.data.conn
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.sqlTables.table_sql;
	import GNNC.system.gnncMemory;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public dynamic class gnncAMFPhp 
	{
		private var _parent:Object						= null;
		
		[Bindable] public var DATA_ARR:ArrayCollection 	= new ArrayCollection();
		public var DATA_OBJ:Object			= null;
		public var DATA_ROWS:uint			= 0;
		public var DATA_STG:String			= '';
		
		public var TRY:Boolean 							= false;
		public var _allowGlobalLoading:Boolean 			= true;
		public var _allowGlobalError:Boolean 			= true;
		
		[Bindable] public var _loading:Boolean 			= false;
		[Bindable] public var _connections:uint			= 0;

		/** last single multiple **/
		public var _requestsType:String					= 'multiple';
		/** single multiple **/
		public var _returnType:String					= 'single';
		public var _error:String						= '';
		
		protected var _className:String 				= 'className';
		protected var _paramns:Object					= null;
		protected var _rObject:RemoteObject				= new RemoteObject();
		protected var _sqlCache:String					= '';
		
		protected var _after_ResultEvent:Function		= function(event:ResultEvent):void{};
		protected var _after_FaultEvent:Function		= function(event:FaultEvent ):void{};
		
		public function gnncAMFPhp(parentApplication_:Object=null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
			__initialize();
		}
		
		public function __initialize():void
		{
			__clear();
			_rObject.addEventListener					(InvokeEvent.INVOKE,	__execInvoke	,false,1,true);
			_rObject.addEventListener					(ResultEvent.RESULT,	__execResult	,false,1,true);
			_rObject.addEventListener					(FaultEvent.FAULT, 		__execFault		,false,1,true);
		}
		
		public function __destroy():void
		{
			if(_rObject.willTrigger(InvokeEvent.INVOKE))
			{
				_rObject.removeEventListener			(InvokeEvent.INVOKE,	__execInvoke		,false);
				_rObject.removeEventListener			(ResultEvent.RESULT,	__execResult		,false);
				_rObject.removeEventListener			(FaultEvent.FAULT, 		__execFault			,false);
			}
			
			if(_after_ResultEvent != null)				_rObject.removeEventListener	(ResultEvent.RESULT,	_after_ResultEvent	,false);
			if(_after_FaultEvent != null)				_rObject.removeEventListener	(FaultEvent.FAULT, 		_after_FaultEvent	,false);
			
			if(_loading)
				__loadingData(false);
			
			//__initialize();
		}


		public function __sqlRefresh():void
		{
			if(_sqlCache.substr(0,10).toUpperCase().indexOf('SELECT')>-1)
			{
				__sql(_sqlCache,'','',_after_ResultEvent,_after_FaultEvent);
			}
		}

		public function __sql(daybydaySql_:String,MESSAGE_RESULT_:String='',MESSAGE_FAULT_:String='',fResultEvent_:Function=null,fFaultEvent_:Function=null):void
		{
			/** FOR SECURITY **/
			//if(DAYBYDAY_SQL_.indexOf("DELETE"))
				//Alert.show('Deseja mesmo excluir sem volta?','Aviso!',4,null,
					//function(event:CloseEvent):void{ 
					//	if(event.detail == Alert.YES){SQL_SECURITY = SQL;}else{SQL_SECURITY = ''}
				//}	
			//)

			_returnType = 'single';
			_sqlCache	= daybydaySql_;

			gnncGlobalLog.__add(daybydaySql_);
			//gnncGlobalLog.__add(connCrypt.encrypt(daybydaySql_),'Encrypt');

			__exec		('sql',new table_sql(daybydaySql_),null,MESSAGE_RESULT_,MESSAGE_FAULT_,fResultEvent_,fFaultEvent_);
		}
		
		public function __sqlMultiple(daybydaySql_:String,fResultEvent_:Function=null,fFaultEvent_:Function=null):void
		{
			_returnType = 'multiple';
			_sqlCache	= daybydaySql_;
			
			gnncGlobalLog.__add(daybydaySql_);
			//gnncGlobalLog.__add(connCrypt.encrypt(daybydaySql_),'Encrypt');

			__exec		('multipleSql',new table_sql(daybydaySql_),null,'','',fResultEvent_,fFaultEvent_);
		}

		public function __exec(DAYBYDAY_METHOD_OR_SQL:String,TABLE_:Object,DAYBYDAY_PAGE:Object=null,MESSAGE_RESULT_:String='',MESSAGE_FAULT_:String='',AFTER_ResultEvent_:Function=null,AFTER_FaultEvent_:Function=null):void
		{
			if(_connections<10)
			{
				_className							= TABLE_.hasOwnProperty('_TABLE') ? TABLE_['_TABLE'] : TABLE_.hasOwnProperty('_className') ? TABLE_._className : new table_sql()._TABLE;
				//new gnncAlert().__alert(_className+'<'+gnncGlobalStatic._serverName+'<'+DAYBYDAY_METHOD_OR_SQL+'<'+TABLE_);

				_rObject.concurrency				= _requestsType;
				_rObject.makeObjectsBindable 		= false;
				_rObject.requestTimeout				= 120;
				_rObject.destination 				= gnncGlobalStatic._serverName?gnncGlobalStatic._serverName:'gnncServer';
				_rObject.source						= _className;

				if(_rObject.willTrigger(ResultEvent.RESULT) && _after_ResultEvent != null)	_rObject.removeEventListener(ResultEvent.RESULT,	_after_ResultEvent);
				if(_rObject.willTrigger(FaultEvent.FAULT)   && _after_FaultEvent  != null)	_rObject.removeEventListener(FaultEvent.FAULT,		_after_FaultEvent);

				_after_ResultEvent					= AFTER_ResultEvent_;
				_after_FaultEvent					= AFTER_FaultEvent_;

				if(AFTER_ResultEvent_ != null) 		_rObject.addEventListener(ResultEvent.RESULT,		AFTER_ResultEvent_		,false,0,true);
				if(AFTER_FaultEvent_ != null) 		_rObject.addEventListener(FaultEvent.FAULT, 		AFTER_FaultEvent_		,false,0,true);

				__initialize();

				_rObject.getOperation				(DAYBYDAY_METHOD_OR_SQL).send(TABLE_);

				//gnncGlobalLog.__add('concurrency : '		+_requestsType);
				//gnncGlobalLog.__add('requestTimeout : '		+_rObject.requestTimeout);
				//gnncGlobalLog.__add('destination : '		+_rObject.destination);
				//gnncGlobalLog.__add('className : '			+_className);
				//gnncGlobalLog.__add('table : '				+TABLE_);
				//gnncGlobalLog.__add('sqlOrMethod : '		+DAYBYDAY_METHOD_OR_SQL);

				if(TRY)
					new gnncAlert().__alert("className:"+_className+"\n"+"Method:"+DAYBYDAY_METHOD_OR_SQL+"\n"+"returnType:"+_returnType+"\n_rObject.destination"+_rObject.destination);
			}
		}
		
		protected function __execInvoke(event:InvokeEvent):void
		{
			__loadingData							(true);
		}
		
		protected function __execResult(event:ResultEvent):void 
		{
			//gnncGlobalLog.__addSuccess('successAmfPhp');

			if(_returnType=='single')
			{
				if(event.result)
				{
					var GET_OBJ:Object 					= event.result; 
					
					DATA_OBJ							= GET_OBJ;
					DATA_ROWS 							= gnncDataObject.__getTotalAMFPhp(DATA_OBJ);
					DATA_ARR 							= gnncDataObject.__object2ArrayCollection(DATA_OBJ);
					DATA_STG							= event.result.toString();
					//DATA_LAST_ID 						= DBD_OBJECT.OBJECT2ID(DATA_OBJ);
				}
			}
			else if(_returnType=='multiple')
			{
				if(event.result)
				{
					var GET_OBJ2:Object 				= event.result[0]; 
					
					DATA_OBJ							= GET_OBJ2;
					DATA_ROWS 							= gnncDataObject.__getTotalAMFPhp(GET_OBJ2);
					DATA_ARR 							= gnncDataObject.__object2ArrayCollection(GET_OBJ2);
					DATA_STG							= event.result.toString();
					//DATA_LAST_ID 						= DBD_OBJECT.OBJECT2ID(DATA_OBJ);
				}
			}
			
			if(TRY)
				new gnncAlert().__alert('DATA_STG:'+DATA_STG);
			
			__loadingData							(false);
			gnncMemory.__clear						();
		}

		protected function __execFault(event:FaultEvent):void 
		{
			__loadingData							(false);
			gnncMemory.__clear						();
			_error 									= '';

			if(!gnncGlobalStatic._userId && _allowGlobalError && !TRY)
			{
				new gnncAlert().__error('Efetue o login com seu usuário e sua senha corretamente ou verifique sua internet.');
				return;
			}
			
			var err:String = ''+
				"\nDetail:" + event.fault.faultDetail.toString() +
				"\nError: " + event.fault.faultString +
				"\nCode:  " + event.fault.faultCode.toString();

			if(TRY) 
				_error += err;

			gnncGlobalLog.__addError(err);
			
			_error += 'Falha na conexão. Verifique sua internet.';

			//gnncGlobalLog.__addError('AmfError : '	+_error);

			if(_allowGlobalError)
				gnncAlert.__delete(_error);
			
		}
		
		public function __clear():void
		{
			//System.disposeXML						(DATA_XML);

			DATA_OBJ								= null;
			DATA_ROWS								= 0;
			DATA_ARR								= new ArrayCollection();
			_paramns								= null;
			
			//gnncGlobalLog.__add	('AmfClearAll');
		}
		
		protected function __loadingData(load_:Boolean):void 
		{
			load_==true ? _connections++ : _connections-- ;

			if(_allowGlobalLoading)
				gnncGlobalStatic.loading = _loading = (_connections>0)?true:false;
			else
				_loading = (_connections>0)?true:false;
		}		
	}
}
