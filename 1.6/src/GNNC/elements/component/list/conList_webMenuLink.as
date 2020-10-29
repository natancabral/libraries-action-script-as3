package GNNC.elements.component.list
{
	import GNNC.modules.web.formNew.newWebMenuLink;
	import GNNC.modules.web.itemRender.itemRender_webMenuLink_forList;
	import GNNC.sqlTables.table_web_menu_link;

	//[Bindable]
	public class conList_webMenuLink extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_webMenuLink()
		{
			__config();
			__configSql();
		}
		
		private function __config():void
		{
			_name							= 'Menu Link';
			
			_itemRenderList					= itemRender_webMenuLink_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_web_menu_link();
			_tableClassName					= '_tableWebMenuLink';

			itemRenderIndex 				= 0;
			
			_afterChangeEventUpdateOnlyItem = false;
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ORDER_ITEM','NAME'];
			_sqlColumns						= ['*'];
			_sqlWhere						= null;
			_sqlOrderDesc					= false;
			_sqlLimit						= null;
		}
		
		public override function __pageView():Object
		{
			return null;
			
			/*
			var _table:table_web_menu_link 	= new table_web_menu_link();
			_table.ID	 					= selectedItem.ID;
			
			var _page:viewAttach			= new viewAttach();
			_page._TABLE_ATTACH 			= _table;

			return _page;
			*/
		}
		
		public override function __pageNew():Object
		{
			var _table:table_web_menu_link 	= new table_web_menu_link();
			_table.ID_WEB_MENU_LOCATION 	= _tableClass.ID_WEB_MENU_LOCATION;
			_table.MIX 						= _tableClass.MIX;
			
			var _page:newWebMenuLink 		= new newWebMenuLink();
			_page._MIX 						= _tableClass.MIX;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_web_menu_link 	= new table_web_menu_link(selectedItem.ID);
			
			var _page:newWebMenuLink 		= new newWebMenuLink();
			_page._tableWebMenuLink			= _table;
			
			return _page;
		}

	
		
		
		
		

	}
}