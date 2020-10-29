package GNNC.main
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncDaybyday.gnncLogo.gnncLogoSystem;
	import GNNC.UI.gnncDaybyday.gnncUserLogin.gnncUserLogin;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataRand;
	import GNNC.data.element.gnncElement;
	import GNNC.data.file.gnncFilesRemote;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.permission.gnncPermission;
	import GNNC.data.securityService.gnncSecurityDate;
	import GNNC.data.sql.gnncSql;
	import GNNC.keyboard.gnncKeyboard;
	import GNNC.keyboard.gnncKeyboardPaste;
	import GNNC.others.gnncToolTip;
	import GNNC.sqlTables.table_category;
	import GNNC.sqlTables.table_departament;
	import GNNC.sqlTables.table_group;
	import GNNC.sqlTables.table_permission;
	import GNNC.sqlTables.table_series;
	import GNNC.sqlTables.table_settings;
	
	import flash.events.KeyboardEvent;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.primitives.Rect;
	
	public class gnncStart
	{ 
		/** ********************************************************* **/
		/** LIBRARY ************************************************* **/
		/** ********************************************************* **/
		
		private var _topLevel:Object 						= FlexGlobals.topLevelApplication;
		private var _parent:Object							= null;
		private var _startValues:gnncStartValues			= null;
		//private var _gnncPermission:gnncAMFPhp				= new gnncAMFPhp();
		private var _gnncPopUp:gnncPopUp					= new gnncPopUp();
		private var _gnncFilesRemote:gnncFilesRemote;

		private var _reloadConnectionsTotal:int				= 7;
		private var _reloadConnectionsCount:int				= 0;
		private var _reloadTryCount:int						= 0;

		[Bindable] public var _gnncGlobal:gnncGlobalStatic	= new gnncGlobalStatic();
		
		public function gnncStart(parentApplication_:Object,programName_:String='',startValues_:gnncStartValues=null)
		{
			_startValues 						= startValues_;
			_parent 							= parentApplication_;

			gnncGlobalStatic._programName		= programName_;
			gnncGlobalStatic._programId			= gnncGlobalArrays.__programId(programName_);
			gnncGlobalStatic._parent			= parentApplication_;

			_gnncPopUp 							= new gnncPopUp(_parent);
			
			_gnncGlobal._PERMISSION				= new gnncAMFPhp(_parent);
			_gnncGlobal._PERMISSION_SET			= new gnncAMFPhp(_parent);
			_gnncGlobal._SETTINGS				= new gnncAMFPhp(_parent);
			_gnncGlobal._DEPARTAMENT			= new gnncAMFPhp(_parent);
			_gnncGlobal._GROUP					= new gnncAMFPhp(_parent);
			_gnncGlobal._CATEGORY				= new gnncAMFPhp(_parent);
			_gnncGlobal._SERIES					= new gnncAMFPhp(_parent);
			
			super();
		}
		
		public function __preInitialize():void
		{
			_topLevel.addEventListener		(FlexEvent.INITIALIZE			,__initialize);
			_topLevel.addEventListener		(FlexEvent.APPLICATION_COMPLETE	,__creationComplete);
			_topLevel.addEventListener		(KeyboardEvent.KEY_UP			,__keyBoardLog);

			_topLevel.frameRate 			= _startValues.globalFrameRate;

			Security.loadPolicyFile			("xmlsocket://www.gnnc.com.br:80/crossdomain.xml"); 
			Security.loadPolicyFile			("xmlsocket://daybyday.gnnc.com.br:80/crossdomain.xml");
		}
		
		public function __help():void 
		{
			//gNial.COMPONENTS.ALERT.ALERT.ALERT_SIMPLE	('Para início da conexão com o banco e cliente:\n initialize = "_START.APPINIT(event);" \n applicationComplete = "_START.APPCOMPLETE(event)" \n close = "_START.APPFINAL(event)" \n mouseMove = "_START.APPMOUSEMOVE(event)"');
			//gNial.COMPONENTS.ALERT.ALERT.ALERT_SIMPLE	('Adicione na compilação do projeto a linha:\n -locale pt_BR -services "services-config.xml"');
		}
		
		private function __initialize(e:FlexEvent):void
		{
			if(_startValues.toolTip)		gnncToolTip.__apply();
			if(_startValues.logo) 			new gnncLogoSystem		(_parent).__apply(gnncGlobalStatic._programIcon48);
			//if(_startValues.menu) 			new gnncMenuRight			(_parent).__creation();
		}
		
		private function __creationComplete(e:FlexEvent):void
		{
			if(_startValues.globalPaste)	new gnncKeyboardPaste	(_parent).__pasteErrorGlobal();
			if(_startValues.login) 			new gnncPopUp			(_parent).__creation(new gnncUserLogin(),false,true);

			_parent.minWidth 				= _startValues.windowsWidth;
			_parent.minHeight 				= _startValues.windowsHeight;

			//new gnncUncaughtErrorEvent();
		}

		private function __keyBoardLog(e:KeyboardEvent):void
		{
			if(gnncKeyboard.__controlL(e) && gnncKeyboard.__alt(e) && gnncKeyboard.__shift(e))
			{
				gnncGlobalLog._try = !gnncGlobalLog._try;
				
				if(gnncGlobalLog._try)
					gnncGlobalLog.__add('Olá, '+gnncGlobalStatic._userNameClient);
				else
					gnncGlobalLog.__hide();
			}
		}
		
		/** ############################# RELOAD ############################# **/
		
		public function __reload():void
		{
			if(!gnncGlobalStatic._userId)
			{
				new gnncAlert().__error('Efetue o login com seu usuário e sua senha corretamente ou verifique sua internet.');
				return;
			}
			
			if(_reloadTryCount>4)
			{
				_gnncPopUp.__close();
				_reloadTryCount = 0;
				
				new gnncAlert().__error("Cinco ou mais tentativas para acessar os dados autenticados. Tente acessar novamente.",'Problema na conexão.',__openUserLogin);
				
				function __openUserLogin(e:*):void
				{
					new gnncPopUp().__creation(new gnncUserLogin(),false,false,null,true,true);
				}

				return;
			}
			
			//check date of PC and SERVER
			var securityDate:gnncSecurityDate = new gnncSecurityDate(d,d);
			function d():void{
				if(securityDate.cantSync==false && securityDate.serverSync==false){
					gnncGlobalStatic._parent.enabled = false;
					new gnncAlert().__alert(
						'Não foi possível sincronizar o fuso horário do servidor. ' +
						'Verifique a data e a hora local no seu computador. ' +
						'O sistema será bloqueado por motivos de segurança, entre novamente.',
						'Fuso horário');
				}else if(securityDate.cantSync==false && securityDate.serverSync==true){
					gnncGlobalStatic._parent.enabled = true;
				}
			}

			//loading screen
			_gnncPopUp.__close		();
			_gnncPopUp.__loading	(!_reloadTryCount?'Acessando dados autenticados...':_reloadTryCount==1?'Segunda tentativa...':'Tentativa número '+(_reloadTryCount+1),0,true);

			//start values
			_reloadConnectionsCount = 0;
			_reloadTryCount++;
			
			//load image documents
			var _url:String 					= gnncGlobalStatic._httpHost+'ATTACH/'+gnncGlobalStatic._dataBase.toUpperCase()+'/LOGO_DOCUMENT_PDF.jpg?'+gnncDataRand.__key();
			_gnncFilesRemote					= new gnncFilesRemote();
			_gnncFilesRemote._allowGlobalError	= false;
			_gnncFilesRemote._allowGlobalLoading= false;
			_gnncFilesRemote.__loadUrl			(_url,__loadImageComplete,__loadImageError);

			gnncGlobalLog.__add('Url Image Document: '+_url);

			gnncGlobalStatic._userPermission     = null;
			gnncGlobalStatic._userPermissionSet  = null;

			//destroy
			//_gnncPermission				.__destroy();
			_gnncGlobal._PERMISSION		.__destroy();
			_gnncGlobal._PERMISSION_SET	.__destroy();
			_gnncGlobal._SETTINGS		.__destroy();
			_gnncGlobal._DEPARTAMENT	.__destroy();
			_gnncGlobal._GROUP			.__destroy();
			_gnncGlobal._CATEGORY		.__destroy();
			_gnncGlobal._SERIES			.__destroy();
			
			//start
			/*
			_gnncPermission			= new gnncAMFPhp();
			_gnncGlobal._SETTINGS	= new gnncAMFPhp();
			_gnncGlobal._DEPARTAMENT= new gnncAMFPhp();
			_gnncGlobal._GROUP		= new gnncAMFPhp();
			_gnncGlobal._CATEGORY	= new gnncAMFPhp();
			*/

			//clear all datas
			//_gnncPermission			.__clear();
			_gnncGlobal._PERMISSION	.__clear();
			_gnncGlobal._PERMISSION_SET.__clear();
			_gnncGlobal._SETTINGS	.__clear();
			_gnncGlobal._DEPARTAMENT.__clear();
			_gnncGlobal._GROUP		.__clear();
			_gnncGlobal._CATEGORY	.__clear();
			_gnncGlobal._SERIES		.__clear();

			//denied error
			//_gnncPermission			._allowGlobalError		= false;
			_gnncGlobal._PERMISSION	._allowGlobalError		= false;
			_gnncGlobal._PERMISSION_SET._allowGlobalError		= false;
			_gnncGlobal._SETTINGS	._allowGlobalError		= false;
			_gnncGlobal._DEPARTAMENT._allowGlobalError		= false;
			_gnncGlobal._GROUP		._allowGlobalError		= false;
			_gnncGlobal._CATEGORY	._allowGlobalError		= false;
			_gnncGlobal._SERIES		._allowGlobalError		= false;

			//denied loading
			//_gnncPermission			._allowGlobalLoading	= false;
			_gnncGlobal._PERMISSION	._allowGlobalLoading	= false;
			_gnncGlobal._PERMISSION_SET	._allowGlobalLoading	= false;
			_gnncGlobal._SETTINGS	._allowGlobalLoading	= false;
			_gnncGlobal._DEPARTAMENT._allowGlobalLoading	= false;
			_gnncGlobal._GROUP		._allowGlobalLoading	= false;
			_gnncGlobal._CATEGORY	._allowGlobalLoading	= false;
			_gnncGlobal._SERIES		._allowGlobalLoading	= false;

			//permission
			var _table:table_permission			= new table_permission();
			_table.ID_GROUP						= gnncGlobalStatic._userIdGroupPermission;
			_table.ID_PROGRAM					= gnncGlobalStatic._programId;
			_gnncGlobal._PERMISSION.__sql		(new gnncSql().__SELECT(_table),'','',__fResult,__fFault);
			
			var _sqlPermissionSet:String        = " select * from dbd_permission_set ps where 1 order by ps.ID asc "; //ps.ID_USER = '"+gnncGlobalStatic._userId+"' OR ps.ID_PERMISSION_GROUP = '"+gnncGlobalStatic._userIdGroupPermission+"' ";
			_gnncGlobal._PERMISSION_SET.__sql	(_sqlPermissionSet,'','',__fResult,__fFault);

			//get name and email of Client General by ID_CLIENT_GENERAL;
			var _clientNameGeneral:String		= "(select (select NAME  from dbd_client where ID like dbd_settings.VALUE) from dbd_settings where NAME like 'ID_CLIENT_GENERAL') as NAME_CLIENT_GENERAL ";
			var _clientEmailGeneral:String		= "(select (select EMAIL from dbd_client where ID like dbd_settings.VALUE) from dbd_settings where NAME like 'ID_CLIENT_GENERAL') as EMAIL_CLIENT_GENERAL ";

			//conneciton
			_gnncGlobal._SETTINGS.__sql			(new gnncSql().__SELECT(new table_settings(),	false,['ID','NAME','VALUE',_clientNameGeneral,_clientEmailGeneral])												,'','',__fResult,__fFault);
			_gnncGlobal._DEPARTAMENT.__sql		(new gnncSql().__SELECT(new table_departament(),false,['ID','NAME','ID_FATHER','LEVEL','MIX','COLOR','ACTIVE'],null,null,null,null,['NAME'],false)				,'','',__fResult,__fFault);
			_gnncGlobal._GROUP.__sql			(new gnncSql().__SELECT(new table_group(),		false,['ID','NAME','ID_FATHER','LEVEL','MIX','COLOR','ACTIVE','TYPE_FINANCIAL_FIX'],null,null,null,null,['NAME'],false)				,'','',__fResult,__fFault);
			_gnncGlobal._CATEGORY.__sql			(new gnncSql().__SELECT(new table_category(),	false,['ID','NAME','ID_FATHER','LEVEL','MIX','COLOR','ACTIVE'],null,null,null,null,['NAME'],false)				,'','',__fResult,__fFault);
			_gnncGlobal._SERIES.__sql			(new gnncSql().__SELECT(new table_series(),		false,['ID','NAME','ID_FATHER','LEVEL','MIX','COLOR','ACTIVE','DESCRIPTION'],null,null,null,null,['NAME'],false),'','',__fResult,__fFault);
			
		}
		
		private function __fResult(e:*):void
		{
			_reloadConnectionsCount++;

			/*
			var _str:String = ""+
			'['+_reloadConnectionsTotal+']_reloadConnectionsTotal '+"\n"+
			'['+_reloadConnectionsCount+']_reloadConnectionsCount '+"\n"+
			'['+_reloadTryCount+']_reloadTryCount ';

			new gnncAlert().__alert(_str);
			*/

			if(_reloadConnectionsCount != _reloadConnectionsTotal)
				return;

			//permissions
			if(_gnncGlobal._PERMISSION.DATA_ROWS > 0)
				//gnncGlobalStatic._userPermission = 
				gnncPermission.__json2objectPermission(String(_gnncGlobal._PERMISSION.DATA_ARR.getItemAt(0).PERMISSION));
			
			if(_gnncGlobal._PERMISSION_SET.DATA_ROWS > 0)
				gnncGlobalStatic._userPermissionSet = _gnncGlobal._PERMISSION_SET.DATA_ARR;
			//new gnncAlert().__dataGrid(_gnncGlobal._PERMISSION_SET.DATA_ARR);

			//settings
			if(_gnncGlobal._SETTINGS.DATA_ROWS)
			{
				gnncGlobalStatic._dataBaseTry = (new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','DATABASE_TRY','VALUE')) ? true : false ;
				gnncElement.removeElementByName(gnncGlobalStatic._parent,'databasetry');

				if(gnncGlobalStatic._dataBaseTry)
				{
					var g:Group  = new Group();
					g.name       = 'databasetry';
					g.width      = 500;
					g.height     = 20;
					g.horizontalCenter = 0;
					var t:Rect   = new Rect();
					t.fill       = new SolidColor(0xff0000,0.6);
					t.stroke     = new SolidColorStroke(0xff0000,1,0.9);
					t.percentWidth = 100;
					t.height     = 20;
					t.top        = 5;
					var x:Label  = new Label();
					x.text       = 'Banco de Dados Teste (Não Produção)';
					x.setStyle   ('font-color',0xffffff);
					x.setStyle   ('fontColor',0xffffff);
					x.setStyle   ('color',0xffffff);
					x.horizontalCenter = 0;
					x.top        = 12;
					x.height     = 10;
					g.addElement (t);
					g.addElement (x);
					gnncGlobalStatic._parent.addElement(g);
				}

				var systemMessage:Object 					= new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','SYSTEM_MESSAGE','VALUE');
				if(systemMessage) 
					new gnncAlert(_parent).__description	(systemMessage.toString(),'Mensagem do Sistema');
				
				gnncGlobalStatic._documentPdfCompany 		= String(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,	'NAME','DOCUMENT_COMPANY'		,'VALUE'));
				gnncGlobalStatic._documentPdfDescription	= String(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,	'NAME','DOCUMENT_DESCRIPTION'	,'VALUE'));
				gnncGlobalStatic._documentPdfReceipt		= String(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,	'NAME','DOCUMENT_RECEIPT'		,'VALUE'));
				
				gnncGlobalStatic._clientGeneralId			= uint(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,	'NAME','ID_CLIENT_GENERAL'		,'VALUE'));
				gnncGlobalStatic._clientGeneralName			= String(_gnncGlobal._SETTINGS.DATA_ARR.getItemAt(0)['NAME_CLIENT_GENERAL']);
				gnncGlobalStatic._clientGeneralEmail		= String(_gnncGlobal._SETTINGS.DATA_ARR.getItemAt(0)['EMAIL_CLIENT_GENERAL']);

				gnncGlobalStatic._idCourse					= uint(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','ID_COURSE'						,'VALUE'));
				gnncGlobalStatic._idGroupClientProfessional	= uint(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','ID_GROUP_CLIENT_PROFESSIONAL'	,'VALUE'));
				gnncGlobalStatic._idGroupClientPatient		= uint(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','ID_GROUP_CLIENT_PATIENT'		,'VALUE'));
				gnncGlobalStatic._idGroupClientTheater		= uint(new gnncDataArrayCollection(_parent).__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','ID_GROUP_CLIENT_THEATER'		,'VALUE'));

			}
			
			//ok try connection
			_reloadTryCount = 0;
			
			//close loading special
			_gnncPopUp.__close();
			
			//newSession
			gnncGlobalStatic.__createNewSession();
		}

		private function __fFault(e:*):void
		{
			//clear all datas
			_gnncGlobal._PERMISSION	.__destroy();
			_gnncGlobal._PERMISSION_SET	.__destroy();
			_gnncGlobal._SETTINGS	.__destroy();
			_gnncGlobal._DEPARTAMENT.__destroy();
			_gnncGlobal._GROUP		.__destroy();
			_gnncGlobal._CATEGORY	.__destroy();
			_gnncGlobal._SERIES		.__destroy();

			//clear
			_gnncGlobal._PERMISSION	.__clear();
			_gnncGlobal._PERMISSION_SET	.__clear();
			_gnncGlobal._SETTINGS	.__clear();
			_gnncGlobal._DEPARTAMENT.__clear();
			_gnncGlobal._GROUP		.__clear();
			_gnncGlobal._CATEGORY	.__clear();
			_gnncGlobal._SERIES		.__clear();

			//permission
			gnncGlobalStatic._userPermission = null;
			gnncGlobalStatic._userPermissionSet = null;
			
			//restart
			__reload();
		}

		private function __loadImageComplete(e:*):void
		{
			gnncGlobalStatic._documentPdfLogo	= new ByteArray();
			gnncGlobalStatic._documentPdfLogo	= _gnncFilesRemote._DATA_CONTENT as ByteArray;
			
			//gnncGlobalLog.__add(gnncGlobalStatic._documentPdfLogo);
		}

		private function __loadImageError(e:*):void
		{
			gnncGlobalStatic._documentPdfLogo	= null;

		}
		
	}
}
