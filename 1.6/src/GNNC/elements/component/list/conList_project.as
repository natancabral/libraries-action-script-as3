package GNNC.elements.component.list
{
	import GNNC.data.data.gnncDataBindable;
	import GNNC.modules.project.formNew.newProject;
	import GNNC.modules.project.itemRender.itemRender_projectList_forList;
	import GNNC.sqlTables.table_project;
	
	//[Bindable]
	public class conList_project extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_project()
		{
			__config();
			gnncDataBindable.__loginSession(__configSql);
		}
		
		private function __config():void
		{
			_name							= 'Projeto';
			
			_itemRenderList					= itemRender_projectList_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= itemRender_projectList_forList;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_project();
			_tableClassName					= '_tableProject';

			itemRenderIndex 				= 0;
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['NAME'];
			_sqlWhere						= null;
			_sqlOrderDesc					= false;
			_sqlLimit						= null;
			_sqlColumns						= [
//				'dbd_project.ID',
				'ID',
				'NAME',
				'ACTIVE',
				'CONTROL',
				"coalesce((select NAME from dbd_client 		where dbd_client.ID 		like dbd_project.ID_CLIENT)		,'') NAME_CLIENT",
				"coalesce((select NAME from dbd_departament where dbd_departament.ID 	like dbd_project.ID_DEPARTAMENT),'') NAME_DEPARTAMENT",
				"coalesce((select NAME from dbd_group 		where dbd_group.ID 			like dbd_project.ID_GROUP)		,'') NAME_GROUP",
				"coalesce((select NAME from dbd_category 	where dbd_category.ID 		like dbd_project.ID_CATEGORY)	,'') NAME_CATEGORY",
				"coalesce((select COUNT(ID) from dbd_step 	where dbd_step.ID_PROJECT 	like dbd_project.ID)			,'') ROWS_STEP"
			];
		}
		
		public override function __pageView():Object
		{
			/*
			var _table:table_project 		= new table_project();
			_table.ID	 					= OBJDATP.ID;
			_table.NAME 					= selectedItem.NAME;
			
			var _page:viewAttach			= new viewAttach();
			_page._table_project 			= _table;
			
			return _page;*/

			return null;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_project 		= new table_project();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			
			var _page:newProject 			= new newProject();
			_page._tableProject 			= _table;
			
			return _page;
			return null;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_project 		= new table_project();
			_table.ID 						= selectedItem.ID;
			
			var _page:newProject 			= new newProject();
			_page._tableProject 			= _table;
			
			return _page;
			return null;
		}
		
		
		
		
	}
}