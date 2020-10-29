package GNNC.application
{
	import GNNC.UI.gnncDaybyday.gnncSetting.gnncSetting;
	import GNNC.UI.gnncDaybyday.gnncUserLogin.gnncUserLogin;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.UI.gnncSettingAir.gnncSettingAIR;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.gnncEmbedImage;
	
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	
	import mx.controls.Button;
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	
	import spark.components.HGroup;

	public class gnncAppIcons
	{
		private var _parent:Object				= null;
		
		private var SET:Button 					= new Button();
		private var ACC:Button 					= new Button();
		private var ATU:Button 					= new Button();
		private var MOV:Button 					= new Button();
		private var MIN:Button 					= new Button();
		private var ICON_MAX_RES:Button 		= new Button();
		private var FUL:Button 					= new Button();
		private var CLS:Button 					= new Button();
		
		private var BG:HGroup 					= new HGroup();
		private var _APP:gnncApplication		= new gnncApplication();

		public function gnncAppIcons(parentApplication_:Object)
		{
			_parent = parentApplication_;
			_parent.addElement(__creation());
		}
		
		private function __fChangeIcon(event:NativeWindowDisplayStateEvent):void
		{
			/**var txt:String = ''+
				'\nful: ' 		+ gnncApplication._fullscreen +
				'\nmax: ' 		+ gnncApplication._maximized +
				'\nres: ' 		+ gnncApplication._restored +
				'\nsW: ' 		+ gnncApplication._screenWidth +
				'\nsH: ' 		+ gnncApplication._screenHeight +
				'\nstageW: ' 	+ gnncApplication._stageWidth +
				'\nstageH: ' 	+ gnncApplication._stageHeight ;
			Alert.show(txt);**/

			if(gnncApplication._maximized)
			{
				ICON_MAX_RES.toolTip 			= "Restaurar";
				ICON_MAX_RES.setStyle			('upSkin',gnncEmbedImage.RESTORE_BW);
				ICON_MAX_RES.setStyle			('overSkin',gnncEmbedImage.RESTORE);
				ICON_MAX_RES.setStyle			('downSkin',gnncEmbedImage.RESTORE_BW);
				ICON_MAX_RES.setStyle			('disabledSkin',gnncEmbedImage.RESTORE_BW);
				ICON_MAX_RES.removeEventListener(MouseEvent.CLICK,gnncApplication.__windowsMaximize); 
				ICON_MAX_RES.addEventListener	(MouseEvent.CLICK,gnncApplication.__windowsRestore);
			}
			else if(gnncApplication._restored)
			{
				ICON_MAX_RES.toolTip 			= "Maximizar";
				ICON_MAX_RES.setStyle			('upSkin',gnncEmbedImage.MAXIMIZE_BW);
				ICON_MAX_RES.setStyle			('overSkin',gnncEmbedImage.MAXIMIZE);
				ICON_MAX_RES.setStyle			('downSkin',gnncEmbedImage.MAXIMIZE_BW);
				ICON_MAX_RES.setStyle			('disabledSkin',gnncEmbedImage.MAXIMIZE_BW);
				ICON_MAX_RES.removeEventListener(MouseEvent.CLICK,gnncApplication.__windowsRestore);
				ICON_MAX_RES.addEventListener	(MouseEvent.CLICK,gnncApplication.__windowsMaximize);
			}
		}
		
		private function __creation():HGroup
		{
			_parent = (_parent)?_parent:gnncGlobalStatic._parent;
			
			//Minimize, Maximaze, Restore events dispatche
			if(_parent.willTrigger(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE))
				_parent.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,__fChangeIcon);
			
			BG.gap								= 2;
			BG.top								= 7;
			BG.right							= 5;
			BG.addEventListener					(MouseEvent.ROLL_OVER,function(event:MouseEvent):void
			{ 
				__fChangeIcon(null);
			});

			SET.toolTip							= 'Configurações';
			SET.focusEnabled					= false;
			SET.setStyle						('upSkin',gnncEmbedImage.SETTING_16);
			SET.setStyle						('overSkin',gnncEmbedImage.SETTING_16_BLUE);
			SET.setStyle						('downSkin',gnncEmbedImage.SETTING_16);
			SET.setStyle						('disabledSkin',gnncEmbedImage.SETTING_16_BLUE);
			SET.addEventListener				(MouseEvent.CLICK,function(event:MouseEvent):void
			{
				var _fr:Function				= function(e:FlexEvent):void{ _page.__setContentTab(new gnncSettingAIR() as IFlexDisplayObject,'APLICAÇÃO') };
				var _page:gnncSetting			= new gnncSetting();
				_page.addEventListener			(FlexEvent.CREATION_COMPLETE,_fr);
				new gnncPopUp					(gnncGlobalStatic._parent).__creation(_page,false,true,null,true,true); 
				
				//new gnncAppWindow(gnncGlobalStatic._parent).__creationNative(new gnncSettingDaybyday(),800,600);
			});

			ACC.toolTip							= 'Login';
			ACC.focusEnabled					= false;
			ACC.setStyle						('upSkin',gnncEmbedImage.ACCESS_16_BW);
			ACC.setStyle						('overSkin',gnncEmbedImage.ACCESS_16);
			ACC.setStyle						('downSkin',gnncEmbedImage.ACCESS_16_BW);
			ACC.setStyle						('disabledSkin',gnncEmbedImage.ACCESS_16);
			ACC.addEventListener				(MouseEvent.CLICK,function(event:MouseEvent):void
			{
				new gnncPopUp(gnncGlobalStatic._parent).__creation(new gnncUserLogin(),true); //_parent
			});
			ACC.addEventListener(FlexEvent.CREATION_COMPLETE,function(event:FlexEvent):void
			{ 
				if(_parent == null) 
					BG.removeElement(ACC); 
			});
			//http://learn.adobe.com/wiki/display/Flex/Event+Propagation
			//event.currentTarget = application

			ATU.toolTip							= 'Atualizar';
			ATU.focusEnabled					= false;
			ATU.setStyle						('upSkin',gnncEmbedImage.REFRESH_16_BW);
			ATU.setStyle						('overSkin',gnncEmbedImage.REFRESH_16);
			ATU.setStyle						('downSkin',gnncEmbedImage.REFRESH_16_BW);
			ATU.setStyle						('disabledSkin',gnncEmbedImage.REFRESH_16_BW);
			ATU.addEventListener				(MouseEvent.CLICK,function():void
			{
					gnncGlobalStatic.__reload();
			});

			MOV.toolTip 						= 'Mover'; 
			MOV.focusEnabled					= false;
			MOV.setStyle						('upSkin',gnncEmbedImage.MOVE_BW);
			MOV.setStyle						('overSkin',gnncEmbedImage.MOVE);
			MOV.setStyle						('downSkin',gnncEmbedImage.MOVE_BW);
			MOV.setStyle						('disabledSkin',gnncEmbedImage.MOVE_BW);
			MOV.addEventListener				(MouseEvent.MOUSE_DOWN,gnncApplication.__windowsDrag);

			MIN.toolTip 						= 'Minimizar'; 
			MIN.focusEnabled					= false;
			MIN.setStyle						('upSkin',gnncEmbedImage.MINIMIZE_BW);
			MIN.setStyle						('overSkin',gnncEmbedImage.MINIMIZE);
			MIN.setStyle						('downSkin',gnncEmbedImage.MINIMIZE_BW);
			MIN.setStyle						('disabledSkin',gnncEmbedImage.MINIMIZE_BW);
			MIN.addEventListener				(MouseEvent.CLICK,gnncApplication.__windowsMinimize);

			ICON_MAX_RES.toolTip 				= "Maximizar";
			ICON_MAX_RES.focusEnabled			= false;
			ICON_MAX_RES.setStyle				('upSkin',gnncEmbedImage.MAXIMIZE_BW);
			ICON_MAX_RES.setStyle				('overSkin',gnncEmbedImage.MAXIMIZE);
			ICON_MAX_RES.setStyle				('downSkin',gnncEmbedImage.MAXIMIZE_BW);
			ICON_MAX_RES.setStyle				('disabledSkin',gnncEmbedImage.MAXIMIZE_BW);
			ICON_MAX_RES.addEventListener		(MouseEvent.CLICK,gnncApplication.__windowsMaximize);

			FUL.toolTip 						= 'FullScreen'; 
			FUL.focusEnabled					= false;
			FUL.setStyle						('upSkin',gnncEmbedImage.FULLSCREEN_BW);
			FUL.setStyle						('overSkin',gnncEmbedImage.FULLSCREEN);
			FUL.setStyle						('downSkin',gnncEmbedImage.FULLSCREEN_BW);
			FUL.setStyle						('disabledSkin',gnncEmbedImage.FULLSCREEN_BW);
			FUL.addEventListener				(MouseEvent.CLICK,gnncApplication.__windowsFullScreen);

			CLS.toolTip 						= 'Fechar';
			CLS.focusEnabled					= false;
			CLS.setStyle						('upSkin',gnncEmbedImage.CLOSE_16_BW);
			CLS.setStyle						('overSkin',gnncEmbedImage.CLOSE_16);
			CLS.setStyle						('downSkin',gnncEmbedImage.CLOSE_16_BW);
			CLS.setStyle						('disabledSkin',gnncEmbedImage.CLOSE_16_BW);
			CLS.addEventListener				(MouseEvent.CLICK,gnncApplication.__windowsClose);

			//Verify if Maximized or Restored
			__fChangeIcon(null);
			
			BG.addElement						(SET);
			BG.addElement						(ACC);
			BG.addElement						(ATU);
			BG.addElement						(MOV);
			BG.addElement						(MIN);
			BG.addElement						(ICON_MAX_RES);
			BG.addElement						(FUL);
			BG.addElement						(CLS);

			return BG;
		}
		
	}
}