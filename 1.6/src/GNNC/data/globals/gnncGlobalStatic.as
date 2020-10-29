package GNNC.data.globals
{
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncDataRand;
	import GNNC.data.encrypt.gnncMD5;
	
	import flash.utils.ByteArray;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.IVisualElement;

	public class gnncGlobalStatic
	{

		/** ********************************************************* **/
		/** STATIC ACCESS ******************************************* **/
		/** ********************************************************* **/

		/** debug **/
		static public var _debug:Boolean					= false; //for test, the new try

		/** token authentic **/
		static public var _keyClient:String					= gnncMD5.hash('NATANCABRAL');		//Key Cliente Databse Permission
		static public var _keySql:String					= gnncMD5.hash('GNNC-DAYBYDAY');	//Key SQL Work
		static public var _breakSql:String					= '[;BREAK;]';//'[;BREAK;]' or ;					//Break SQL
		
		/** program values **/
		static public var _programVersion:String 			= '';							//Program Version Number
		static public var _programId:uint 					= 0;							//Program ID
		static public var _programName:String				= '';							//Program Name Open/Work
		static public var _programIcon16:Object				= null;
		static public var _programIcon32:Object				= null;
		static public var _programIcon48:Object				= null;
		static public var _programIcon74:Object				= null;
		static public var _programIcon128:Object			= null;

		/** client - access values **/
		static public var _clientGeneralId:uint				= 0;
		static public var _clientGeneralName:String 		= '';
		static public var _clientGeneralEmail:String 		= '';
		
		static public var _userAdmin:Boolean				= false;						//User admin false
		static public var _userClient:Boolean				= false;						//User admin false
		static public var _userId:uint						= 0;							//User ID user
		static public var _userIdClient:uint				= 0;							//User ID client
		static public var _userNameClient:String			= '';							//User ClientName
		static public var _userNameLogin:String				= '';							//User LoginName
		static public var _userEmail:String					= '';							//User Email
		static public var _userBirthday:String				= '';							//User Data BirthDay
		static public var _userIdGroupPermission:uint		= 0;							//User id Group Permission
		static public var _userPermission:Object	         = null;						//User Permission Access
		static public var _userPermissionSet:ArrayCollection = null;                        //All PermissionSet Access
		
		/*
		case 'ID_COURSE':						break;
		case 'ID_GROUP_CLIENT_PROFESSIONAL':	break;
		case 'ID_GROUP_CLIENT_PATIENT':			break;
		case 'ID_GROUP_CLIENT_THEATER':			break;
		case 'ID_GROUP_PRODUCT_DIAGNOSTIC':		break;
		case 'ID_GROUP_PRODUCT_TREATMENT':		break;
		*/

		/** groups **/
		static public var _idCourse:uint					= 0;
		static public var _idGroupClientProfessional:uint 	= 0;
		static public var _idGroupClientPatient:uint 		= 0;
		static public var _idGroupClientTheater:uint 		= 0;

		/** client - Images **/
		static public var _documentPdfLogo:ByteArray		= null; 						//500 x 168
		static public var _documentPdfCompany:String		= ''; 							//Gnnc
		static public var _documentPdfDescription:String	= ''; 							//Estratégia Empresarial
		static public var _documentPdfReceipt:String		= ''; 							//CNPJ, Address, ZipCode

		/** connection DAYBYDAY **/
		static public var _dataBase:String 					= '';							//NickName (NAME) of de DataBase
		static public var _dataBaseTry:Boolean 				= false;						//Base de Teste
		static public var _serverName:String				= '';							//Server connection (ARRAYS.as)
		static public var _httpHost:String					= '';							//URL connection (ARRAYS.as)
		static public var _httpDomain:String				= '';							//URL domain
		static public var _dateToday:Date					= null;							//date server
		
		/** system Values Static **/
		static public var _parent:Object					= null;							//parentApplication for Classes
		static public var _popUpAlertIsOpen:Boolean			= false;						//Open or Close
		static public var _popUpOpenList:Array				= new Array();					//PopUpManager List
		static public var _popUpOpenAlert:Array				= new Array();					//PopUpManager Alert
		static public var _popDisplayIconTry:IVisualElement = null;

		/** Educ Change - Temporary **/
		static public var _courseTableName:String           = 'dbd_project'; //dbd_course
		static public var _courseColumnName:String          = 'ID_PROJECT'; //ID_COURSE

		
		/** ********************************************************* **/
		/** BINDABLE ACCESS ***************************************** **/
		/** ********************************************************* **/
		
		/** system Values **/
		[Bindable] public var _session:Number				= 0;							//For __reload() and change/enter loginAccess
		static public var loading:Boolean				= false;						//Loading global, all connections on-line
		static public var connections:uint				= 0;							//No work! Count all Connection

		/** general values in database **/
		[Bindable] public var _PERMISSION:gnncAMFPhp		= new gnncAMFPhp();
		[Bindable] public var _PERMISSION_SET:gnncAMFPhp	= new gnncAMFPhp();
		[Bindable] public var _SETTINGS:gnncAMFPhp			= new gnncAMFPhp();
		[Bindable] public var _DEPARTAMENT:gnncAMFPhp		= new gnncAMFPhp();
		[Bindable] public var _GROUP:gnncAMFPhp				= new gnncAMFPhp();
		[Bindable] public var _CATEGORY:gnncAMFPhp			= new gnncAMFPhp();
		[Bindable] public var _SERIES:gnncAMFPhp			= new gnncAMFPhp();
		[Bindable] public var _FINANCIAL_ACCOUNT:gnncAMFPhp	= new gnncAMFPhp(); //contas bancárias
		[Bindable] public var _FINANCIAL_SELLER:gnncAMFPhp	= new gnncAMFPhp(); //vendedores

		//[Bindable] public var changeClient:Date             = null;
		//[Bindable] public var changeProject:Date            = null;
		//[Bindable] public var changeStep:Date               = null;
		
		public function gnncGlobalStatic(bindable_:Boolean=false)
		{
			super();
			
			if(bindable_ && FlexGlobals.topLevelApplication.hasOwnProperty('_START'))
			{
				BindingUtils.bindProperty(this,'_session',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_session');
				//BindingUtils.bindProperty(this,'_loading',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_loading');
				//BindingUtils.bindProperty(this,'_connections',			FlexGlobals.topLevelApplication._START._gnncGlobal,'_connections');
				
				BindingUtils.bindProperty(this,'_PERMISSION',			FlexGlobals.topLevelApplication._START._gnncGlobal,'_PERMISSION');
				BindingUtils.bindProperty(this,'_PERMISSION_SET',		FlexGlobals.topLevelApplication._START._gnncGlobal,'_PERMISSION_SET');
				BindingUtils.bindProperty(this,'_SETTINGS',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_SETTINGS');
				BindingUtils.bindProperty(this,'_DEPARTAMENT',			FlexGlobals.topLevelApplication._START._gnncGlobal,'_DEPARTAMENT');
				BindingUtils.bindProperty(this,'_GROUP',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_GROUP');
				BindingUtils.bindProperty(this,'_CATEGORY',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_CATEGORY');
				BindingUtils.bindProperty(this,'_SERIES',				FlexGlobals.topLevelApplication._START._gnncGlobal,'_SERIES');
				BindingUtils.bindProperty(this,'_FINANCIAL_ACCOUNT',	FlexGlobals.topLevelApplication._START._gnncGlobal,'_FINANCIAL_ACCOUNT');
				BindingUtils.bindProperty(this,'_FINANCIAL_SELLER',		FlexGlobals.topLevelApplication._START._gnncGlobal,'_FINANCIAL_SELLER');
				
				//BindingUtils.bindProperty(this,'changeClient',			FlexGlobals.topLevelApplication._START._gnncGlobal,'changeClient');
				//BindingUtils.bindProperty(this,'changeProject',			FlexGlobals.topLevelApplication._START._gnncGlobal,'changeProject');
				//BindingUtils.bindProperty(this,'changeStep',			FlexGlobals.topLevelApplication._START._gnncGlobal,'changeStep');
			}
		}

		static public function __set(variable_:String,value_:Object):void
		{
			var obj:Object = gnncGlobalStatic;
			
			if(obj.hasOwnProperty(variable_))
				gnncGlobalStatic[variable_] = value_;
		}

		static public function __get(variable_:String):Object
		{
			var obj:Object = gnncGlobalStatic;
			
			if(obj.hasOwnProperty(variable_))
				return gnncGlobalStatic[variable_];
			else
				return 0;
		}

		public function __set(variable_:String,value_:Object):void
		{
			 if(!FlexGlobals.topLevelApplication.hasOwnProperty('_START'))
				 return;
			 
			if(FlexGlobals.topLevelApplication._START._gnncGlobal.hasOwnProperty(variable_))
				FlexGlobals.topLevelApplication._START._gnncGlobal[variable_] = value_;
		}

		public function __get(variable_:String):Object
		{
			if(!FlexGlobals.topLevelApplication.hasOwnProperty('_START'))
				return 0;
			
			if(FlexGlobals.topLevelApplication._START._gnncGlobal.hasOwnProperty(variable_))
				return FlexGlobals.topLevelApplication._START._gnncGlobal[variable_];
			else
				return 0;
		}

		static public function __createNewSession():void
		{
			/** Create Session **/
			if(FlexGlobals.topLevelApplication.hasOwnProperty('_START')) //no request
				FlexGlobals.topLevelApplication._START._gnncGlobal._session = gnncDataRand.__number(111111,999999);
			
			if(FlexGlobals.topLevelApplication.hasOwnProperty('__begin'))
				FlexGlobals.topLevelApplication.__begin();
		}
		
		static public function __reload():void
		{
			if(FlexGlobals.topLevelApplication.hasOwnProperty('_START')) //no request
				FlexGlobals.topLevelApplication._START.__reload();
		}

		static public function getSessionId():Number
		{
			return FlexGlobals.topLevelApplication._START._gnncGlobal._session;
		}

	}
}