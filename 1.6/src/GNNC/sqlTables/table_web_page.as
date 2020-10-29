package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	//[RemoteClass(alias="table_job")]
	public class table_web_page
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
		
		public var _TABLE:String 					= 'WEB_PAGE';
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		public var ID_USER:uint						= 0;
		public var ID_WEB_MENU_LINK:uint			= 0;
		public var ID_CLIENT_AUTHOR:uint			= 0;

		public var MIX:String						= 'WEB_PAGE';

		public var TITLE:String						= '';
		public var SUBTITLE:String					= '';
		public var DESCRIPTION:String				= '';
		public var CONTENT:String					= '';

		public var IMG1_URL:String					= '';//char 500

		public var URL_FRIENDLY:String				= '';
		public var ORDER_ITEM:uint					= 0;
		
		//public var DATE:String;
		public var DATE_START:String				= '';
		public var DATE_END:String					= '';

		public var ID_DEPARTAMENT:uint				= 0;
		public var ID_GROUP:uint					= 0;
		public var ID_CATEGORY:uint					= 0;
		
		public var ACTIVE:uint						= 0;	//LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint						= 1; 	//SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint						= 0;	//VERIFIED - Verificado
		
		public function table_web_page(ID_:uint=0)
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