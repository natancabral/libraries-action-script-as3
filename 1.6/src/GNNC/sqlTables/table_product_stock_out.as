package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_product_stock_out
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
		
		public var _TABLE:String 					= 'PRODUCT_STOCK_OUT';
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		public var ID_PRODUCT:uint					= 0; //produto e serviço
		public var ID_PRODUCT_STOCK_OS:uint			= 0; //ordem de servico ou produto

		public var VALUE_IN:Number					= 0; //quantidades
		public var VALUE_OUT:Number					= 0; //quantidades
		
		public var UNIT:Number						= 0; //quantidades
		public var UNIT_TYPE:String					= ''; //quantidades
		public var REF:uint							= 0; //
		
		public var ACTIVE:uint					    = 0; //aberto, finalizado

		public function table_product_stock_out(ID_:uint=0)
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