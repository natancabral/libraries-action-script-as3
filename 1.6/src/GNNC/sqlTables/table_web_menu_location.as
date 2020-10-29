package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_web_menu_location
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
		
		public var _TABLE:String				= 'WEB_MENU_LOCATION';
		
		public var ID:uint						= 0;
		public var ID_FATHER:uint				= 0;
		public var LEVEL:uint					= 0;
		public var MIX:String					= 'WEB_MENU_LOCATION';
		public var NAME:String					= '';
		public var NAME_FRIENDLY:String			= '';
		
		public var DESCRIPTION:String			= '';
		
		public var COLOR:String					= '';
		public var COLOR_TEXT:String			= '';
		
		/** IN ALL TABLES **/
		public var ACTIVE:uint					= 0;
		public var VISIBLE:uint					= 1;
		public var CONTROL:uint					= 0;
		
		public function table_web_menu_location(ID_:uint=0)
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
				_PROGRAMID					= gnncGlobalStatic._programId; _PROGRAMVERSION = gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL			= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL				= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
			}
		}
	}
}