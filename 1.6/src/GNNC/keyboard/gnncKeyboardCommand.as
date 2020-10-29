package GNNC.keyboard
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class gnncKeyboardCommand extends Sprite
	{
		public function gnncKeyboardCommand()
		{
			super();
			//this.addEventListener(MouseEvent.CLICK,			clickHandler);
			this.addEventListener(KeyboardEvent.KEY_DOWN,	__keyPressed);
			this.addEventListener(Event.ACTIVATE,			__clickHandler);
		}
		private function __clickHandler(event:Event):void {
			trace("set");
			//stage.focus = this;
			this.width = 400;
			this.height	= 400;
		}
		private function __keyPressed(evt:KeyboardEvent):void{
			if(evt.ctrlKey && evt.keyCode == 65)
				trace("CTRL A is pressed");
			if(evt.ctrlKey && evt.keyCode == 66)
				trace("CTRL B is pressed");
		}
	}
}