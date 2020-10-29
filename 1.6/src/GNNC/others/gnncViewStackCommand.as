package GNNC.others
{
	public class gnncViewStackCommand
	{
		private var _PAGE:String 	= '...';

		private var _PARENT:Object				= null;

		public function gnncViewStackCommand(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;
		}
		
		static public function __next(VIEWSTACK_:Object):Object
		{
			return (VIEWSTACK_.selectedIndex == VIEWSTACK_.numElements)?false:VIEWSTACK_.selectedIndex=VIEWSTACK_.selectedIndex+1;
			__PAGE();
		}
		
		static public function __prev(VIEWSTACK_:Object):Object
		{
			return (VIEWSTACK_.selectedIndex == 0)?false:VIEWSTACK_.selectedIndex=VIEWSTACK_.selectedIndex-1;
			__PAGE();
		}
		
		static private function __PAGE():void
		{
			//PAGE_NAME_.text = uint(VIEWSTACK_.selectedIndex+1)+'-'+VIEWSTACK_.numElements;
		}
		
		/*private function __KEY__F8_F9():Object
		{
			_PARENT.addEventListener(KeyboardEvent.KEY_UP,
			function(event:KeyboardEvent):void
			{
				if(new DAYBYDAY_KEY().F8(event)) __PREV();
				if(new DAYBYDAY_KEY().F9(event)) __NEXT();
				if(new DAYBYDAY_KEY().F8(event) || new DAYBYDAY_KEY().F9(event))
				{
					//FocusManager.mixins.push(this);
					//focusManager; new FocusEvent
					//focusManager.showFocus();
					//focusManager.getFocus();
					//focusManager.activate();
					ICON_.setFocus();
					//new DAYBYDAY_ALERT(parentApplication)._ALERT(systemManager.popUpChildren.getChildIndex(this)+":");
					//Object(focusManager.getFocus()).PANEL_;
				}
			}
		)*/

		
		
	}
}