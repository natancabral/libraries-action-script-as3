package GNNC.UI.gnncDaybyday.gnncLogo
{
	import spark.components.Image;
	import spark.primitives.BitmapImage;
	
	public class gnncLogoSystem
	{
		private var _parent:Object 	= null;
		
		public var _x:uint = 10;
		public var _y:uint = 10;
		
		public function gnncLogoSystem(parentApplication_:Object)
		{
			_parent = parentApplication_;
		}
		
		public function __apply(imageClass_:Object=null):void
		{
			if(!imageClass_)
				return;
			
			var image:Image			= new Image();
			image.source			= imageClass_;
			image.y					= _y;
			image.x					= _x;
			
			_parent.addElement		(image);
		}
		
	}
}