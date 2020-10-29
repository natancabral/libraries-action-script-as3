package GNNC.application
{
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	
	public class gnncAppResize
	{
		private var _PARENT:Object			= null;		
		private var _APP:gnncApplication	= new gnncApplication();
		private var image:Image 			= new Image();

		[Embed(source="image/resize-16.png")]
		private var resize:Class;

		public function gnncAppResize(parentApplication_:Object=null)
		{
			_PARENT 						= (parentApplication_)?parentApplication_:FlexGlobals.topLevelApplication;
			
			image.right						= 0;	
			image.bottom					= 0;
			image.source					= resize;
			image.addEventListener			(MouseEvent.MOUSE_DOWN,gnncApplication.__windowsResizeManual);
			
			_PARENT.addElement				(image);

		}
		
	}
}