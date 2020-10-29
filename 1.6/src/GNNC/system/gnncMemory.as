package GNNC.system
{
	import flash.net.LocalConnection;
	import flash.system.System;
	
	public class gnncMemory
	{
		private var _PARENT:Object 		= null;
		
		public function gnncMemory(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;
		}
		
		static public function __clear():void
		{
			try
			{
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
				
				//System.freeMemory;
				System.gc();
				System.gc();
			}
			catch(error:*)
			{
			}
		}
		
		static public function __used():uint 
		{
			//return System.totalMemory;
			return Number((Math.round(100*System.totalMemory/1048576)/100).toFixed(2));
		}


	}
}