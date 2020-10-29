package GNNC.data.data
{
	public class gnncDataVector
	{
		private var _parent:Object;
		
		public function gnncDataVector(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}

		public static function __vector2Array(obj:Object):Array
		{
			if (!obj) 
			{
				return [];
			} 
			else if (obj is Array)
			{
				return obj as Array;
			} 
			else if (obj is Vector.<*>)
			{
				var array:Array = new Array(obj.length);
				
				for (var i:int = 0; i < obj.length; i++) 
				{
					array[i] = obj[i];
				}
				
				return array;
			} 
			else 
			{
				return [obj];
			}
					
		}
		
	}
}