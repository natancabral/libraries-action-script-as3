package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_comment
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
		
		public var _TABLE:String 		= 'COMMENT';
		
		public var ID:uint				= 0;
		public var ID_KEY:String		= '';

		//public var ID_CLIENT_OF_USER:uint = 0; //quem inseriu

		public var ID_CLIENT:uint		= 0;	
		public var ID_PROJECT:uint		= 0;	
		public var ID_STEP:uint			= 0;
		public var ID_JOB:uint			= 0;
		
		public var ID_USER:uint			= 0; //quem inseriu
		public var ID_CLIENT_INSERT:uint = 0; //quem inseriu

		public var ID_CLIENT_REPLY:uint = 0;
		public var ID_COMMENT_REPLY:uint = 0;

		public var ID_FATHER:uint = 0;
		public var LEVEL:uint = 0;
		
		public var ID_MIX:uint			= 0;
		public var MIX:String			= '';

		public var DATE_FINAL:String	= '';
		public var DATE_CANCELED:String	= '';
		
		public var MESSAGE:String		= '';

		public var PUBLIC:uint			= 0;

		public var ACTIVE:uint			= 0;
		public var CONTROL:uint			= 0;
		public var VISIBLE:uint			= 1;
		
		public function table_comment(ID_:uint=0)
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

				_PROGRAMNAME				= gnncGlobalStatic._programName;
				_PROGRAMID					= gnncGlobalStatic._programId; 
				_PROGRAMVERSION 			= gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL			= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL				= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
			}
		}
	}
}