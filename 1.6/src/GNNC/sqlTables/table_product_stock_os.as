package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_product_stock_os
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
		
		public var _TABLE:String 					= 'PRODUCT_STOCK_OS';
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		public var ID_CLIENT:uint					= 0; //cliente
		public var ID_CLIENT_SELLER:uint		    = 0; //vendedor

		public var NUMBER:uint					    = 0;
		public var NUMBER_TYPE:String			    = '';

		public var VALUE_IN:Number					= 0;
		public var VALUE_OUT:Number					= 0;
		public var DISCOUNT_VALUE:Number			= 0;

		public var PAY_TYPE:String			    = '';

		public var DESCRIPTION:String			    = '';

		public var DATE_START:String			    = ''; 
		public var DATE_END:String			        = ''; 
		public var DATE_FINAL:String			    = ''; 
		
		public var ACTIVE:uint					    = 0; //aberto, finalizado

		public function table_product_stock_os(ID_:uint=0)
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