package GNNC.data.data
{
	import GNNC.data.date.gnncDate;
	
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.XMLListCollection;
	import mx.core.INavigatorContent;
	import mx.rpc.xml.QualifiedResourceManager;
	import mx.utils.ArrayUtil;
	import mx.utils.ObjectUtil;
	
	public class gnncDataObject
	{
		private var _parent:Object = null;
		
		public function gnncDataObject(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		
		public static function __object2URLVariables(parameters_:Object):URLVariables 
		{
			var paramsToSend:URLVariables = new URLVariables();
			
			for(var i:String in parameters_)
			{
				if(i!=null && i!='') 
				{
					if(parameters_[i] is Array) 
						paramsToSend[i] = parameters_[i];
					else 
						paramsToSend[i] = parameters_[i].toString();
				}
			}
			return paramsToSend;
		}
		
		static public function __object2ArrayCollection(Obj_:Object):ArrayCollection 
		{
			var _arrayC:ArrayCollection = new ArrayCollection();
			
			for (var _num:String in Obj_)
				_arrayC.addItem(Obj_[_num]);
			
			//GET_COLLECTION.filterFunction = __FILTER_FUNCTION_ARRAYCOLLECTION;
			//GET_COLLECTION.refresh();
			
			return _arrayC;
		}
		
		static private function __FILTER_FUNCTION_ARRAYCOLLECTION(item:Object):Boolean 
		{
			var OBJ:Object = ObjectUtil.getClassInfo(item);
			var O:Object = {};
			O[OBJ.properties[0].localName] = (!item[OBJ.properties[0].localName])?'[Nenhum]':item[OBJ.properties[0].localName];
			return O;
		}
		
		static public function __object2XML(object_:Object,blankValue_:String='null',setNumberItem_:Boolean=false,nodeFather_:String='dbd',nodeChild_:String='item'):XML 
		{
			var _xmlFile:XML = <{nodeFather_}></{nodeFather_}>;
			var _value:String = '';
			
			for (var _number:String in object_) 
			{
				if(setNumberItem_)
					_xmlFile.appendChild(<{nodeChild_} itemNumber={_number}></{nodeChild_}>);
				else
					_xmlFile.appendChild(<{nodeChild_}></{nodeChild_}>);
				
				for (var _name:String in object_[_number]) 
				{
					_value = object_[_number][_name];
					_value = !gnncData.__trimText(_value) ? blankValue_ : gnncData.__trimText(_value) == 'null' ? blankValue_ : _value;
					
					if(_name.toString().substr(0,3) == 'ROW' || _name.toString().substr(0,3) == 'ID_')
						_xmlFile.item[_number].attribute(_name.toString())[_number] = _value;
					
					else if(_name.toString().substr(0,4) == 'DATE')
						_xmlFile.item[_number].appendChild(<{_name}>{gnncDate.__date2Legend(_value)}</{_name}>);
					
					else
						_xmlFile.item[_number].appendChild(<{_name}>{_value}</{_name}>);
				}
			}
			
			/*
			var qName:QName = new QName("root");
			var xmlDocument:XMLDocument = new XMLDocument();
			var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
			var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
			var xml:XML = new XML(xmlDocument.toString());
			// trace(xml.toXMLString());
			*/
			
			return _xmlFile;
		}

		static public function __getPropertysNamesAMFPhp(object_:Object,excludePrefixWith_:String='',returnTooValues_:Boolean=false):Array
		{
			var _array2:Array 	= new Array();
			var _numb2:String	= '';
			var _name2:String	= '';
			var _value2:Object 	= new Object();
			var i:uint 			= 0;
			
			for (_numb2 in object_)
			{
				for (_name2 in object_[_numb2])
				{
					_value2 = object_[_numb2][_name2];
					
					//if(_value != false && _value != null)
					if(!excludePrefixWith_)
					{
						_array2.push(_name2);
						
						if(returnTooValues_) 
							_array2.push(_value2?_value2:'');
					}
					else if(_name2.slice(0,excludePrefixWith_.length) != excludePrefixWith_) //&& EXCLUDE_COLUMNS_.indexOf(NAM) == -1)
					{
						_array2.push(_name2);
						
						if(returnTooValues_) 
							_array2.push(_value2?_value2:'');
					}

				}
				//First values
				return _array2;
			}
			//All values
			return _array2;
		}
		
		/**
		 * 
		 * returnTooValues_ = FALSE
		 * 
		 * Array("property_1","property_2","property_3");
		 * 
		 * returnTooValues_ = TRUE
		 * 
		 * Array("property_1","value_1","property_2","value_2","property_3","value_3");
		 * 
		 * **/
		static public function __getPropertysNames(object_:Object,excludePrefixWith_:String='',returnTooValues_:Boolean=false):Array
		{
			if(!object_)
				return new Array();

			var _array:Array 	= new Array();
			var _obj:Object 	= ObjectUtil.getClassInfo(object_);
			var _name:String 	= '';
			var _value:Object 	=  new Object();
			var i:uint 			= 0;
			
			if(_obj.properties.length < 1)
				return new Array();

			for(i = 0; i<_obj.properties.length; i++)
			{
				if(!_obj.properties[i].hasOwnProperty('localName'))
					continue;
				
				_name 	= _obj.properties[i].localName;
				_value 	= object_[_obj.properties[i].localName];
				
				//if(_value != false && _value != null)
				if(!excludePrefixWith_)
				{
					_array.push(_name);
					
					if(returnTooValues_) 
						_array.push(_value?_value:'');
				}
				else if(_name.slice(0,excludePrefixWith_.length) != excludePrefixWith_) //&& EXCLUDE_COLUMNS_.indexOf(NAM) == -1)
				{
					_array.push(_name);

					if(returnTooValues_) 
						_array.push(_value?_value:'');
				}
			}
			
			return _array;
		}

		static public function __getTotalAMFPhp(object_:Object):uint 
		{
			var len:uint = 0;
			
			for (var item:* in object_)
				if (item != "mx_internal_uid")
					len++;
				//else
					//len++;
			
			return len;
		}

		static public function __getTotal(object_:Object):uint 
		{
			var len:uint = 0;
			
			for (var item:* in object_)
				len++;
			
			return len;
		}

		static public function __getIndex(OBJECT:Object,PROPERTY:String,VALUE:Object,DATAPROVIDER:Boolean=false):int
		{
			var i:int;

			/**
			 * 
			 * TESTAR REMOVENDO O FOR ####
			 * 
			 * ArrayUtil.toArray(
			 * ArrayUtil.getItemIndex(
			 * 
			 * **/
					
			if(DATAPROVIDER)
			{//true
				for (i=0; i<OBJECT.length; i++)
				{
					if (String(OBJECT[i].child(PROPERTY)) == VALUE.toString()){
						return i;
						trace(i);
					}
					//trace('==='+i+'__'+OBJECT[i].child(PROPERTY).toString());
				}
			}
			else
			{//false
				for (i=0; i<__getTotalAMFPhp(OBJECT); i++)
				{
					var obj:Object = Object(OBJECT[i]);
					if (obj[PROPERTY] == VALUE){
						return i;
						trace(i);
					}
					//trace('==='+i+'__'+OBJECT[i].child(PROPERTY).toString());
				}
			}
			
			return -1;
		}

		//WORK A XML FILTER, SELECTIONING THE VALUES ;)
		static public function __objectFilter(objects:Object,property:String,value:Object,valueIsNumber:Boolean=false):Object
		{
			var i:int;
			var no:ArrayCollection = new ArrayCollection();
			var ob:Object = null;
			
			if(valueIsNumber==true)
			{
				for (i=0; i<__getTotalAMFPhp(objects); i++){
					ob = Object(objects[i]);
					if (Number(ob[property]) === Number(value)){
						no.addItem(objects[i]);
					}
				}
			}
			else
			{
				for (i=0; i<__getTotalAMFPhp(objects); i++){
					ob = Object(objects[i]);
					if (String(ob[property]).toLowerCase() == String(value).toLowerCase()){
						no.addItem(objects[i]);
					}
				}
			}
			
			return no.length == 0 ? null : no ;
		}

		static public function __objectUpdate(OBJECT:Object,WHERE_PROPERTY:String,IS_VALUE:Object,PROPERTY:String,VALUE:Object):Object
		{
			var i:int;
			
			for (i=0; i<__getTotalAMFPhp(OBJECT); i++)
			{
				var obj:Object = Object(OBJECT[i]);
				if (obj[WHERE_PROPERTY] == IS_VALUE){
					OBJECT[i][PROPERTY] = VALUE;
				}
			}
			
			return OBJECT;
		}
		
		static public function __getValueOf(OBJECT:Object,property_:String='ID'):uint
		{
			if(OBJECT != null && __getTotalAMFPhp(OBJECT)!= 0)
				var LAST_ID:uint = uint(OBJECT[0][property_]);
			else
				LAST_ID = 0;
			
			return LAST_ID;
		}

		/**
		 *  if TextInput, Button, Label, DropDownList
		 *  ...
		 * 
		 * **/
		static public function __getClassName(objectVisualComponent_:Object):String
		{
			if(objectVisualComponent_.hasOwnProperty('className'))
				return objectVisualComponent_.className;
			else
				return 'noClassName';
		}

		/**
		 *  if TextInput 	= text
		 *  if Button 		= label
		 *  if label 		= text
		 *  if DropDownList = dataprovider
		 *  ...
		 * 
		 * **/
		static public function __getTypeToSetValue(objectVisualComponent_:Object,byIndex:Boolean=false):String
		{
			var type:String = __getClassName(objectVisualComponent_);
			var setIn:String = '';
			
			if(type == 'noClassName')
				return 'noClassName';
			
			switch(type)
			{
				case 'TextInput':
				case 'Label':
				case 'TextArea':
					setIn = 'text';
					break;
				
				case 'Button':
					setIn = 'label';
					break;
				
				/*case 'DropDownList':
				case 'ComboBox':
					setIn = 'selectedIndex';
					break;*/
				
				case 'HSlider':
				case 'VSlider':
				case 'NumericStepper':
					setIn = 'value';
					break;
				
				case 'DropDownList':
				case 'ComboBox':
				case 'DataGrid':
				case 'List':
					setIn = byIndex == true ? 'selectedIndex' : 'dataProvider';
					break;
				
				case 'DateChooser':
				case 'DateField':
					setIn = 'selectedDate';
					break;
				
				case 'CheckBox':
				case 'RadioButton':
				case 'ToggleButton':
					setIn = 'selected';
					break;
			}		
		
			return (setIn)?setIn:'noIdentifyClassName';
		}

	}
}