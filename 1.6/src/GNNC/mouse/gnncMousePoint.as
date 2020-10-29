package GNNC.mouse
{
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class gnncMousePoint
	{
		public function gnncMousePoint()
		{
		}
		
		static public function __local2Global(event:MouseEvent):Point
		{
			var pt:Point = new Point(event.localX, event.localY);
			pt = event.target.localToGlobal(pt);
			return pt;
		}
		
		static public function __stage2Global(event:MouseEvent):Point
		{
			var pt:Point = new Point(event.stageX, event.stageY);
			pt = event.target.localToGlobal(pt);
			return pt;
		}

	}
}