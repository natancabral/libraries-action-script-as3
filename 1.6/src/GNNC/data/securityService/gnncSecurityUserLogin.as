package GNNC.data.securityService
{
	import GNNC.data.data.json.gnncJSON;
	import GNNC.data.encrypt.gnncMD5;
	import GNNC.data.globals.gnncGlobalStatic;

	public class gnncSecurityUserLogin
	{
		public var _key:String				= '';
		public var _keySql:String			= '';
		public var _breakSql:String;
		public var _programName:String		= '';
		public var _programId:uint			= 0;
		public var _programVersion:String	= '';
		public var _clientIdGeneral:uint	= 0;
		public var _userIdGeneral:uint		= 0;
		public var _dataBase:String			= '';

		public var _usernameAUTH:String 	= '';
		public var _passwordAUTH:String 	= '';
		public var _keyLoginAUTH:String 	= '';

		public var _data:String = '[{}]';

		//public var _className:String 		= '_gnncAmfPhp';
		
		public function gnncSecurityUserLogin(u:String='',p:String='')
		{
			var d:Date = new Date();
			
			u = u
			.replace(' ','' )
			.replace('%','-')
			.replace(';','-')
			.replace('"','-')
			.replace("'","-")
			.replace("`","-")
			.replace("´","-")
			.replace("insert","-")
			.replace("delete","-")
			.replace("update","-")
			.replace("show","-")
			.replace("select","-")
			.replace("\\","-")
			.replace("/","-");

			p = p
			.replace(' ','' )	
			.replace('%','-')
			.replace(';','-')
			.replace('"','-')
			.replace("'","-")
			.replace("`","-")
			.replace("´","-")
			.replace("insert","-")
			.replace("delete","-")
			.replace("update","-")
			.replace("show","-")
			.replace("select","-")
			.replace("\\","-")
			.replace("/","-");

			_usernameAUTH = u;
			_passwordAUTH = p.length < 25 ? gnncMD5.hash(gnncMD5.hash(p) + 'GNNC' ) : p;
			_keyLoginAUTH = gnncMD5.hash( d.month +  'GNNC' + d.day + 'DAYBYDAY' + d.date ); //nocheck
			
			if(_usernameAUTH && _passwordAUTH)
			{
				_key						= gnncGlobalStatic._keyClient;
				_keySql						= gnncGlobalStatic._keySql;
				_breakSql					= gnncGlobalStatic._breakSql;
				_programName				= gnncGlobalStatic._programName;
				_programId					= gnncGlobalStatic._programId; 
				_programVersion 			= gnncGlobalStatic._programVersion;
				_clientIdGeneral			= gnncGlobalStatic._clientGeneralId;
				_userIdGeneral				= gnncGlobalStatic._userId;
				_dataBase					= gnncGlobalStatic._dataBase;
				
				var _o:Object = new Object();
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