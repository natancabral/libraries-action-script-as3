package GNNC.UI.gnncMenuRight
{
	import GNNC.mouse.gnncMousePoint;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Menu;

	public class gnncMenuRight
	{
		private var _MENU:Menu = new Menu();
		
		public var menuData:Array = [
			{label: "MenuItem A", children: [
				{label: "SubMenuItem A-1", enabled: false},
				{label: "SubMenuItem A-2", type: "normal"} 
			]},
			{label: "MenuItem B", type: "check", toggled: true},
			{label: "MenuItem C", type: "check", toggled: false},
			{type: "separator"},
			{label: "MenuItem D", children: [
				{label: "SubMenuItem D-1", type: "radio", groupName: "g1"},
				{label: "SubMenuItem D-2", type: "radio", groupName: "g1", toggled: true}, 
				{label: "SubMenuItem D-3", type: "radio", groupName: "g1"} 
			]} 
		];

		public function gnncMenuRight()
		{
			_MENU = Menu.createMenu(null, menuData, true);
		}

		public function __creation(event:MouseEvent):void 
		{
			var mp:Point = gnncMousePoint.__local2Global(event);
			_MENU.show(mp.x,mp.y);
		}
		
	}
}
