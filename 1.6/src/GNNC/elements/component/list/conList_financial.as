package GNNC.elements.component.list
{
	import GNNC.event.gnncEventGeneral;
	import GNNC.modules.financial.formNew.newFinancial;
	import GNNC.modules.financial.formView.viewFinancial;
	import GNNC.modules.financial.itemRender.itemRender_financial_forList;
	import GNNC.others.gnncFocus;
	import GNNC.sqlTables.table_financial;
	
	import mx.core.ClassFactory;

	//[Bindable]
	public class conList_financial extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_financial()
		{
			__config();
		}
		
		private function __config():void
		{
			_name							= 'Financial';
			
			_itemRenderList					= itemRender_financial_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= itemRender_financial_forList;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_financial();
			_tableClassName					= '_tableFinancial';
			
			itemRenderIndex 				= 0;

			_dragMoveEnabled				= true;
		}
		
		private function __addEventPersonal():void
		{
			//Personal
			list_.addEventListener(gnncEventGeneral._key,__selectKeyFinancial);
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['DATE_END,DATE_START,ID'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
			_sqlColumns						= [
				"*",
				"(select NAME 		from dbd_client 			where dbd_client.ID 				= ID_CLIENT								) as NAME_CLIENT",
				"(select NAME 		from dbd_group 				where dbd_group.ID 					= ID_GROUP								) as NAME_GROUP",
				"(select NAME 		from dbd_departament 		where dbd_departament.ID 			= ID_DEPARTAMENT						) as NAME_DEPARTAMENT",
				"(select NAME 		from dbd_financial_account 	where dbd_financial_account.ID 		= ID_FINANCIAL_ACCOUNT					) as NAME_FINANCIAL_ACCOUNT",
				"(select COUNT(ID) 	from dbd_attach 			where dbd_attach.MIX = 'FINANCIAL' AND dbd_attach.ID_MIX = dbd_financial.ID	) as ROWS_ATTACH"
			];
		}
		
		public override function __pageView():Object
		{
			var _table:table_financial 		= _tableClass ? _tableClass as table_financial : new table_financial();
			_table.ID	 					= selectedItem.ID;
			
			var _page:viewFinancial			= new viewFinancial();
			_page._tableFinancial 			= _table;
			
			return _page;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_financial 		= _tableClass ? _tableClass as table_financial : new table_financial();
			
			var _page:newFinancial			= new newFinancial();
			_page._tableFinancial 			= _table;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_financial 		= _tableClass ? _tableClass as table_financial : new table_financial();
			_table.ID	 					= selectedItem.ID;
			
			var _page:newFinancial			= new newFinancial();
			_page._tableFinancial 			= _table;
			
			return _page;
		}
		
		public function __selectKeyFinancial(e:*=null,fResult_:Function=null,fFault_:Function=null):void
		{
			if(!selected)
				return;
			
			if(!selectedItem.hasOwnProperty('KEY_FINANCIAL'))
				return;
			
			if(selectedItem.KEY_FINANCIAL=='')
				return;
			
			__configSql();
			
			var _keyFinancial:String = selectedItem.KEY_FINANCIAL;
			var _columns:String = !_sqlColumns ? '' : _sqlColumns.toString();
			
			__loading(true);
			
			var _sql:String	= " select "+_columns+" from dbd_financial where KEY_FINANCIAL like '"+_keyFinancial+"' order by NUMBER asc ";
			
			//new gnncAlert().__alert(_sql+"\n\n"+_columns);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
			
			function __fFault(event:*):void
			{
				if(fFault_!=null)
					fFault_.call();
				
				__loading(false);
			}
			
			function __fResult(event:*):void
			{			
				dataProvider = _connList.DATA_ARR;

				if(fResult_!=null)
					fResult_.call();

				__loading(false);
				
				if(_selectFirstItem && _length)
				{
					list_.selectedIndex = 0;
					gnncFocus.__set(list_);
				}
				
			}
		}

	}
}