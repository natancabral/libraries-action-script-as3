package GNNC.modules.client.report
{
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataNumber;
	import GNNC.data.file.gnncFileReport;
	import GNNC.data.globals.gnncGlobalStatic;
	
	import mx.collections.ArrayCollection;
	
	public class gnncFileReport_client_inListSimple extends gnncFileReport
	{
		public function gnncFileReport_client_inListSimple()
		{
		}
		
		protected override function __addHeader(e:*=null):void
		{
			//A4 wth margin = 190 or 260 
			_gnncFilePdf.__setFontStyle(_headerFont); //Font
			
			_gnncFilePdf.__addCell("Nome"			,100,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("CPF"			,30 ,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Matrícula"		,30 ,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Registro Prof."	,23 ,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("UF"				,7  ,"L",_headerRow,_headerBg,_headerBorder);
			
			_gnncFilePdf.__breakLine(_headerRow);
			
			_gnncFilePdf.__addCell("Endereço"		,70,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Número"			,13,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Compl."			,13,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Bairro"			,34,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Cidade"			,30,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Estado"			,30,"L",_headerRow,_headerBg,_headerBorder);
			
			_gnncFilePdf.__breakLine(_headerRow);
			
			_gnncFilePdf.__addCell("E-mail"			,70,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Telefone"		,30,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Celular"		,30,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Tel. Emp."		,30,"L",_headerRow,_headerBg,_headerBorder);
			_gnncFilePdf.__addCell("Fax"			,30,"L",_headerRow,_headerBg,_headerBorder);
			
			_gnncFilePdf.__breakLine(_headerRow+1);
			
			_gnncFilePdf.__setFontStyle(_normalFont+1);
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
			_gnncFilePdf.__setFontStyle(_normalFont+2); //Font
			//_gnncFilePdf.__setFontWeight(true);
			
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.NAME)			,100,"L",_normalRow+1,0xeeeeee,_normalBorder);
			
			_gnncFilePdf.__setFontStyle(_normalFont); //Font
			
			_gnncFilePdf.__addCell(String(object_.CPF_CNPJ).substr(0,4)=='2626'?'-':String(object_.CPF_CNPJ)	,30 ,"L",_normalRow+1,0xeeeeee,_normalBorder);
			_gnncFilePdf.__addCell(object_.ENROLLMENT										,30 ,"L",_normalRow+1,0xeeeeee,_normalBorder);
			_gnncFilePdf.__addCell(object_.PROFESSIONAL_NUMBER								,23 ,"C",_normalRow+1,0xeeeeee,_normalBorder);
			_gnncFilePdf.__addCell(String(object_.PROFESSIONAL_STATE).toUpperCase()			,7  ,"C",_normalRow+1,0xeeeeee,_normalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+1);

			_gnncFilePdf.__setFontStyle(_normalFont-1); //Font

			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.ADDRESS)			,70,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(object_.ADDRESS_NUMBER									,13,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(object_.ADDRESS_COMPLEMENT								,13,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.NEIGHBORHOOD)	,34,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.CITY)			,30,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.STATE)			,30,"L",_normalRow,_normalBg,_normalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow);
			
			_gnncFilePdf.__addCell(String(object_.EMAIL).toLowerCase()						,70,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE)			,30,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_CEL)		,30,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_COMPANY)	,30,"L",_normalRow,_normalBg,_normalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_FAX)		,30,"L",_normalRow,_normalBg,_normalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+1);

		}
		
		protected override function __filterArrayCollection(arrayC_:ArrayCollection):ArrayCollection
		{
			return _object['arrayC'] ? _object['arrayC'] : arrayC_;
			//return arrayC_;
		}
		
		protected override function __finalReport(e:*=null):void
		{
		}
		
		protected override function __setValues():void
		{
			_fileName 			= "DAYBYDAY - "+gnncGlobalStatic._programName+" - Relacao dos Clientes (Personalizada)";
			_documentTitle  	= "Relação dos Clientes (Personalizada)";
			
			_sql 				= "";
		}

		public function __createPersonal(list_:ArrayCollection):void
		{
			_object 			= new Object();
			_object['arrayC']	= list_;
			
			__create();
		}
	}
}