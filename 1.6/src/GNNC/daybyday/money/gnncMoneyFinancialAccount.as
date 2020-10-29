package GNNC.daybyday.money
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataNumber;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.collections.ArrayCollection;

	public class gnncMoneyFinancialAccount
	{
		[Bindable] private var _gnncGlobal:gnncGlobalStatic = new gnncGlobalStatic(true);

		public function gnncMoneyFinancialAccount()
		{
		}

		public function checkOver(indexAccount:uint,safeIn:Boolean,valueSafe:Object):Boolean
		{
			var o:Object = null;
			var x:Number = 0;
			
			valueSafe = gnncDataNumber.__safeClear(valueSafe);
			
			if(indexAccount<0)
				return false;
			if(valueSafe==0 || !valueSafe)
				return false;
			if(_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ROWS==0)
				return false;
			
			o = _gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.getItemAt(indexAccount);
			
			if(Number(o.ALLOW_NEGATIVE) === 0){
				x = Number(o.VALUE_ACCOUNT) + ((safeIn?1:-1) * Number(valueSafe));
				if(x < 0){
					gnncAlert.__alert('Saldo na conta não permite essa operação.' +
						"\nVerifique o valor existente na conta." +
						"\n<b>Valor atual: "+gnncDataNumber.__safeReal(o.VALUE_ACCOUNT))+'</b>';
					return false;
				}
			}
			return true;
		}

		public function updateData(indexAccount:uint,safeIn:Boolean,valueSafe:Object):Boolean
		{
			var o:Object = null;
			var x:Number = 0;
			
			valueSafe = gnncDataNumber.__safeClear(valueSafe);
			
			if(indexAccount<0)
				return false;
			if(valueSafe==0 || !valueSafe)
				return false;
			if(_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ROWS==0)
				return false;

			o = _gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.getItemAt(indexAccount);
			x = Number(o.VALUE_ACCOUNT) + ((safeIn?1:-1) * Number(valueSafe));
			_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.getItemAt(indexAccount).VALUE_ACCOUNT = x;
			_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.refresh();
			
			return true;
		}

		public function updateDataReversal(idAccount:int,safeIn:Boolean,valueSafe:Object):Boolean
		{
			var a:ArrayCollection = new ArrayCollection();
			var o:Object = null;
			var x:Number = 0;
			var i:uint   = 0;

			valueSafe = gnncDataNumber.__safeClear(valueSafe);
			
			if(idAccount<1)
				return false;
			if(valueSafe==0 || !valueSafe)
				return false;
			if(_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ROWS==0)
				return false;

			// ---------- ATUALIZA O SALDO DAS CONTAS
			// ---------- Atenção, essa linha debaixo serve somente para REVERSAL, ou estorno.
			a = new gnncDataArrayCollection().__filterNumeric(_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR,'ID',idAccount);
			
			if(a == null || !a || a.length == 0)
				return false;
			
			o = a.getItemAt(0);
			i = _gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.getItemIndex(o);
			
			if(i<0)
				return false;
			
			// ---------- Atenção, essa linha debaixo serve somente para REVERSAL, ou estorno.
			x = Number(o.VALUE_ACCOUNT) + ((safeIn?-1:1) * Number(valueSafe) );
			_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.getItemAt(i).VALUE_ACCOUNT = x;
			_gnncGlobal._FINANCIAL_ACCOUNT.DATA_ARR.refresh();
			
			return true;
		}

		
		public function updateSql():void
		{
			
		}
		
	}
}