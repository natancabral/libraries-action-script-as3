package GNNC.sqlTables
{
	import GNNC.data.data.json.gnncJSON;
	import GNNC.data.globals.gnncGlobalStatic;
	
	[Bindable]
	public dynamic class table_
	{
		public var _KEY:String				= '';
		public var _KEY_SQL:String			= '';
		public var _BREAK_SQL:String		= '';
		public var _PROGRAMNAME:String		= '';
		public var _PROGRAMID:uint			= 0;
		public var _PROGRAMVERSION:String	= '';
		public var _CLIENTIDGENERAL:uint	= 0;
		public var _USERIDGENERAL:uint		= 0;
		public var _DATABASE:String			= ''
		
		public var _data:String	            = '';
		private var _o:Object               = null;
			
		public var _TABLE:String 		    = '';
		public var ID:uint				    = 0;
		
		public function table_(id_:uint=0)
		{
			ID = id_;
			table_data();
		}
		
		public function table_data():void
		{
			if(_TABLE)
			{
				_KEY						= gnncGlobalStatic._keyClient;
				_KEY_SQL					= gnncGlobalStatic._keySql;
				_BREAK_SQL					= gnncGlobalStatic._breakSql;
				_PROGRAMNAME				= gnncGlobalStatic._programName;
				_PROGRAMID					= gnncGlobalStatic._programId; 
				_PROGRAMVERSION 			= gnncGlobalStatic._programVersion;
				_CLIENTIDGENERAL			= gnncGlobalStatic._clientGeneralId;
				_USERIDGENERAL				= gnncGlobalStatic._userId;
				_DATABASE					= gnncGlobalStatic._dataBase;
				
				_o = new Object();
				_o.keyServer    = ''; //token accept
				_o.keyClient    = gnncGlobalStatic._keyClient;
				_o.keySql       = gnncGlobalStatic._keySql;
				_o.breakSql     = gnncGlobalStatic._breakSql;
				_o.progName     = gnncGlobalStatic._programName;
				_o.progId       = gnncGlobalStatic._programId;
				_o.progVersion  = gnncGlobalStatic._programVersion;
				_o.companyUnit  = ''; //filial
				_o.userId       = gnncGlobalStatic._userId;
				_o.userIdClient = gnncGlobalStatic._clientGeneralId;
				_o.dbn          = gnncGlobalStatic._dataBase; //sigla
				
				_data = gnncJSON.encode(_o);
			}
		}
	}
}