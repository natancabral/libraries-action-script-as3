package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_attach
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
		
		public var _TABLE:String 		= 'ATTACH';
		
		public var ID:uint				= 0;
		public var ID_KEY:String		= '';
		
		public var ID_CLIENT:uint		= 0;
		public var ID_PROJECT:uint		= 0;
		public var ID_STEP:uint			= 0;
		public var ID_USER:uint			= 0;
		
		public var ID_MIX:uint			= 0;
		public var MIX:String			= '';

		public var ORDER_ITEM:uint		= 0;

		// Imagem:
		// --FILE_HTTP--/ATTACH/--DATABASE--/--FILE_LINK--
		
		public var NAME:String			= ''; // Minha Imagem ou Nome do Arquivo. Pode ser alterado confirme queira
		//public var DESCRIPTION:String	= ''; // Descrição da Imagem
		public var URL_LINK:String		= ''; // Quando no DAYBYDAY WEB precisa de link após clicar 
		public var FILE_HTTP:String		= ''; // https://daybyday.gnnc.com.br/ <-- Imagem hospedada neste servidor, exemplo.
		public var FILE_LINK:String		= ''; // Nome do Arquivo no Servidor, ex: gnnc3412423423423.jpg

		//public var WEB_ID:String 		= ''; // idName
		//public var WEB_CLASS:String 	= ''; // nameClass className2
		//public var WEB_STYLE:String 	= ''; // width:200px;height:100px;margin:0;padding:0 0 0 0;border: 1px solid #000;
		//public var WEB_ALIGN:String 	= ''; // LEFT | RIGHT | TOP | BOTTOM
		
		public var EXTENSION:String		= ''; //jpg pdf doc... 
		public var SIZE:uint			= 0;  //bytes
		public var DOWNLOAD_ENABLE:uint	= 0;
		
		//public var ID_DEPARTAMENT:uint	= 0;
		//public var ID_GROUP:uint		= 0;
		//public var ID_CATEGORY:uint		= 0;

		public function table_attach(ID_:uint=0)
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