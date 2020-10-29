package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_client
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

		public var _TABLE:String 					= 'CLIENT';

		public var ID:uint							= 0;
		public var INDICATED_CLIENT:uint			= 0; //Indicado por
		
		public var NAME:String						= '';
		public var MIDDLE_NAME:String				= '';
		public var LAST_NAME:String					= '';
		public var NICK_NAME:String					= '';
		public var CPF_CNPJ:String					= '';
		public var RG_REGISTER:String				= ''; 
		public var RG_REGISTER_UF:String			= ''; 
		public var SEX:String						= '';
		public var DATE_BIRTH:String				= '';
		public var COMPANY:uint						= 0;
		
		public var ENROLLMENT:String				= '';
		public var ACCESS_WEB:uint					= 0;
		public var ACCESS_WEB_PASSW:String			= '';

		public var STAR_RATING:uint					= 0;

		public var ID_PROFESSIONAL:uint				= 0;
		public var PROFESSIONAL_NUMBER:String		= '';
		public var PROFESSIONAL_STATE:String		= '';

		public var ADDRESS:String					= '';
		public var ADDRESS_NUMBER:uint				= 0;
		public var ADDRESS_COMPLEMENT:String		= '';
		public var NEIGHBORHOOD:String				= '';
		public var ZIPCODE:uint						= 0;
		public var CITY:String						= '';
		public var STATE:String						= '';
		public var ISO_COUNTRY:String				= '';

		public var NATURALITY:String				= '';
		public var ISO_NACIONALITY:String			= '';

		public var PHONE:String						= '';
		public var PHONE_CEL:String					= '';
		public var PHONE_COMPANY:String				= '';
		public var PHONE_FAX:String					= '';

		public var PHONE_OPERATOR:uint				= 0;
		public var PHONE_CEL_OPERATOR:uint			= 0;
		public var PHONE_COMPANY_OPERATOR:uint		= 0;
		public var PHONE_FAX_OPERATOR:uint			= 0;

		public var EMAIL_FINANCIAL:String			= ''; //varchar(200)
		public var EMAIL:String						= '';
		public var FATHER:String					= '';
		public var MOTHER:String					= '';
		public var DESCRIPTION:String				= '';

		public var ID_DEPARTAMENT:uint				= 0;
		public var ID_GROUP:uint					= 0;
		public var ID_CATEGORY:uint					= 0;

		public var ACTIVE:uint						= 1;	//LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint						= 1;	//SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint						= 0;	//VERIFIED - Verificado

		public function table_client(ID_:uint=0)
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