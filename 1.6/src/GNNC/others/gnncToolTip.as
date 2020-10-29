package GNNC.others
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.events.MouseEvent;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.ToolTipManager;
	
	import spark.components.Group;
	
	public class gnncToolTip
	{
		private var _parent:Object 	= null;
		
		public function gnncToolTip(parentApplication_:Object=null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent;
		}

		public static function __apply(showDelay_:uint=100, hideDelay_:uint=10000, enabled_:Boolean=true, scrubDelay_:uint=3000):void
		{
			ToolTipManager.showDelay 	= showDelay_;
			ToolTipManager.hideDelay 	= hideDelay_;
			ToolTipManager.enabled 		= enabled_;
			ToolTipManager.scrubDelay 	= scrubDelay_;
		}

		public static function __destroy(displayObject_:IFlexDisplayObject):void
		{
			try{
				displayObject_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				displayObject_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}catch(e:*){
				gnncGlobalStatic._parent.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				gnncGlobalStatic._parent.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
			
			
			//return displayObject_;
			
			/*if(ToolTipManager.currentToolTip)
			{
				ToolTipManager.destroyToolTip(ToolTipManager.currentToolTip);
			}*/
		}		

	}
}