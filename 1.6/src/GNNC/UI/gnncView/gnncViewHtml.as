package GNNC.UI.gnncView
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.data.gnncData;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import flash.events.Event;
	import flash.events.HTMLUncaughtScriptExceptionEvent;
	import flash.html.HTMLLoader;
	import flash.html.HTMLPDFCapability;
	import flash.net.URLRequest;
	
	import mx.controls.HTML;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	
	public class gnncViewHtml extends Group
	{
		private var _parent:Object;
		private var _gnncPopUp:gnncPopUp 			= new gnncPopUp();
		
		private var _urlLocation:String				= '';
		public  var _html:HTML 						= null;
		public  var _functionLoadComplete:Function 	= null;
		public  var _showLoading:Boolean 			= false;
		
		public function set _htmlText(textHtml_:String):void 	{ _html.htmlText = textHtml_ }
		public function get _htmlText():String 					{ return _html.htmlText }
		
		public function set _htmlUrl(url_:String):void 			{ __loadUrl(url_) }
		
		public function gnncViewHtml(parentApplication_:Object=null,try_:Boolean=false)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent;
			
			__create();
		}

		public function __loadHtml(textHtml_:String):void
		{
			if(_html!=null)
				_html.htmlText = textHtml_;
		}

		public function __loadUrl(urlLocation_:String):void
		{
			if(_html!=null)
				_html.htmlLoader.load(new URLRequest(urlLocation_));
		}

		public function __create(urlLocation_:String='',functionLoadComplete_Event_:Function=null,showLoading_:Boolean=false):void
		{
			_functionLoadComplete		= functionLoadComplete_Event_;
			_showLoading				= showLoading_;
			
			_html						= new HTML();
			_html.percentWidth			= 100;
			_html.percentHeight			= 100;
			_html.errorString			= '';
			_html.addEventListener		(Event.ENTER_FRAME,__activeFrame);
			_html.addEventListener		(Event.HTML_RENDER,__renderHtml);
			_html.addEventListener		(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION,__error);
			_html.addEventListener		(Event.COMPLETE,__loadComplete);
			_html.addEventListener		(FlexEvent.CREATION_COMPLETE,__go);
			
			if(_functionLoadComplete != null)
				_html.addEventListener	(Event.COMPLETE,_functionLoadComplete);

			function __go(e:*):void
			{
				if(urlLocation_.length<10)x
					return;

				if(_showLoading)
				{
					_html.visible = false;
					_gnncPopUp.__loading('Carregando html...');
					_gnncPopUp.__toFront();
				}

				if(urlLocation_.length>10)
					_html.htmlLoader.load(new URLRequest(urlLocation_));
			}
			
			percentWidth 				= 100;
			percentHeight 				= 100;
			addElement					(_html);
		}
		private function __loadComplete (e:*):void 
		{
			if(_showLoading)
			{
				_html.visible = true;
				_gnncPopUp.__close();
			}
		}
	
		private function __error (e:*):void 
		{
			e.preventDefault();
			return;
			
			trace("exceptionValue:", e.exceptionValue)
			for (var i:int = 0; i < e.stackTrace.length; i++)
			{
				trace("sourceURL:", e.stackTrace[i].sourceURL);
				trace("line:", e.stackTrace[i].line);
				trace("function:", e.stackTrace[i].functionName);
			}
		}
		
		private function __activeFrame(e:*):void
		{
			_html.validateDisplayList();
			_html.validateNow();
		}
		
		private function __renderHtml(e:*):void
		{
		}

		public function __codeSource ():String
		{
			return "Don\'t work!";
		}

		public function __setFocusById (elementId_:String):void
		{
			try //Because if the element not found returned fatal Error
			{
				_html.domWindow.document.getElementById(elementId_).focus();
			}
			catch(e:*){}
		}

		public function __setFocusByName (elementName_:String,index_:uint=0):void
		{
			try //Because if the element not found returned fatal Error
			{
				_html.domWindow.document.getElementById(elementName_)[index_].focus();
			}
			catch(e:*){}
		}

		public function __getElementById (elementId_:String,property_:String):String
		{
			try //Because if the element not found returned fatal Error
			{
				if(property_)
					return _html.domWindow.document.getElementById(elementId_)[property_];
				else
					return _html.domWindow.document.getElementById(elementId_).innerHTML;
			}
			catch(e:*){}
			
			return '';
		}

		public function __setElementById (elementId_:String,property_:String,value_:String):void
		{
			try //Because if the element not found returned fatal Error
			{
				if(property_)
					_html.domWindow.document.getElementById(elementId_)[property_] = value_;
				else
					_html.domWindow.document.getElementById(elementId_).innerHTML = value_;
			}
			catch(e:*){}
		}

		public function __getElementByName (elementName_:String,property_:String,index_:uint=0):String
		{
			try //Because if the element not found returned fatal Error
			{
				if(property_)
					return _html.domWindow.document.getElementsByName(elementName_)[index_][property_];
				else
					return _html.domWindow.document.getElementsByName(elementName_)[index_].innerHTML;
			}
			catch(e:*){}

			return '';
		}
		
		public function __setElementByName (elementName_:String,property_:String,value_:String,index_:uint=0):void
		{
			try //Because if the element not found returned fatal Error
			{
				if(property_)
					_html.domWindow.document.getElementsByName(elementName_)[index_][property_] = value_;
				else
					_html.domWindow.document.getElementsByName(elementName_)[index_].innerHTML = value_;
			}
			catch(e:*){}
		}
		
		public function __callFunction (functionName_:String):String
		{
			try //Because if the element not found returned fatal Error
			{
				functionName_ = gnncData.__replace(functionName_,'()','');
				return _html.domWindow[functionName_+'()'];
			}
			catch(e:*){}
			
			return '';
		}

		
		public function __callFunctionArguments (functionName_:String, ... rest):String
		{
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}

			try //Because if the element not found returned fatal Error
			{
				functionName_ = gnncData.__replace(functionName_,'()','');
				return _html.domWindow[functionName_+'('+args.toString()+')'];
			}
			catch(e:*){}
			
			return '';
		}
		
		
		
		


	}
}