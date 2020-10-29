package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	//[RemoteClass(alias="table_job")]
	public class table_form_model
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
		
		public var _TABLE:String 					= 'FORM_MODEL';
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		public var ID_CLIENT:uint					= 0;
		public var ID_USER:uint						= 0;

		public var MIX:String						= ''; //PROCESS_ODONTO_FORM, PROCESS_ODONTO_TRIAGE(triagem), PROCESS_FORM, FORM_QUEST

		public var TYPE:String						= ''; //XML, JSON, HTML, GNNC
		public var TITLE:String						= '';
		public var DESCRIPTION:String				= '';
		public var TEXT:String						= '';

		public var ORDER_ITEM:uint					= 0;
		
		//public var DATE:String;

		public var ID_DEPARTAMENT:uint				= 0;
		public var ID_GROUP:uint					= 0;
		public var ID_CATEGORY:uint					= 0;
		
		public var ACTIVE:uint						= 0;	//LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint						= 1; 	//SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint						= 0;	//VERIFIED - Verificado
		
		public function table_form_model(ID_:uint=0)
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