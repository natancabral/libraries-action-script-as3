package GNNC.elements.component.list
{
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.data.data.gnncData;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.permission.gnncPermission;
	import GNNC.data.sql.gnncSql;
	import GNNC.modules.project.formNew.newComment;
	import GNNC.modules.project.formView.viewComment;
	import GNNC.modules.project.itemRender.itemRender_comment_forList;
	import GNNC.sqlTables.table_comment;
	
	import flashx.textLayout.elements.TabElement;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;
	import mx.states.OverrideBase;
	
	//[Bindable]
	public class conList_comment extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_comment()
		{
			__config();
		}
		
		private function __config():void
		{
			_name							= 'Comentário';
			
			_itemRenderList					= itemRender_comment_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_comment();
			_tableClassName					= '_tableComment';

			itemRenderIndex 				= 0;
		}

		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:false,	visible:true,	dispatchEvent:'', 	fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:'', 	fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:'', 	fName:__fEdit	},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:'', 	fName:__fDelete	},
					{label:'Atualizar',		enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:'', 	fName:__fRefresh},
				]
			);
			
		}

		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ID desc','DATE'];
			_sqlWhere						= null;
			_sqlOrderDesc					= false;
			_sqlLimit						= null;
			_sqlColumns						= 
				[
					"*",
					"(select (select v.NAME from dbd_client v where v.ID = a.ID_CLIENT) from dbd_login a where a.ID = dbd_comment.ID_USER) NAME_USER ",
					//"coalesce((select (select a.FILE_LINK from dbd_attach a WHERE a.MIX = 'CLIENT_PHOTO' and a.ID_MIX = a.ID_CLIENT AND (a.EXTENSION = 'jpg' or a.EXTENSION = 'jpeg' or a.EXTENSION = 'png' or a.EXTENSION = 'gif') ORDER BY a.ORDER_ITEM LIMIT 0,1	) from dbd_login l where l.ID = dbd_comment.ID_USER),'') ATTACH_CLIENT"
					"coalesce((select a.FILE_LINK from dbd_attach a WHERE a.MIX = 'CLIENT_PHOTO' and a.ID_MIX = dbd_comment.ID_CLIENT_INSERT AND (a.EXTENSION = 'jpg' or a.EXTENSION = 'jpeg' or a.EXTENSION = 'png' or a.EXTENSION = 'gif') ORDER BY a.ORDER_ITEM asc,a.ID desc LIMIT 0,1	),'')  ATTACH_CLIENT"
				];
		}
		
		public override function __pageView():Object
		{
			var _page:viewComment			= new viewComment();
			_page._tableComment 			= new table_comment(selectedItem.ID);
			
			return _page;
		}
		
		public override function __pageNew():Object
		{
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
		}

		public override function __pageEdit():Object
		{
			var _page:newComment			= new newComment();
			_page._tableComment				= new table_comment(selectedItem.ID);
			
			return _page;
		}
		
		public function __insertComment(message_:String,fResul_:Function=null,fFault_:Function=null):void
		{
			if(!_tableClass || !message_)
			{
				if(fFault_!=null)
					fFault_.call(null);
				return ;
			}
			
			__loading(true);
			
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
				__select();
			}
			
			var _table:Object 	= gnncData.__clone(_tableClass);
			_table.ID_USER		= gnncGlobalStatic._userId;
			_table.ID_CLIENT_INSERT = gnncGlobalStatic._userIdClient;
			_table.MESSAGE		= message_;
			
			var _sql:String = new gnncSql().__INSERT(_table,false,false,false)
			_connExec.__sql(_sql,'','',__fResult,__fFault);
		}

		
		
		
		
		
		
		
		
		
	}
}
