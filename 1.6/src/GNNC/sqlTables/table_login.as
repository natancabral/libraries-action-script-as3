package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_login
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

		public var _TABLE:String 			= 'LOGIN';

		public var ID:uint					= 0;
		public var ID_CLIENT:uint			= 0;
		public var ID_GROUP:uint			= 0; 	//Permissions group
		
		public var USER:String				= '';	//User Name Login
		public var USER_EMAIL:String		= '';	//User Email 
		public var PASSW:String				= '';	//PassWord Simple
		public var PASSWSUPER:String		= '';	//PassWord Super
		public var PASSW_CHANGE:uint		= 0;	//Request change PassWord

		public var IS_ADMIN:uint		    = 0;
		public var IS_CLIENT:uint		    = 0;
		
		public var UTC:String				= '';	//UTC/GMT
		public var SUMMER_TIME:uint			= 0;	//Daylight Saving Time DST -> 0/1
		
		public var TOKEN:String				= '';	//To change, to authentication, to security

		public var ACTIVE:uint				= 1;	//active or not

		public function table_login(ID_:uint=0,gnncGlobal_:Object=null)
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