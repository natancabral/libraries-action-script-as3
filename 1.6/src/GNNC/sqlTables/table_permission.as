package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_permission
	{
		public var _KEY:String;
		public var _KEY_SQL:String;
		public var _BREAK_SQL:String;
		public var _PROGRAMNAME:String;
		public var _PROGRAMID:uint;
		public var _PROGRAMVERSION:String;
		public var _CLIENTIDGENERAL:uint;
		public var _USERIDGENERAL:uint;
		public var _DATABASE:String;

		public var _TABLE:String 			= 'PERMISSION';
		
		/**
		 * !!ATTENCION""
		 * For access application at login: 
		 * ID_PROGRAM: 	# 			-> Id of Program
		 * ID_GROUP: 	# 			-> Of the User
		 * NAME_MODULE: 'ACCESS'
		 * NAME_HOST: 	'true'/'false'
		 *  **/
		
		public var ID:uint					= 0;
		public var ID_PROGRAM:uint			= 0;
		public var ID_GROUP:uint			= 0;
		public var NAME_MODULE:String		= '';
		public var NAME_HOST:String			= '';
		
		public var PERMISSION:String		= '';//json
		
		public var KEY_PERMISSION:String	= '';
		
		/*public var ACC:uint;				//access of program
		
		public var SEL:uint;				//select
		public var INS:uint;				//insert
		public var UPD:uint;				//update
		public var DEL:uint;				//delete

		public var MAI:uint;				//mail send 

		public var ATT:uint;				//attach file - read and down
		public var ATS:uint;				//attach file - send

		public var USR:uint;				//create new user permission

		public var SHO:uint; 				//active show in SQL*/

		public function table_permission(ID_:uint=0)
		{
			ID = ID_;
			table_info();
		}
		
		public function table_info():void
		{
			if(_TABLE)
			{
				_KEY						= gnncGlobalStatic._keyClient;
				_KEY_SQL					= gnncGlobalStatic._keySql;
				_BREAK_SQL					= gnncGlobalStatic._breakSql;

				_PROGRAMNAME				= gnncGlobalStatic._programName;
				_PROGRAMID					= gnncGlobalStatic._programId; _PROGRAMVERSION = gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL			= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL				= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
			}
		}
	}
}