/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//GNNC
//http://www.json-generator.com/
package GNNC.data.data.json
{
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataNumber;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.data.json.gnncJSONDecoder;
	import GNNC.data.data.json.gnncJSONEncoder;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	/**
	 * This class provides encoding and decoding of the JSON format.
	 *
	 * Example usage:
	 * <code>
	 * 		// create a JSON string from an internal object
	 * 		JSON.encode( myObject );
	 *
	 *		// read a JSON string into an internal object
	 *		var myObject:Object = JSON.decode( jsonString );
	 *	</code>
	 */
	public final class gnncJSON
	{
		
		public static function object2ArrayCollection(o:Object):ArrayCollection
		{
			return gnncDataObject.__object2ArrayCollection(o);
		}
		
		public static function toArrayCollection(json:String,allowError:Boolean=true):ArrayCollection
		{
			return gnncDataObject.__object2ArrayCollection(decode(json,!allowError));
		}
		
		public static function toArray(json:String,allowError:Boolean=false ):Array
		{
			return toArrayCollection(json,allowError).toArray();
		}
		
		public static function toJson( o:ArrayCollection ):String
		{
			var x:ArrayCollection = gnncDataArrayCollection.clone(o);
			return encode(x.source as Object);
		}

		public static function toString( o:Object ):String
		{
			var a:Object = [];
			for( var prop:String in o )
				if(o[prop] is Object)
					a[prop] = ObjectUtil.toString( o[prop] );
				else 
					a[prop] = o[prop];
			
			return ObjectUtil.toString(a);
		}

		public static function escape( json:String, forceTwoSlashes:Boolean=false ):String
		{
			var s:String = gnncData.__trimText(json);
			if(s.substr(0,1)!='[' && s.substr(0,1)=='{')
				s = '['+s+']';

			s = s.split('"').join('\"');
			s = s.split("'").join("\'");
			
			return s;
		}

		public static function isValid( s:String, group:Boolean=true ):Boolean{
			
			if(s.length<7)
				return false;
			
			var i2:String = s.substr(0,2);
			var i3:String = s.substr(0,3);
			var i4:String = s.substr(0,4);
			
			if((i3=='[{"' || i3=="[{'" || i4=='[{\"' || i4=="[{\'") && s.length>7 && group==true)
				return true;
			else if((i2=='{"' || i2=="{'" || i3=='{\"' || i3=="{\'") && s.length>7 && group==false)
				return true;
			else
				return false;
		}
		
		/*public static function toJson( o:ArrayCollection ):Array
		{
			var array:Array = [];
			for( var prop:String in obj )
				array.push( obj[prop] );
		}*/

		
		/**
		 * Encodes a object into a JSON string.
		 *
		 * @param o The object to create a JSON string for
		 * @return the JSON string representing o
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function encode( o:Object ):String
		{
			return new gnncJSONEncoder( o ).getString();
		}
		
		/**
		 * Decodes a JSON string into a native object.
		 *
		 * @param strict (true=json perfeito) (false=aceita erros)
		 * 
		 * @param s The JSON string representing the object
		 * @param strict Flag indicating if the decoder should strictly adhere
		 * 		to the JSON standard or not.  The default of <code>true</code>
		 * 		throws errors if the format does not match the JSON syntax exactly.
		 * 		Pass <code>false</code> to allow for non-properly-formatted JSON
		 * 		strings to be decoded with more leniancy.
		 * @return A native object as specified by s
		 * @throw JSONParseError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function decode( s:String, strict:Boolean = true ):*
		{
			return new gnncJSONDecoder( s, strict ).getValue();
		}
	
	}

}