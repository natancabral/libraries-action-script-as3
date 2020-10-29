package GNNC.UI.gnncPopUp
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncLoading.gnncLoading;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.event.gnncEventGeneral;
	import GNNC.keyboard.gnncKeyboard;
	import GNNC.others.gnncToolTip;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	import mx.messaging.AbstractConsumer;
	
	import spark.components.Button;
	import spark.components.PopUpAnchor;

	public class gnncPopUp
	{
		public  var _displayObject:IFlexDisplayObject 	= null;
		private var _parent:Object 						= null;
		private var _center:Boolean 					= true;
		private var _buttonClose:Button;
		private var _keysforEsc:Boolean;
		private var _modal:Boolean;
		
		static private var _POPA:PopUpAnchor			= new PopUpAnchor();
		static private var _parent:Object 				= null;
		
		public function gnncPopUp(parentApplication_:Object=null)
		{
			_parent = (parentApplication_) ? parentApplication_ : gnncGlobalStatic._parent;
		}
		
		public function __creation(displayObject_:IFlexDisplayObject,keysforEsc_:Boolean=true,toFront_:Boolean=false,functionRemovePopUp_FlexEvent_:Function=null,modal_:Boolean=true,center_:Boolean=true):void
		{
			_modal				= modal_;
			_center 			= center_;
			_keysforEsc			= keysforEsc_;
			_displayObject 		= displayObject_ as IFlexDisplayObject;
			_parent				= (_parent!=null)?_parent as DisplayObject:FlexGlobals.topLevelApplication.parent;
			
			try 
			{
				_displayObject.addEventListener					(KeyboardEvent.KEY_DOWN			,__keyDown);
				_displayObject.addEventListener					(FlexEvent.REMOVE				,__popUpRemove);
				_displayObject.addEventListener					(FocusEvent.FOCUS_IN			,__focusManager);
				_displayObject.addEventListener					(FlexEvent.CREATION_COMPLETE	,__creationComplete);

				if(_center)	_parent.addEventListener			(ResizeEvent.RESIZE				,__centerPopUpAdvanced);
				if(_center)	_displayObject.addEventListener		(MouseEvent.ROLL_OVER			,__centerPopUpAdvanced);
				if(_center)	_displayObject.addEventListener		(Event.ACTIVATE					,__centerPopUpAdvanced);
				//if(_center)	_displayObject.addEventListener	(FlexEvent.CREATION_COMPLETE	,function(event:FlexEvent):void		{ 	__center(_displayObject); 	if(keysforEsc) _displayObject.parent.addChild(__buttonClosePopUp())  });

				if(_displayObject.willTrigger(FlexEvent.REMOVE) && functionRemovePopUp_FlexEvent_!=null)	
					_displayObject.removeEventListener			(FlexEvent.REMOVE				,functionRemovePopUp_FlexEvent_);
				
				if(functionRemovePopUp_FlexEvent_!=null)
					_displayObject.addEventListener				(FlexEvent.REMOVE				,functionRemovePopUp_FlexEvent_);
				
				PopUpManager.addPopUp							(_displayObject,_parent as DisplayObject,_modal); 
				//systemManager.getSandboxRoot();
			}
			catch(err:Error)  
			{
				new gnncAlert(_parent).__error('Problema ao abrir a página.');
			}
		}

		protected function __creationComplete(event:FlexEvent):void
		{
			gnncGlobalStatic._popUpOpenList.push	(_displayObject);
			//IVisualElementContainer(_parent).setElementIndex(this,IVisualElementContainer(_parent).numElements-1);
			
			if(_keysforEsc && Sprite(_displayObject).hasOwnProperty('parent'))
				_displayObject.parent.addChild		(__buttonClosePopUp())
			if(_center)
				__center							(_displayObject);

			gnncToolTip.__destroy					(_displayObject.parent as IFlexDisplayObject);
		}
		
		protected function __focusManager(event:FocusEvent):void		
		{
			//Object(event.currentTarget).getFocus();
			//focusManager.getNextFocusManagerComponent().setFocus();
		}
		
		protected function __keyDown(event:KeyboardEvent):void		
		{
			if(_keysforEsc) 
				if(gnncKeyboard.__ESC(event)) 
					__close(_displayObject);
		}
		
		protected function __buttonClosePopUp():Button
		{
			_buttonClose						= new Button();
			_buttonClose.label 					= 'Fechar';
			_buttonClose.right 					= 1;
			_buttonClose.top					= 1;
			_buttonClose.setStyle				('fontSize',11);
			_buttonClose.setStyle				('font-size',11);
			//_buttonClose.setStyle				('icon',gNial.EMBEDS.IMAGE.CLOSE);
			_buttonClose.addEventListener		(MouseEvent.CLICK,	function(event:MouseEvent):void		{ 	__close(_displayObject); });
			
			return _buttonClose;
		}

		private function __centerPopUpAdvanced(e:*):void
		{ 
			__center(_displayObject);
		}
		
		public function __close(this_:Object=null):void
		{
			if(this_ == null)
				this_ = _displayObject;
			if(this_!=null){
				PopUpManager.removePopUp((this_ as IVisualElement) as IFlexDisplayObject);
				//_displayObject.dispatchEvent(new gnncEventGeneral());
			}
		}

		static public function __close():void
		{
			PopUpManager.removePopUp(_POPA as IFlexDisplayObject);
		}

		public function __center(this_:Object):void
		{
			if(this_ == null)
				this_ = _displayObject;
			if(this_ != null)
				PopUpManager.centerPopUp(this_ as IFlexDisplayObject);
		}

		static public function __center():void
		{
			PopUpManager.centerPopUp(_POPA as IFlexDisplayObject);
		}

		public function __toFront(this_:Object=null):void
		{
			if(this_ == null)
				this_ = _displayObject;
			PopUpManager.bringToFront(this_ as IFlexDisplayObject);
		}

		static public function __toFrotn():void
		{
			PopUpManager.bringToFront(_POPA as IFlexDisplayObject);
		}
		
		public function __loading(textLoading_:String='',percent_:uint=0,specialLoading_:Boolean=false):void
		{
			var _page:gnncLoading 	= new gnncLoading();
			_page._textLoading 		= textLoading_;
			_page._percent			= percent_;
			_page._specialLoading	= specialLoading_;
			
			__creation				(_page,false);
		}

		protected function __popUpRemove(event:FlexEvent):void		
		{
			gnncGlobalStatic._popUpOpenList.pop();
			//IVisualElementContainer(_parent).removeElement(this);
			
			/** IMPORTANT PROCESS OF FOCUS **/
			if(gnncGlobalStatic._popUpOpenList.length)
				Object( gnncGlobalStatic._popUpOpenList[ (gnncGlobalStatic._popUpOpenList.length-1) ] ).setFocus();
			else
				Object( _parent ).setFocus();
			
			if(_center) _parent.removeEventListener(ResizeEvent.RESIZE	,__centerPopUpAdvanced);
			if(_center)	_parent.removeEventListener(Event.ACTIVATE		,__centerPopUpAdvanced);
			
			_parent.dispatchEvent(new gnncEventGeneral(gnncEventGeneral._free));

			if(_buttonClose) 
				try{
					_displayObject.parent.removeChild(_buttonClose);
				}catch(error:Error){ /** **/ }

		}
	}
}