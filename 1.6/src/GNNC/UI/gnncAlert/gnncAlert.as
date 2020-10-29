package GNNC.UI.gnncAlert
{
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.data.gnncClipBoard;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArray;
	import GNNC.data.encrypt.gnncMD5;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.event.gnncCloseEvent;
	import GNNC.time.gnncFunctions;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.collections.IList;
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	
	import spark.components.Alert;
	import spark.components.Button;
	import spark.components.DataGrid;
	import spark.components.HGroup;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.Panel;
	import spark.components.PopUpAnchor;
	import spark.components.RichText;
	import spark.components.TextArea;
	
	//use namespace NS_ALERT;
	
	public class gnncAlert
	{
		private var _parent:Object 					= null;
		private var _createNoError:Boolean 			= false;
		private var _popA:PopUpAnchor				= new PopUpAnchor();
		private var _formObject:Object;
		private var _textToCopy:String;
		
		public static const _alert:String 			= "ALERT";
		public static const _error:String 			= "ERROR";
		public static const _description:String 	= "DESCRIPTION";
		public static const _textArea:String 		= "TEXTAREA";
		public static const _dataGrid:String 		= "DATAGRID";
		public static const _dark:String 			= "DARK";

		public static var OK_LABEL:String           = 'OK';
		public static var YES_LABEL:String          = 'Sim';
		public static var NO_LABEL:String           = 'Não';
		public static var CANCEL_LABEL:String       = 'Cancelar';

		public static const OK:uint                 = Alert.OK;
		public static const YES:uint                = Alert.YES;
		public static const NO:uint                 = Alert.NO;
		public static const CANCEL:uint             = Alert.CANCEL;
		
		public  var _return:int                     = -1;
		public  var _maxChar:uint 					= 0;
		public  var _width:uint                     = 400;
		public  var _height:uint                    = 170;
		private var _keyAlert:String 				= '';
		private var _keyAlertRegister:Boolean 		= true;

		private var _labelOLD:Label 				= new Label();
		private var _label:RichText                 = new RichText();
		private var _textAreaInput:TextArea 		= new TextArea();
		private var _datagrid:DataGrid 				= new DataGrid();
		private var _button:Button					= new Button();
		private var _buttonGroup:HGroup				= new HGroup();
		private var _panel:Panel					= new Panel();
		private var _image:Image					= new Image();

		public function get DATA_STG():String
		{
			return _textAreaInput.text;
		}

		public function set DATA_STG(value_:String):void
		{
			_textAreaInput.text = value_;
		}

		public function gnncAlert(parentApplication_:Object=null,keyAlertRegister_:Boolean=true)
		{
			_keyAlertRegister = keyAlertRegister_;
			_parent = (parentApplication_)?parentApplication_:gnncGlobalStatic._parent;
		}
		
		/** ####################################################################### **/
		/** ############################## FUNCTIONS ############################## **/
		/** ####################################################################### **/
		
		public static function reset():void
		{
			Alert.buttonWidth	   = 90;
			gnncAlert.OK_LABEL     = Alert.OK_LABEL     = 'OK';
			gnncAlert.YES_LABEL    = Alert.YES_LABEL    = 'Sim';
			gnncAlert.NO_LABEL     = Alert.NO_LABEL 	= 'Não';
			gnncAlert.CANCEL_LABEL = Alert.CANCEL_LABEL = 'Cancelar';
		}

		static public function __alert(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(gnncGlobalStatic._popUpAlertIsOpen==true)
				return;
			if(!menssage_)// || gnncGlobalStatic._popUpOpenAlert.length>0 ) //gnncAlert.gnncAlert.getGlobalList()
				return;
			var alert:gnncAlert = new gnncAlert();
			alert.__show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._alert,flag);
		}

		static public function __delete(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(gnncGlobalStatic._popUpAlertIsOpen==true)
				return;
			if(!menssage_)// || gnncGlobalStatic._popUpOpenAlert.length>0 ) //gnncAlert.gnncAlert.getGlobalList()
				return;
			var alert:gnncAlert = new gnncAlert();
			alert.__show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._dark,flag);
		}
		
		public function __alert(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(menssage_) __show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._alert,flag);
		}
		
		public function __error(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(menssage_) __show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._error,flag);
		}
		
		public function __textArea(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(menssage_) __show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._textArea,flag);
		}
		
		public function __dataGrid(menssage_:Object='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(menssage_) __show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._dataGrid,flag);
		}
		
		public function __description(menssage_:String='',title_:String='',functionRemovePopUp_CloseEvent:Function=null,flag:Array=null):void
		{
			if(menssage_) __show(menssage_,title_,functionRemovePopUp_CloseEvent,gnncAlert._description,flag);
		}

		protected function __creation(text_:Object,title_:String,alertType_:String,flag:Array=null,keyUID:String=''):Panel
		{
			//var deveriam estar aqui
			
			if(!_createNoError)
			{
				var tf:String = text_.toString();
				tf = gnncData.__replace(tf,"\\n","<br>");
				tf = gnncData.__replace(tf,"\n","<br>");
				tf = gnncData.__trimText(tf);
				
				//https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html
				//_label.text			= gnncData.__trimText(text_.toString());
				_label.textFlow			= TextConverter.importToFlow(tf, TextConverter.TEXT_FIELD_HTML_FORMAT);
				_label.setStyle			('fontSize',14);
				_label.setStyle			('font-size',14);
				_label.setStyle			('color',0x333333);
				_label.setStyle			('verticalAlign','top');
				_label.left				= 20;
				_label.top				= 20;
				_label.right			= 20;
				_label.bottom			= 60;

				_textAreaInput.text		= gnncData.__trimText(text_.toString());
				_textAreaInput.setStyle	('fontSize',14);
				_textAreaInput.setStyle	('font-size',14);
				_textAreaInput.setStyle	('color',0x333333);
				_textAreaInput.setStyle	('verticalAlign','top');
				_textAreaInput.setStyle	('borderColor',0xBBBBBB);
				_textAreaInput.setStyle	('border-color',0xBBBBBB);
				//_textAreaInput.setStyle	("backgroundColor",0xEEEEEE);
				//_textAreaInput.setStyle	("background-color",0xEEEEEE);
				_textAreaInput.left		= 20;
				_textAreaInput.top		= 20;
				_textAreaInput.right	= 20;
				_textAreaInput.bottom	= 60;
				_textAreaInput.maxChars = _maxChar;

				_datagrid.dataProvider	= text_ as  IList;
				_datagrid.setStyle		('borderVisible',false);
				_datagrid.setStyle		('border-visible',false);
				_datagrid.setStyle		("backgroundColor",0xEEEEEE);
				_datagrid.setStyle		("background-color",0xEEEEEE);
				_datagrid.setStyle		('color',0x333333);
				_datagrid.setStyle		('fontSize',10);
				_datagrid.setStyle		('font-size',10);
				_datagrid.rowHeight		= 20;
				_datagrid.left			= 20;
				_datagrid.top			= 20;
				_datagrid.right			= 20;
				_datagrid.bottom		= 60;
				
				_buttonGroup.gap        = 1;
				_buttonGroup.right		= 10;
				_buttonGroup.bottom		= 10;

				//flag
				if(flag==null)
					flag = [gnncAlert.OK];
				flag = flag.sort(Array.NUMERIC);
				for(var i:uint=0;i<flag.length;i++)
				{
					_button = new Button();
					_button.setStyle		('fontSize',11);
					_button.setStyle		('font-size',11);
					_button.setStyle		('verticalAlign','top');
					_button.setStyle		('fontWeight','bold');
					_button.setStyle		('font-weight','bold');
					_button.setStyle		('color',0x333333);
					_button.label			= __flag(flag[i]);
					_button.setStyle        ('uid',flag[i]);
					_button.drawFocus		(false);
					_button.setFocus		();
					_button.addEventListener(MouseEvent.MOUSE_DOWN,__click);
					_button.addEventListener(MouseEvent.CLICK,__destroy);
					_button.height          = 30;
					//group
					_buttonGroup.addElement	(_button);
				}

				if(keyUID)
					_panel.uid = keyUID;
				
				_panel.width			= (_parent.width<500)? 200 : _width; //400
				_panel.minHeight		= _height; //190
				//_panel.height			= 300;
				_panel.title			= '';
				_panel.setStyle			('fontSize',11);
				_panel.setStyle			('font-size',11);
				_panel.setStyle			('color',0xFFFFFF);
				_panel.filters			= [];
				_panel.setStyle			("titleDisplay",0xCC0000);
				_panel.setStyle			("dropShadowVisible",false);
				_panel.setStyle			("backgroundColor",0xEEEEEE);
				_panel.addEventListener	("rightMouseDown",__rightMouseDown);
				
				_image.source			= null;//GNNC.gnncEmbedImage.OK_32_RED;//GNNC.gnncEmbedImage.ALERT_32;
				_image.right			= 20;
				_image.top				= 20;
				
				/** ############################################################ **/
				
				switch(alertType_)
				{
					case 'ERROR':
						_panel.title		= 'Atenção';
						_panel.setStyle		("chromeColor",0xb40d0d);
						_panel.setStyle		("backgroundColor",0xb40d0d);
						_label.setStyle		("color",0xFFFFFF);
						break;
					case 'DARK':
						_panel.title		= 'Importante';
						_panel.setStyle		("chromeColor",0x53545e);
						_panel.setStyle		("backgroundColor",0x53545e);
						_label.setStyle		("color",0xFFFFFF);
						_panel.setStyle		("titleDisplay",0x53545e);
						break;
					case 'ALERT':
						_panel.title		= 'Aviso';
						_panel.setStyle		("chromeColor",0xEEEEEE);
						_panel.setStyle		("backgroundColor",0xFFFFFF);
						_panel.setStyle		("color",0x888888);
						_panel.setStyle		("titleDisplay",0x666666);
						break;
					case 'QUESTION':
						_panel.title		= 'Sim ou não?';
						_panel.setStyle		("chromeColor",0x0084ff);
						break;
					case 'TEXTAREA':
						_panel.title		= 'Copie e Cole';
						_panel.setStyle		("chromeColor",0x0084ff);
						break;
					case 'DATAGRID':
						_panel.title		= 'Grade de Dados';
						//_panel.setStyle		("chromeColor",0x0084ff);
						break;
					case 'DESCRIPTION':
					default:
						_panel.title		= 'Descrição';
						_panel.setStyle		("chromeColor",0x777777);
				}
				
				/** ############################################################ **/
				
				_panel.title			= (title_)?title_:_panel.title;
				
				_panel.addElement		(_image);
				_panel.addElement		(alertType_ == gnncAlert._textArea ? _textAreaInput : alertType_ == gnncAlert._dataGrid ? _datagrid : _label);
				_panel.addElement		(_buttonGroup);
				
				_panel.setFocus			();
				_button.setFocus		();
				
				_createNoError 			= true;
			}	
			
			return _panel;
		}

		private function __flag(e:uint):String
		{
			switch(e){
				case gnncAlert.CANCEL: return gnncAlert.CANCEL_LABEL; break;
				case gnncAlert.NO:     return gnncAlert.NO_LABEL;     break;
				case gnncAlert.OK:     return gnncAlert.OK_LABEL;     break;
				case gnncAlert.YES:    return gnncAlert.YES_LABEL;    break;
				default:               return String(e);
			}
		}
		
		private function __click(e:MouseEvent):void
		{
			//uid está sendo utilizado para mostrar qual botao foi clicado, YES, NO, CANCEL...
			_return = e.currentTarget.getStyle('uid');
		}
		
		private function __destroy(e:MouseEvent):void
		{
			reset();
			gnncGlobalStatic._popUpAlertIsOpen = false;
			new gnncPopUp().__close(_formObject);
		}
		
		private function __rightMouseDown(e:MouseEvent):void
		{
			var copy:ContextMenuItem 			= new ContextMenuItem("Copiar...", false, true);
			copy.addEventListener				(Event.SELECT,__copy);
				
			function __copy(event:Event):void
			{
				if(!_textToCopy)
					return;
				
				gnncClipBoard.__clear();
				gnncClipBoard.__copyText(_textToCopy);
			};
			
			// Create custom context menu. 
			var cm:ContextMenu 	= new ContextMenu();
			cm.hideBuiltInItems	();
			cm.customItems 		= [copy];
			
			e.currentTarget.contextMenu = cm;
		}

		public static function keyGlobalList(v:String):String
		{
			return gnncMD5.hash(v);
		}
		
		public static function getGlobalList(keyUID:String):Boolean
		{
			if(!gnncGlobalStatic._popUpOpenAlert || !keyUID)
				return false;
			if(gnncGlobalStatic._popUpOpenAlert.length==0)
				return false;

			var i:int = gnncDataArray.__getItemIndex(gnncGlobalStatic._popUpOpenAlert,keyUID);
			return i == -1 ? false : true ;
		}

		public static function removeGlobalList(keyUID:String):void
		{
			//gnncGlobalLog.__add(keyUID,'removeGlobalList');
			//e.currentTarget.getStyle('uid');

			if(!gnncGlobalStatic._popUpOpenAlert)
				return;
			if(gnncGlobalStatic._popUpOpenAlert.length==0)
				return;
			gnncDataArray.__removeItemIndex(gnncGlobalStatic._popUpOpenAlert,keyUID);
		}
		
		public static function addGlobalList(keyUID:String):void
		{
			if(!gnncGlobalStatic._popUpOpenAlert)
				gnncGlobalStatic._popUpOpenAlert = new Array();
			gnncGlobalLog.__add(keyUID,'addGlobalList');
			gnncGlobalStatic._popUpOpenAlert.push(keyUID);
		}
		
		public function __show(message_:Object,title_:String='',functionRemovePopUp_CloseEvent:Function=null,alertType_:String='',flag:Array=null):void
		{
			//no message or text
			if(!message_ && alertType_ != gnncAlert._textArea)
				return;
			else
				_textToCopy = message_.toString();


			//open alert try
			try 
			{
				var keyUID:String = keyGlobalList(String(title_+message_));
				gnncAlert.addGlobalList(keyUID);
				gnncGlobalStatic._popUpAlertIsOpen = true;
				
				_formObject = __creation(message_,title_,alertType_,flag,keyUID) as IFlexDisplayObject;

				//_formObject.addEventListener	(KeyboardEvent.KEY_UP,function(event:KeyboardEvent):void{ if(gnncKeyboard.__ESC(event)){ reset(); new gnncPopUp().__close(_formObject)} });
				//_formObject.addEventListener	(KeyboardEvent.KEY_UP,function(event:KeyboardEvent):void{ if(gnncKeyboard.__ENTER(event)){ reset(); new gnncPopUp().__close(_formObject); } });

				if( alertType_ != gnncAlert._textArea && alertType_ != gnncAlert._dataGrid )
					_formObject.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{ 
						reset(); 
						gnncGlobalStatic._popUpAlertIsOpen = false;
						new gnncPopUp().__close(_formObject); 
					});

				function __functionCloseEvent(e:FlexEvent=null):void{ //Flex-Event

					gnncAlert.removeGlobalList(keyUID);
					gnncGlobalStatic._popUpAlertIsOpen = false;

					if(functionRemovePopUp_CloseEvent==null)
						return;					
					if(e==null)
						e = new FlexEvent(FlexEvent.REMOVE,false,false); //Flex-Event

					var gnncEvent:gnncCloseEvent = new gnncCloseEvent(e.type,e.bubbles,e.cancelable,_return); //gnnc-Close-Event
					//gnncFunctions.callOnEvent(new IEventDispatcher(),CloseEvent.REMOVE,functionRemovePopUp_CloseEvent,[gnncCloseEvent]);
					//gnncFunctions.delayedCall(functionRemovePopUp_CloseEvent,0,[]);
					//functionRemovePopUp_CloseEvent.apply(null,gnncEvent);
					//functionRemovePopUp_CloseEvent.call(gnncEvent);
					functionRemovePopUp_CloseEvent.call(null,gnncEvent);
				}

				//_parent as DisplayObject
				new gnncPopUp(_parent).__creation(_formObject as IFlexDisplayObject,false,false,__functionCloseEvent,true,true);

				gnncFunctions.delayedCall(__setFocusInTextArea,2);

				function __setFocusInTextArea(e:*=null):void
				{
					if(alertType_ != gnncAlert._textArea)
						return;

					var px:uint = _textAreaInput.text.length;
					_textAreaInput.selectRange(px,px);
					_textAreaInput.setFocus();
				}

			}
			catch(event:Error)
			{
				Alert.show(message_.toString(),'Catch:'+title_,4,null,functionRemovePopUp_CloseEvent);
			}
		}
		
	}
}