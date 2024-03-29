package be.boulevart.as3.security { 
	/**
	* Encodes and decodes a Goauld string.
	* @authors Sven Dens - http://www.svendens.be
	* @version 0.1
	*/
	
	public class Goauld {
		/**
		* Variables
		* @exclude
		*/
		public static var shiftValue:Number = 6;
	
		/**
		* Encodes and decodes a Goauld string with the character code shift value.
		*/
		public static function calculate(src:String):String {
			var result:String = new String("");
			for (var i:Number = 0; i<src.length; i++) {
				var charCode:Number = src.substr(i, 1).charCodeAt(0);
				result += String.fromCharCode(charCode^shiftValue);
			}
			return result;
		}
	}
}