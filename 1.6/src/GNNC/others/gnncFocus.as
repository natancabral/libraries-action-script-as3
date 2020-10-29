package GNNC.others
{
	import mx.core.FlexSprite;
	
	import spark.components.Group;

	public class gnncFocus extends Group
	{
		public function gnncFocus()
		{
		}
		
		public static function __set(componentFlex_:Object):Object
		{
			var count:uint = 0;
			
			function __focus():void
			{
				try
				{
					while (count++ < 10)
					{
						(componentFlex_).setFocus();
						(componentFlex_).setFocus();
						(componentFlex_).drawFocus(true);
					}
				}
				catch (e:*)
				{ 
				}
			}
			
			return (componentFlex_);
		}
	}
}