package GNNC.elements.component.list
{
	import GNNC.data.data.gnncDataBindable;
	import GNNC.modules.project.formNew.newJob;
	import GNNC.modules.project.formView.viewJob;
	import GNNC.modules.project.itemRender.itemRender_jobBox_forList;
	import GNNC.modules.project.itemRender.itemRender_jobList_forList;
	import GNNC.sqlTables.table_job;
	
	import mx.collections.ArrayCollection;

	//[Bindable]
	public class conList_job extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_job()
		{
			__config();
			gnncDataBindable.__loginSession(__configSql);
		}
		
		private function __config():void
		{
			_name							= 'Job';
			
			_itemRenderList					= itemRender_jobList_forList;
			_itemRenderBox					= itemRender_jobBox_forList;
			_itemRenderListClear			= itemRender_jobList_forList;
			_itemRenderBoxClear				= itemRender_jobBox_forList;
			
			_tableClass						= new table_job();
			_tableClassName					= '_tableJob';
			
			itemRenderIndex 				= 0;

			_dragMoveEnabled				= true;
		}
		
		public override function __contextMenuModel():void
		{
			
			//_contextMenuItems = new ArrayCollection();

			var s:String = '';
			var t:String = '';
			var c:String = '';

			if(selectedIndex > -1)
			{
				s = selectedItem.TITLE;
				t = String(s).length > 40 ? String(s).substr(0,40) : s;
				c = selectedItem.CONTROL == 1 ? ' Desaprovar' : ' Aprovar';
			}
			
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Título'+t,				enabled:false,		separator:false,	visible:true,	dispatchEvent:'', 		fName:null			},
					
					{label:'Visualizar',			enabled:_view,		separator:true,		visible:true,	dispatchEvent:'', 		fName:__fView		},
					{label:'Novo',					enabled:_new,		separator:true,		visible:true,	dispatchEvent:'', 		fName:__fNew		},
					{label:'Editar',				enabled:_edit,		separator:false,	visible:true,	dispatchEvent:'', 		fName:__fEdit		},
					{label:'Excluir',				enabled:_delete,	separator:false,	visible:true,	dispatchEvent:'', 		fName:__fDelete		},

					{label:'Finalizar',				enabled:false,		separator:true,		visible:true,	dispatchEvent:'', 		fName:null			},
					{label:'Cancelar',				enabled:false,		separator:false,	visible:true,	dispatchEvent:'', 		fName:null			},
					
					{label:'Controle: '+c,			enabled:false,		separator:true,		visible:true,	dispatchEvent:'', 		fName:null			},

					{label:'Enviar aos Favoritos ',	enabled:false,		separator:true,		visible:true,	dispatchEvent:'', 		fName:null			},
					{label:'Enviar Arquivo ',		enabled:false,		separator:false,	visible:true,	dispatchEvent:'', 		fName:null			},
					{label:'Enviar Comentários',	enabled:false,		separator:false,	visible:true,	dispatchEvent:'', 		fName:null			},

					{label:'Atualizar',				enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:'', 		fName:__fRefresh	}
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
//				'dbd_job.ID',
				'ID',
				'(1) NO_CONTROL',
				'TITLE',
				'MESSAGE',
				'ACTIVE',
				'CONTROL',
				'DATE',
				'DATE_START',
				'DATE_END',
				'DATE_FINAL',
				'DATE_CANCELED',
				"coalesce((select NAME from dbd_client 		where dbd_client.ID 		like dbd_job.ID_CLIENT)		,'') NAME_CLIENT",
				"coalesce((select NAME from dbd_project 	where dbd_project.ID 		like dbd_job.ID_PROJECT)	,'') NAME_PROJECT",
				"coalesce((select NAME from dbd_step 		where dbd_step.ID 			like dbd_job.ID_STEP)		,'') NAME_STEP",
				"coalesce((select NAME from dbd_departament where dbd_departament.ID 	like dbd_job.ID_DEPARTAMENT),'') NAME_DEPARTAMENT",
				"coalesce((select NAME from dbd_group 		where dbd_group.ID 			like dbd_job.ID_GROUP)		,'') NAME_GROUP",
				"coalesce((select NAME from dbd_category 	where dbd_category.ID 		like dbd_job.ID_CATEGORY)	,'') NAME_CATEGORY"
			];
		}
		
		public override function __pageView():Object
		{
			var _table:table_job 			= new table_job();
			_table.ID	 					= selectedItem.ID;
			
			var _page:viewJob				= new viewJob();
			_page._tableJob 				= _table;
			
			return _page;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_job 			= new table_job();
			_table.ID_CLIENT				= _tableClass['ID_CLIENT']  	? _tableClass['ID_CLIENT']  : selectedIndex > -1 ? selectedItem.ID_CLIENT 	: 0;
			_table.ID_PROJECT				= _tableClass['ID_PROJECT'] 	? _tableClass['ID_PROJECT'] : selectedIndex > -1 ? selectedItem.ID_PROJECT 	: 0;
			_table.ID_STEP					= _tableClass['ID_STEP']    	? _tableClass['ID_STEP']    : selectedIndex > -1 ? selectedItem.ID_STEP 	: 0;
			
			var _page:newJob				= new newJob();
			_page._tableJob 				= _table;
			_page._nameClient				= selectedIndex < 0 ? '' : selectedItem.hasOwnProperty('NAME_CLIENT')  	? selectedItem['NAME_CLIENT'] 	: '';
			_page._nameProject				= selectedIndex < 0 ? '' : selectedItem.hasOwnProperty('NAME_PROJECT')  ? selectedItem['NAME_PROJECT'] 	: '';
			_page._nameStep					= selectedIndex < 0 ? '' : selectedItem.hasOwnProperty('NAME_STEP')  	? selectedItem['NAME_STEP'] 	: '';
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_job 			= new table_job();
			_table.ID	 					= selectedItem.ID;
			
			var _page:newJob				= new newJob();
			_page._tableJob 				= _table;
			
			return _page;
		}

	}
}