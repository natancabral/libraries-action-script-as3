package GNNC.data.data
{
	public class gnncDataNumberConvert
	{
		public function gnncDataNumberConvert()
		{
		}
		
		//MILLI, GRAM, KG, TON
		private static const _uint:Array = [0.001,1,1000,1000000];
		
		public static const _milligram:String 		= "MILLIGRAM";
		public static const _gram:String 			= "GRAM";
		public static const _kilogram:String 		= "KILOGRAM";
		public static const _ton:String 			= "TON";

		static private function __unitValue(uintStrin_:String):Number
		{
			switch(uintStrin_)
			{
				case _milligram: 	return _uint[0];	break;
				case _gram:			return _uint[1];	break;
				case _kilogram:		return _uint[2];	break;
				case _ton:			return _uint[3];	break;
				default:			return 0;
			}
			
			return 0;
		}
		
		/** 
		 * CONVERT ALL
		 * 
		 * S * C = E
		 * Where S is our starting value, C is our conversion factor, and E is our end converted result. 
		 * 5 kg * 1000 [ (g) / (kg) ] = 5000 g
		 * 
		 * **/

		static public function __weight(valueWeight_:Number,fromType_:String,toType_:String):Number
		{
			var from:Number 		= 0;
			var to:Number 			= 0;
			
			var convertTo_:Number 	= __unitValue(toType_) * __unitValue(fromType_);
			var result:Number 		= valueWeight_ * convertTo_;
			
			return result;
		}

		/** 
		 * GRAMS to ALL
		 * **/
		
		static public function __gram2Milligram(gram_:Number):Number
		{
			return 0;
		}
		
		static public function __gram2Gram(gram_:Number):Number
		{
			return 0;
		}
		
		static public function __gram2Kilogram(gram_:Number):Number
		{
			return 0;
		}
		
		static public function __gram2Ton(gram_:Number):Number
		{
			return 0;
		}
		
		static public function getUnit(d:Object,returnHightWeight:Boolean=true,setUnitMetric:Boolean=true,returnNumber:Boolean=false,KgPrecision:uint=2,propertyUnit:String='UNIT',propertyType:String='UNIT_TYPE'):Object
		{
			if(d.hasOwnProperty(propertyType)==false)
				return returnNumber == true ? 0 : '' ;
			if(d.hasOwnProperty(propertyUnit)==false)
				return returnNumber == true ? 0 : '' ;
			
			var t:String = String(d[propertyType]).toLowerCase();
			var n:Number = Number(d[propertyUnit]);
			var x:Object = n;
			if(returnHightWeight==true)
			{
				x = n/1000;
				if(t=='gg')
					return returnNumber == true ? x : gnncDataNumber.__safeReal(x,KgPrecision,'')+(!setUnitMetric?'':'Kg');
				else if(t=='ml')
					return returnNumber == true ? x : gnncDataNumber.__safeReal(x,2,'')+(!setUnitMetric?'':'L');
			}
			else if(returnHightWeight==false)
			{
				if(t=='gg')
					return returnNumber == true ? x : gnncDataNumber.__safeReal(x,0,'')+(!setUnitMetric?'':'g');
				else if(t=='ml')
					return returnNumber == true ? x : gnncDataNumber.__safeReal(x,0,'')+(!setUnitMetric?'':'ml');
			}
			return returnNumber == true ? n : String(n)+(!setUnitMetric?'':t);;
		}
		
	}
}