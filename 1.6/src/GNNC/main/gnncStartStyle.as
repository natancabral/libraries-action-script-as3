package GNNC.main
{
	import GNNC.skin.button.skin_button;
	import GNNC.skin.buttonBar.skin_buttonBar3;
	import GNNC.skin.checkBox.skin_checkBox;
	import GNNC.skin.comboBox.skin_comboBox;
	import GNNC.skin.datagrid.skin_datagridHeaderMX;
	import GNNC.skin.dropDownList.skin_dropDownList;
	import GNNC.skin.form.skin_formItem;
	import GNNC.skin.list.skin_list;
	import GNNC.skin.mxScroller.mxScrollBarDownButtonSkin;
	import GNNC.skin.mxScroller.mxScrollBarUpButtonSkin;
	import GNNC.skin.mxScroller.mxVScrollBarThumbSkin;
	import GNNC.skin.mxScroller.mxVScrollBarTrackSkin;
	import GNNC.skin.scroller.skin_scroller;
	import GNNC.skin.tabBar.skin_tabBar_default;
	import GNNC.skin.toggleButton.skin_toggleButton;
	
	import flash.text.AntiAliasType;
	
	import mx.core.UIComponent;
	import mx.managers.SystemManagerGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	import mx.styles.StyleManager;

	public class gnncStartStyle extends UIComponent
	{
		private var _parent:Object		= null;
		public var _SM:IStyleManager2 	= StyleManager.getStyleManager(null);
		public const valueAlpha:Number = 0.3;

		public function gnncStartStyle(parentApplication_:Object=null)
		{
			/** 
			 * For Adobe Flex 3.5:
			 * StyleManager.getStyleDeclaration("global").setStyle("font-size",22);
			 * SystemManager.getSWFRoot(_parent)
			 * **/

			_parent = parentApplication_;
			_SM = StyleManager.getStyleManager(SystemManagerGlobals.topLevelSystemManagers[0]);
		}
		
		private function __applyNextTime(e:*):void
		{
			_SM = StyleManager.getStyleManager(SystemManagerGlobals.topLevelSystemManagers[0]);
			__apply();
		}
		
		public function __apply():void
		{
				var css:CSSStyleDeclaration 				= _SM.getStyleDeclaration("global");
				css.setStyle("fontSize", 					11);
				css.setStyle("font-size", 					11);
				css.setStyle("color",						0x333333);
				css.setStyle("font-weight",					"normal");
				css.setStyle("focusColor",					0x869CA7);
				css.setStyle("focus-color",					0x869CA7);
				css.setStyle("focusAlpha", 					valueAlpha);
				css.setStyle("focus-alpha", 				valueAlpha);
				
				css.setStyle("chromeColor",					0xEEEEEE);
				css.setStyle("themeColor",					0xDDDDDD);
				css.setStyle("selection-color",				0x999999);
				css.setStyle("selectionColor",				0x999999);
				css.setStyle("roll-over-color",				0xCCCCCC);
				css.setStyle("rollOverColor",				0xCCCCCC);
				
				//css.setStyle("backgroundAlpha",			0); no edit, that is commentary
				//css.setStyle("background-alpha",			0); no edit, that is commentary
				//css.setStyle("contentBackgroundAlpha",	0); no edit, that is commentary
				css.setStyle("content-background-alpha",	0);
				
				css.setStyle("modalTransparency",			0.8);
				css.setStyle("modalTransparencyBlur",		5);
				css.setStyle("modalTransparencyColor",		0x333333);
				css.setStyle("modalTransparencyDuration",	0);
				
				css.setStyle("advancedAntiAliasing",		true);
				css.setStyle("anti-alias-types",			AntiAliasType.ADVANCED);
				css.setStyle("antiAliasTypes",              AntiAliasType.ADVANCED); /* mais legivel */
				css.setStyle("fontSharpness",				0);
				css.setStyle("fontThickness",				0);
				css.setStyle("fontGridFitType",				"pixel");
				
				var cssModule:CSSStyleDeclaration 			= new CSSStyleDeclaration();
				cssModule.setStyle("fontSize", 				11);
				cssModule.setStyle("font-size", 			11);
				cssModule.setStyle("focusAlpha", 			valueAlpha);
				cssModule.setStyle("focus-alpha", 			valueAlpha);
				_SM.setStyleDeclaration("spark.modules.Module",cssModule,false);
				
				var cssGroup:CSSStyleDeclaration 			= new CSSStyleDeclaration();
				cssGroup.setStyle("fontSize", 				11);
				cssGroup.setStyle("font-size", 				11);
				cssGroup.setStyle("chromeColor",			0xEEEEEE);
				cssGroup.setStyle("focusAlpha", 			valueAlpha);
				cssGroup.setStyle("focus-alpha", 			valueAlpha);
				_SM.setStyleDeclaration("spark.modules.Group",cssGroup,false);
				
				var cssButoon:CSSStyleDeclaration 			= _SM.getStyleDeclaration("spark.components.Button");
				cssButoon.setStyle("skinClass", 			GNNC.skin.button.skin_button);
				cssButoon.setStyle("fontSize", 				11);
				cssButoon.setStyle("font-size", 			11);
				cssButoon.setStyle("chromeColor",			0xEEEEEE);
				
				var cssTextInput:CSSStyleDeclaration 		= _SM.getStyleDeclaration("spark.components.TextInput");
				cssTextInput.setStyle("focusAlpha", 		valueAlpha);
				cssTextInput.setStyle("focus-alpha", 		valueAlpha);
				cssTextInput.setStyle("borderColor", 		0xAAAAAA);
				cssTextInput.setStyle("border-color", 		0xAAAAAA);
				
				var cssTextArea:CSSStyleDeclaration 		= _SM.getStyleDeclaration("spark.components.TextArea");
				cssTextArea.setStyle("focusAlpha", 			valueAlpha);
				cssTextArea.setStyle("focus-alpha", 		valueAlpha);
				cssTextArea.setStyle("borderColor", 		0xAAAAAA);
				cssTextArea.setStyle("border-color", 		0xAAAAAA);

				var css5:CSSStyleDeclaration 				= _SM.getStyleDeclaration("spark.components.FormItem");
				css5.setStyle("skinClass",					GNNC.skin.form.skin_formItem);
				
				var cssComboBox:CSSStyleDeclaration 		= _SM.getStyleDeclaration("spark.components.ComboBox");
				cssComboBox.setStyle("skinClass",			GNNC.skin.comboBox.skin_comboBox);
				
				var css7:CSSStyleDeclaration 				= _SM.getStyleDeclaration("spark.components.TabBar");
				css7.setStyle("skinClass",					GNNC.skin.tabBar.skin_tabBar_default);
				
				var cssButtonBar:CSSStyleDeclaration 		= _SM.getStyleDeclaration("spark.components.ButtonBar");
				cssButtonBar.setStyle("skinClass",			GNNC.skin.buttonBar.skin_buttonBar3);
				
				var css8:CSSStyleDeclaration 				= _SM.getStyleDeclaration("spark.components.ToggleButton");
				css8.setStyle("skinClass",					GNNC.skin.toggleButton.skin_toggleButton);
				
				var css10:CSSStyleDeclaration 				= _SM.getStyleDeclaration("spark.components.List");
				css10.setStyle								("skinClass",GNNC.skin.list.skin_list);
				
				var cssCheckBox:CSSStyleDeclaration 		= _SM.getStyleDeclaration("spark.components.CheckBox");
				cssCheckBox.setStyle						("skinClass",GNNC.skin.checkBox.skin_checkBox);
				
				var cssAlertSpark:CSSStyleDeclaration = styleManager.getStyleDeclaration("spark.components.Alert");
				//cssAlertSpark.setStyle("fontSize",13);
				cssAlertSpark.setStyle("font-size",13);
				cssAlertSpark.setStyle("font-weight","normal");
				//cssAlertSpark.setStyle("fontWeight","normal");

				styleManager.getStyleDeclaration("spark.components.Scroller").setStyle("skinClass",GNNC.skin.scroller.skin_scroller);
				styleManager.getStyleDeclaration("spark.components.HScrollBar").setStyle("skinClass",GNNC.skin.scroller.skin_hScrollBar);
				styleManager.getStyleDeclaration("spark.components.VScrollBar").setStyle("skinClass",GNNC.skin.scroller.skin_vScrollBar);
				
				// MX Halo -------------------------

				var cssToopTip:CSSStyleDeclaration 			= _SM.getStyleDeclaration("mx.controls.ToolTip");
				cssToopTip.setStyle("color",				0xFFFFFF);
				cssToopTip.setStyle("backgroundColor",		0x222222);
				cssToopTip.setStyle("backgroundAlpha",		0.95);
				
				var cssTextInputMasked:CSSStyleDeclaration 	= _SM.getStyleDeclaration("mx.controls.TextInput");
				cssTextInputMasked.setStyle("focusAlpha", 	valueAlpha);
				cssTextInputMasked.setStyle("focus-alpha", 	valueAlpha);
				cssTextInputMasked.setStyle("borderColor", 	0xAAAAAA);
				cssTextInputMasked.setStyle("border-color", 0xAAAAAA);
				
				var css9:CSSStyleDeclaration 				= _SM.getStyleDeclaration("mx.controls.ToolTip");
				css9.setStyle("fontSize",					11);
				css9.setStyle("font-size",					11);
				css9.setStyle("font-weight",				"normal");
				css9.setStyle("fontWeight",					"normal");
				
				var cssAlert:CSSStyleDeclaration = _SM.getStyleDeclaration("mx.controls.Alert");
				cssAlert.setStyle("fontSize",13);
				cssAlert.setStyle("font-size",13);
				cssAlert.setStyle("font-weight","normal");
				cssAlert.setStyle("fontWeight","normal");
				
				setScrollBarMX();
				setNumericStepper();
				setDataGridMX();
				setDropDownList();
				setMenuMX();
		}

		public function setMenuMX(v:uint=0):void
		{
			try{
				var cssMenu:CSSStyleDeclaration = _SM.getStyleDeclaration("mx.controls.Menu");
				cssMenu.setStyle("fontSize",11);
				cssMenu.setStyle("content-background-color",0x555555);
				cssMenu.setStyle("background-color",0x555555);
				cssMenu.setStyle("backgroundColor",0x555555);
				cssMenu.setStyle("selectionColor",0xFFFFFF);
				cssMenu.setStyle("rollOverColor",0x648ec3);
				cssMenu.setStyle("color",0xFFFFFF);
				cssMenu.setStyle("dropShadowEnabled",false);
				cssMenu.setStyle("dropShadowVisible",false);
				cssMenu.setStyle("borderColor",0x888888);
				cssMenu.setStyle("borderVisible",false);
			}catch(e:*){
				v=v+1;
				if(v<4)
					setMenuMX(v);
			}
		}
		
		public function setDataGridMX(v:uint=0):void
		{
			try{
				styleManager.getStyleDeclaration("mx.controls.DataGrid").setStyle("headerBackgroundSkin",GNNC.skin.datagrid.skin_datagridHeaderMX)
			}catch(e:*){
				v=v+1;
				if(v<4)
					setDataGridMX(v);
			}
		}
		
		public function setScrollBarMX(v:uint=0):void
		{
			// MX ScrollBars ----------------------------
			try{
				var cssVSB:CSSStyleDeclaration = new CSSStyleDeclaration();
				cssVSB.setStyle('thumbSkin',mxVScrollBarThumbSkin);
				cssVSB.setStyle('thumb-skin',mxVScrollBarThumbSkin);
				cssVSB.setStyle('trackSkin',mxVScrollBarTrackSkin);
				cssVSB.setStyle('track-skin',mxVScrollBarTrackSkin);
				cssVSB.setStyle('downArrowSkin',mxScrollBarDownButtonSkin);
				cssVSB.setStyle('down-arrow-skin',mxScrollBarDownButtonSkin);
				cssVSB.setStyle('upArrowSkin',mxScrollBarUpButtonSkin);
				cssVSB.setStyle('up-arrow-skin',mxScrollBarUpButtonSkin);
				_SM.setStyleDeclaration(".sbTrackStyles",cssVSB,false);
				
				var cssTree:CSSStyleDeclaration = _SM.getStyleDeclaration("mx.controls.Tree");
				cssTree.setStyle("verticalScrollBarStyleName","sbTrackStyles");
				cssTree.setStyle("horizontalScrollBarStyleName","sbTrackStyles");
				
				cssTree.setStyle("selectionDuration",200);
				cssTree.setStyle("selectionDuration",200);

				cssTree.setStyle("paddingBottom",0);
				cssTree.setStyle("paddingLeft",0);
				cssTree.setStyle("paddingRight",0);
				cssTree.setStyle("paddingTop",0);
				
				cssTree.setStyle("borderVisible",false);
				cssTree.setStyle("borderStyle","none");

			}catch(e:*){
				v=v+1;
				if(v<4)
					setScrollBarMX(v);
			}
			// MX ScrollBars ----------------------------
		}

		public function setDropDownList(v:uint=0):void
		{
			try{
				styleManager.getStyleDeclaration("spark.components.DropDownList").setStyle("skinClass",GNNC.skin.dropDownList.skin_dropDownList);
			}catch(e:*){
				v=v+1;
				if(v<4)
					setDropDownList(v);
			}
		}
		
		public function setNumericStepper(v:uint=0):void
		{
			try{
				var cssNumericStepper:CSSStyleDeclaration = _SM.getStyleDeclaration("spark.components.NumericStepper");
				cssNumericStepper.setStyle("focusAlpha",valueAlpha);
				cssNumericStepper.setStyle("focus-alpha",valueAlpha);
				cssNumericStepper.setStyle("borderColor",0xAAAAAA);
				cssNumericStepper.setStyle("border-color",0xAAAAAA);
			}catch(e:*){
				v=v+1;
				if(v<4)
					setNumericStepper(v);
			}
		}
		
		public function __change(COMPONENT_:String='',PROPERTY_:String='',VALUE_:Object=null):Boolean
		{
			if(!COMPONENT_ || !PROPERTY_ || !VALUE_)
			return false;
			
			var css:CSSStyleDeclaration = _SM.getStyleDeclaration(COMPONENT_);
			css.setStyle(PROPERTY_, VALUE_);
			
			return true;
		}

		public function __changeList(COMPONENT_:Array=null,PROPERTY_:Array=null,VALUE_:Array=null):Boolean
		{
			return true;
		}

		
	}
}
