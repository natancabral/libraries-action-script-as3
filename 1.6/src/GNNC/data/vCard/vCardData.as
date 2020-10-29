package GNNC.data.vCard
{
	import flash.utils.ByteArray;

	public class vCardData
	{
		public var fullName:String;
		public var orgs:Array;
		public var title:String;
		public var image:ByteArray;
		public var phones:Array;
		public var emails:Array;
		public var addresses:Array = new Array();
		
		public function vCardData()
		{
			orgs 			= new Array();
			phones 			= new Array();
			emails 			= new Array();
			addresses 		= new Array();
		}
	}
}