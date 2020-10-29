package GNNC.system
{
	public class gnncMemonyEventListener
	{
		private var myArrayListeners:Array = new Array();

		public function gnncMemonyEventListener()
		{
		}
		
		public function addEventListener (type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void 
		{ 
			super.addEventListener (type, listener, useCapture, priority, useWeakReference);
			myArrayListeners.push({type:type, listener:listener, useCapture:useCapture});
		}
		
		public function clearEvents(OBJ_:Object):void {
			for (var i:Number=0; i < myArrayListeners.length; i++) {
				if (OBJ_.hasEventListener(myArrayListeners[i].type)) {
					OBJ_.removeEventListener(myArrayListeners[i].type,myArrayListeners[i].listener);
				}
			}
			myArrayListeners = null;
		}
	}
}