package GNNC.data.conn
{
	import be.boulevart.as3.security.Base64;
	import be.boulevart.as3.security.ROT13;
	
	import com.hurlant.util.Base64;
	
	public class gnncCrypt
	{
		public function gnncCrypt()
		{
		}
		
		//base64 = 0 is OK UTF8 and ISO
		static public function encrypt(str:String, key:String = '%key&', base64:uint = 0):String 
		{
			var result:String = '';
			var len:uint = str.length;
			var i:int = 0;

			for (i = 0; i < len; i++) 
			{
				var char:String = str.substr(i, 1);
				var keychar:String = key.substr((i % key.length) - 1, 1);
				var ordChar:int = char.charCodeAt(0);
				var ordKeychar:int = keychar.charCodeAt(0);
				var sum:int = ordChar + ordKeychar;
				char = String.fromCharCode(sum);
				result = result + char;
			}

			str = encode64(result,base64);
			
			return str;
		}
		
		//base64 = 0 is OK UTF8 and ISO
		static public function decrypt(str:String, key:String = '%key&', base64:uint = 0):String 
		{
			str = decode64(str,base64);

			var result:String = '';
			var i:int = 0;
			var len:uint = str.length;

			for (i = 0; i < len; i++) 
			{
				var char:String = str.substr(i, 1);
				var keychar:String = key.substr((i % key.length) - 1, 1);
				var ordChar:int = char.charCodeAt(0);
				var ordKeychar:int = keychar.charCodeAt(0);
				var sum:int = ordChar - ordKeychar;
				char = String.fromCharCode(sum);
				result = result + char;
			}

			return result;
		}

		static public function encode64(str:String, base64:uint = 0):String 
		{
			/*
			be.boulevart.as3.security.Base64 - works! !!!!!!!!!!!!!!!!!!!!!!!!!!!						
			mx.utils.Base64Encoder           - wrong result!
			com.dynamicflash.util.Base64     - wrong result!
			com.hurlant.util.Base64          - wrong result!
			*/

			var r:String = '';

			if(base64==0){
				r = com.hurlant.util.Base64.encode(str);
			}else if(base64==1){
				r = be.boulevart.as3.security.Base64.encode(str);
			}else if(base64==2){
				r = be.boulevart.as3.security.Base64.encode2(str);
			}else{
				r = str;
			}
			
			return r;
		}

		static public function decode64(str:String, base64:uint = 0):String 
		{
			var r:String = '';

			if(base64==0){
				r = com.hurlant.util.Base64.decode(str);
			}else if(base64==1){
				r = be.boulevart.as3.security.Base64.decode(str);
			}else if(base64==2){
				r = be.boulevart.as3.security.Base64.decode2(str);
			}else{
				r = str;
			}
			
			return r;
		}
		
		/** 
		 * php gnncCrypt.php
		 * gnncCrypt::encrypt();
		 * **/
		public static function phpEncrypt(input:String):String
		{
			return ROT13.calculate(encode64(input,0));
		}

		/** 
		 * php gnncCrypt.php
		 * gnncCrypt::decrypt();
		 * **/
		public static function phpDecrypt(input:String):String
		{
			return decode64(ROT13.calculate(input),0);
		}

		/*public static function rot13(input:String) 
		{
			var sb:Array = new Array();
			for (var i:uint = 0; i < input.length; i++) {
				var c:String = input.charAt(i);
				if       (c >= 'a' && c <= 'm') c = input.charAt(i+13);
				else if  (c >= 'A' && c <= 'M') c = input.charAt(i+13);
				else if  (c >= 'n' && c <= 'z') c = input.charAt(i-13);
				else if  (c >= 'N' && c <= 'Z') c = input.charAt(i-13);
				sb.push(c);
			}
			return sb.join('');
		}
		
		public static function rot13v2(s:String):String 
		{
			return s.replace(/[A-Za-z]/g, function (c:String) {
				return "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".charAt(
					"NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm".indexOf(c)
				);
			} );
		};
		
		//This function take rot13 encoded string and decoded it as simple string.
		public static function rot13v4(str:String):String 
		{ 
			var arr:Array = str.split('');
			var newArray:Array = [];			
			var first:Object = {'A' : 'N','B' : 'O','C' : 'P','D' : 'Q','E' : 'R','F' : 'S','G' : 'T','H' : 'U','I' : 'V','J' : 'W','K' : 'X','L' : 'Y','M' : 'Z'};
			var rest:Object  = {'N' : 'A','O' : 'B','P' : 'C','Q' : 'D','R' : 'E','S' : 'F','T' : 'G','U' : 'H','V' : 'I','W' : 'J','X' : 'K','Y' : 'L','Z' : 'M'};

			// Iteration though the string array(arr)
			for(var i:uint = 0; i <= arr.length; i++)
			{
				if (first.hasOwnProperty(arr[i])){      //checking first obj has the element or not
					newArray.push(first[arr[i]]);       //Pushing the element to the nerarray
				} else if(rest.hasOwnProperty(arr[i])){ //checking rest obj has the element or not
					newArray.push(rest[arr[i]]);
				} else {
					newArray.push(arr[i]);
				}
			}
			return newArray.join('');
		};*/
		
	}
}