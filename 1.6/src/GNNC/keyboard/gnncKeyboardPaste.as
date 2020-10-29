package GNNC.keyboard
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class gnncKeyboardPaste
	{
		private var _parent:Object;
		
		public function gnncKeyboardPaste(parentApplication_:Object=null)
		{
			_parent = parentApplication_ ? parentApplication_ : gnncGlobalStatic._parent;
		}
		
		public function __pasteErrorGlobal():void
		{
			//PROBLEM: Toda vez que uma tecla for clicada ele confere 
			//se é um paste/colagem então acaba deixando o sistema mais lento. Porém evita erro.
			_parent.stage.addEventListener(Event.PASTE,__eventPaste);
			_parent.stage.addEventListener(KeyboardEvent.KEY_DOWN,__eventKeyboard);
		}
		
		private function __eventKeyboard(e:KeyboardEvent):void
		{
			//new DAYBYDAY_ALERT()._ERROR(_PARENT,'ok');
			//ATTENTION: control = ctrolKey + V = 86  |or|  control and V = 22
			if(gnncKeyboard.__controlV(e))
			{ 
				if(!Clipboard.generalClipboard.hasFormat(ClipboardFormats.TEXT_FORMAT))
				{
					e.preventDefault();
					e.stopPropagation();
					e.stopImmediatePropagation();
				}
			}
		}

		private function __eventPaste(e:Event):void
		{
			if(!Clipboard.generalClipboard.hasFormat(ClipboardFormats.TEXT_FORMAT))
			{
				e.preventDefault();
				e.stopPropagation();
				e.stopImmediatePropagation();
			}
		}
	}
}