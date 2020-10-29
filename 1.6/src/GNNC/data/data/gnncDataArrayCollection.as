package GNNC.data.data
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flashx.textLayout.operations.CopyOperation;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.utils.ArrayUtil;
	
	import spark.collections.SortField;
	
	public class gnncDataArrayCollection
	{
		private var _parent:Object					= null;
		private var _arrayCollection:ArrayCollection = new ArrayCollection();
		
		private var _x:uint; //position for
		
		private var _property:String				= '';
		private var _propertyArray:Array			= new Array();
		private var _value:Object					= null;
		private var _obj:Object						= null;
		
		private var _allowRelativeValue:Boolean		= false;
		private var _allowCaseSensitive:Boolean		= false;
		
		public function gnncDataArrayCollection(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}		

		public static function clone(arr:ArrayCollection):ArrayCollection
		{
			return new gnncDataArrayCollection().__cloneAddItem( arr );
			
			var ba:ByteArray = new ByteArray(); 
			ba.writeObject(arr); // Copy the original array (a) into a ByteArray instance
			ba.position = 0; // Put the cursor at the beginning of the ByteArray to read it
			var b:ArrayCollection = ba.readObject() as ArrayCollection; // Store a copy of the array in the destination array (b)
			ba.clear(); // Free memory
			return b;
		}
		
		public function __vector2arraC( source_:Vector.<Object> ) :ArrayCollection
		{
			//this function assumes that v is a Vector!
			var result:ArrayCollection = new ArrayCollection();
			var len:uint = source_.length;
			for (var i:int = 0; i < len; i++)
				result.addItem(source_[i]);
			
			return result;
		}		
		
		public function __clone( source_:ArrayCollection ) :ArrayCollection
		{
			return __cloneAddItem( source_ );
			
			var myBA:ByteArray 	= new ByteArray();
			myBA.writeObject	( source_.source );
			myBA.position 		= 0;
			return new ArrayCollection( myBA.readObject() );
		}
		
		public function __cloneAddItem( source_:ArrayCollection ):ArrayCollection{
			
			var index:int = 0;
			var data:ArrayCollection = new ArrayCollection();
			var length:int = source_.length;
			var obj:Object = new Object();
			
			var className:String = getQualifiedClassName( source_.getItemAt(0) );
			registerClassAlias( className, (getDefinitionByName( className ) as Class ) );
			
			for(index; index < length; index++)
			{
				// initializing a Item object.
				obj = new Object();
				obj = source_.getItemAt(index);
				data.addItem(obj);
			} 
			
			return data;
		}
		
		public var filterData:ArrayCollection = new ArrayCollection();
		public var filterIds:Array = new Array();
		public var filterIndexs:Array = new Array();
		/** filter Numeric Faster 
		 * 
		 * return new ArrayCollection();
		 * too
		 * return filterData:ArrayCollection = [obj,obj]
		 * return filterIds:Array = [obj,obj];
		 * return filterIndexs:Array = [obj,obj];
		 * 
		 * **/
		public function __filterArrayNumeric(arrayC_:ArrayCollection,property_:String,values_:Array):ArrayCollection
		{
			var arr:ArrayCollection = new ArrayCollection();
			var len:uint = arrayC_.length;
			var i:uint = 0;
			var o:Object = new Object();
			
			for( i=0; i<len; i++ ){
				o = gnncData.__clone(arrayC_.getItemAt(i));
				if(o.hasOwnProperty(property_)){ //if true
					if( values_.indexOf(o[property_]) !== -1 ){
						filterData.addItem(o);
						filterIds.push(o.ID);
						filterIndexs.push(i);
						arr.addItem(o);
					}
				}
			}			
			return arr;
		}
		
		/** filter String Faster 
		 * 
		 * return new ArrayCollection();
		 * too
		 * return filterData:ArrayCollection = [obj,obj]
		 * return filterIds:Array = [obj,obj];
		 * return filterIndexs:Array = [obj,obj];
		 * 
		 * **/
		public function __filterArrayString(arrayC_:ArrayCollection,property_:Array,value_:String):ArrayCollection
		{
			var arr:ArrayCollection = new ArrayCollection();
			var len:uint = arrayC_.length;
			var lenProperty:uint = property_.length;
			var i:uint = 0;
			var e:uint = 0;
			var o:Object = new Object();
			
			if(value_=='')
				return arrayC_;
			if(property_==null)
				return arrayC_;
			if(property_.length==0)
				return arrayC_;
			
			for( i=0; i<len; i++ ){
				o = gnncData.__clone(arrayC_.getItemAt(i));
				for( e=0; e<lenProperty; e++ ){
					if(o.hasOwnProperty(property_[e])==true){ //if true
						if( String(o[property_[e]]).indexOf(value_) !== -1 ){
							filterData.addItem(o);
							filterIds.push(o.ID);
							filterIndexs.push(i);
							arr.addItem(o);
							continue;
						}
					}
				}
			}			
			return arr;
		}
		
		/** filter Numeric Faster **/
		public function __filterNumeric(arrayC_:ArrayCollection,property_:String,value_:Number):ArrayCollection
		{
			if(!arrayC_)
				return arrayC_;
			
			if(!arrayC_.length)
				return arrayC_;
			
			for(var o:uint=0; o<arrayC_.length; o++)
				if(arrayC_.getItemAt(o).hasOwnProperty(property_)) //if true
					if(String(arrayC_.getItemAt(o)[property_])===String(value_))
						_arrayCollection.addItem(arrayC_.getItemAt(o));
			
			return _arrayCollection;
		}
		
		/** filter Value Faster **/
		public function __filter(arrayC_:ArrayCollection,property_:String,value_:Object,relativeValue_:Boolean=true,caseSensitive_:Boolean=false):ArrayCollection
		{
			if(!arrayC_)
				return arrayC_;
			
			if(!arrayC_.length)
				return arrayC_;
			
			//BAD IDEA - Se for um numero Retorna Vazio
			//if(!isNaN(parseInt(WORD_.toString())) && WORD_.toString())
			//	WORD_ = '';
			
			var clone:Array                    = gnncData.__clone(arrayC_.source) as Array;
			_arrayCollection					= new ArrayCollection(clone); 
			_value 								= value_;
			_property 							= property_;
			_allowRelativeValue 				= relativeValue_;
			_allowCaseSensitive 				= caseSensitive_;
			
			_arrayCollection.filterFunction 	= __filterProperty;
			_arrayCollection.refresh			();
			
			return _arrayCollection;
		}
		
		/** filter Value Slow... **/
		public function __filterArray(arrayC_:ArrayCollection,propertyArray_:Array,value_:Object,relativeValue_:Boolean=true,caseSensitive_:Boolean=false):ArrayCollection
		{
			if(!arrayC_)
				return arrayC_;
			
			if(!arrayC_.length)
				return arrayC_;
			
			//BAD IDEA - Se for um numero Retorna Vazio
			//if(!isNaN(parseInt(WORD_.toString())) && WORD_.toString())
			//	WORD_ = '';
			
			var clone:Array                    = gnncData.__clone(arrayC_.source) as Array;
			_arrayCollection					= new ArrayCollection(clone); 
			_value 								= value_;
			_propertyArray 						= propertyArray_;
			_allowRelativeValue 				= relativeValue_;
			_allowCaseSensitive 				= caseSensitive_;
			
			_arrayCollection.filterFunction 	= __filterPropertyArray;
			_arrayCollection.refresh			();
			
			return _arrayCollection;
		}
		
		private function __filterPropertyArray(item:Object):Boolean 
		{
			if(!_propertyArray)
				return false;
			
			if(!_propertyArray.length)
				return false;
			
			var _result:Boolean = false;
			
			for(_x=0; _x<_propertyArray.length; _x++)
			{
				var W:String = _value.toLowerCase();
				var V:Object = item.hasOwnProperty(_propertyArray[_x]) ? item[_propertyArray[_x]] : null;
				
				if(V)// && W
				{
					if(String(V).toLowerCase().indexOf(W) > -1)
						_result = true;
				} 
				else 
				{
					_result = !_value ? true : false ;
				}
			}
			
			return _result;
			
			/*var OK:Boolean = false;
			var N:Number;
			var W:String;
			var V:Object;
			
			for(_X=0;_X<_PROPERTY_ARRAY.length;_X++)
			{
			if(item[_PROPERTY_ARRAY[_X]] == null)
			OK = (!_WORD)?true:false;
			
			if(_WORD is String)
			{
			W = _WORD.toLowerCase();
			V = item[_PROPERTY_ARRAY[_X]].toLowerCase();
			OK = (V.indexOf(W) > -1)?true:false;
			}
			else if(_WORD is Number)
			{
			N = Number(_WORD);
			V = item[_PROPERTY_ARRAY[_X]];
			OK = (V==W)?true:false;//indexOf(null,N) > -1);
			}
			}
			
			return OK;*/
		}
		
		private function __filterProperty(item:Object):Boolean 
		{
			var N:Number;
			var W:String;
			var V:Object;
			
			if(item[_property] == null)
				return !_value ? true : false ;
			
			if(_value is String || _value is Object)
			{
				W = String(_value).toLowerCase();
				V = item[_property].toLowerCase();
				
				if(_allowRelativeValue)
					return V.indexOf(W) > -1 ? true : false ;
				else
					return V==W ? true : false ;
			}
				
			else if(_value is Number)
			{
				N = Number(_value);
				V = item[_property];
				return  V==W ? true : false ; //indexOf(null,N) > -1);
			}
			
			return false;
		}
		
		public function __search(arrayC_:ArrayCollection,whereProperty:String,isValue_:Object,returnValueOfProperty_:String):Object
		{
			if(!arrayC_)
				return arrayC_;
			
			if(!arrayC_.length)
				return arrayC_;
			
			_arrayCollection					= new ArrayCollection(arrayC_.source); 
			_property 							= whereProperty;
			_value 								= isValue_;
			
			_arrayCollection.filterFunction 	= __filterProperty;
			_arrayCollection.refresh			();
			
			if(!_arrayCollection.length){
				return '';
			}else if(_arrayCollection.length == 1){
				_obj = _arrayCollection.getItemAt(0)[returnValueOfProperty_];
			}else{
				return 'Encontrados ' + _arrayCollection.length + ' valores';
			}
			
			/*
			function __filterFunctionSearech(item:Object):Boolean 
			{
			var W:String = _WORD.toLowerCase();
			var V:String = item[_PROPERTY].toLowerCase();
			return (V.indexOf(W) > -1);
			}
			*/
			
			return _obj;
		}
		
		
		public function __sort(arrayC_:ArrayCollection,sortBy_:String,numeric_:Boolean=false,descending_:Boolean=false):ArrayCollection
		{
			var dataSortField:SortField 	= new SortField(sortBy_,descending_,numeric_);
			var DataSort:Sort 				= new Sort();
			DataSort.fields 				= [dataSortField];
			
			_arrayCollection				= new ArrayCollection();
			_arrayCollection				= arrayC_;
			_arrayCollection.sort			= DataSort;
			_arrayCollection.refresh		();
			
			return 							_arrayCollection;
		}
		
		private function __sortFunction(a:Object, b:Object, array:Array = null):int
		{
			//assuming that 'level' is the name of the variable in each object 
			//that holds values like "Critical", "High" etc
			var levels:Array = ["Low", "Medium", "High", "Critical"];
			var aLevel:Number = levels.indexOf(a.level);
			var bLevel:Number = levels.indexOf(b.level);
			if(aLevel == -1 || bLevel == -1)
				throw new Error("Invalid value for criticality ");
			if(aLevel == bLevel)
				return 0;
			if(aLevel > bLevel)
				return 1;
			return -1;
		}
		
		public function __sortLevel(arrayCollection_:ArrayCollection):void
		{
			var sort:Sort 				= new Sort();
			sort.compareFunction 		= __sortFunction;
			arrayCollection_.sort 		= sort;
			arrayCollection_.refresh	();
		}
		
		public function __getIndex(arrayC_:ArrayCollection,property_:String,value_:Object,caseSensitive_:Boolean=false):int
		{
			_allowCaseSensitive = caseSensitive_;
			
			var _len:uint = arrayC_.length;
			var _i:int;
			
			for (_i=0; _i<_len; _i++)
			{
				var obj:Object = Object(arrayC_[_i]);
				
				if(caseSensitive_)
				{
					if (String(obj[property_]).toLowerCase() == String(value_).toLowerCase())
						return _i;
				}
				else
				{
					if (obj[property_] == value_)
						return _i;
				}					
				
				//trace(_i);
			}
			
			return -1;
		}
		
		public function __hierarchy(arrayC_:ArrayCollection,namePropertyId_:String='ID',namePropertyIdParent_:String='ID_FATHER',namePropertyNameLevel_:String='LEVEL',namePropertyLabelField_:String='NAME'):ArrayCollection
		{
			_arrayCollection						= new ArrayCollection();
			
			var i:uint 								= 0;
			var newIndex:int 						= 0;
			var level:uint 							= 0;
			
			var gnncDataArr:gnncDataArrayCollection	= new gnncDataArrayCollection();
			
			var newArrayC:ArrayCollection 			= new ArrayCollection();
			var newIdNotFoundArrayC:ArrayCollection = new ArrayCollection();
			var newName:Object						= new Object();
			
			//arrayC_ = gnncDataArr.__SORT(arrayC_,'NAME',false);
			newArrayC = gnncDataArr.__filterNumeric(arrayC_,namePropertyNameLevel_,0);

			arrayC_ = gnncDataArr.__sort(arrayC_,'NAME',false,true);

			for(level=1; level<10; level++)
				
				if(gnncDataArr.__getIndex(arrayC_,namePropertyNameLevel_,level)>-1)
				{
					for(i=0; i<arrayC_.length; i++)
					{
						if(arrayC_.getItemAt(i).hasOwnProperty(namePropertyNameLevel_)) //if true
							
							if(String(arrayC_.getItemAt(i)[namePropertyNameLevel_])===String(level))
							{
								newIndex = gnncDataArr.__getIndex(newArrayC,namePropertyId_,arrayC_.getItemAt(i)[namePropertyIdParent_])
								
								if(newIndex>-1)
								{
									/*
									newName 				= new Object();
									newName 				= arrayC_.getItemAt(i);
									newName.NAME 			= newName.NAME;
									newArrayC.addItemAt		(newName,newIndex+1);
									*/
									
									newArrayC.addItemAt		(arrayC_.getItemAt(i),newIndex+1);
								}
								else
								{
									newName 				= new Object();
									newName 				= arrayC_.getItemAt(i);
									newName.LEVEL 			= 0;
									newIdNotFoundArrayC.addItem(newName);
								}
							}
					}
				}
				else
				{
					//level=100;
				}
			
			newArrayC.addAll(newIdNotFoundArrayC);
			
			return newArrayC;
		}
	
		public function __hierarchyReport(arrayC_:ArrayCollection,namePropertyId_:String='ID',namePropertyIdParent_:String='ID_FATHER',namePropertyNameLevel_:String='LEVEL',namePropertyLabelField_:String='NAME'):ArrayCollection
		{
			_arrayCollection						= new ArrayCollection();
			
			var i:uint 								= 0;
			var newIndex:int 						= 0;
			var level:uint 							= 0;
			
			var gnncDataArr:gnncDataArrayCollection	= new gnncDataArrayCollection();
			
			var newArrayC:ArrayCollection 			= new ArrayCollection();
			var newIdNotFoundArrayC:ArrayCollection = new ArrayCollection();
			var newName:Object						= new Object();
			
			//arrayC_ = gnncDataArr.__SORT(arrayC_,'NAME',false);
			newArrayC = gnncDataArr.__filterNumeric(arrayC_,namePropertyNameLevel_,0);
			
			for(level=1; level<10; level++)
				
				if(gnncDataArr.__getIndex(arrayC_,namePropertyNameLevel_,level)>-1)
				{
					for(i=0; i<arrayC_.length; i++)
					{
						if(arrayC_.getItemAt(i).hasOwnProperty(namePropertyNameLevel_)) //if true
							
							if(String(arrayC_.getItemAt(i)[namePropertyNameLevel_])===String(level))
							{
								newIndex = gnncDataArr.__getIndex(newArrayC,namePropertyId_,arrayC_.getItemAt(i)[namePropertyIdParent_])
								
								if(newIndex>-1)
								{
									/*
									newName 				= new Object();
									newName 				= arrayC_.getItemAt(i);
									newName.NAME 			= newName.NAME;
									newArrayC.addItemAt		(newName,newIndex+1);
									*/
									
									newArrayC.addItemAt		(arrayC_.getItemAt(i),newIndex+1);
								}
								else
								{
									newName 				= new Object();
									newName 				= arrayC_.getItemAt(i);
									newName.LEVEL 			= 0;
									newIdNotFoundArrayC.addItem(newName);
								}
							}
					}
				}
				else
				{
					//level=100;
				}
			
			newArrayC.addAll(newIdNotFoundArrayC);
			
			return newArrayC;
		}

		
		
		public function __filterDuplicateProperty(arrayC_:ArrayCollection,property_:String='ID'):ArrayCollection
		{ 
			if(!arrayC_)
				return arrayC_;
			
			if(!arrayC_.length)
				return arrayC_;
			
			var arc:ArrayCollection = __clone(new ArrayCollection(arrayC_.source));
			var neo:ArrayCollection = new ArrayCollection();
			var dup:Array  			= new Array();
			var obj:Object 			= new Object();
			var v:Object			= new Object();
			
			for each (obj in arc) 
			{
				v = obj[property_];
				
				if (dup.indexOf(v) >= 0) {
					//
				} else {
					neo.addItem(obj);
					dup.push(v);
				}
			}
			
			return neo;
			
			
			/**
			 * Called by the Application container's creationComplete
			 * event handler. This method creates a new Array object
			 * which will be used as a data provider as well as a
			 * filtered view of that array which does not contain
			 * duplicated items.
			 */
			
			var keys:Object = {};
			
			/* Create a dummy data source with some semi-random
			data. */
			var arr:Array = [];
			arr.push({data:1, label:"one"});
			arr.push({data:1, label:"one"});
			arr.push({data:1, label:"one"});
			arr.push({data:1, label:"one"});
			arr.push({data:2, label:"two"});
			arr.push({data:2, label:"two"});
			arr.push({data:2, label:"two"});
			arr.push({data:1, label:"one"});
			arr.push({data:3, label:"three"});
			arr.push({data:3, label:"three"});
			
			/* Filter the original array and call the
			removeDuplicates() function on each item
			in the array. */
			
			var arrColl:ArrayCollection 		= new ArrayCollection();
			var dedupedArrColl:ArrayCollection 	= new ArrayCollection();
			
			var filteredArr:Array = arr.filter(removedDuplicates);
			
			arrColl.source = arr;
			dedupedArrColl.source = filteredArr;
			
			/**
			 * This method is used to filter an array so that no
			 * duplicate items are created. It works by first
			 * checking to see if a keys object already contains
			 * a key equal to the current value of the item.data
			 * value. If the key already exists, the  current item
			 * will not be readded to the data provider. If the key
			 * does not already exist, add the key to the keys
			 * object and add this item to the data provider.
			 */
			function removedDuplicates(item:Object, idx:uint, arr:Array):Boolean 
			{
				if (keys.hasOwnProperty(item.data)) {
					/* If the keys Object already has this property,
					return false and discard this item. */
					return false;
				} else {
					/* Else the keys Object does *NOT* already have
					this key, so add this item to the new data
					provider. */
					keys[item.data] = item;
					return true;
				}
			}
			
			
			
			
			
		}
		
		
	}
}