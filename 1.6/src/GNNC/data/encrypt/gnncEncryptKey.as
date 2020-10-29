package GNNC.data.encrypt
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.utils.SHA256;


	/**
	 * 
	 * @author Paul Robertson, davidderaedt
	 * 
	 * This class is a simplified version of Paul Roberston's
	 * EncryptionKeyGenerator.
	 * 
	 * It is designed to let users generate encryption keys without
	 * using EncryptedLocalStore based salt values.
	 * 
	 * As a result, it can be used by third party applications to 
	 * access encrypted SQLite DBs created by other applications 
	 * using the same shared password.
	 * 
	 * It is also much less secure, as it's pretty easy to break
	 * using brute force. You may consider adding some limited
	 * login attempts logic.
	 * 
	 */			
	public class gnncEncryptKey
	{
		// ------- Constants -------
		public  static const PASSWORD_ERROR_ID:uint 		= 3138;
		public  static const PASSWORD_WARNING:String 		= "A senha deve ser forte. Deve ser 8-32 caracteres. Ele deve conter pelo menos uma letra maiúscula, pelo menos uma letra minúscula, e pelo menos um número ou símbolo.";
		//public  static const PASSWORD_WARNING:String 		= "The password must be a strong password. It must be 8-32 characters long. It must contain at least one uppercase letter, at least one lowercase letter, and at least one number or symbol.";
		private static const STRONG_PASSWORD_PATTERN:RegExp = /(?=^.{8,32}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/;		
		
		// ------- Constructor -------
		public function gnncEncryptKey()
		{
		}
		
		// ------- Public methods -------
		public static function __validateStrongPassword(password:String,showAlert_:Boolean=false):Boolean
		{
			if (password == null || password.length <= 0)
			{
				if(showAlert_)
					new gnncAlert().__error(PASSWORD_WARNING);
				
				return false;
			}

			var valided:Boolean = STRONG_PASSWORD_PATTERN.test(password);
			
			if(showAlert_ && !valided)
				new gnncAlert().__error(PASSWORD_WARNING);

			return valided;
		}
		
		
		public static function __getEncryptionKey(password:String):ByteArray
		{
			
			if (!gnncEncryptKey.__validateStrongPassword(password))
			{
				//throw new ArgumentError(PASSWORD_WARNING);
				new gnncAlert().__error(PASSWORD_WARNING);
			}
									
			var concatenatedPassword:String = gnncEncryptKey.concatenatePassword(password);
						
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTF(concatenatedPassword);
			
			bytes.position = 0; // have to reset to 0 for an accurate hash
			var hashedKey:String = SHA256.computeDigest(bytes);
			
			var encryptionKey:ByteArray = gnncEncryptKey.generateEncryptionKey(hashedKey);
			
			return encryptionKey;
		}
				
		// ------- Creating encryption key -------
		private static function concatenatePassword(pwd:String):String
		{
			var len:int = pwd.length;
			var targetLength:int = 32;
			
			if (len == targetLength)
			{
				return pwd;
			}
			
			var repetitions:int = Math.floor(targetLength / len);
			var excess:int = targetLength % len;
			
			var result:String = "";
			
			for (var i:uint = 0; i < repetitions; i++)
			{
				result += pwd;
			}
			
			result += pwd.substr(0, excess);
			
			return result;
		}
		
		private static function generateEncryptionKey(hash:String):ByteArray
		{
			var result:ByteArray = new ByteArray();
			
			// select a range of 128 bits (32 hex characters) from the hash
			// In this case, we'll use the bits starting from position 17
			for (var i:uint = 0; i < 32; i += 2)
			{
				var position:uint = i + 17;
				var hex:String = hash.substr(position, 2);
				var byte:int = parseInt(hex, 16);
				result.writeByte(byte);
			}
			
			return result;
		}
	}
}