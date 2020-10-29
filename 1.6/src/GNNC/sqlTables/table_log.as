package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_log
	{
		public var _KEY:String;
		public var _KEY_SQL:String;
		public var _BREAK_SQL:String;
		public var _PROGRAMNAME:String;
		public var _PROGRAMID:uint;
		public var _PROGRAMVERSION:String;
		public var _CLIENTIDGENERAL:uint;
		public var _USERIDGENERAL:uint;
		public var _DATABASE:String;
		
		public var _TABLE:String 				= 'LOG';
		
		public var ID:uint						= 0;
		public var ID_CLIENT:uint				= 0;
		public var ID_USER:uint					= 0;
		public var ID_PROGRAM:uint				= 0;
		public var PROGRAMVERSION:String		= '';

		public var TABLE_NAME:String			= '';
		public var ACTION:String				= '';
		public var MESSAGE:String				= '';

		public var DATE:String					= '';
		
		public function table_log(ID_:uint=0)
		{ 
			ID = ID_;
			table_info();
		}
		
		public function table_info():void
		{
			if(_TABLE)
			{
				_KEY						= gnncGlobalStatic._keyClient;
				_KEY_SQL					= gnncGlobalStatic._keySql;
				_BREAK_SQL					= gnncGlobalStatic._breakSql;

				_PROGRAMNAME					= gnncGlobalStatic._programName;
				_PROGRAMID					= gnncGlobalStatic._programId; 
				_PROGRAMVERSION = gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL				= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL					= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
			}
		}
	}
}