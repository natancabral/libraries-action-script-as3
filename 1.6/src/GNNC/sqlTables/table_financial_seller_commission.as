package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_financial_seller_commission
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

		public var _TABLE:String 				= 'FINANCIAL_SELLER_COMMISSION';
		
		public var ID:uint						= 0;
		public var ID_FINANCIAL_GROUP:uint		= 0; // OFF //por valores que entram no plano de contas
		public var ID_FINANCIAL_CATEGORY:uint	= 0; // OFF //por valores que entram em categoryas

		public var NAME:String					= ''; //nome do grupo de comissões

		public var VALUE_AT:Number				= 0; //comissão de valores de...
		public var VALUE_TO:Number				= 0; //comissão de valores até...

		public var COMMISSION_VALUE:Number		= 0; //comissão paga, de valor fixo
		public var COMMISSION_PERCENT:Number	= 0; //comissao paga, de porcentagem sobre o valor vendido

		public var DISCOUNT_VALUE:Number		= 0; //desconto dado no máximo em valor
		public var DISCOUNT_PERCENT:Number		= 0; //desconto dado no máximo em porcentagem

		//public var DATE:uint					= gnncDate.__date2String(new Date());//Registrado
		public var DATE_START:String			= ''; // OFF //comissão valida DE
		public var DATE_END:String				= ''; // OFF //comissão valida ATE

		//public var LEVEL:uint					= 0; // OFF //criar uma nova tabela de regras para este
		
		public var DESCRIPTION:String			= '';

		public function table_financial_seller_commission(ID_:uint=0)
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
				_PROGRAMVERSION = gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL			= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL				= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
			}
		}
	}
}