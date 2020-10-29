package GNNC.time
{
	import flash.events.TimerEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.controls.Alert;

	public class gnncTime 
	{
		private var _total:uint = 0;
		private var _repeat:uint = 0;

		protected var timeIdA:uint = 1;
		protected var timeIdB:uint = 2;

		private var fStorage:Function = null;

		public function gnncTime()
		{
		}

		public function __start(milliSeconds_:uint,functionName_:Function,repeat_zeroIsInfinity_:uint=1):void
		{
			_repeat = repeat_zeroIsInfinity_;
			
			fStorage = functionName_;
			
			timeIdA = setInterval(actFunction,milliSeconds_);
			timeIdB = setInterval(__function,milliSeconds_);
		}

		private function actFunction(e:*=null):void
		{
			if(fStorage!=null)
				fStorage();
		}
		
		private function __function():void
		{
			if(_repeat){
				_total++;
				if(_total>=_repeat)
					__stop();
			}
		}

		public function __stop():void
		{
			fStorage = null;
			//Alert.show('stop');
			clearInterval(timeIdA);
			clearInterval(timeIdB);
			
			timeIdA = 0;
			timeIdB = 0;
			_total = 0;
		}


	}
}