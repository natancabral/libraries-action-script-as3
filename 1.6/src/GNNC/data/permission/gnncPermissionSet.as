package GNNC.data.permission
{
	import GNNC.data.data.gnncData;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.collections.ArrayCollection;

	public class gnncPermissionSet
	{
		private var _parent:Object;

		public function gnncPermissionSet(parentApplication_:Object=null)
		{
			_parent = parentApplication_ ? parentApplication_ : gnncGlobalStatic._parent;
		}

		public static function __getArray(mix_:Object,property_:Object='ID'):Array
		{
			var s:String = __get(mix_,property_);
			return s?[s]:null; 
		}
		
		public static function __get(mix_:Object,property_:Object='ID'):String
		{
			//gnncGlobalLog.__add('#############################'+gnncGlobalStatic._userPermissionSet.length+'|'+gnncGlobalStatic._userId+'|'+gnncGlobalStatic._userIdGroupPermission+'','permissionSet');

			//gnncGlobalLog.__add('(1):idUser:'+gnncGlobalStatic._userId+':idGroupPermission:'+gnncGlobalStatic._userIdGroupPermission); 
			if(!gnncGlobalStatic._userPermissionSet)
				return '';
			
			//gnncGlobalLog.__add('2');
			var _arr:ArrayCollection                  = new ArrayCollection(gnncData.__clone(gnncGlobalStatic._userPermissionSet.source) as Array);
			var _arrFilter:ArrayCollection            = new ArrayCollection();
			
			if(!_arr)
				return '';
			//gnncGlobalLog.__add('3');
			
			var _arrLen:uint = _arr.length;
			var _value:String;
			var _obj:Object;
			var _in:Boolean = true; 
			
			if(!_arrLen)
				return '';
			//gnncGlobalLog.__add('4');
			
			for(var i:uint=0;i<_arrLen;i++){
				_obj = _arr.getItemAt(i);
				if(_obj.MIX == mix_ && _obj.PROPERTY == property_ && _obj.VALUE){
					//gnncGlobalLog.__add(_obj.MIX+mix_+_obj.PROPERTY+property_+_obj.VALUE,'add');
					//gnncGlobalLog.__add(_obj.ID_USER+'|'+gnncGlobalStatic._userId,'USER###############');
					//gnncGlobalLog.__add(_obj.ID_GROUP_PERMISSION+'|'+gnncGlobalStatic._userIdGroupPermission,'PERIMISSION##############');
					if(_obj.ID_USER == gnncGlobalStatic._userId){
						_arrFilter.addItem(_obj);
						i = 100;
					}else if(_obj.ID_GROUP_PERMISSION == gnncGlobalStatic._userIdGroupPermission){
						_arrFilter.addItem(_obj);
						i = 100;
					}
				}
			}
			//gnncGlobalLog.__add('5');

			if(!_arrFilter.length)
				return '';
			//gnncGlobalLog.__add('6');

			if(uint(_arrFilter.getItemAt(0).IN_NOTIN) == 1 && uint(_arrFilter.getItemAt(0).IN_NOTIN) != 0)
				_in = true;
			else
				_in = false;

			//gnncGlobalLog.__add('7');

			_value = String(_arrFilter.getItemAt(0).VALUE).split(',').join(',');
			//_value = _value.substr(-1,1)==','?_value.substring(0,_value.length-1):_value;
			return " "+String(property_).toUpperCase()+" "+(_in?' IN ':' NOT IN ')+" ("+_value+") ";

			//###############################################################################################################
			//TERMINA AQUI
			//###############################################################################################################
			//###############################################################################################################
			//new gnncAlert(FlexGlobals.topLevelApplication.parent).__dataGrid(_arr,'1');
			//new gnncAlert(FlexGlobals.topLevelApplication.parent).__dataGrid(_arrMix,'2');
			//new gnncAlert(FlexGlobals.topLevelApplication.parent).__dataGrid(_arrayPermissionSet,'3');

			var _arrIdUser:ArrayCollection            = new ArrayCollection();
			var _arrIdGroupPermission:ArrayCollection = new ArrayCollection();

			if(!_arrFilter)
				return '';

			if(!_arrFilter.length)
				return '';
			
			for(var e:uint=0;e<_arrFilter.length;e++){
				_obj = _arrFilter.getItemAt(e);
				if(_obj.ID_USER == gnncGlobalStatic._userId){
					_arrIdUser.addItem(_obj);
				}else if(_obj.ID_GROUP_PERMISSION == gnncGlobalStatic._userIdGroupPermission){
					_arrIdGroupPermission.addItem(_obj);
				}
			}

			if(!_arrIdUser.length || !_arrIdGroupPermission.length)
				return '';

			//_values = String(_arrMix.getItemAt(0).VALUE).split(',');
			//_value  = _values.join(',');
			
			if(_arrIdUser.length==1)
				_value = String(_arrIdUser.getItemAt(0).VALUE);
			else if(_arrIdGroupPermission.length==1)
				_value = String(_arrIdGroupPermission.getItemAt(0).VALUE);
			
			if(!_value) 
				return ''; //se os valores forem vazios entao nao retorna nada
			
			_value = _value.substr(-1,1)==','?_value.substring(0,_value.length-1):_value;
			return " "+String(property_).toUpperCase()+" IN ("+_value+") ";

			return '';
		}
		
		public static function __getSql(idGroupPermission_:Object,idUser_:Object,mix_:Object,property_:Object,values_:Object):String
		{
			var _sql:String = '';
			var _in:Boolean = true;

			if(!property_)
				property_ = 'ID';
			
			idGroupPermission_;
			idUser_;
			mix_;
			property_;
			values_;
			
			_sql = " ID IN ("+1+") ";
			
			return _sql;
		}

	}
}