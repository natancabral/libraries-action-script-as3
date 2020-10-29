package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_product
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
		
		public var _TABLE:String 					= 'PRODUCT';
		
		public var ID:uint							= 0;
		public var ID_KEY:String					= '';
		public var ID_CLIENT_PROVIDER:uint			= 0;//
		
		public var NAME:String						= '';
		public var NICK_NAME:String					= '';
		public var COLOR:String						= '';
		public var DESCRIPTION:String				= '';

		public var SERVICE:uint = 0; //Is product 0 or service 1
		public var TYPE:String = ''; //IN materia-prima | OUT producao/produto final 

		//Price, Returno em Porcentagem(lucro), Max Disconto e Comissão Paga
		public var VALUE:Number						= 0;
		public var VALUE_OUT:Number					= 0;
		public var RETURN_PERCENT:Number			= 0; //Valor acrescido em porcentagem
		public var MAX_DISCOUNT_VALUE:Number		= 0;
		public var MAX_DISCOUNT_PERCENT:Number		= 0;
		public var PAY_COMMISSION_VALUE:Number		= 0;
		public var PAY_COMMISSION_PERCENT:Number	= 0;
		
		//Peso, Tamanho e Unidade
		public var WEIGHT:Number					= 0;
		public var WEIGHT_TYPE:String				= '';
		public var SIZE:Number						= 0;
		public var SIZE_TYPE:String					= '';
		public var TIME:Number						= 0;
		public var TIME_TYPE:String					= '';
		public var UNIT:Number						= 0; //quantidades
		public var UNIT_TYPE:String					= ''; //caixa, unidade

		//NO WORK, please, not set value
		public var TIME_HOUR:uint					= 0;
		
		public var STOCK_MIN:uint					= 0;

		//code
		public var CODE:String						= '';
		public var CODE_ORIGINAL:String				= '';
		
		//Desenv, Website
		public var WEBSITE:String					= '';

		//Promoção, Novidade e Exclusivo
		public var STATUS_PROMOTION:uint			= 0;
		public var STATUS_NEW:uint					= 0;
		public var STATUS_UNIQUE:uint				= 0;

		public var ID_SERIES_MAKER:uint				= 0; //Fabricante

		/** ORGANIZATION **/
		public var ID_DEPARTAMENT:uint				= 0;
		public var ID_GROUP:uint					= 0;
		public var ID_CATEGORY:uint					= 0;

		/** GENERAL **/
		public var ACTIVE:uint						= 0; //LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint 					= 1; //SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint						= 0; //VERIFIED - Verificado

		public function table_product(ID_:uint=0)
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