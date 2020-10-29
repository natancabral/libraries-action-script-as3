package GNNC.elements.component.list
{
	import GNNC.data.data.gnncClipBoard;
	import GNNC.data.date.gnncDate;
	import GNNC.event.gnncEventGeneral;
	import GNNC.modules.financial.formNew.newFinancialOverDraft;
	import GNNC.modules.financial.formView.viewFinancial;
	import GNNC.modules.financial.itemRender.itemRender_financialOverDraft_forList;
	import GNNC.others.gnncFocus;
	import GNNC.sqlTables.table_financial;
	import GNNC.sqlTables.table_financial_overdraft;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;

	//[Bindable]
	public class conList_financial_overDraft extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_financial_overDraft()
		{
			__config();
			__addEventPersonal();
		}
		
		private function __config():void
		{
			_name							= 'Financial_OverDraft';
			
			_itemRenderList					= itemRender_financialOverDraft_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= itemRender_financialOverDraft_forList;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_financial_overdraft();
			_tableClassName					= '_tableFinancialOverDraft';
			
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
			
			_sqlOrderBy						= ['NUMBER','DATE_END','DATE_START','ID'];
			
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
			_sqlColumns						= [
				"*",
				"(select NAME 		from dbd_client 			where dbd_client.ID 			like ID_CLIENT				) as NAME_CLIENT",
				"(select NAME 		from dbd_departament 		where dbd_departament.ID 		like ID_DEPARTAMENT			) as NAME_DEPARTAMENT",
				"(select NAME 		from dbd_group 				where dbd_group.ID 				like ID_GROUP				) as NAME_GROUP",
				"(select NAME 		from dbd_financial_account 	where dbd_financial_account.ID 	like ID_FINANCIAL_ACCOUNT	) as NAME_FINANCIAL_ACCOUNT",
				"(select COUNT(ID) 	from dbd_attach 			where dbd_attach.MIX 			like 'OVERDRAFT' AND dbd_attach.ID_MIX like dbd_financial_overdraft.ID	) as ROWS_ATTACH"
			];
		}
		
		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',				enabled:_view,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._view, 			fName:__fView	},
					{label:'Copiar número do documento',enabled:_copy,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._copy, 			fName:__fCopyDocumentNumber	},
					{label:'Remover item(ns) da lista',	enabled:true,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._removeItemList, fName:__fRemoveItemList	}
				]
			);
		}

		public override function __pageView():Object
		{
			return new Object();
			
			var _table:table_financial 		= new table_financial();
			_table.ID	 					= selectedItem.ID;
			
			var _page:viewFinancial			= new viewFinancial();
			_page._tableFinancial 			= _table;
			
			return _page;
		}
		
		public override function __pageNew():Object
		{
			//var _table:table_financial_overdraft 	= _tableClass ? _tableClass as table_financial_overdraft : new table_financial_overdraft();
			var _table:table_financial_overdraft 	= new table_financial_overdraft();
			
			var _page:newFinancialOverDraft			= new newFinancialOverDraft();
			_page._tableFinancialOverDraft 			= _table;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_financial_overdraft 	= _tableClass ? _tableClass as table_financial_overdraft : new table_financial_overdraft();
			_table.ID	 							= selectedItem.ID;
			
			var _page:newFinancialOverDraft			= new newFinancialOverDraft();
			_page._tableFinancialOverDraft 			= _table;
			
			return _page;
		}
		
		public function __selectKeyFinancial(e:*=null):void
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
			
			var _sql:String	= " select "+_columns+" from dbd_financial_overdraft where KEY_FINANCIAL like '"+_keyFinancial+"' order by NUMBER asc ";

			//new gnncAlert().__alert(_sql+"\n\n"+_columns);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
			
			function __fFault(event:*):void
			{
				__loading(false);
			}
			
			function __fResult(event:*):void
			{			
				dataProvider = _connList.DATA_ARR;
				
				__loading(false);
				
				if(_selectFirstItem && _length)
				{
					list_.selectedIndex = 0;
					gnncFocus.__set(list_);
				}
				
			}
		}
		
		public function __overDraft2Financial():void
		{
			if(!selected)
				return;
			
			var _obj:Object			= selectedItem;
			
			var _table:table_financial = new table_financial();
			_table.VALUE_IN 		= _obj.VALUE_IN;
			_table.VALUE_OUT 		= _obj.VALUE_OUT;
			_table.ID_GROUP			= _obj.ID_GROUP;
			_table.ID_CLIENT		= _obj.ID_CLIENT;
			_table.DESCRIPTION		= _obj.DESCRIPTION;
			_table.KEY_FINANCIAL	= _obj.KEY_FINANCIAL;
			_table.DOCUMENT_NUMBER 	= _obj.DOCUMENT_NUMBER;
			_table.DOCUMENT_TYPE 	= _obj.DOCUMENT_TYPE;
			
			var f:conList_financial = new conList_financial();
			f._tableClass 			= _table;
			f.__pageNew();
			f.__fNew(null,__fRemove);
			
			function __fRemove(e:*=null):void
			{
				if(!f.page['_change'])
					return;
				
				if(!selected)
					return;
				
				if(gnncDate.__isValid(selectedItem.DATE_FINAL))
					return;
				
				var _dNumber:String = _obj.DOCUMENT_NUMBER ;
				var _text:String 	= _dNumber ? 'número '+_dNumber : '' ;
				
				Alert.show('Deseja compensar o cheque '+ _text +' lançado neste momento?','Compensar...',3,null,__closeAlert);
				
				function __closeAlert(event:CloseEvent):void
				{
					if(event.detail != Alert.YES)
						return;
					
					__fDateFinal(false,new Date());
					
				}
				
			}
		}

		public function __fCopyDocumentNumber(event:*=null):void
		{
			if(selectedIndex < 0)
				return;
			
			gnncClipBoard.__copyText(selectedItem['DOCUMENT_NUMBER']);
		}


	}
}