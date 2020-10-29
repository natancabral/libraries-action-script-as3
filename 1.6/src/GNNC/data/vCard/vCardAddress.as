package GNNC.data.vCard
{
	public class vCardAddress
	{
		public var type:String;
		public var street:String;
		public var city:String;
		public var state:String;
		public var postalCode:String;
		
		public function toString():String
		{
			return (street + " " + city + ", " + state + " " + postalCode);
		}
	}
}