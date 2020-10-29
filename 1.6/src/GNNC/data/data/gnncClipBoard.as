package GNNC.data.data
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	
	import GNNC.data.globals.gnncGlobalStatic;

	public class gnncClipBoard
	{
		private var _parent:Object;
		
		static public const BITMAP_FORMAT:String 				= ClipboardFormats.BITMAP_FORMAT;
		static public const FILE_LIST_FORMAT:String 			= ClipboardFormats.FILE_LIST_FORMAT;
		static public const FILE_PROMISE_LIST_FORMAT:String 	= ClipboardFormats.FILE_PROMISE_LIST_FORMAT;
		static public const HTML_FORMAT:String 					= ClipboardFormats.HTML_FORMAT;
		static public const RICH_TEXT_FORMAT:String 			= ClipboardFormats.RICH_TEXT_FORMAT;
		static public const TEXT_FORMAT:String 					= ClipboardFormats.TEXT_FORMAT;
		static public const URL_FORMAT:String 					= ClipboardFormats.URL_FORMAT;
		static public const OBJECT:String 						= "object";
		
		public function gnncClipBoard(parentApplication_:Object=null)
		{
			_parent = (parentApplication_)?parentApplication_:gnncGlobalStatic._parent;
		}

		static public function __clear():void
		{
			Clipboard.generalClipboard.clear();
		}

		/** ############################## COPY ################################### **/

		static public function __copyText(dataToCopy_:Object):void
		{
			__copy(ClipboardFormats.TEXT_FORMAT,dataToCopy_);
		}

		static public function __copyHtml(dataToCopy_:Object):void
		{
			__copy(ClipboardFormats.HTML_FORMAT,dataToCopy_);
		}

		static public function __copyObject(dataToCopy_:Object):void
		{
			__copy(OBJECT,dataToCopy_,true);
		}

		static public function __copy(type_:String,dataToCopy_:Object,serialzable_:Boolean=false):void
		{
			Clipboard.generalClipboard.clear();
			Clipboard.generalClipboard.setData(type_, dataToCopy_, serialzable_);
		}

		/** ############################## GET FORMAT ################################### **/
		
		static public function __formatData(type_:String):Boolean
		{
			return Clipboard.generalClipboard.hasFormat(type_);
		}
		
		/** ############################## PASTE ################################### **/
		
		static public function __paste(conditionType_:String=''):Object
		{
			if(!conditionType_)
				conditionType_ = TEXT_FORMAT;
			 
			if(Clipboard.generalClipboard.hasFormat(conditionType_))
				return Clipboard.generalClipboard.getData(conditionType_);
			
			return '';
		}

	}
}