package GNNC.system
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.ISystemManager;
	
	public class gnncParent
	{
		private var _PARENT:Object		= null;
		private var _PARENT_NEW:Object	= null;
		
		public function gnncParent(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;	
		}
		
		private function __CREATION():void
		{
			if (_PARENT == null)
			{
				var sm:ISystemManager = ISystemManager(FlexGlobals.topLevelApplication.systemManager);
				// no types so no dependencies
				var mp:Object = sm.getImplementation("mx.managers.IMarshallPlanSystemManager");
				if (mp && mp.useSWFBridge())
					_PARENT_NEW = sm.getSandboxRoot();
				else
					_PARENT_NEW = FlexGlobals.topLevelApplication;
			}
		}
		
		public function __SPRITE():Sprite
		{
			__CREATION();
			return Sprite(_PARENT_NEW);
		}
		
		public function __DISPLAY_OBJECT():DisplayObject
		{
			__CREATION();
			return _PARENT_NEW as DisplayObject;
		}
		
		public function __IFLEX_DISPLAY_OBJECT():IFlexDisplayObject
		{
			__CREATION();
			return _PARENT_NEW as IFlexDisplayObject;
		}
		
	}
}