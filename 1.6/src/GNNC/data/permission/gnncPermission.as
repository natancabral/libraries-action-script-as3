package GNNC.data.permission
{
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.UI.gnncNotification.gnncNotificationConst;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;

	public class gnncPermission
	{
		[Embed(source='image/shield-48.png')]
		static public const shield_48:Class;
		
		[Embed(source='image/shield-32.png')]
		static public const shield_32:Class;
		
		[Embed(source='image/shield-16.png')]
		static public const shield_16:Class;

		private static const _try:Boolean = false;
		private var _parent:Object;
		
		public static const _alertTitle:String          = 'Permissão Negada';
		public static const _alertNoPermission:String   = 'Você não tem permissão para executar esta ação.';

		public static const _alertTitleNoAllowed:String = 'Integridade';
		public static const _alertNoAllowed:String      = 'Não é permitido este tipo de operação para manter a integridade do sistema.';

		public static const _alertErrorConfig:String    = 'As configurações de permissões estão incorretas.\nEntre em contato com administrador do aplicativo.';
		public static const _alertErrorConflict:String  = 'As permissões estão em conflito, por este motivo você não terá permissão para acessar.\nEntre em contato com administrador do aplicativo.';
		
		public function gnncPermission(parentApplication_:Object=null)
		{
			_parent = parentApplication_ ? parentApplication_ : gnncGlobalStatic._parent;
		}

		public static function __notify(title_:String,message_:String):void
		{
			var n:gnncNotification = new gnncNotification();
			n.__show(
				title_,
				message_,
				shield_32,
				null,false,false,true,true,
				gnncNotificationConst.DISPLAY_LENGTH_SHORT,
				gnncNotificationConst.DISPLAY_LOCATION_TOP_RIGHT,
				null
			);
		}

		public static function __alert():void
		{
			__notify(_alertTitle,_alertNoPermission);
		}
		
		public static function __alertAlt(start:String='',end:String=''):void
		{
			__notify(_alertTitle,start+' '+_alertNoPermission+' '+end);
		}
		
		public static function __alertSystemNoAllowed():void
		{
			__notify(_alertTitleNoAllowed,_alertNoAllowed);
		}

		/**
		 * __access($module,$type,$value);
		 * **/
		public static function __json2objectPermission(json_:String):Boolean
		{
			//var jsonString:String = '{"idProgram":9,"idGroup":57,"permission":{"module-account":{"a":1,"n":0,"e":0,"v":0,"d":1},"account-safes":{"a":0,"n":0,"e":0,"v":0,"d":1},"safe-in":{"a":1,"n":1,"e":1,"v":1,"d":1},"safe-out":{"a":0,"n":0,"e":0,"v":0,"d":1},"safe-trans":{"a":0,"n":0,"e":0,"v":0,"d":1},"safe-final":{"a":0,"n":0,"e":0,"v":0,"d":1},"module-safe":{"a":0,"n":0,"e":0,"v":0,"d":1},"module-report":{"a":0,"n":0,"e":0,"v":0,"d":1},"module-group":{"a":1,"n":1,"e":1,"v":1,"d":1}}}';
			//json_ = jsonString;
			//gnncGlobalLog.__add(json_);
			//new gnncAlert(gnncGlobalStatic._parent).__alert(json_+'!!','!!');

			//temp
			//var jsonString:String = '{"idProgram":9,"idGroup":57,"permission": { "module-course":{"a":1,"n":1,"e":0,"v":0,"d":0}, "course-attach":{"a":0,"n":0,"e":0,"v":0,"d":0}, "course-discipline":{"a":0,"n":0,"e":1,"v":1,"d":0}, "course-discipline-teacher":{"a":0,"n":0,"e":0,"v":0,"d":0}, "course-set-student":{"a":0,"n":1,"e":0,"v":0,"d":0}, "course-set-teacher":{"a":0,"n":0,"e":0,"v":0,"d":0}, "module-course-student":{"a":1,"n":0,"e":0,"v":0,"d":0}, "course-student-attach":{"a":0,"n":0,"e":0,"v":0,"d":0}, "module-course-teacher":{"a":0,"n":1,"e":1,"v":0,"d":0}, "course-teacher-attach":{"a":0,"n":0,"e":0,"v":0,"d":0} } }';
			//var object:Object = gnncJSON.decode( jsonString );
			//var arrayC:ArrayCollection = gnncDataObject.__object2ArrayCollection(object);
			//var array:Array = [];
			//var obj:Object;
			//for( var prop:String in obj )
			//array.push( obj[prop] );

			var result:Object = null;

			if(json_)
			  result = JSON.parse(json_);
			//trace(ObjectUtil.getClassInfo(result.permission));
			//trace(result.permission['module-course']);  //traces "Analysis1"
			
			if(!result)
				return true;
			
			if(!result.hasOwnProperty('permission'))
				return true;
			
			//workflow is the root node of your structure
			var workflow:Object = result.permission;
			//iterate the keys in the 'workflow' object
			
			/** TESTE WORKS!! **/
			/*for (var key:String in workflow) 
			{
				var b:Object = workflow[key];
				for (var key2:String in b) {
					trace(key + ' : ' + key2 + ' : ' + b[key2]);
					//arra[key][key2] = b[key2];
				}
			}*/
			
			gnncGlobalStatic._userPermission = workflow;

			//trace(workflow['module-course']['m']+'-1');
			//trace(workflow['module-course']['n']+'-2');
			//trace(workflow['module-course']['e']+'-3');
			
			return true;
		}

		/**
		 * $host = module-safe, safe-in,
		 * $type = m,e,d,v,n,
		 * __access($module,$type,$value);
		 * **/
		public static function __access(host_:String,type_:String,showAlert_:Boolean=false,defaultReturn_:Boolean=true):Boolean
		{
			var workflow:Object = gnncGlobalStatic._userPermission;
			
			if(!workflow){
				if(_try)
					gnncGlobalLog.__add('permission:'+'noRules');
				return defaultReturn_;
			}
			
			if(!workflow.hasOwnProperty(host_)){
				if(_try)
					gnncGlobalLog.__add('permission:'+'noHost['+host_+']');
				return defaultReturn_;
			}

			if(!workflow[host_].hasOwnProperty(type_)){
				if(_try)
					gnncGlobalLog.__add('permission:'+'noType['+type_+']');
			    return defaultReturn_;
		    }			
			
			if(uint(workflow[host_][type_])===1){
				if(_try)
					gnncGlobalLog.__add('permission:'+'allowed['+host_+':'+type_+']');
				return true;
			} else if(uint(workflow[host_][type_])===0) {
				if(_try)
					gnncGlobalLog.__add('permission:'+'restrict['+host_+':'+type_+']');
				if(showAlert_){
				    //new gnncAlert(gnncGlobalStatic._parent).__alert(_alertNoPermission);
					__alert();
				}
				return false;
			}
			
			//trace(arra.toString());
			//template: Analysis1
			//start: [Object]
			//host: [Object]
			//...
			
			return defaultReturn_;
		}
		
		/**
		 * programName_ :
		 *     Default value : null (get of the system)
		 * 
		 * moduleName_ : Module Name setted the function
		 * 
		 * localNameToAccess_ : Name set in top begin function, type name permission
		 *
		 * Sample 1: __access(project,moduleProject,newClient);
		 * Sample 2: __access(MONEY,MODULE_FINANCIAL_SAFE,NEW_FINANCIAL);
 		 * **/
		/*
		public static function __accessAdvanced(programName_:String,moduleName_:String,hostName_:String,mixName_:String):Boolean
		{
			var _permissionClone:ArrayCollection 	= null;
			var _permissionFinal:Object				= null;
			var _programId:uint 					= 0;
			var _keyPermission:String				= gnncMD5.hash(gnncMD5.hash(_programId+moduleName_+hostName_)+'GNNC').substr(0,10);
			
			programName_ 							= programName_ ? programName_ : gnncGlobalStatic._programName;
			_programId								= gnncGlobalArrays.__programId(programName_);
			_permissionClone						= gnncDataObject.__object2ArrayCollection(gnncData.__clone(gnncGlobalStatic._userPermission));
			
			//new gnncAlert().__alert('p:'+programName_+',pId:'+_programId+',m:'+moduleName_+',h:'+hostName_);
			//new gnncAlert().__textArea(_keyPermission+'<<KEY');
			//new gnncAlert().__dataGrid(_permissionClone,'PRIMEIRO');
			
			if(!_programId || !programName_ || !hostName_)
			{
				new gnncAlert().__error(_alertErrorConfig,_alertTitle);
				return false;
			}
			
			_permissionClone = new ArrayCollection(new gnncDataArrayCollection().__filter(_permissionClone,'NAME_HOST',hostName_).toArray());
			_permissionClone = new ArrayCollection(new gnncDataArrayCollection().__filter(_permissionClone,'NAME_MODULE',moduleName_).toArray());
			_permissionClone = new ArrayCollection(new gnncDataArrayCollection().__filterNumeric(_permissionClone,'ID_PROGRAM',_programId).toArray());
			
			//new gnncAlert().__dataGrid(_permissionClone,'SEGUNDO');

			if(_permissionClone.length==1)
			{
				_permissionFinal = _permissionClone.getItemAt(0);
				
				if(
					_permissionFinal.NAME_HOST 		== hostName_ 	&&
					_permissionFinal.NAME_MODULE 	== moduleName_ 	&&
					_permissionFinal.ID_PROGRAM 	== _programId	&&
					_permissionFinal.KEY_PERMISSION == _keyPermission
				)
				{
					//Great! You have permission
					return true;
				}
				else
				{
					//Ohh gosh, no!
					new gnncAlert().__error(_alertNoPermission,_alertTitle);
					return false;
				}
				
			}
			else if(_permissionClone.length>1)
			{
				//Ohh gosh, no!
				new gnncAlert().__error(_alertErrorConflict,_alertTitle);
				return false;
			}
			else
			{
				//Ohh gosh, no!
				new gnncAlert().__error(_alertNoPermission,_alertTitle);
				return false;
			}

			return false;
		}
		*/

		public static function __blockModule(this_:Object,host_:String,visible_:Boolean=true,defaultReturn_:Boolean=true):Boolean
		{
			if(!__access(host_,'a',false,defaultReturn_)){
				this_.enabled = false;
				this_.visible = visible_;
				if(_try)
					gnncGlobalLog.__add('permission:'+'blockModule:false');
				return false;
			}
			if(_try)
				gnncGlobalLog.__add('permission:'+'blockModule:true');
			this_.enabled = true;
			this_.visible = true; //true ever
			return true;
		}
		
		public static function __blockApplication(parent_:Object,programName_:String=null):Boolean
		{
			return false;
		}

	}
}