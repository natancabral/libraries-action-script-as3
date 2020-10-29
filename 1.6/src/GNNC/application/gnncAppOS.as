package GNNC.application
{
	import flash.desktop.NativeProcessStartupInfo;
	import flash.system.Capabilities;

	public class gnncAppOS
	{
		static private var pi:NativeProcessStartupInfo = new NativeProcessStartupInfo();
		static public const WIN:String = 'win';
		static public const MAC:String = 'mac';
		static public const LINUX:String = 'linux';
		
		public function gnncAppOS()
		{
		}
		
		static public function __getOS():String
		{
			var os:String = Capabilities.os.toLowerCase();
			
			if(os.indexOf(WIN) >= 0)
				return 'win' ; //File.applicationDirectory.resolvePath("imagick/win32/convert.exe");
			else if(os.indexOf(MAC) >= 0)
				return 'mac' ; //File.applicationDirectory.resolvePath("imagick/macosx/bin/convert");
			else if(os.indexOf(LINUX) >= 0)
				return 'linux' ;
			else 
				return "unsupported OS";
		}

		static public function __get(nameOS_:String):Boolean
		{
			var os:String = Capabilities.os.toLowerCase();
			
			if(os.indexOf(nameOS_.toLowerCase()) >= 0)
				return true;
			
			return false;
		}

		static public function __getOSNameComplete():String
		{
			return Capabilities.os;
		}
	}
}