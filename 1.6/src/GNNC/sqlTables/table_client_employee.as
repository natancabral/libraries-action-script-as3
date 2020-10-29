package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_client_employee
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

		public var _TABLE:String 					= 'CLIENT_EMPLOYEE';

		public var ID:uint							= 0;
		public var ID_DEPARTAMENT:uint				= 0;

		public var ID_CLIENT_EMPLOYEE:uint			= 0;
		public var LEVEL:uint			            = 0;
		public var ID_CLIENT_BOSS_1:uint			= 0;
		public var ID_CLIENT_BOSS_2:uint			= 0;
		public var ID_SERIES_CARGO:uint				= 0;
		public var ID_SERIES_FUNCAO:uint			= 0;
		public var SCHOOL_LEVEL:String				= ''; //fun/med/sup
		public var IS_MANAGER:uint					= 0;

		public var DATE:String						= '';
		public var DATE_START:String				= '';
		public var DATE_OUT:String					= '';

		public var ID_GROUP:uint					= 0;
		public var ID_CATEGORY:uint					= 0;

		public var ACTIVE:uint						= 1;

		public function table_client_employee(ID_:uint=0)
		{
			ID = ID_;
			table_info();
		}

		public function table_info():void
		{
			if(_TABLE)
			{
				_KEY								= gnncGlobalStatic._keyClient;
				_KEY_SQL							= gnncGlobalStatic._keySql;
				_BREAK_SQL							= gnncGlobalStatic._breakSql;

				_PROGRAMNAME						= gnncGlobalStatic._programName;
				_PROGRAMID							= gnncGlobalStatic._programId; _PROGRAMVERSION = gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL					= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL						= gnncGlobalStatic._userId;
				_DATABASE							= gnncGlobalStatic._dataBase;
			}
		}
	}
}