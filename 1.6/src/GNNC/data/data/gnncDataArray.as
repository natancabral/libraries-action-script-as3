package GNNC.data.data
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class gnncDataArray
	{
		public function gnncDataArray()
		{
		}
	
		public static function clone(arr:Array):Array
		{
			var ba:ByteArray = new ByteArray(); 
			ba.writeObject(arr); // Copy the original array (a) into a ByteArray instance
			ba.position = 0; // Put the cursor at the beginning of the ByteArray to read it
			var b:Array = ba.readObject() as Array; // Store a copy of the array in the destination array (b)
			ba.clear(); // Free memory
			return b;
		}
		
		
		public static function merge(array_:Array,removeDuplicate_:Boolean=false):Array
		{
			if(array_===null || !array_)
				return new Array();
			if(array_.length==0)
				return array_;
			if(array_.length===1 && String(array_[0])==='' )
				return array_;
			
			var arr:Array = new Array();
			var lenI:uint = array_.length;

			for (var i:int = 0; i<lenI; i++){
				arr = arr.concat(array_[i] as Array);
			}
			
			if(removeDuplicate_==true)
				arr = __removeDuplicates(arr);
			
			return arr;
		}
		
		/**
		 * Adjusts all values in an Array.
		 * 
		 * @param    array        Array whose values to adjust
		 * @param    value        Value with which to increase, decrease, multiply, or divide a value from array with    
		 * @param    operator    Indicates how to adjust a value from array (addition, minus, multiplication, or division)
		 * 
		 * @see        MathTool#PLUS
		 * @see        MathTool#MINUS
		 * @see        MathTool#MULTIPLICATION
		 * @see        MathTool#DIVISION
		 * 
		 * @return    Array with adjusted values
		 */
		
		public static const PLUS:String = "+";
		public static const MINUS:String = "-";
		public static const MULTIPLICATION:String = "*";
		public static const DIVISION:String = "/";

		public static function __toString(array_:Array,prex_:String='',sufix_:String='',separator_:String=','):String
		{
			if(array_===null || !array_)
				return '';
			if(array_.length==0)
				return '';
			if(array_.length===1 && String(array_[0])==='' )
				return '';
			
			var _str:String = array_.join(separator_);
			_str = sufix_ + _str + prex_;
			_str = prex_+separator_
			return _str;
		}
		
		public static function __removeDuplicatesFilter(sourceArr:Array):Array
		{			
			return sourceArr.filter(
				function(element:*, index:int, _inputArr:Array):Boolean
				{
					return _inputArr.indexOf(element) == index;
				});
		}
		
		public static function __removeDuplicates(array_:Array):Array 
		{	
			if(array_===null || !array_)
				return new Array();
			if(array_.length==0)
				return array_;
			if(array_.length===1 && String(array_[0])==='' )
				return array_;

			var dict:Dictionary = new Dictionary();
			var len:uint = array_.length;
			var str:String = '';
			
			for (var i:int = len-1; i>=0; --i)
			{
				str = String(array_[i]);
				
				if (!dict[str]){
					dict[str] = true;
				} else {
					array_.splice(i,1);
				}
			}
			
			dict = null;
			return array_;
			
			/*
			
			var a:Array = gnncData.__clone(array_) as Array;
			var i:int = 0;			
			while(i < a.length) {
				while(i < a.length+1 && a[i] == a[i+1]) {
					a.splice(i, 1);
				}
				i++;
			}
			return a;*/
		}
		
		public static function __matchValues(array:Array,operator:String="*"):Number 
		{
			var newValue:Number = 0;
			
			for (var i:String in array){
				switch (operator){
					case gnncDataArray.PLUS : 
						newValue = array[i] + newValue;
						break;
					case gnncDataArray.MINUS : 
						newValue = array[i] - newValue;
						break;
					case gnncDataArray.MULTIPLICATION : 
						newValue = array[i] * newValue;
						break;
					case gnncDataArray.DIVISION : 
						newValue = array[i] / newValue;
						break;
				}
			}
			
			return newValue;
		}


		public static function __adjustValues(array:Array,
												  value:*,
												  operator:String="*"):Array {
			var newArray:Array = new Array();
			
			for (var i:String in array){
				switch (operator){
					case gnncDataArray.PLUS : 
						newArray[i] = array[i] + value;
						break;
					case gnncDataArray.MINUS : 
						newArray[i] = array[i] - value;
						break;
					case gnncDataArray.MULTIPLICATION : 
						newArray[i] = array[i] * value;
						break;
					case gnncDataArray.DIVISION : 
						newArray[i] = array[i] / value;
						break;
				}
			}
			
			return newArray;
		}
		
		/**
		 * Similar to ArrayUtil.getItemIndex(), this method searches an Array for an Object with a given property that has a certain value. Can also search for nested Objects.<br /><br />
		 * 
		 * @example    The following code returns 2:<br /><br />
		 * <code>var array:Array = [ {foo: {bar: 'value1'}}, {foo: {bar: 'value2'}}, {foo: {bar: 'value3'}} ];<br />
		 * var propChain:Array = ['foo', 'bar'];<br />
		 * var value:String = 'value3';<br />
		 * ArrayTool.getValueMatchIndex (array, propChain, value); // outputs 2</code>
		 * 
		 * @param    array        Array to search.
		 * @param    property    Property or property-chain to try every item in the Array for. This parameter can either be a String (normal property), Array (property-chain), or numeric value (array index).
		 * @param    value        Value to be found.
		 * 
		 * @return    Index of the item where the value was found on the end of the property chain.
		 */
		
		public static function __getValueMatchIndex (array:Array, property:*, value:*):int {
			
			// if property param is neither an Array nor a String nor a numeric value, try to cast it to a String:
			if (!(property is Array) && !(property is String) && !(property is uint || property is int || property is Number)){
				property = String(property);
			}
			// now make sure that we have a chain of properties (in the form of an Array) to loop through:
			var propertyChain:Array;
			if (property is Array){
				propertyChain = property;
			}else{
				propertyChain = [property];
			}
			
			// loop through source Array:
			var path:*;
			for (var i:int=0; i<array.length; i++){
				path = array[i];
				// loop through property-chain:
				for (var j:int=0; j<propertyChain.length; j++){
					if (path.hasOwnProperty(propertyChain[j])){
						path = path[propertyChain[j]];
						if (j == propertyChain.length-1 && path == value){
							return i;
						}
					}else{
						break;
					}
				}
			}
			
			// if value was not found:
			return -1;
		}
		
		public static function __getItemIndex(source:Array, item:Object, caseSensitive_:Boolean=false):int
		{
			if(!source)
				return -1;
			
			var n:int = source.length;
			var i:int = 0;
			
			if(caseSensitive_){
				for (i = 0; i < n; i++)
					if (String(source[i]) === String(item))
						return i;
			}else{
				for (i = 0; i < n; i++)
					if (String(source[i]).toLowerCase() == String(item).toLowerCase())
						return i;
			}

			return -1;           
		}
		
		public static function __removeItemIndex(source:Array,item:Object):Array
		{
			return removeItemObject(source,item);
		}

		public static function removeItemIndex(source:Array,index:uint):Array
		{
			if(!source)
				return new Array();

			var newSource:Array = new Array();
			var n:int = source.length;
			
			for (var i:int = 0; i < n; i++){
				if (i === index)
					continue; //no action
				else
					newSource.push(source[i]);
			}
			return newSource;
		}

		public static function removeItemObject(source:Array,item:Object):Array
		{
			if(!source)
				return new Array();

			var newSource:Array = new Array();
			var n:int = source.length;
			
			for (var i:int = 0; i < n; i++){
				if (source[i] === item)
					continue; //no action
				else
					newSource.push(source[i]);
			}
			return newSource;
		}

		public static function __filterBy(array_:Array):Array
		{
			var arr:Array = array_;
			//arr = [1,3,2,22,1,4,5,6,4,3,5,6,2,3,4,1,4,6,4,10,3,10,"a","a"];
			
			arr.filter(__filter);
			
			function __filter(e:*, i:int, a:Array):Boolean
			{
				return a.indexOf(e) == i;
			}
			
			//trace( arr );
			
			return arr;
		}
		
		private function __filterFunction(element:*, index:int, arr:Array):Boolean 
		{
			var _property:String 	= '';
			var _value:Object		= 1;
			
			return  ( element[_property].indexOf(_value) > -1 ) ;
		}

		/**
		 * arr       = new Array()
		 * propertys = ['id','name','date']
		 * **/
		public static function __sortNumeric(arr:Array, propertys:*=null):Array
		{
			if(arr===null || !arr)
				return new Array();
			if(arr.length==0)
				return arr;
			if(arr.length===1 && String(arr[0])==='' )
				return arr;
			
			if(propertys!=null)
				return arr.sortOn( propertys, [Array.NUMERIC]);
			else
				return arr.sort( Array.NUMERIC );
		}

		public static function __sortAlpha(arr:Array, propertys:*=null):Array
		{
			if(arr===null || !arr)
				return new Array();
			if(arr.length==0)
				return arr;
			if(arr.length===1 && String(arr[0])==='' )
				return arr;
			
			if(propertys!=null)
				return arr.sortOn( propertys, [Array.DESCENDING]);
			else
				return arr.sort( Array.DESCENDING );
		}
		
		
	}

}