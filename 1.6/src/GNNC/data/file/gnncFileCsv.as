package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncData;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.DataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumnGroup;
	import mx.controls.dataGridClasses.DataGridColumn;

	public class gnncFileCsv
	{
		private var _parent:Object;

		private var _csvSeparator:String				= ";";
		private var _lineBreak:String					= "\n";
		private var _removeDoubleQuote:Boolean			= true;
		private var _removeSimpleQuote:Boolean			= false;
		private var _doubleQuoteRexExPattern:RegExp 	= /\"/g;
		private var _encoding:String;
		
		public var _dataStr:String 			= "";
		public var _dataArr:ArrayCollection 	= new ArrayCollection();
		
		public var _headerText:Array 					= new Array();
		public var _headerDataField:Array 				= new Array();
		public var _numberColumns:uint 					= 0;
		
		public function gnncFileCsv(parentApplication_:Object=null)
		{
			_parent				= parentApplication_;
		}

		public function __clear():void 
		{
			_dataArr = new ArrayCollection();
			_dataStr = '';
		}

		/** ########################################################################
		 * #########################################################################
		 * EXPORT
		 * #########################################################################
		 * ######################################################################### **/

		/** 0 - NO TRY **/
		
		protected static var tabDelimiter:String = "\t";
		protected static var commaDelimiter:String = ","; 
		protected static var newLine:String = "\n";
		
		public function __exportGridToCSV (gridDisplayObject_:Object, tabSeparator_:Boolean, onlySelected_:Boolean):String
		{
			var dataSource:ICollectionView = (onlySelected_ ? new ArrayCollection (gridDisplayObject_.selectedItems) : gridDisplayObject_.dataProvider) as ICollectionView;
			
			var headers:String = "";		
			var delimiter:String = ""
			
			if (!tabSeparator_)	
				delimiter = commaDelimiter;
			else
				delimiter = tabDelimiter;
			
			//build header
			for each (var hcol:Object in gridDisplayObject_.columns)//coltypes differe between DG & ADG
			{
				if (headers.length > 0)//avoid firstcolumn having extra delimeter
					headers += delimiter;					
				
				headers += hcol.headerText;			
			}
			headers += newLine;
			
			//populate data
			var cursor:IViewCursor = dataSource.createCursor();
			var data:String = "";
			var item:Object;
			var itemData:String;
			
			do 
			{
				item = cursor.current;
				itemData = "";
				
				for each (var col:Object in gridDisplayObject_.columns)
				{
					if (itemData.length > 0)	//avoid firstcolumn having extra delimeter				
						itemData += delimiter;
					
					itemData += col.itemToLabel(item);					
				}
				
				data += itemData +newLine;
			}while (cursor.moveNext())
			
			return headers + data;
		} 						
		
		/** 1 - NO TRY**/
		
		private function __formatAsCSVString(items:Array):String
		{
			if (_removeDoubleQuote)
			{
				// escape any existing double quotes then place double quotes around values
				for (var i:int = 0; i < items.length; i++)
				{
					items[i] = items[i] ? items[i].replace(_doubleQuoteRexExPattern, "\"\"") : "";
					items[i] = "\"" + items[i] + "\"";
				}
			}
			return items.join(_csvSeparator) + _lineBreak;
		}

		/** 1 - NO TRY**/

		public function __advancedDataGrid2Csv(dg:AdvancedDataGrid):String
		{
			var headerCSV:String 				= "";
			var headerItems:Array;
			var dataCSV:String 					= "";
			var dataItems:Array;
			var columns:Array 					= dg.groupedColumns ? dg.groupedColumns : dg.columns;
			var column:AdvancedDataGridColumn;
			var headerGenerated:Boolean 		= false;
			var cursor:IViewCursor 				= (dg.dataProvider as ICollectionView).createCursor();
			
			// loop through rows
			while (!cursor.afterLast)
			{
				var obj:Object = null;
				obj = cursor.current;
				dataItems = new Array();
				headerItems = new Array();
				// loop through all columns for the row
				for each (column in columns)
				{
					// if the column is not visible or the header text is not defined (e.g., a column used for a graphic),
					// do not include it in the CSV dump
					if (!column.visible || !column.headerText)
						continue;
					
					// depending on whether the current column is a group or not, export the data differently
					if (column is AdvancedDataGridColumnGroup)
					{
						for each (var subColumn:AdvancedDataGridColumn in (column as AdvancedDataGridColumnGroup).children)
						{
							// if the sub-column is not visible or the header text is not defined (e.g., a column used for a graphic),
							// do not include it in the CSV dump
							if (!subColumn.visible || !subColumn.headerText)
								continue;
							dataItems.push(obj ? subColumn.itemToLabel(obj) : "");
							if (!headerGenerated)
								headerItems.push(column.headerText + ": " + subColumn.headerText);
						}
					}
					else
					{
						dataItems.push( obj ? column.itemToLabel(obj) : "");
						if (!headerGenerated)
							headerItems.push(column.headerText);						
					}
				}
				// append a CSV generated line of our data
				dataCSV += __formatAsCSVString(dataItems);
				// if our header CSV has not been generated yet, do so; this should only occur once
				if (!headerGenerated)
				{
					headerCSV = __formatAsCSVString(headerItems);
					headerGenerated = true;
				}
				// move to our next item
				cursor.moveNext();
			}
			
			// set references to null:
			headerItems = null;
			dataItems = null;
			columns = null;
			column = null;
			cursor = null;
			
			// return combined string
			return headerCSV + dataCSV;
		}

		/** 1 - NO TRY**/

		public function __exportAdvancedDataGridAsCSVFile(dg:AdvancedDataGrid, fileName:String, encoding:String = "utf-16"):void
		{
			var csvString:String = __advancedDataGrid2Csv(dg);
			var bytes:ByteArray = new ByteArray();
			
			// if using UTF-16, prefix file with BOM (little-endian)
			if (encoding == "utf-16")
			{
				bytes.writeByte(0xFF);
				bytes.writeByte(0xFE);
				bytes.writeMultiByte(csvString, encoding);
			}
			else
			{
				bytes.writeMultiByte(csvString, encoding);
			}

			// prompt the user with a save location
			// note: FileReference requires a minimum flash player version of 10
			var fileReference:FileReference = new FileReference();
			fileReference.save(bytes, fileName);
			fileReference = null;
		}
		
		/** NO TRY **/
		
		public function __exportCSV(dg:DataGrid, csvSeparator:String=",", lineSeparator:String="\n"):String
		{
			var data:String = "";
			var columns:Array = dg.columns;
			var columnCount:int = columns.length;
			var column:DataGridColumn;
			var header:String = "";
			var headerGenerated:Boolean = false;
			var dataProvider:Object = dg.dataProvider;
			
			var rowCount:int = dataProvider.length;
			var dp:Object = null;
			
			
			var cursor:IViewCursor = dataProvider.createCursor ();
			var j:int = 0;
			
			//loop through rows
			while (!cursor.afterLast)
			{
				var obj:Object = null;
				obj = cursor.current;
				
				//loop through all columns for the row
				for(var k:int = 0; k < columnCount; k++)
				{
					column = columns[k];
					
					//Exclude column data which is invisible (hidden)
					if(!column.visible)
					{
						continue;
					}
					
					data += column.itemToLabel(obj);
					
					if(k < (columnCount -1))
					{
						data += csvSeparator;
						trace(data);
					}
					
					//generate header of CSV, only if it's not genereted yet
					if (!headerGenerated)
					{
						header += column.headerText;
						if (k < columnCount - 1)
						{
							header += csvSeparator;
						}
					}
					
					
				}
				
				headerGenerated = true;
				
				if (j < (rowCount - 1))
				{
					data += lineSeparator;
				}
				
				j++;
				cursor.moveNext ();
			}
			
			//set references to null:
			dataProvider = null;
			columns = null;
			column = null;
			
			return (header + "\r\n" + data);
		}	

		/** NO TRY **/
		
		public function __exportCSV2(csvData:String):Array
		{
			var properties:Array 		= new Array();
			var headings:Boolean 		= false;
			var carriage:Number 		= new Number();
			var comma:Number			= new Number();
			var cursor:Number 			= new Number();
			var sub:Number 				= new Number();
			var item:Object 			= new Object();
			var value:String 			= new String();
			var line:String 			= new String();
			var contacts:Array 			= new Array();	
			
			var result:String = csvData;
			
			while( result.indexOf( "\n", cursor ) != -1 ) {
				carriage = result.indexOf( "\n", cursor );
				line = result.substring( cursor, carriage );
				
				cursor = 0;
				sub = 0;
				
				item = new Object();
				
				while( line.indexOf( ",", cursor ) != -1 ) {
					comma = line.indexOf( ",", cursor );
					value = line.substring( cursor, comma );
					
					if( !headings ) {
						properties.push( value );
					} else {
						item[properties[sub]] = value;
						//trace("email:\n" + value.toString());
					}
					
					cursor = comma + 1;
					sub++;
				}
				
				value = line.substring( cursor, line.length - 1 );
				
				if( !headings ) {
					properties.push( value );
					headings = true;
					//trace("headings:\n" + value.toString());
				} else {
					item[properties[sub]] = value;
					contacts.push( item );
					//trace("contact:\n" + item.Name.toString());
				}
				cursor = carriage + 1;
			}
			
			trace("Parsing Complete " + contacts.length + " contacts found: \n");
			
			return contacts;
		}
		
		/** 
		 * WORK!! 
		 * new gnncFilesNative().__writeNative('csv1','csv','CSV',false,true,gnncFilesNative._desktop,TEXT_CSV,null,null,null);
		 * 
		 * **/
		public static function __arrayCollection2Csv(arrayC_or_String:Object, propertysGet_:Array, propertysName_:Array=null, csvSeparator_:String = ";", lineBreak_:String = "\n", quoteValues_:String = "'", scapeText_:Boolean = false,header_:Boolean=true,removeAllDoubleQuoteValues_:Boolean=false,removeAllSimpleQuotesValues_:Boolean=false):String
		{
			var arrayC_:Object = arrayC_or_String;
			
			if(!arrayC_)
				return '';

			if(!arrayC_.length)
				return '';
			
			if(!lineBreak_)
				lineBreak_ = "\n";

			if(!csvSeparator_)
				csvSeparator_ = ";";

			// var1;var2;var3;\n
			var _head:String 	= propertysName_ ? propertysName_.join(csvSeparator_) + lineBreak_ :  gnncData.__replace(propertysGet_.toString(),",",csvSeparator_) + lineBreak_;
			var _csv:String 	= '';
			var _i:uint			= 0;
			var _e:uint			= 0;
			var _obj:Object		= null;
			
			var _propertysGetLength:uint 	= propertysGet_.length;
			var _arrayCLength:uint 			= arrayC_.length;

			var t:String = '';

			//header names
			_csv += header_ ? _head : '';
	
			if(arrayC_ as String)
				return _csv += arrayC_ + lineBreak_;

			// line arrayC
			for(_i=0; _i<_arrayCLength; _i++)
			{
				// get obj
				_obj = arrayC_.getItemAt(_i);
				// property
				for(_e=0; _e<_propertysGetLength; _e++)
				{
					// check property exists
					if(_obj.hasOwnProperty(propertysGet_[_e])){
						
						t = _obj[propertysGet_[_e]];

						if(removeAllDoubleQuoteValues_)
							t = gnncData.__replace(t,'"','');
					
						if(removeAllSimpleQuotesValues_)
							t = gnncData.__replace(t,"'",'');

						_csv += quoteValues_ + t + quoteValues_ + csvSeparator_;
						
					}
					
					// break line
					if(_e == (_propertysGetLength-1))
						_csv += lineBreak_;
				}
			}

			
			return _csv;
			
			//new gnncFilesNative().__writeNative('DAYBYDAY - '+gnncGlobalStatic._programName+' - Relacao de Emails','txt','GNNC/Export',false,true,'DOC',_text);
			//new gnncFilesNative().__saveWithBrowserNative('DAYBYDAY - '+gnncGlobalStatic._programName+' - Relacao de Emails','txt',_text,gnncFilesNative._documentDirectory,'',true);
		}

		/** ########################################################################
		 * #########################################################################
		 * IMPORT
		 * #########################################################################
	     * ######################################################################### **/

		
		/** 
		 * 
		 * tab 				=> \t 
		 * ponto vírgula 	=> ; 
		 * vírgula 			=> , 
		 * 
		 * **/
		
		/** WORK! **/

		public function __csv2ArrayCollection(csvSeparator_:String = ";", lineSeparator_:String = "\n", removeAllDoubleQuoteValues_:Boolean = true, removeAllSimpleQuotesValues_:Boolean = false, scapeText_:Boolean = true):void
		{
			//var ending:String = new String("\n\g");
			// Split the whole file into lines
			
			var values:Array;
			var lines:Array = _dataStr.split(lineSeparator_);
			var i:uint;
			var e:uint;
			var obj:Object;
			var line:String;
			
			_dataArr 		= new ArrayCollection();
			_numberColumns 	= 0;
			
			if(removeAllDoubleQuoteValues_)
				_dataStr = gnncData.__replace(_dataStr,'"','');

			if(removeAllSimpleQuotesValues_)
				_dataStr = gnncData.__replace(_dataStr,"'",'');

			if(scapeText_)
				gnncData.__scapeText([_dataStr]);

			/**
				var idx1:int = str.substr(0,2).indexOf('"');
				var idx2:int = str.substr(-2).indexOf('"');
				
				if(idx1 > -1)
					str = str.substr(idx1);
				if(idx2 > -1)
					str = str.substr(0,str.length-1);
			**/

			// Split each line into data content – start from 1 instead of 0 as this is a header line.
			for ( i = 0; i < lines.length; i++ ) 
			{
				line		= lines[i];
				values 		= line.split(csvSeparator_);
				
				if(!_numberColumns)
					_numberColumns = values.length;
				
				trace ("line split in " + values);
				
				// objects
				obj			= new Object();
				
				for ( e = 0; e < values.length; e++ ) 
				{
					obj['col'+e] = gnncData.__trimText(values[e].toString());
				}

				// Add values to arraycollection
				_dataArr.addItem(obj);
			}
		}
		
		/** WORK! **/

		public function __loadUrlFile(urlFile_:String="http://gnnc.com.br/file.csv"):void 
		{
			var _hostNameTrue:Boolean = false;
			
			if(urlFile_.indexOf("http://")  > -1){	_hostNameTrue = true	}
			if(urlFile_.indexOf("https://") > -1){	_hostNameTrue = true	}
			if(urlFile_.indexOf("ftp://")   > -1){	_hostNameTrue = true	}
			if(urlFile_.indexOf("ftps://")  > -1){	_hostNameTrue = true	}
			if(urlFile_.indexOf("file://")  > -1){	_hostNameTrue = true	}

			if(!_hostNameTrue)
			{
				new gnncAlert().__error('Url não está correta. Tente começar com http://, https://, ftp:// entre outros.');
				return;
			}

			if(urlFile_.length<10)
			{
				new gnncAlert().__error('Url muito curta. Tente outro endereço.');
				return;
			}
			
			var loader:URLLoader 	= new URLLoader();
			__configureListeners	(loader);
			
			var request:URLRequest 	= new URLRequest(urlFile_);

			try 
			{
				loader.load(request);
			} 
			catch (error:Error) 
			{
				new gnncAlert().__error("Não foi possível carregar o arquivo.\nVerifique o caminho da Url.");
			}
		}
		
		private function __configureListeners(dispatcher:IEventDispatcher):void 
		{
			dispatcher.addEventListener(Event.COMPLETE, __completeHandler);
		}
		
		private function __completeHandler(event:Event):void
		{
			__clear();
			_dataStr = String(event.target.data);
		}
			
	}
}