package GNNC.elements.component.list
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncData;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.sql.gnncSql;
	import GNNC.modules.project.itemRender.itemRender_contactList_forList;
	import GNNC.skin.dropDownList.itemRender.itemRender_hierarchy_forList;
	import GNNC.sqlTables.table_contact;
	
	import mx.collections.ArrayCollection;
	
	//[Bindable]
	public class conList_contact extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_contact()
		{
			__config();
			__addEventPersonal();
		}
		
		private function __config():void
		{
			_name							= 'Contato';
			
			_itemRenderList					= itemRender_contactList_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_contact();
			_tableClassName					= '_tableContact';

			itemRenderIndex 				= 0;
		}
		
		private function __addEventPersonal():void
		{
			list_.addEventListener('selectDataBaseName',__fDataBaseName);
		}

		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					/*{label:'Visualizar',	enabled:_view,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:'', 	fName:__fEdit	},*/
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:'', 	fName:__fDelete	},
					{label:'Conferir',		enabled:true,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fDateFinal},
					
					{label:'Remover item(ns) da lista',	enabled:true,		separator:true,		visible:true,	dispatchEvent:'', fName:__fRemoveItemList	}
				]
			);
			
		}

		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['DATE'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
			_sqlColumns						= 
				[
					"*",
					"(select v.NAME 		from dbd_client v where v.ID like ID_CLIENT	) NAME_CLIENT ",
					"(select v.NICK_NAME 	from dbd_client v where v.ID like ID_CLIENT	) NICK_NAME_CLIENT "
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

		public function __fDataBaseName(e:*=null):void
		{
			if(!selected)
				return;
			
			if(!selectedItem.hasOwnProperty('DATABASENAME'))
				return;

			if(!selectedItem.DATABASENAME)
				return;

			//_sqlShow = true;
			__selectWhere(selectedItem.DATABASENAME,['DATABASENAME'],'',false);
		}

		public function __selectDataBaseName(value_:String):void
		{
			//_sqlShow = true;
			__selectWhere(value_,['DATABASENAME'],'',false);
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
				
				" FROM dbd_contact " +
				" WHERE VISIBLE LIKE '1' AND (TITLE like '%"+value_+"%' OR MESSAGE like '%"+value_+"%' OR MESSAGE_HTML like '%"+value_+"%' OR DATABASENAME like '"+value_+"') " +
				" ORDER BY DATE DESC ";
			
			//new gnncAlert().__alert(_sql);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
		}
		
		public function __selectDate(date_:Date,fResult_:Function=null,fFault_:Function=null):void
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

				" FROM dbd_contact " +
				" WHERE ( VISIBLE LIKE '1' AND LEFT(DATE,10) like '"+gnncDate.__date2String(date_,false)+"' ) " +
				" ORDER BY DATE DESC ";
			
			//new gnncAlert().__alert(_sql);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
		}
		
		
		
	}
}
