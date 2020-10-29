package GNNC.elements.component.select.report
{
	import GNNC.data.data.gnncData;
	import GNNC.data.file.gnncFileReport;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.collections.ArrayCollection;

	public class gnncFileReport_series extends gnncFileReport
	{
		public function gnncFileReport_series()
		{
		}
		
		protected override function __addHeader(e:*=null):void
		{
			//A4 wth margin = 190 or 260 
			_gnncFilePdf.__setFontStyle(_headerFont); //FONT
			_gnncFilePdf.__addCell('NOME'					,130,"C",4,_headerBg,_headerBorder);

			if(_object['TABLE']=='GROUP' && (_object['MIX']=='FINANCIAL_IN' || _object['MIX']=='FINANCIAL_OUT')){
				_gnncFilePdf.__addCell('CUSTO'				,15 ,"C",4,_headerBg,_headerBorder);
			}

			_gnncFilePdf.__addCell('NÍVEL'					,15 ,"C",4,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell('ID'						,15 ,"L",4,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell('SUBID'					,15 ,"C",4,_headerBg,_headerBorder);

			_gnncFilePdf.__breakLine(4);
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
			//A4 wth margin = 190 or 260 			var LEVEL:uint = OBJ.LEVEL;
			var _normalBg:uint  = Number(object_.LEVEL)==0 ? 0xDDDDDD : Number(object_.LEVEL)==1 ? gnncFileReport._normalBg : Number(object_.LEVEL)==2 ? 0xEEEEEE : gnncFileReport._normalBg;
			var _normalRow:uint = Number(object_.LEVEL)==0 ? 4+2 : 4+1;
			var space:String 	= Number(object_.LEVEL)==0 ? " ": Number(object_.LEVEL)==1 ? "   " : Number(object_.LEVEL)==2 ? "      " : "         "; 
			
			if(Number(object_.LEVEL)==0){
				_gnncFilePdf.__setFontWeight(false,_normalFont-2);
				_gnncFilePdf.__breakLine(1);
			}else{
				_gnncFilePdf.__setFontStyle(_normalFont-1); //FONT
			}

			_gnncFilePdf.__addCell(space+gnncData.__firstLetterUpperCase(object_.NAME)		,130,"L",_normalRow,_normalBg,_normalBorder);
			
			if(_object['TABLE']=='GROUP' && (_object['MIX']=='FINANCIAL_IN' || _object['MIX']=='FINANCIAL_OUT')){
				_gnncFilePdf.__addCell(Number(object_.TYPE_FINANCIAL_FIX)==1?'Fixo':Number(object_.TYPE_FINANCIAL_FIX)==2?'Variável':'',15 ,"L",_normalRow,_normalBg,_normalBorder);
			}
			
			_gnncFilePdf.__addCell(object_.LEVEL											,15 ,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(object_.ID												,15 ,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(object_.ID_FATHER										,15 ,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__breakLine(_normalRow);
		}
		
		protected override function __filterArrayCollection(arrayC_:ArrayCollection):ArrayCollection
		{
			return _object['arrayC'];
		}
		
		protected override function __finalReport(e:*=null):void
		{
		}
		
		protected override function __setValues():void
		{
			_fileName = "DAYBYDAY - "+gnncGlobalStatic._programName+" - Series";
			_documentTitle = _object['title'];
			_sql = "";
		}

	}
}