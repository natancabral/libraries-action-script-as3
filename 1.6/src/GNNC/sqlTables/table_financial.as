package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_financial
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

		public var _TABLE:String 				= 'FINANCIAL';
		
		public var ID:uint						= 0;
		public var ID_KEY:String				= ''; //------------------------------------- Registro unico de lancamento (like ID)

		//public var ID_FATHER:uint				= 0;  //PARA REFERENCIAS: ESTORNO, TAXAS, TRANSFERIR UM VALOR EXATO DE CARTAO OU BOLETO.
		public var ID_PAY_PART:uint				= 0;  //
		
		public var ID_CLIENT:uint				= 0;  //Quem: A receber / A pagar
		public var ID_CLIENT_SELLER:uint		= 0;  //Comissão para / Vendedor
		public var ID_PROJECT:uint				= 0;  //Relacionado a um projeto, ou CURSO
		public var ID_CONTRACT:uint				= 0;  //Sem descrição
		public var ID_FINANCIAL_ACCOUNT:uint	= 0;  //Conta
		public var ID_PRODUCT_STOCK_OS:uint		= 0;  //ordem de servico ou venda

		public var IDS_REFERENCE:String		    = '';  //max 300 chars

		public var MIX:String                   = '';

		public var IS_TAX:uint					= 0;
		public var IS_TRANS:uint				= 0;
		public var IS_PAY_PART:uint				= 0; //se o pagamento foi separado em mais pedaços
		public var IS_REVERSAL:uint				= 0; //estorno
		
		public var IS_FIXED_COST:uint		    = 0; //1-fixed  2-variable

		public var NUMBER_LETTER:String			= ''; //Grupo do NUMBER(num sequencial), para ordem numerica...
		public var NUMBER:uint					= 0;  //numero interno da empresa, sequencial
		public var NUMBER_FINAL_PAY:uint		= 0;  //numero interno da empresa, sequencial qundo é baixado o lançamento
		public var DOCUMENT_NUMBER:String		= ''; //numero externo. da folha, do document pago.
		public var DOCUMENT_TYPE:uint			= 0;  //dinheiro, cheque...
		public var DOCUMENT_BANK:String			= '';  //banco do documento, emissor
		public var VALUE_IN:Number				= 0;  //Receber de
		public var VALUE_OUT:Number				= 0;  //Pagar para
		public var VALUE_IN_PAY:Number			= 0;  //RECEBIDO!
		public var VALUE_OUT_PAY:Number			= 0;  //PAGO!

		public var FLAG_CARD:String			    = '';  //bandeira do cartao string(3)

		public var PAY_TYPE:String				= ''; //dinheiro, cheque...
		public var DISCOUNT_VALUE:Number		= 0;
		public var DISCOUNT_PERCENT:Number		= 0;
		public var DISCOUNT_PUNCTUALITY:Number  = 0;
		
		public var FINE_VALUE:Number			= 0; //valor fixo de multa, aplicado uma vez
		public var FINE_VALUE_PERCENT:Number	= 0; //valor aplicado independente da data, sobre o valor. 1 dia ou 5 anos, aplicado sobre o valor 1x
		public var FINE_PERCENT:Number			= 0; //juros/multa
		public var FINE_PERCENT_TIME:Number		= 0; //juros/multa

		public var DISCOUNT_PAY:Number		    = 0; //DESCONTO PAGO
		public var FINE_PAY:Number			    = 0; //JUROS PAGO

		public var DESCRIPTION:String			= '';

		//public var DATE:uint					= gnncDate.__date2String(new Date());//Registrado
		public var DATE_START:String			= ''; //Programado para
		public var DATE_END:String				= ''; //Vencimento
		public var DATE_FINAL:String			= ''; //Pago em
		public var DATE_FINAL_AUTO:String		= ''; //Programar pagamento automatico
		public var DATE_FINAL_FIXED:String		= ''; //Previsao de entrada COMPENSADA, como cheque e cartão, que é pago mas nao dá saldo pois não comepensou
		public var DATE_CANCELED:String			= ''; //Cancelado
		public var DATE_PAY:String			    = ''; //pago ou pado baixa
		
		public var KEY_FINANCIAL:String			= ''; //Key para grupos, como PARCELAMENTO, TRANSFERÊNCIA...

		public var ID_DEPARTAMENT:uint			= 0; //Centro de Custo
		public var ID_GROUP:uint				= 0; //Plano de CONTAS [Receita, Despesa](Serviços, Luz, Água, etc)
		public var ID_CATEGORY:uint				= 0; //boleto, promissória, carnê, cartão de créd, DARF, fatura, duplic...
		
		public var ID_PRODUCT:uint	 			= 0;//TEMPORARY - trocar por multiplos produtos
		
		public var ACTIVE:uint					= 0; //LEVEL IN SYSTEM - Nível Geral no Systema (ex Ativo,Analisando,Inativo,Observado,etc)
		public var VISIBLE:uint					= 1; //SYSTEM HIDE - Invisível pelo Sistema
		public var CONTROL:uint					= 0; //VERIFIED - Verificado
		
		public function table_financial(ID_:uint=0)
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