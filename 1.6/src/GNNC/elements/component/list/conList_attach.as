package GNNC.elements.component.list
{
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.modules.attach.formNew.newAttach;
	import GNNC.modules.attach.formView.viewAttach;
	import GNNC.modules.attach.itemRender.itemRender_attachPhoto_forList;
	import GNNC.modules.attach.itemRender.itemRender_attach_forList;
	import GNNC.sqlTables.table_attach;
		
	import spark.components.Image;

	//[Bindable]
	public class conList_attach extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_attach()
		{
			__config();
			__configSql();
		}
		
		private function __config():void
		{
			_name							= 'Arquivo';
			
			_itemRenderList					= itemRender_attach_forList;
			_itemRenderBox					= itemRender_attachPhoto_forList;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_attach();
			_tableClassName					= '_TABLE_ATTACH';

			itemRenderIndex 				= 0;
			
			_afterChangeEventUpdateOnlyItem = false;
		}
		
		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['ID'];
			_sqlColumns						= ['*'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
		}
		
		public override function __pageView():Object
		{
			var _table:table_attach 		= new table_attach();
			_table.ID	 					= selectedItem.ID;
			_table.NAME 					= selectedItem.NAME;
			_table.FILE_HTTP				= selectedItem.FILE_HTTP;
			_table.FILE_LINK				= selectedItem.FILE_LINK;
			_table.URL_LINK					= selectedItem.URL_LINK;
			_table.SIZE						= selectedItem.SIZE;
			_table.EXTENSION				= selectedItem.EXTENSION;
			
			var _page:viewAttach			= new viewAttach();
			_page._TABLE_ATTACH 			= _table;

			return _page;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_attach 		= new table_attach();
			_table.ID_CLIENT 				= _tableClass.ID_CLIENT;
			_table.ID_PROJECT 				= _tableClass.ID_PROJECT;
			_table.ID_STEP 					= _tableClass.ID_STEP;
			_table.MIX 						= _tableClass.MIX;
			_table.ID_MIX					= _tableClass.ID_MIX;
			
			var _page:newAttach 			= new newAttach();
			_page._tableAttach 				= _table;
			_page._MIX						= _tableClass.MIX;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _page:newAttach			= new newAttach();
			_page._tableAttach			= new table_attach(selectedItem.ID);
			
			return _page;
		}

		public function __fileLocation(index_:int,propertyNamePhoto_:String='PHOTO_CLIENT',setInImage_:Image=null):Object
		{
			if(index_ < 0 || index_ == length || !length)
				return null;
			
			var _obj:Object = list_.dataProvider.getItemAt(0);
			
			if(!selectedItem.hasOwnProperty(propertyNamePhoto_))
				return null;
			
			var _http:String = gnncGlobalStatic._httpHost+'ATTACH/'+String(gnncGlobalStatic._dataBase).toUpperCase()+'/'+_obj[propertyNamePhoto_];
			
			if(setInImage_!=null)
				setInImage_.source = _http;
			
			return _http;
		}

		
		
		
		
		
		
		

	}
}