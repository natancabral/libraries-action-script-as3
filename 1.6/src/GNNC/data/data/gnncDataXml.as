package GNNC.data.data
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.collections.XMLListCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	
	public class gnncDataXml
	{
		private var _parent:Object;
		
		static public const TEXT:String 					= "text";
		static public const COMMENT:String 					= "comment";
		static public const PROCESSING_INSTRUCTION:String 	= "processing-instruction";
		static public const ATTRIBUTE:String 				= "attribute";
		static public const ELEMENT:String 					= "element";
		
		public function gnncDataXml(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		
		static public function __isValidXML(data:String):Boolean
		{
			var xml:XML;
			
			try
			{
				xml = new XML(data);
			}
			catch(e:Error)
			{
				return false;
			}
			
			if(xml.nodeKind() != ELEMENT)
			{
				return false;
			}
			
			return true;
		}
		
		static public function __xml2Object(xmlFile_:XML):Object 
		{
			var xmlDoc:XMLDocument 			= new XMLDocument(xmlFile_.toXMLString());
			var decoder:SimpleXMLDecoder 	= new SimpleXMLDecoder(true);
			var OBJECT:Object 				= decoder.decodeXML(xmlDoc);

			return OBJECT;
		}

		static public function __xml2ArrayCollection(xmlFile_:XML,firtNode_:String='dbd',secondNode_:String='item'):ArrayCollection
		{
			var xmlDoc:XMLDocument 			= new XMLDocument(xmlFile_.toXMLString());
			var decoder:SimpleXMLDecoder 	= new SimpleXMLDecoder();
			var data:Object 				= decoder.decodeXML( xmlDoc );
			//var array:Array 				= ArrayUtil.toArray( data.rows.row );
			var array:Array 				= ArrayUtil.toArray( secondNode_ ? data[firtNode_][secondNode_] : firtNode_ ? data[firtNode_] : data );
			
			return new ArrayCollection( array );
		}

		static public function __getTotal(xmlFile_:XML):uint 
		{
			return xmlFile_.length();
		}
		
		public static function __deleteNode(node:XML):void
		{
			if (node != null && node.parent() != null)
			{
				delete node.parent().children()[node.childIndex()];
			}
		}
		
		static public function __getIndex(xmlFile_:*,PROPERTY:String,VALUE:Object,DATAPROVIDER:Boolean=false):int
		{
			
			if(DATAPROVIDER)
			{
				var i:uint;
				for (i=0; i<xmlFile_.length; i++)
				{
					if (xmlFile_[i].child(PROPERTY) == VALUE.toString())
					{
						return i;
					}
				}
			}
			else 
			{				
				if(xmlFile_.child('item').hasOwnProperty(PROPERTY))
				{
					return xmlFile_.child('item').(child(PROPERTY).toString() == VALUE.toString()).childIndex();
				}
				else
				{
					gnncAlert('"'+PROPERTY+'" não existe.');
				}
			}

			return -1;
		}

		static public function __xmlUpdate(xmlFile_:*,WHERE_PROPERTY:String,IS_VALUE:Object,PROPERTY:String,VALUE:Object,DATAPROVIDER:Boolean):*
		{
			if(DATAPROVIDER){
				
				/**
				 * 
				 * HERE XML LIST COLLECTION
				 * ATTENCION PROBLEM IN DATAPROVIDER
				 * 
				 * **/
				
				var i:uint;
				for (i=0; i<xmlFile_.length; i++)
				{
					if (xmlFile_[i].child(WHERE_PROPERTY) == IS_VALUE.toString())
						xmlFile_[i].(child(WHERE_PROPERTY).toString() == IS_VALUE.toString()).replace(PROPERTY,<{PROPERTY}>{VALUE}</{PROPERTY}>);
				}
			}
			else
			{
				if(xmlFile_.child('item').hasOwnProperty(WHERE_PROPERTY))
					if(WHERE_PROPERTY.substr(0,1) == '@')
						xmlFile_.child('item').(attribute(WHERE_PROPERTY) == IS_VALUE.toString()).attribute(PROPERTY)[0] = VALUE;
					else
						xmlFile_.child('item').(child(WHERE_PROPERTY) == IS_VALUE.toString()).replace(PROPERTY,<{PROPERTY}>{VALUE}</{PROPERTY}>);
				else
					gnncAlert('"'+PROPERTY+'" não existe.');
			}
			
			return  xmlFile_;
		}

		static public function __orderTo(xmlFile_:XMLList,ORDER_BY:String='ID',DESC:Boolean=false,NUMERIC:Boolean=false):XMLListCollection
		{
			var XMLLIST:XMLListCollection = new XMLListCollection(xmlFile_);
			var XMLSORT:Sort = new Sort();
			
			XMLSORT.fields = [new SortField(ORDER_BY,true,DESC,NUMERIC)];
			XMLLIST.sort = XMLSORT;
			XMLLIST.refresh();
			
			return XMLLIST as XMLListCollection;
		
		}

		static public function __getNextSibling(x:XML):XML
		{	
			return __getSiblingByIndex(x, 1);
		}
		
		static public function __getPreviousSibling(x:XML):XML
		{	
			return __getSiblingByIndex(x, -1);
		}		
		
		static private function __getSiblingByIndex(x:XML, count:int):XML	
		{
			var out:XML;
			
			try
			{
				out = x.parent().children()[x.childIndex() + count];	
			} 		
			catch(e:*)
			{
				return null;
			}
			
			return out;			
		}		
		
	}
}