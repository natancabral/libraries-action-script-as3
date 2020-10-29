package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncData;
	import GNNC.data.date.DateUtils;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.event.gnncEventGeneral;
	
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	
	import org.alivepdf.events.PageEvent;
	
	public dynamic class gnncFileReport extends Sprite
	{
		private var _parent:Object 					= null;
		
		public var _report:gnncAMFPhp 				= new gnncAMFPhp();
		public var _gnncFilePdf:gnncFilePdf			= new gnncFilePdf();

		public static const _headerBorder:uint 		= 0x999999;
		public static const _headerBg:uint 			= 0xEEEEEE;
		public static const _headerFont:uint 		= 6; //size
		public static const _headerRow:uint 		= 4;
		
		public static const _normalBorder:uint 		= 0x999999;
		public static const _normalBg:uint 			= 0xFFFFFF;
		public static const _normalFont:uint 		= 9; //size
		public static const _normalRow:uint 		= 4;
		
		public var _alertTextNoResult:String		= "Não foram encontrados dados na sua pesquisa.";
		public var _documentTitle:String 			= "documentTitle";
		public var _fileName:String 				= "fileName";
		public var _sql:String 						= '';
		public var _headInAllPages:Boolean			= true;
		public var _autoSave:Boolean				= true;
		
		public var _dateStart:Date					= null;
		public var _dateEnd:Date					= null;
		public var _object:Object					= null;
		public var _arrayC:ArrayCollection          = null; // substituir o _object['arrayC'];
		
		public var _itemRenderLength:uint			= 0;
		
		private var _error:String 					= '';

		//###########################################################################
		//CSV file
		public var _csvReturn:Boolean				= false;
		
		protected var _csvDocument:String 			= ''; //all
		protected var _csvHeader:Array 				= new Array();
		protected var _csvProperty:Array 			= new Array();
		protected var _csvHeaderSet:Boolean 		= false;
		
		protected var _csvContent:String 			= '';
		protected var _csvContentArrayC:ArrayCollection = new ArrayCollection();
		
		protected var _csvSeparator:String			= ';';
		protected var _csvBreakLine:String			= "\n";

		protected var _csvFooter:String 			= '';
		//###########################################################################

		public function gnncFileReport(parentApplication_:Object=null)
		{
			_parent = (parentApplication_)?parentApplication_:gnncGlobalStatic._parent;
			__csvClear();
		}
		
		protected function __csvClear():void
		{
			_csvHeader			= new Array();
			_csvProperty		= new Array();
			_csvHeaderSet		= false;
			_csvContent		 	= '';
			_csvContentArrayC	= new ArrayCollection();
			_csvSeparator		= ';';
			_csvBreakLine		= "\n";
			_csvFooter 			= '';
		}

		protected function __createEvent():void
		{
			addEventListener(gnncEventGeneral._complete,__finalReport);
		}
		
		protected function __addHeader(e:*=null):void
		{
			/**A4 wth margin = 190 or 260 **/
		}
		
		protected function __addResume(object_:Object):void
		{
			/**A4 wth margin = 190 or 260 **/
		}

		protected function __addFinalObservation(object_:Object):void
		{
			/**A4 wth margin = 190 or 260 **/
		}

		protected function __itemRender(object_:Object,i_:uint,objectAlternative_:Object=null):void
		{
			/**A4 wth margin = 190 or 260 **/
		}
		
		protected function __filterArrayCollection(arrayC_:ArrayCollection):ArrayCollection
		{
			return arrayC_;
		}

		protected function __finalReport(e:*=null):void
		{
			new gnncAlert().__textArea(_error);
		}
		
		protected function __setValues():void
		{
		}
		
		protected function __fResultPdf(e:*=null):void
		{
			gnncGlobalLog.__add("__fResult() start");
			
			// filter ArrayC
			_report.DATA_ARR 	= __filterArrayCollection(_report.DATA_ARR);
			_report.DATA_ROWS 	= __filterArrayCollection(_report.DATA_ARR).length;
			
			/*var t:String = gnncFileCsv.__arrayCollection2Csv(dp,
				new Array('city','email','firstName','lastName'),
				new Array('Cidade','Email','Nome','SobrenomeName'),
				';','','');
			
			new gnncFilesNative().__writeNative('csv1','csv','CSV',false,true,gnncFilesNative._desktop,t,null,null,null);*/
			
			//new gnncAlert().__dataGrid(_report.DATA_ARR);
			
			_itemRenderLength = _report.DATA_ARR.length;
			
			if(_itemRenderLength==0)// || !_report.DATA_ROWS)
			{
				gnncGlobalLog.__add("arrary null");
				new gnncAlert().__alert(_alertTextNoResult);
				return;
			}

			// header
			__addHeader();

			if(_headInAllPages)
				_gnncFilePdf._PDF.addEventListener(PageEvent.ADDED,__addHeader);

			// Content Pdf

			var repeat:uint = 0;

			// Repetir a emissão da ordem
			if(_object == null)
				_object = new Object();
			if(!_object.hasOwnProperty('repeat'))
				_object.repeat = 1;
			else if(!uint(_object.repeat))
				_object.repeat = 1;
			repeat = uint(_object.repeat);
			
			// Repeat Document - repete na mesma pagina tudo que foi impresso
			for(var k:uint=0; k<repeat; k++)
			{
				for(var i:uint=0; i<_report.DATA_ROWS; i++)
					__itemRender(_report.DATA_ARR.getItemAt(i),i);
			}
			
			_gnncFilePdf._PDF.removeEventListener(PageEvent.ADDED,__addHeader);

			// Footer
			__addResume(_report.DATA_ARR.getItemAt(0));

			// Final Observation
			__addFinalObservation(_report.DATA_ARR.getItemAt(0));

			//csv
			_csvDocument += _csvHeader.join(_csvSeparator) + _csvBreakLine;
			_csvDocument += _csvBreakLine + _csvContent + _csvBreakLine;
			_csvDocument += _csvBreakLine + _csvFooter + _csvBreakLine;

			// Write Pdf File  (Auto save to off if create a pdf file whith two consults sql)
			if(_autoSave)
			{
				if(_csvReturn && (_csvContent || _csvContentArrayC.length>0))
					new gnncFilesNative().__writeNative(_fileName,'csv','GNNC/Export',false,true,gnncFilesNative._documentDirectory,_csvDocument,null,null,null);
				else
					_gnncFilePdf.__saveDesktop(_fileName);
			}
			
			// Dispatche Event
			dispatchEvent(new gnncEventGeneral(gnncEventGeneral._complete));
			
			// Clear Data - For insert manual data and not consult sql
			_report.__clear();
			__csvClear();
			
			gnncGlobalLog.__add("__fResult() end");
		}
		
		protected function __fFaultPdf(e:*=null):void
		{
		}
		
		/**
		 * If you set information in "_report.DATA_ARR" not have consult SQL
		 * show
		 * 
		 * **/
		public function __create(object_:Object=null,dateStart_:Date=null,dateEnd_:Date=null):void
		{
			gnncGlobalLog.__add("__create() ok");
			
			_dateStart 	= dateStart_  ? gnncData.__clone(dateStart_) as Date : new Date();
			_dateEnd 	= dateEnd_    ? gnncData.__clone(dateEnd_)   as Date : new Date();
			_object 	= object_     ? object_ : _object;

			_gnncFilePdf = new gnncFilePdf(_parent);

			__setValues(); //dont remove this order

			_gnncFilePdf._document_3_type = _documentTitle;
			_gnncFilePdf.__addPage();

			gnncGlobalLog.__add("__create() addPage()");

			if(!_sql)
			{
				__fResultPdf.call();
				return;
			}

			gnncGlobalLog.__add("__create() sql");

			_report = new gnncAMFPhp();
			//_report.__destroy();
			_report.__sql(_sql,'','',__fResultPdf,__fFaultPdf);
			
			gnncGlobalLog.__add("__create() end");
		}
		
		//---------------------------------------------------------------------------------------
		
		/**
		 * add = -1 or add = 0
		 * **/
		protected function getDateStart(addDay:int=0):String
		{
			//var dateStartCurrent:String   = gnncDate.__date2String(_dateStart,false);
			//var dateStartYesterday:String = gnncDate.__date2String(DateUtils.dateAdd(DateUtils.DAY_OF_MONTH,-1,_dateStart),false);
			if(addDay==0)
				return gnncDate.__date2String(_dateStart,false);
			return gnncDate.__date2String(DateUtils.dateAdd(DateUtils.DAY_OF_MONTH,addDay,_dateStart),false);
		}
		
		/**
		 * add = -1 or add = 0
		 * **/
		protected function getDateEnd(addDay:int=0):String
		{
			//var dateEndCurrent:String   = gnncDate.__date2String(_dateEnd,false);
			//var dateEndYesterday:String = gnncDate.__date2String(DateUtils.dateAdd(DateUtils.DAY_OF_MONTH,-1,_dateEnd),false);
			if(addDay==0)
				return gnncDate.__date2String(_dateEnd,false);
			return gnncDate.__date2String(DateUtils.dateAdd(DateUtils.DAY_OF_MONTH,addDay,_dateEnd),false);
		}

		protected function getDatePeriodLegend():String
		{
			return getDateStart().substr(0,10)==getDateEnd().substr(0,10)? gnncDate.__date2Legend('',_dateStart) : gnncDate.__date2Legend('',_dateStart) + ' até ' + gnncDate.__date2Legend('',_dateEnd);
		}

		protected function getDateStartMonth():String
		{
			return gnncGlobalArrays._MONTH.getItemAt(_dateStart.month).label;
		}

		protected function getDateEndMonth():String
		{
			return gnncGlobalArrays._MONTH.getItemAt(_dateEnd.month).label;
		}
		
		protected function addCellHeader(labels:Array,widths:Array,alignText:Array=null,setUpCase:Boolean=true,marginBottom:Number=1):void
		{
			if( labels==null || widths==null )
				return;

			var i:uint;
			var l:Number = labels.length;
			var w:Number = widths.length;
			var s:String = '';
			var a:String = '';
			
			if(w != l){
				_gnncFilePdf.__addCell('A quantidade do label x width do Header não está correta',180 ,"L",10,0xeeeeee,0xcccccc);
				return;
			}
			
			if(alignText!=null)
				if(alignText.length != l)
					alignText = null;

			for(i=0;i<l;i++){
				
				_gnncFilePdf.__clearFillStyle();
				_gnncFilePdf.__clearFontStyle()
				_gnncFilePdf.__clearStrokeStyle();

				s = setUpCase ? String(labels[i]).toUpperCase() : String(labels[i]) ;
				w = widths[i] as Number;				
				a = alignText == null ? 'L' : String(alignText[i]) ;
				_gnncFilePdf.__setFontStyle(_headerFont); //FONT
				_gnncFilePdf.__addCell( s, w,a, _headerRow, _headerBg, _headerBorder );
				
			}
			_gnncFilePdf.__breakLine(_headerRow+marginBottom);
		}

		protected function addCellResume(labels:Array,widths:Array,bgColors:Array=null,colors:Array=null,alignText:Array=null,setUpCase:Boolean=false,marginTop:Number=2,setLine:Boolean=true):void
		{
			if( labels==null || widths==null )
				return;

			var h:Number = 9;
			var i:uint;
			var l:Number = labels.length;
			var w:Number = widths.length;
			var s:String = '';
			var a:String = '';
			
			var bg:uint = 0;
			var co:uint = 0;
			
			if( w != l ){
				_gnncFilePdf.__addCell('A quantidade do label x width do Header não está correta',180 ,"L",10,0xeeeeee,0xcccccc);
				return;
			}
			
			if(alignText!=null)
				if(alignText.length != l)
					alignText = null;
			if(bgColors!=null)
				if(bgColors.length != l)
					bgColors = null;
			if(colors!=null)
				if(colors.length != l)
					colors = null;


			_gnncFilePdf.__breakLine(marginTop);

			if(setLine)
				_gnncFilePdf.__addLine(0x444444,0.3);

			for(i=0;i<l;i++){
				
				_gnncFilePdf.__clearFillStyle();
				_gnncFilePdf.__clearFontStyle()
				_gnncFilePdf.__clearStrokeStyle();
				
				s = setUpCase ? String(labels[i]).toUpperCase() : String(labels[i]) ;
				w = widths[i] as Number;				
				a = alignText == null ? 'R' : String(alignText[i]) ;
				
				bg = bgColors == null ? _headerBg : uint(bgColors[i]);
				co = colors   == null ? 0x333333  : uint(colors[i]);
				
				_gnncFilePdf.__setFontStyle(10,co);
				_gnncFilePdf.__setFontWeight(false,10);
				_gnncFilePdf.__addCell( s, w, a, h, bg, _headerBorder );

				_gnncFilePdf.__clearFillStyle();
				_gnncFilePdf.__clearFontStyle()
				_gnncFilePdf.__clearStrokeStyle();

			}

			_gnncFilePdf.__breakLine(h);

		}

		protected function addCellTitle(title:String,subTitle:String,sizeTitle:Number=13,sizeSubTitle:Number=8):void
		{
			//-------------------------------------------------------------------------------------
			_gnncFilePdf.__setFontWeight(true,sizeTitle);
			_gnncFilePdf.__addCellInLine(title,'C',8);
			_gnncFilePdf.__setFontWeight(true,sizeSubTitle);
			_gnncFilePdf.__addCellInLine(subTitle,'C',3);
			_gnncFilePdf.__breakLine(5);
			//-------------------------------------------------------------------------------------
		}


		
	}
}

// START

/**

 protected override function __addHeader(e:*=null):void
 {
 	//A4 wth margin = 190 or 260 
 } 

 protected override function __addResume(object_:Object):void
 {
 	//A4 wth margin = 190 or 260 
 }

 protected override function __addFinalObservation(object_:Object):void
 {
	//A4 wth margin = 190 or 260
 }

 protected override function __itemRender(object_:Object,i_:uint,objectAlternative_:Object=null):void
 {
 	//A4 wth margin = 190 or 260 
 }

 protected override function __filterArrayCollection(arrayC_:ArrayCollection):ArrayCollection
 {
	return _object['arrayC'] ? _object['arrayC'] : arrayC_;
	//return _object['arrayC'];
	//return arrayC_;
 }
 
 protected override function __finalReport(e:*=null):void
 {
 }
 
 protected override function __setValues():void
 {
	_fileName = "DAYBYDAY - "+gnncGlobalStatic._programName+" - Nome";
	_documentTitle = "Nome";
	_sql = "SELECT * from dbd_client where ID > 0 LIMIT 0,10";
 }

 public function __createPersonal(...):void
 {
 }
 
 * **/

// END

/**

_gnncFilePdf._PDF.endFill ( );
_gnncFilePdf._PDF.lineStyle ( new RGBColor ( 0x000000 ), 0.1);//, .3, null, CapsStyle.ROUND, JointStyle.MITER);
_gnncFilePdf._PDF.moveTo ( 90, 20 );
_gnncFilePdf._PDF.lineTo ( 120, 80 );
_gnncFilePdf._PDF.lineTo ( 200, 20 );
_gnncFilePdf._PDF.lineTo ( 100, 10 );
_gnncFilePdf._PDF.lineTo ( 50, 100 );
_gnncFilePdf._PDF.end();

**/
