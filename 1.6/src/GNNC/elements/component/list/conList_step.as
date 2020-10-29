package GNNC.elements.component.list
{
	import GNNC.data.data.gnncDataBindable;
	import GNNC.event.gnncEventGeneral;
	import GNNC.modules.step.formNew.newStep;
	import GNNC.modules.step.itemRender.itemRender_stepList_forList;
	import GNNC.sqlTables.table_step;
	
	import mx.collections.ArrayCollection;
	
	//[Bindable]
	public class conList_step extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_step()
		{
			__config();
			gnncDataBindable.__loginSession(__configSql);
		}
		
		private function __config():void
		{
			_name							= 'Etapa';
			
			_itemRenderList					= itemRender_stepList_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_step();
			_tableClassName					= '_tableStep';
			
			itemRenderIndex 				= 0;
		}

		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:true,		visible:true,	dispatchEvent:'', 		fName:__fView		},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:'', 		fName:__fNew		},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:'', 		fName:__fEdit		},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:'', 		fName:__fDelete		},
					{label:'Atualizar',		enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:'', 		fName:__fRefresh	}
				]
			);
		}

		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ORDER_ITEM'];
			_sqlWhere						= null;
			_sqlOrderDesc					= false;
			_sqlLimit						= null;
			_sqlColumns						= [
//				'dbd_step.ID',
				'ID',
				'NAME',
				'ACTIVE',
				'CONTROL',
				'DESCRIPTION',
				/*"coalesce((select NAME from dbd_client 		where dbd_client.ID 		like dbd_project.ID_CLIENT)		,'') NAME_CLIENT",
				"coalesce((select NAME from dbd_departament where dbd_departament.ID 	like dbd_project.ID_DEPARTAMENT),'') NAME_DEPARTAMENT",
				"coalesce((select NAME from dbd_group 		where dbd_group.ID 			like dbd_project.ID_GROUP)		,'') NAME_GROUP",
				"coalesce((select NAME from dbd_category 	where dbd_category.ID 		like dbd_project.ID_CATEGORY)	,'') NAME_CATEGORY",*/
				"coalesce((select COUNT(ID) from dbd_job 	where dbd_job.ID_STEP 		like dbd_step.ID)				,'') ROWS_JOB"
			];
		}
		
		public override function __pageView():Object
		{
			/*
			var _table:table_project 		= new table_project();
			_table.ID	 					= selectedItem.ID;
			_table.NAME 					= selectedItem.NAME;
			
			var _page:viewAttach			= new viewAttach();
			_page._table_project 			= _table;
			
			return _page;*/
			
			return null;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_step 			= new table_step();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			_table.ID_PROJECT 				= _tableClass.ID_PROJECT;
			
			var _page:newStep 				= new newStep();
			_page._tableStep 				= _table;
			//_page._MIX						= _tableClass['MIX'];
			
			return _page;
			
			return null;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_step 			= new table_step();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			_table.ID_PROJECT 				= _tableClass.ID_PROJECT;
			
			var _page:newStep 				= new newStep();
			_page._tableStep 				= _table;
			//_page._MIX						= _tableClass['MIX'];

			return _page;

			return null;
		}
		
		public function __description(value_:String,fResult_:Function=null,fFault_:Function=null):void
		{
			if(!selected)
				return;

			__loading(true);

			_connExec.__sql("Update dbd_step set DESCRIPTION = '"+value_+"' where ID like '"+selectedItem.ID+"' ",'','',__fResult,__fFault);
			//_connExec.__sql(new gnncSql().__UPDATE(new table_step(_idStep),new table_step(_idStep),false,[" DESCRIPTION = '"+descriptionStep_.text+"' "]),'','',__fResult,__fFault);
			
			function __fResult(e:*):void
			{
				selectedItem.DESCRIPTION = value_;
				
				__loading(false);
				callLater(fResult_,[null]);
			}

			function __fFault(e:*):void
			{
				__loading(false);
				callLater(fFault_,[null]);
			}
		}
		
		
	}
}