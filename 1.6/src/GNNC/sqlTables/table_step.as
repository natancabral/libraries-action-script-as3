package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_step
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

		public var _TABLE:String 				= 'STEP';
		
		public var ID:uint						= 0;
		public var ID_KEY:String				= '';
		public var ID_CLIENT:uint				= 0;
		public var ID_PROJECT:uint				= 0;
		
		public var MIX:String					= '';
		
		public var NAME:String					= '';
		public var DESCRIPTION:String			= '';
		public var ORDER_ITEM:uint				= 0;

		public var TIME_HOUR_PRACTICE:uint		= 0;
		public var TIME_HOUR_THEORY:uint		= 0;
		
		public var DATE_START:String			= '';
		public var DATE_END:String				= '';
		public var DATE_FINAL:String			= '';

		public var ID_DEPARTAMENT:uint			= 0;
		public var ID_GROUP:uint				= 0;
		public var ID_CATEGORY:uint				= 0;

		public var ACTIVE:uint					= 0; //LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint					= 1; //SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint					= 0;//VERIFIED - Verificado

		public function table_step(ID_:uint=0)
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