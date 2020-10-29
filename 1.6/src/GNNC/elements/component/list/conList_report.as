package GNNC.elements.component.list
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncData;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.sql.gnncSql;
	import GNNC.modules.project.itemRender.itemRender_jobList_forList;
	import GNNC.modules.project.itemRender.itemRender_reportList_forList;
	import GNNC.sqlTables.table_report;
	
	import mx.collections.ArrayCollection;
	
	//[Bindable]
	public class conList_report extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_report()
		{
			__config();
			__addEventPersonal();
		}
		
		private function __config():void
		{
			_name							= 'Relatório';
			
			_itemRenderList					= itemRender_reportList_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_report();
			_tableClassName					= '_tableReport';

			itemRenderIndex 				= 0;
		}
		
		private function __addEventPersonal():void
		{
			list_.addEventListener('selectClient',__fClient);
		}

		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:'', 	fName:__fEdit	},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:'', 	fName:__fDelete	},
					{label:'Conferir',		enabled:true,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fDateFinal},
					
					{label:'Remover item(ns) da lista',	enabled:true,		separator:true,		visible:true,	dispatchEvent:'', fName:__fRemoveItemList	}
				]
			);
			
		}

		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['DATE_END'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
			_sqlColumns						= 
				[
					"*",
					"(select v.NAME 		from dbd_client v where v.ID like ID_CLIENT	) NAME_CLIENT ",
					"(select v.NICK_NAME 	from dbd_client v where v.ID like ID_CLIENT	) NICK_NAME_CLIENT ",
					"(LEFT(DATE_END,10)) DATE_ORDER"
				];
		}
		
		public override function __pageView():Object
		{
			/*
			var _page:viewComment			= new viewComment();
			_page._tableComment 			= new table_comment(selectedItem.ID);
			
			return _page;
			*/
			return null;
		}
		
		public override function __pageNew():Object
		{
			/*
			var _table:table_comment 		= new table_comment();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			_table.ID_PROJECT 				= _tableClass.ID_PROJECT;
			_table.ID_STEP 					= _tableClass.ID_STEP;
			_table.ID_JOB 					= _tableClass.ID_JOB;
			
			_table.ID_USER 					= gnncGlobalStatic._userId;
			
			_table.MIX 						= _tableClass.MIX;
			_table.ID_MIX					= _tableClass.ID_MIX;
			
			var _page:newComment 			= new newComment();
			_page._tableComment 			= _table;
			_page._MIX						= _tableClass.MIX;
			
			return _page;
			*/
			return null;
		}

		public override function __pageEdit():Object
		{
			/*
			var _page:newComment			= new newComment();
			_page._tableComment				= new table_comment(selectedItem.ID);
			
			return _page;
			*/
			return null;
		}

		public function __fClient(e:*=null):void
		{
			if(!selected)
				return;
			
			if(!selectedItem.hasOwnProperty('ID_CLIENT'))
				return;
			
			//_sqlShow = true;
			__selectWhere(selectedItem.ID_CLIENT,['ID_CLIENT'],'',false);
		}

		public function __selectClient(idClient_:uint):void
		{
			//_sqlShow = true;
			__selectWhere(idClient_,['ID_CLIENT'],'',false);
		}

		public function __selectText(value_:String,fResult_:Function=null,fFault_:Function=null):void
		{
			function __fFault(e:*):void
			{ 
				if(fFault_!=null)
					fFault_.call(null);
				
				__loading(false);
			}
			
			function __fResult(e:*):void
			{ 
				list_.dataProvider = _connList.DATA_ARR;
				
				if(fResult_!=null)
					fResult_.call(null);
				
				__loading(false);
			}
			
			__loading(true);
			
			//to create sql columns (@temporary)
			__configSql();
			
			var _sql:String = " SELECT " + _sqlColumns.toString() + 
				
				" FROM dbd_report " +
				" WHERE VISIBLE LIKE '1' AND (TITLE like '%"+value_+"%' OR MESSAGE like '%"+value_+"%') " +
				" ORDER BY DATE_END DESC ";
			
			//new gnncAlert().__alert(_sql);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
		}
		
		public function __selectDate(dateEnd_:Date,getIdUser_:Boolean=true,fResult_:Function=null,fFault_:Function=null):void
		{
			function __fFault(e:*):void
			{ 
				if(fFault_!=null)
					fFault_.call(null);
				
				__loading(false);
			}
			
			function __fResult(e:*):void
			{ 
				if(fResult_!=null)
					fResult_.call(null);
				
				list_.dataProvider = _connList.DATA_ARR;
				
				__loading(false);
			}

			__loading(true);
			
			__configSql(); //refresh

			var _sql:String = " SELECT " + _sqlColumns.toString() + 

				" FROM dbd_report " +
				" WHERE ( VISIBLE LIKE '1' AND LEFT(DATE_END,10) like '"+gnncDate.__date2String(dateEnd_,false)+"' " +
				" " + ( getIdUser_ ? " AND ID_USER = '"+gnncGlobalStatic._userId+"' " : "" ) + " ) " +
				" ORDER BY DATE_END DESC ";
			
			//new gnncAlert().__alert(_sql);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
		}
		
		
		public function __insertReport(idClient_:uint,title_:String,message_:String='',type_:uint=0,active_:uint=0,dateToday_:Date=null,fResul_:Function=null,fFault_:Function=null):void
		{
			if(!_tableClass || !idClient_ || !title_)
			{
				if(fFault_!=null)
					fFault_.call(null);
				return ;
			}
			
			function __fFault(e:*):void
			{ 
				if(fFault_!=null)
					fFault_.call(null);
				
				__loading(false);
			}
			
			function __fResult(e:*):void
			{ 
				if(fResul_!=null)
					fResul_.call(null);
				
				__selectDate(new Date());
			}
			
			__loading(true);

			var _table:Object 			= gnncData.__clone(_tableClass);
			
			_table.ID_CLIENT 			= idClient_;
			_table.ID_USER 				= gnncGlobalStatic._userId;
			
			_table.TITLE 				= title_;
			_table.MESSAGE 				= message_;
			_table.MIX					= 'REPORT';
			
			_table.DATE_END 			= gnncDate.__date2String(dateToday_ ? dateToday_ : new Date(),true,true);
			
			var _sql:String = new gnncSql().__INSERT(_table,false,false,false)
			_connExec.__sql(_sql,'','',__fResult,__fFault);
		}

				
		
		
	}
}
