package GNNC.elements.component.list
{
	import GNNC.data.data.gnncData;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.sql.gnncSql;
	import GNNC.modules.document.formNew.newFormModel;
	import GNNC.modules.document.itemRender.itemRender_formModel_forList;
	import GNNC.modules.project.formNew.newComment;
	import GNNC.modules.project.formView.viewComment;
	import GNNC.modules.project.itemRender.itemRender_comment_forList;
	import GNNC.sqlTables.table_comment;
	import GNNC.sqlTables.table_form_model;
	
	import flashx.textLayout.elements.TabElement;
	
	import mx.core.IFlexDisplayObject;
	import mx.states.OverrideBase;
	
	//[Bindable]
	public class conList_formModel extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_formModel()
		{
			__config();
		}
		
		private function __config():void
		{
			_name							= 'Formulário Modelo';
			
			_itemRenderList					= itemRender_formModel_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_form_model();
			_tableClassName					= '_tableFormModel';

			itemRenderIndex 				= 0;
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ID'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
			_sqlColumns						= 
				[
					"*"
				];
		}
		
		/*public override function __pageView():Object
		{
			var _page:viewComment			= new viewComment();
			_page._tableComment 			= new table_comment(selectedItem.ID);
			
			return _page;
		}*/
		
		public override function __pageNew():Object
		{
			var _table:table_form_model 	= new table_form_model();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			_table.ID_USER 					= gnncGlobalStatic._userId;
			_table.MIX 						= _tableClass.MIX;
			
			var _page:newFormModel			= new newFormModel();
			_page._tableFormModelo 			= _table;
			_page._MIX						= _tableClass.MIX;
			
			return _page;
		}

		public override function __pageEdit():Object
		{
			var _page:newFormModel			= new newFormModel();
			_page._tableFormModelo			= new table_form_model(selectedItem.ID);
			
			return _page;
		}
		
		
		
		
		
		
		
		
	}
}
