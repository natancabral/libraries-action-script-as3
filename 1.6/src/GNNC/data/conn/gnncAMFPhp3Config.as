package GNNC.data.conn
{
	import GNNC.data.data.json.gnncJSON;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class gnncAMFPhp3Config
	{
		/*
		public var _KEY:String;
		public var _KEY_SQL:String;
		public var _BREAK_SQL:String;
		public var _PROGRAMNAME:String;
		public var _PROGRAMID:uint;
		public var _PROGRAMVERSION:String;
		public var _CLIENTIDGENERAL:uint;
		public var _USERIDGENERAL:uint;
		public var _DATABASE:String;
		*/

		/* ------------------------------------------------------------------------ */

		public var _key:String				= '';
		public var _keySql:String			= '';
		public var _breakSql:String;
		public var _programName:String		= '';
		public var _programId:uint			= 0;
		public var _programVersion:String	= '';
		public var _clientIdGeneral:uint	= 0;
		public var _userIdGeneral:uint		= 0;
		public var _dataBase:String			= '';
		public var _data:String			    = '';
		
		/* ------------------------------------------------------------------------ */
		
		public var _channel:String      = 'gnncAmfPhp'; //channel class
		public var _method:String       = 'gnncAmfPhp'; //method function
		public var _arguments:Array     = null; //arguments
		public var _query:Array         = null; //sql
		
		public var _logReference:String = '';   //simple name to log
		public var _logLegend:String    = '';   //description log

		public var _after_ResultEvent:Function	= function(event:ResultEvent):void{};
		public var _after_FaultEvent:Function	= function(event:FaultEvent ):void{};
		
		/* ------------------------------------------------------------------------ */
		
		public function set channel(name:String):void{
			_channel = name;
		}
		
		public function set method(name:String):void{
			_method = name;
		}
		
		public function set arguments(... args:Array):void{
			_arguments = args;
		}
		
		public function set query(... args:Array):void{
			_query = args;
		}

		/**
		 * 	Reference //simple name to log
		 */
		public function set reference(str:String):void{
			_logReference = str;
		}
		/**
		 *  Legend    //description log
		 */
		public function set legend(str:String):void{
			_logLegend = str;
		}
		
		public function gnncAMFPhp3Config()
		{
			table_info();
		}
		
		public function table_info():void
		{
			_key						= gnncGlobalStatic._keyClient;
			_keySql						= gnncGlobalStatic._keySql;
			_breakSql					= gnncGlobalStatic._breakSql;
			_programName				= gnncGlobalStatic._programName;
			_programId					= gnncGlobalStatic._programId; 
			_programVersion 			= gnncGlobalStatic._programVersion;
			_clientIdGeneral			= gnncGlobalStatic._clientGeneralId;
			_userIdGeneral				= gnncGlobalStatic._userId;
			_dataBase					= gnncGlobalStatic._dataBase;

			var _o:Object   = new Object();
			_o.keyServer    = ''; //token accept
			_o.keyClient    = gnncGlobalStatic._keyClient;
			_o.keySql       = gnncGlobalStatic._keySql;
			_o.breakSql     = gnncGlobalStatic._breakSql;
			_o.progName     = gnncGlobalStatic._programName;
			_o.progId       = gnncGlobalStatic._programId;
			_o.progVersion  = gnncGlobalStatic._programVersion;
			_o.companyUnit  = ''; //filial
			_o.userId       = gnncGlobalStatic._userId;
			_o.userIdClient = gnncGlobalStatic._clientGeneralId;
			_o.dbn          = gnncGlobalStatic._dataBase; //sigla
			
			_data = gnncJSON.encode(_o);
		}
	}
}