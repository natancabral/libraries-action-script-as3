package GNNC.UI.gnncList
{
	import flash.ui.ContextMenu;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.List;

	public class gnncList extends List
	{
		public var _contextMenuItems:ArrayCollection 	= new ArrayCollection();
		public var _contextMenu:ContextMenu 			= new ContextMenu();
		public var _message:String 						= "Message this here";
		public var _setting:ArrayCollection 			= new ArrayCollection();
		
		public function gnncList()
		{
		}
		
		public function __contextMenu(data_:Object):ContextMenu
		{
			return new ContextMenu();
		}
		
	}
}