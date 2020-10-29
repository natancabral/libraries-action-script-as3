package GNNC.data.data
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.date.DateUtils;
	import GNNC.data.encrypt.gnncMD5;
	
	import flash.geom.ColorTransform;

	public class gnncDataRand
	{
		private var _parent:Object;
		
		public function gnncDataRand(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		
		static public function __key(length_:uint=40):String
		{
			var _string:String = gnncDataRand.__enrollment(25) + gnncMD5.hash(__passWord(5,false)+__number(1111,9999)+new Date().time+'');
			_string = _string.split('.').join('');
			return _string.substr(0,length_);
		}
		
		static public function __number(startValue_:int=0,endValue_:int=50):Number
		{
			var n:String = '';
			var maxLen:uint = String(endValue_).length;
			var _scale:Number = endValue_ - startValue_;
			//return Math.round(Math.random() * _scale + startValue_);
			n = '' + Number(String(Math.ceil( Math.random()*(endValue_+1) ) / (startValue_+1)).substr(0,maxLen));//<--- GOOOOOOODDDD 
			n = n.split('.').join('');
			return Number(n);
		}
		
		static public function __passWord(LENGHT_:uint=6,CHARAC_SPECIAL:Boolean=false):String
		{
			//characters to use in password
			var _spec : String = "!@#$%¨&*()+_~^ç}{[]|";
			var _salt : String = "abchefghjkmnpqrstuvwxyz0123456789ABCHEFGHJKMNPQRSTUVWXYZ";
			
			if(CHARAC_SPECIAL)
				_salt += _spec;
			
			//initialize vars
			var _password : String = '';
			var _i:Number = 0;
			
			//loop 
			while ( _i < LENGHT_ )
			{
				var _num : Number = Math.random() * _salt.length;
				_password += _salt.charAt( _num );
				_i++;
			}
			
			return _password;
		}
		
		static public function __hexRand():uint
		{
			var RED:Number 			= 0xFF;
			var GREEN:Number 		= 0xFF;
			var BLUE:Number 		= 0xFF;
			
			var ct:ColorTransform 	= new ColorTransform(1,1,1,1,Math.random()*RED, Math.random()*GREEN, Math.random()*BLUE);
			var color:uint 			= ct.color;
			return color;
		}
		
		static public function __enrollment(length_:uint=15):String
		{
			if(length_<15)
				return 'min.15.char';

			var DATA:String = ''+new Date().fullYear+''+gnncDataNumber.__setZero(new Date().month)+''+gnncDataNumber.__setZero(new Date().date)+''+__number(111,999)+''+new Date().time+new Date().millisecondsUTC+''+__number(111111,999999);
			DATA = DATA.split('.').join('');
			return DATA.substr(0,length_);
		}

	}
}