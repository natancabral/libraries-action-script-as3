package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_product_stock_lot
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
		
		public var _TABLE:String 					= 'PRODUCT_STOCK_LOT';
		
		/*CREATE TABLE `dbd_product_stock_lot` (
		`ID` int(9) NOT NULL AUTO_INCREMENT,
		`ID_KEY` varchar(40) NOT NULL,
		`NAME` varchar(60) NOT NULL,
		`IDS_PRODUCT_FONT` varchar(250) NOT NULL COMMENT 'materia prima',
		`IDS_PRODUCT_STOCK` varchar(250) NOT NULL COMMENT 'material produzido',
		`PERCENT_TOLERANCE` double NOT NULL COMMENT 'tolerancia de estoque produzido com os valores da materia prima',
		
		`DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		`DATE_START` datetime NOT NULL COMMENT 'iniciou producao',
		`DATE_END` datetime NOT NULL COMMENT 'finalizou producao',
		`DATE_BUY` datetime NOT NULL COMMENT 'vendido ou finalizo',
		`DATE_VALID` datetime NOT NULL COMMENT 'validade',
		`VALUE_IN` double NOT NULL,
		`VALUE_OUT` double NOT NULL,
		`DISCOUNT_VALUE` double NOT NULL,
		`ACTIVE` int(1) NOT NULL,
		PRIMARY KEY (`ID`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8
		*/
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		
		public var NAME:String						= ''; //nome do lote
		public var NAME_DYNAMIC:String				= ''; //nome do lote automatico
		
		//public var IDS_PRODUCT_FONT:String			= ''; //materia-prima
		//public var IDS_PRODUCT_STOCK:String		    = ''; //material estoque produzido
		
		public var PERCENT_TOLERANCE:Number			= 0; //'tolerancia de estoque produzido com os valores da materia prima',
		
		public var VALUE_IN:Number					= 0;
		public var VALUE_OUT:Number					= 0;
		
		public var UNIT_MANUAL_PRECISION:Number		= 0;
		
		public var DESCRIPTION:String			    = ''; //300 len
		
		public var DATE_FABRICATION:String				= ''; //'fabricacao no lote, na etiqueta',
		public var DATE_FABRICATION_SCHEDULED:String	= ''; //programado a iniciar
		public var DATE_FABRICATION_BEGIN:String    	= ''; //iniciado
		public var DATE_FABRICATION_FINISH:String		= ''; //fabricacao finalizada',
		public var DATE_EXPIRATION:String				= ''; //'validade',
		public var DATE_SALE:String			        	= ''; //'vendido tudo',
		 //public var DATE_INSERT_STORAGE:String       = ''; //ENTRADA/inserido no sistema/fabricado/comprado
		
		public var ACTIVE:uint					    = 0; //aberto, finalizado
		
		public function table_product_stock_lot(ID_:uint=0)
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