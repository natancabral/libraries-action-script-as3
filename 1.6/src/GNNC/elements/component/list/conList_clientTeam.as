package GNNC.elements.component.list
{
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArray;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.event.gnncEventGeneral;
	import GNNC.modules.client.formView.viewClient;
	import GNNC.modules.client.itemRender.itemRender_clientName_forList;
	import GNNC.modules.client.itemRender.itemRender_clientPhoto_forList;
	import GNNC.modules.client.itemRender.itemRender_client_forList;
	import GNNC.modules.project.itemRender.itemRender_Project_clientTeam_forList;
	import GNNC.sqlTables.table_;
	import GNNC.sqlTables.table_client;
	import GNNC.sqlTables.table_login;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.Image;

	//[Bindable]
	public class conList_clientTeam extends conList_class
	{
		//override public var _length:uint;
		public var selectedCheckItensArray:ArrayCollection = new ArrayCollection();
		
		public function conList_clientTeam()
		{
			__config();
			__configSql();
			__configEventListener();
		}
		
		private function __config():void
		{
			_name							= 'Equipe';
			
			_itemRenderList					= itemRender_Project_clientTeam_forList
			_itemRenderBox					= itemRender_Project_clientTeam_forList;
			_itemRenderListClear			= null;
			_itemRenderBoxClear				= null;
			
			_tableClass						= new table_login();
			_tableClassName					= '_TABLE_LOGIN';

			itemRenderIndex 				= 0;
			
			_afterChangeEventUpdateOnlyItem = false;
		}
		
		public override function __configSql(e:*=null):void
		{
			_sqlConsult = " " +
				" select " +
				" l.ID,l.ID_CLIENT,l.ID_GROUP,l.USER,l.USER_EMAIL,l.IS_ADMIN,l.IS_CLIENT,l.ACTIVE," +
				" 0 as SELECTED," +
				" c.NAME as NAME_CLIENT," +
				" g.NAME as NAME_GROUP," +
				" coalesce(( select a.FILE_LINK from dbd_attach a WHERE a.MIX = 'CLIENT_PHOTO' and a.ID_MIX = l.ID_CLIENT AND (a.EXTENSION = 'jpg' or a.EXTENSION = 'jpeg' or a.EXTENSION = 'png' or a.EXTENSION = 'gif') ORDER BY a.ORDER_ITEM asc,a.ID desc LIMIT 1	),'') ATTACH_CLIENT" +
				" from dbd_login l" +
				" left join dbd_client c on (c.ID = l.ID_CLIENT) " +
				" left join dbd_group g on (g.ID = l.ID_GROUP) " +
				" where l.ACTIVE > 0  " +
				" order by NAME_CLIENT asc, l.USER asc " +
				"";
			
			_sqlOrderBy						= ['ID'];
			_sqlColumns						= ['*'];
			_sqlWhere						= null;
			_sqlOrderDesc					= true;
			_sqlLimit						= null;
		}

		private function __configEventListener(e:*=null):void
		{
			list_.addEventListener(gnncEventGeneral._selectItem,selectedItensArrayFunction);
			list_.addEventListener(gnncEventGeneral._clear,clearItensArrayFunction);
		}

		private function selectedItensArrayFunction(e:gnncEventGeneral):void
		{
			var o:Object = dataProvider.getItemAt(selectedIndex);
			o.SELECTED = 1;
			dataProvider.setItemAt(o,selectedIndex);

			selectedCheckItensArray.addItem(o);
			selectedItem.SELECTED = 1;
		}
		
		private function clearItensArrayFunction(e:gnncEventGeneral):void
		{
			selectedCheckItensArray.removeItem(selectedItem);
			selectedItem.SELECTED = 0;
			
			var o:Object = dataProvider.getItemAt(selectedIndex);
			o.SELECTED = 0;
			dataProvider.setItemAt(o,selectedIndex);
		}
		
		public function selectedCheckIdsList(property_:String='ID_CLIENT'):Array
		{
			var arr:Array = new Array();
			var i:uint = 0;
			var len:uint = selectedCheckItensArray.length;
			for(i=0;i<len;i++){
				arr.push(selectedCheckItensArray.getItemAt(i)[property_]);
			}
			arr = gnncDataArray.__sortAlpha(arr);
			return arr;
		}

		public function selectedCheckIds(v:Object):void
		{
			var s:Array = v is Array ? v as Array : v is String ? String(v).split(',') as Array : null ; 

			if(s == null || s == false)
				return;
			
			if(_length==0)
				return;
			
			var gda:gnncDataArrayCollection = new gnncDataArrayCollection();
			var arr:ArrayCollection = gda.__filterArrayNumeric(dataProviderArrayC,'ID_CLIENT',s);
			var idx:Array = gda.filterIndexs;
			var len:uint = gda.filterIndexs.length;
			var i:uint = 0;
			var o:Object = null;
			
			for(i=0;i<len;i++){
				o = gnncData.__clone(arr.getItemAt(i));
				o.SELECTED = 1;
				dataProvider.setItemAt(o,idx[i]);
				selectedCheckItensArray.addItem(o);
				//gnncGlobalLog.__add('addArrayItem:'+i+'|IdClient:'+o.ID_CLIENT);
			}
			//selectedCheckItensArray = arr;
			list_.dataProvider = new ArrayCollection(dataProvider.toArray());
			list_.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
		}
		
		/*
		public var filterData:Array = new Array();
		public var filterIds:Array = new Array();
		public var filterIndexs:Array = new Array();
		public function __filterArrayNumeric(arrayC_:ArrayCollection,property_:String,values_:Array):ArrayCollection
		{
			var arr:ArrayCollection = new ArrayCollection();
			var len:uint = arrayC_.length;
			var i:uint = 0;
			var o:Object = new Object();
			
			for( i=0; i<len; i++ ){
				o = arrayC_.getItemAt(i);
				if(o.hasOwnProperty(property_)){ //if true
					if( values_.indexOf(o[property_]) !== -1 ){
						filterData.push(o);
						filterIds.push(o.ID);
						filterIndexs.push(i);
						arr.addItem(o);
					}
				}
			}			
			return arr;
		}*/

		
		public override function __pageView():Object
		{
			return null;
			var _table:table_client 		= new table_client();
			_table.ID	 					= selectedItem.ID_CLIENT;
			
			var _page:viewClient			= new viewClient();
			_page._tableClient 			= _table;

			return _page;
		}
		
		public override function __pageNew():Object
		{
			return null;
		}
		
		public override function __pageEdit():Object
		{
			return null;
		}

		
		
		
		

	}
}