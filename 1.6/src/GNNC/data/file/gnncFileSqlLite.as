package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.events.SQLUpdateEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;

	public class gnncFileSqlLite
	{
		private var _parent:Object						= null;
		private var _gnncFiles:gnncFilesNative			= new gnncFilesNative();

		// sqlc is a variable we need to define the connection to our database
		public var _SQLc:SQLConnection 					= new SQLConnection();
		// sqlc is an SQLStatment which we need to execute our sql commands
		public var _SQLs:SQLStatement 					= new SQLStatement();
		
		public var _dataBaseFile:File					= null;
		
		// ArrayCollection used as a data provider for the datagrid. It has to be bindable so that data in datagrid changes automatically when we change the ArrayCollection
		[Bindable]
		public var DATA_ARR:ArrayCollection 			= new ArrayCollection();
		public var DATA_ROWS:uint						= 0;
		public var DATA_STG:String						= '';
		
		public var TRY:Boolean 							= false;
		public var _allowGlobalLoading:Boolean 			= true;
		public var _allowGlobalError:Boolean 			= true;
		
		[Bindable] public var _loading:Boolean 			= false;
		
		private var _fAfterResult:Function			 	= null;
		private var _fAfterError:Function			 	= null;
		private var _opended:Boolean					= false;
		private var _exists:Boolean					    = false;
		
		//private var _dbn:String = '';
		private var _ext:String = 'db';
		private var _pth:String = 'GNNC/DataBaseSqlLite';
		private var _loc:String = gnncFilesNative._documentDirectory;

		public function gnncFileSqlLite(parentApplication_:Object = null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent ;
		}

		public function __close():void
		{
			_dataBaseFile = null;
			_opended = false;
		}

		public function __connect(dataBaseName_:String,passWord_:String=''):void
		{
			_SQLc.addEventListener					(SQLEvent.OPEN			,__openedDataBase);
			//_SQLc.addEventListener					(SQLEvent.CLOSE			);
			_SQLc.addEventListener					(SQLErrorEvent.ERROR	,__fError);
			
			_SQLs.addEventListener					(SQLEvent.RESULT		,__fResult);
			_SQLs.addEventListener					(SQLErrorEvent.ERROR	,__fError);
			
			_SQLc.addEventListener					(SQLEvent.ANALYZE		,__loading);
			_SQLc.addEventListener					(SQLEvent.COMMIT		,__loading);
			_SQLc.addEventListener					(SQLUpdateEvent.DELETE	,__loading);
			_SQLc.addEventListener					(SQLUpdateEvent.INSERT	,__loading);
			_SQLc.addEventListener					(SQLUpdateEvent.UPDATE	,__loading);

			/*if(passWord_)
				if(!gnncEncryptKey.__validateStrongPassword(passWord_))
					return;*/
			
			if(!_opended){
				_exists = _gnncFiles.__fileExists(dataBaseName_,_ext,_pth,_loc);
				_SQLc.open(__openDataBase(dataBaseName_), _exists ? SQLMode.READ : SQLMode.CREATE ); //, false, 1024, passWord_ ? gnncEncryptKey.__getEncryptionKey(passWord_) : null
			}

		}
		
		private function __openDataBase(dataBaseName_:String):File
		{
			_dataBaseFile = _gnncFiles.__selectedLocationToSaveFile(dataBaseName_,_ext,_pth,_loc,false,false,false);
			//_dataBaseFile = File.documentsDirectory.resolvePath(_pth+'/'+_dbn+'.'+_ext);
			
			//if(!_dataBaseFile.exists)
			//	__openDataBase(dataBaseName_);
			
			return _dataBaseFile;
		}
		
		private function __loading(e:*):void
		{
			_loading 								= _SQLs.executing;
		}

		private function __openedDataBase(e:SQLEvent):void
		{
			_SQLs.sqlConnection 					= _SQLc;
			//_SQLs.itemClass 						= ClassObject whith itens;
			_opended								= true;
		}

		private function __fResult(e:SQLEvent):void
		{
			var result:SQLResult = _SQLs.getResult();

			if (!result)
				return;

			var data:Array 							= result.data;
			DATA_ARR 								= new ArrayCollection(data);
			DATA_ROWS								= (data)?data.length:0;
			DATA_STG								= (data)?data.toString():'';
			
			if(_fAfterResult != null)
				_fAfterResult.call(null);
		}

		private function __fError(e:*):void
		{
			var error:String						= '';
			if(TRY) error 							+= 'Detail: '  	+ e.toString()  + '\n';
			error 									+= 'Falha na conexão. Verifique seu banco de dados.'
			
			if(_allowGlobalError) 
				new gnncAlert().__error(error);
			
			if(_fAfterError != null)
				_fAfterError.call(null);
		}

		public function __query(sql_:String,fAfterResult_:Function=null,fAfterError_:Function=null,repeat_:uint=1):void
		{
			if(!_opended)
				return;
			
			_fAfterResult 	= fAfterResult_;
			_fAfterError 	= fAfterError_;
			
			var timer:Timer 						= new Timer(1000,repeat_);
			timer.addEventListener					(TimerEvent.TIMER,__tryAgain);
			
			function __tryAgain(event:*):void
			{ 
				__query(sql_,fAfterResult_,fAfterError_,repeat_);
			} 

			if(!_SQLs.executing)
			{
				try
				{
					_SQLs.text 							= sql_;
					_SQLs.execute						();
				}
				catch(e:*)
				{
					if(_fAfterError != null)
						_fAfterError.call(null);
				}
			}
			else 
			{
				timer.start							();
			}
		}
		
		public function __delete(tableName_:String,id_:uint,fAfterResult_:Function=null,fAfterError_:Function=null):void
		{
			__query("DELETE FROM "+tableName_+" WHERE ID = '"+id_+"'",fAfterResult_,fAfterError_);
		}

		public function __clear():void
		{
			DATA_ARR								= new ArrayCollection();
			DATA_ROWS								= 0;
			DATA_STG								= '';
		}
		
		public function __createSample(tableName_:String='daybydayTable'):void
		{
			if(!_opended)
				return;

			__query("CREATE IF NOT EXIST TABLE "+tableName_+" (ID INTEGER PRIMARY KEY AUTOINCREMENT, recipeName TEXT, authorName TEXT)");
			__query("INSERT INTO "+tableName_+" (recipeName, authorName) VALUES ('natan','"+gnncDate.__date2Legend('',new Date())+"')");
		}

	}
}

/*


INSERT INTO dbd_financial (VALUE_IN,DESCRIPTION) VALUES ('111','Destando...')


public function SET(TABLE:String,PARAMS:Object):void
{
PARAMS 							= new Object;
PARAMS['A'] 					= 'A1';
PARAMS['B'] 					= 'B2';

if(!_SQLs.executing){
_SQLs.text 					= 'INSERT INTO '+TABLE+' (NAME, SOBRENOME) VALUES(\''+PARAMS['A']+'\',\''+PARAMS['B']+'\')';
_SQLs.execute				();
__REFRESH						(TABLE);
}
}


public function __CREATE_TABLE(TABLE:String,PARAMS:Object):void
{
_SQLs.text 						= 'CREATE TABLE IF NOT EXISTS '+TABLE+' ( ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SOBRENOME TEXT )';
_SQLs.execute					();
}


*/