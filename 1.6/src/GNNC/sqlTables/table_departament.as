package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_departament
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
		
		public var _TABLE:String				= 'DEPARTAMENT';
		
		public var ID:uint;
		public var ID_FATHER:uint;
		public var LEVEL:uint;
		public var MIX:String;
		public var NAME:String;
		public var DESCRIPTION:String;
		public var COLOR:String;
		
		/** IN ALL TABLES **/
		public var ACTIVE:uint;		//LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo)
		public var VISIBLE:uint; 	//SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint;	//VERIFIED - Verificado
		
		public function table_departament(ID_:uint=0)
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