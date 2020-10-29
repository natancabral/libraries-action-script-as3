package GNNC.elements.component.list
{
	import GNNC.modules.web.formNew.newWebPage;
	import GNNC.modules.web.itemRender.itemRender_webMenuLink_forList;
	import GNNC.sqlTables.table_web_page;

	//[Bindable]
	public class conList_webPage extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_webPage()
		{
			__config();
			__configSql();
		}
		
		private function __config():void
		{
			_name							= 'Web Página';
			
			_itemRenderList					= itemRender_webMenuLink_forList;
			_itemRenderBox					= null;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_web_page();
			_tableClassName					= '_tableWebPage';

			itemRenderIndex 				= 0;
			
			_afterChangeEventUpdateOnlyItem = false;
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ORDER_ITEM','TITLE'];
			_sqlColumns						= ['*','(select count(ID) from dbd_web_page p where p.ID_WEB_MENU_LINK like dbd_web_menu_link.ID limit 0,1 ) ROWS_WEB_PAGE'];
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
			var _table:table_web_page 		= new table_web_page();
			_table.ID_WEB_MENU_LINK 		= _tableClass.ID_WEB_MENU_LINK;
			_table.MIX 						= _tableClass.MIX;
			
			var _page:newWebPage 			= new newWebPage();
			_page._MIX 						= _tableClass.MIX;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _table:table_web_page 		= new table_web_page(selectedItem.ID);
			
			var _page:newWebPage 			= new newWebPage();
			_page._tableWebPage				= _table;
			
			return _page;
		}

	
		
		
		
		

	}
}