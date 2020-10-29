package GNNC.data.globals
{
	
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncBook.book.limited;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataHtml;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.date.gnncDate;
	import GNNC.keyboard.gnncKeyboard;
	import GNNC.system.gnncParent;
	import GNNC.time.gnncTime;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextInput;
	import mx.graphics.SolidColor;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.TextArea;
	import spark.components.VGroup;
	import spark.primitives.Rect;

	public class gnncGlobalLog
	{
		static public var _log:ArrayCollection 	= new ArrayCollection();
		static public var _try:Boolean 			= false;

		static public const _normal:String 		= 'normal';
		static public const _error:String 		= 'error';
		static public const _success:String 	= 'success';
		static public const _labelBreak:String 	= '';//'---- break ----';
		
		static private var _label:Label 	    = new Label();
		static private var _group:Group 	    = new Group();
		static private var _bg:Rect             = new Rect();
		static private var _vGroup:VGroup 	    = new VGroup();
		static private var _textArea:TextArea 	= new TextArea();
		static private var _textInput:TextInput = new TextInput();
		static private var _textPass:TextInput  = new TextInput();
		static private var _time:gnncTime 		= new gnncTime();
		static private var _btn:Button 		    = new Button();
		
		public function gnncGlobalLog()
		{
		}

		static private function __addElement(type_:String,message_:String,date_:Date,title_:Object=null):void
		{
			if(!String(message_))
				return;
			
			var v:Array = new Array();
			v.type 		= type_;
			v.label 	= message_;
			v.date 		= date_;
			v.title     = title_?title_:'';

			if(!_log)
				_log = new ArrayCollection();
			
			_log.addItem(v);
			
			_time.__stop();
			_time.__start(5000,__addBreak,1);
		}

		static public function __passw():Boolean
		{
			return _textPass.text == 'designer' ? true : false;
		}
		
		static public function __addBreak():void
		{
			if(!_log)
				return;

			if(!_log.length)
				return;

			if(_log.getItemAt(_log.length-1).label != _labelBreak)
				__addElement('',_labelBreak,new Date());
		}
		
		static public function __add(v:Object,title_:Object=null):void
		{
			__addElement(gnncGlobalLog._normal,String(v),new Date(),title_);
			__show();
		}

		static public function __addError(v:Object):void
		{
			__addElement(gnncGlobalLog._error,String(v),new Date());
			__show();
		}

		static public function __addSuccess(v:Object):void
		{
			__addElement(gnncGlobalLog._success,String(v),new Date());
			__show();
		}

		static public function __toString():String
		{
			//var cop:ArrayCollection 	= gnncData.__clone(_log);
			var len:uint 				= _log.length;
			var i:uint 					= 0;
			var str:String 				= '';
			var o:Object				= new Object();

			_log.source.reverse();

			for(i = 0; i < len; i++)
			{
				o 	= _log.getItemAt(i);
				str += '# ' + ' ------------------------ ';
				str += gnncDate.__date2Legend('',o.date,true,true,'-',true,true);
				str += ' [' + String(o.type).toUpperCase() + (o.title?' - ' + o.title:'') + "]\n";
				str += o.label;
				str += "\n\n";
			}

			_log.source.reverse();

			return str;
		}

		static public function __show():void
		{
			if(!_try)
				return;
			
			_group.width        = 400;
			_group.right 	    = 10;
			_group.top 		    = 10;
			_group.visible	    = true;
			_group.alpha		= 0.9;
			
			_bg.percentWidth    = 100;
			_bg.percentHeight   = 100;
			_bg.visible	        = true;
			_bg.radiusX         = 3;
			_bg.radiusY         = 3;
			_bg.fill            = new SolidColor(0x444444);

			_vGroup.percentWidth = 100;
			_vGroup.percentHeight = 100;
			_vGroup.visible	    = true;
			_vGroup.alpha		= 1;
			_vGroup.gap		    = 1;
			_vGroup.padding		= 10;

			_label.text     = 'INPUT - LOG DO SISTEMA';
			_label.percentWidth = 100;
			_label.height 	= 16;
			_label.setStyle	('color',0xffffff);
			_label.setStyle	('font-size',10);
			_label.setStyle	('fontSize',10);
			_label.setStyle	('font-weight','bold');
			_label.setStyle	('fontWeight','bold');
			
			_textPass.percentWidth = 100;
			_textPass.height    = 10;
			_textPass.setStyle	('font-size',1);
			_textPass.setStyle	('fontSize',1);
			_textPass.setStyle	('color',0xffffff);
			_textPass.visible   = true;
			_textPass.displayAsPassword = true;

			_textArea.percentWidth = 100;
			_textArea.height 	= 400;
			_textArea.setStyle	('color',0xffffff);
			_textArea.setStyle	('font-size',9);
			_textArea.setStyle	('fontSize',9);
			_textArea.setStyle	('borderVisible',false); 
			_textArea.setStyle	('contentBackgroundAlpha',0);
			//_textArea.textFlow 	= gnncDataHtml.__html2TextFlow(__toString());
			_textArea.text = __toString();
			_textArea.visible   = __passw();
			
			_textInput.percentWidth = 100;
			_textInput.height   = 30;
			_textInput.setStyle	('color',0xffffff);
			_textInput.setStyle	('font-size',9);
			_textInput.setStyle	('fontSize',9);
			_textInput.setStyle	('borderVisible',false); 
			_textInput.setStyle	('contentBackgroundAlpha',0);
			_textInput.visible  = __passw();

			_btn.label = '';
			_btn.height = 5;
			_btn.percentWidth = 100;
				
			_vGroup.addElement(_label);
			_vGroup.addElement(_textPass);
			_vGroup.addElement(_textArea);
			_vGroup.addElement(_textInput);
			_vGroup.addElement(_btn);
			
			_group.addElement(_bg);
			_group.addElement(_vGroup);
			
			_textArea.doubleClickEnabled = true;
			_group.doubleClickEnabled = true;
			
			if(!_textArea.hasEventListener(MouseEvent.DOUBLE_CLICK))
				_textArea.addEventListener(MouseEvent.DOUBLE_CLICK,__close);

			if(!_group.hasEventListener(MouseEvent.DOUBLE_CLICK))
				_group.addEventListener(MouseEvent.DOUBLE_CLICK,__close);

			if(!_btn.hasEventListener(MouseEvent.CLICK))
				_btn.addEventListener(MouseEvent.CLICK,__injectSql);

			function __close(e:MouseEvent):void
			{
				_group.visible = false;
			}

			function __injectSql(e:MouseEvent):void
			{
				/*if(!_textInput.text)
					return;

				if(!gnncKeyboard.__CONTROL_ENTER(e))
					return;*/
				
				__add('INJECT');
				
				var _sql:String = _textInput.text;
				var gnncConn:gnncAMFPhp = new gnncAMFPhp(gnncGlobalStatic._parent);
				gnncConn.__sql(_sql,'','',__fResult,__fFault);
				
				function __fResult(e:*):void
				{
					__add('INJECT2');
					new gnncAlert(gnncGlobalStatic._parent).__dataGrid(gnncConn.DATA_ARR);
				}
				function __fFault(e:*):void
				{
					__add('INJECT3');
				}
			}

			Object(gnncGlobalStatic._parent).addElement(_group);
		}

		static public function __hide():void
		{
			_group.visible = false;
		}
		
		static public function __clear():void
		{
			_log = new ArrayCollection();
			_textArea.text = __toString();
		}
		
	}
}