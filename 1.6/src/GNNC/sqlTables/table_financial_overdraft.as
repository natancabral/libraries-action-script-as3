package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_financial_overdraft
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

		public var _TABLE:String 				= 'FINANCIAL_OVERDRAFT';
		
		public var ID:uint						= 0;
		public var ID_KEY:String				= '';
		public var ID_CLIENT:uint				= 0; //Quem: A receber / A pagar
		public var ID_FINANCIAL_ACCOUNT:uint	= 0; //Conta

		public var NAME_CLIENT_DOCUMENT:String	= ''; //emissor

		public var MIX:String					= '';

		public var NUMBER_LETTER:String			= '';//Grupo do NUMBER(num sequencial), para ordem numerica...
		public var NUMBER:uint					= 0; //numero interno da empresa, sequencial
		public var DOCUMENT_NUMBER:String		= ''; //numero externo. da folha, do document pago.
		public var DOCUMENT_TYPE:uint			= 6; //dinheiro, [6]cheque...
		public var VALUE_IN:Number				= 0; //Receber de
		public var VALUE_OUT:Number				= 0; //Pagar para

		public var DESCRIPTION:String			= '';

		//public var DATE:uint					= ''; = gnncDate.__date2String(new Date());//Registrado
		public var DATE_START:String			= ''; //Programado baixa auto
		public var DATE_END:String				= ''; //Vencimento
		public var DATE_FINAL:String			= ''; //Pago em
		public var DATE_CANCELED:String			= ''; //Cancelado
		public var DATE_PAY_REFERENCE:String	= ''; //para pagamento referentes a datas anteriores
		
		public var KEY_FINANCIAL:String			= ''; //Key para grupos, como PARCELAMENTO, TRANSFERÊNCIA...

		public var ID_DEPARTAMENT:uint			= 0; //Centro de Custo
		public var ID_GROUP:uint				= 0; //Plano de CONTAS [Receita, Despesa](Serviços, Luz, Água, etc)
		public var ID_CATEGORY:uint				= 0; //boleto, promissória, carnê, cartão de créd, DARF, fatura, duplic...
		
		public var ACTIVE:uint					= 0; //LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint					= 1; //SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint					= 0; //VERIFIED - Verificado
		
		public function table_financial_overdraft(ID_:uint=0)
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