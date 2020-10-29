package GNNC.data.data
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.binding.utils.ChangeWatcher;

	public class gnncDataBindable
	{
		private static var _gnncGlobal:gnncGlobalStatic = new gnncGlobalStatic(true);
		
		private var _parent:Object;
		public var _change:ChangeWatcher;

		public function gnncDataBindable(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		public function __monitoring(local_:Object,variableObject_:String,function_PropertyChangeEvent_:Function=null):void
		{
			_change = ChangeWatcher.watch(local_,variableObject_,function_PropertyChangeEvent_);
		}

		public static function __loginSession(function_:Function=null):void
		{
			ChangeWatcher.watch(_gnncGlobal,'_session',
				function(e:*):void{ 
					if(function_!=null)
						function_.call();
				}
				,true);
		}

		public function __exitMonitoring():void
		{
			if(_change != null)
				if(_change.isWatching())
					_change.unwatch();
		}

	}
}