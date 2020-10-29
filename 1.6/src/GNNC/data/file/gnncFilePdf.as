package GNNC.data.file
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.application.gnncAppOS;
	import GNNC.application.gnncAppWindow;
	import GNNC.data.data.gnncDataHtml;
	import GNNC.data.date.gnncDate;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.time.gnncTime;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.html.HTMLPDFCapability;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.data.GridColumn;
	import org.alivepdf.display.Display;
	import org.alivepdf.events.PageEvent;
	import org.alivepdf.events.ProcessingEvent;
	import org.alivepdf.fonts.CoreFont;
	import org.alivepdf.fonts.FontFamily;
	import org.alivepdf.fonts.IFont;
	import org.alivepdf.images.ColorSpace;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Layout;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Resize;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Download;
	import org.alivepdf.saving.Method;

	public dynamic class gnncFilePdf
	{
		[Embed( source="image/gnnc.jpg", mimeType="application/octet-stream" )]
		private var gnncLogo:Class;
		public  var gnncLogoByteArray:ByteArray 	= new gnncLogo() as ByteArray;

		[Embed( source="image/bgh.jpg", mimeType="application/octet-stream" )]
		private var bgh:Class;
		public var bghByteArray:ByteArray = bgh as ByteArray;

		[Embed( source="image/bgv.jpg", mimeType="application/octet-stream" )]
		private var bgv:Class; 
		public var bgvByteArray:ByteArray = bgv as ByteArray;

		private var _gnncPopUP:gnncPopUp			= new gnncPopUp();

		private var _parent:Object					= null;
		public  var _PDF:PDF						= null;
		public var TRY:Boolean						= false;

		public var _document_0_logo:Object 			= null;
		public var _document_1_company:String		= "";
		public var _document_2_description:String 	= "";
		public var _document_3_type:String 			= "";

		public var _normalFontSize:uint 			= 9;
		public var _normalFontColor:uint 			= 0x000000;
		public var _normalFontFamily:String 		= FontFamily.HELVETICA;
		public var _normalFontUnderline:Boolean 	= false;
		public var _normalHeightRow:uint 			= 4;
		public var _normalBg:uint 					= 0xFFFFFF;
		public var _normalBgAlternative:uint 		= 0xEEEEEE;
		public var _normalBorder:uint 				= 0x888888;
		public var _normalFont:IFont				= new CoreFont(_normalFontFamily);
		
		public var _showHeader:Boolean				= true;
		public var _locationSystemSave_:String		= gnncFileCookie.__get('FILE_PDF','PATH') ? gnncFileCookie.__get('FILE_PDF','PATH').toString() : gnncFilesNative._documentDirectory;
		public var _currentNumberPage:uint 			= 0;

		public var _pageSize:Size 					= Size.A4;
		public var _pageUnit:String 				= Unit.MM;
		public var _pageOrientation:String 			= Orientation.PORTRAIT;
		public var _pageMarginTop:uint 				= 40;
		public var _pageMarginBottom:uint 			= 30;
		public var _pageMarginLeft:uint 			= 10;
		public var _pageMarginRight:uint 			= 10;
		
		private var _images:Array					= new Array();
		private var _imagesCompletes:Array			= new Array();
		private var _repeatSave:uint 				= 0;
		private var _fileName:String 				= '_fileName';
		
		private var _gnncAppWin:gnncAppWindow 		= new gnncAppWindow();
		
		//new HTTPLink("http://alivepdf.bytearray.org/"));

		public function gnncFilePdf(parentApplication_:Object=null,TRY_:Boolean=false)
		{
			_parent 						= parentApplication_?parentApplication_:gnncGlobalStatic._parent;
			TRY 							= TRY_;

			_PDF							= null;

			_document_0_logo 				= gnncGlobalStatic._documentPdfLogo			?gnncGlobalStatic._documentPdfLogo			:null;
			_document_1_company				= gnncGlobalStatic._documentPdfCompany		?gnncGlobalStatic._documentPdfCompany		:"GNNC - Estratégia Empresarial / gNial";
			_document_2_description 		= gnncGlobalStatic._documentPdfDescription	?gnncGlobalStatic._documentPdfDescription	:"www.gnnc.com.br / www.gnial.com.br";
		}
		
		public function get _x():Number
		{
			return _PDF.getX();
		}

		public function set _x(x:Number):void
		{
			_PDF.setX(x);
		}

		public function get _y():Number
		{
			return _PDF.getY();
		}

		public function set _y(y:Number):void
		{
			_PDF.setY(y);
		}

		public function get _pageWidth():uint
		{
			//return uint(_PDF.getCurrentPage().size.mmSize[0])
			return _pageOrientation == Orientation.PORTRAIT ? _PDF.getCurrentPage().size.mmSize[0] : _PDF.getCurrentPage().size.mmSize[1]; //A4 mm 
		}

		public function get _pageHeight():uint
		{
			//return uint(_PDF.getCurrentPage().size.mmSize[1])
			return _pageOrientation == Orientation.PORTRAIT ? _PDF.getCurrentPage().size.mmSize[1] : _PDF.getCurrentPage().size.mmSize[0]; //A4 mm
		}

		public function get _pageWidthWithoutMargin():uint
		{
			return uint(_pageWidth-(_pageMarginLeft+_pageMarginRight));
		}
		
		public function get _pageHeightWithoutMargin():uint
		{
			return uint(_pageHeight-(_pageMarginTop+_pageMarginBottom));
		}

		public function __setPageMargin(top:Number,right:Number,bottom:Number,left:Number,showHeader:Boolean=true):void
		{
			_pageMarginTop     = top;
			_pageMarginBottom  = bottom;
			_pageMarginLeft    = left;
			_pageMarginRight   = right;
			_showHeader        = showHeader;
		}

		
		
		

		
		/** ##########################################################
		 *  ##########################################################
		 *  COMPABILITY PDF
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		

		
		static public function __isPdfCapability():Boolean
		{
			/**
			// Check to see if Adobe Reader 8.1 or higher is installed
			// Possible values:
			//         HTMLPDFCapability.STATUS_OK 
			//         HHTMLPDFCapability.ERROR_INSTALLED_READER_NOT_FOUND
			//         HTMLPDFCapability.ERROR_INSTALLED_READER_TOO_OLD 
			//         HTMLPDFCapability.ERROR_PREFERRED_READER_TOO_OLD
			 * **/
			
			if(HTMLLoader.pdfCapability == HTMLPDFCapability.STATUS_OK)
				return true;
			else
				return false;
		}
		
		static public function __getSystemCapability():String
		{
			var namePdfProgram:String = '"Adobe Acrobar/PDF"';
			
			switch(HTMLLoader.pdfCapability)
			{
				case HTMLPDFCapability.STATUS_OK:
					return namePdfProgram+' está instalado corretamente em seu sistema operacional '+gnncAppOS.__getOSNameComplete()+'.';
					break;
				case HTMLPDFCapability.ERROR_CANNOT_LOAD_READER:
					return 'Faltam alguns arquivos para que o '+namePdfProgram+' funcione corretamente. Tente instalá-lo novamente.';
					break;
				case HTMLPDFCapability.ERROR_INSTALLED_READER_NOT_FOUND:
					return 'Provavelmente seu sistema não tenha o programa correto para funcionar o '+namePdfProgram+'.';
					break;
				case HTMLPDFCapability.ERROR_PREFERRED_READER_TOO_OLD:
				case HTMLPDFCapability.ERROR_INSTALLED_READER_TOO_OLD:
					return 'Versão anterior ao 9.0 do '+namePdfProgram+'. Tente atualizá-lo se possível.';
					break;
				default:
					return 'Não foi possível identificar o problema com o PDF. Verifique se está instalado.';
			}
			
			return '';
		}
		
		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  DOCUMENT AND PAGES
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		private var _fontPreserve:Object = new Object();

		public function __addHeader(event:PageEvent=null):void
		{
			__ifNoPage();
			__clearFontStyle();
			
			if(!_showHeader)
				return;
						
			/**  Header  **/
			_PDF.beginFill					(new RGBColor(0xFFFFFF));
			_PDF.lineStyle					(new RGBColor(0xAAAAAA),0,0,1);
			//_PDF.drawRect					(new Rectangle(-5,-5,(_PDF.getDefaultOrientation() == Orientation.PORTRAIT) ? _pageWidth+5 : _pageHeight+5,35+5));
			_PDF.drawRect					(new Rectangle(-5,-5,_pageWidth+5,35+5));
			//_PDF.drawRect					(new Rectangle(-5,-5,_pageHeight+5,35+5));
			
			/**  Header Text  **/
			_PDF.setFont					(_normalFont,14);
			_PDF.textStyle					(new RGBColor(0x333333),1);
			_PDF.addText					(_document_1_company,12,15);
			_PDF.setFont					(_normalFont,9);
			_PDF.addText					(_document_2_description,12,20);
			_PDF.addText					(_document_3_type,12,25);
			
			/**  Header logo  **/
			var x:Number = _pageWidth-_pageMarginLeft-_pageMarginRight-60; //130
			
			if(!_document_0_logo)
			{
				gnncGlobalLog.__add('Image Document #1');
				_PDF.addImageStream			(gnncLogoByteArray as ByteArray,ColorSpace.DEVICE_RGB,null,x,-30,60,20); //values in pixel   |  130
			}
			else if(_document_0_logo.toString().toLowerCase() == "blank")
			{
				gnncGlobalLog.__add('Image Document #none');
				//none
			}
			else if(_document_0_logo is DisplayObject)
			{
				gnncGlobalLog.__add('Image Document #DisplayObject');
				__addImageUI				(_document_0_logo as DisplayObject,null,x,-30,60,20);
			}
			else if(_document_0_logo is String)
			{
				gnncGlobalLog.__add('Image Document #String');
				__addImageUrl				(_document_0_logo as String,x,-30,60,20);
			}
			else if(gnncGlobalStatic._documentPdfLogo != null)
			{
				gnncGlobalLog.__add('Image Document #byteArray Global');
				__addImageByteArray			(gnncGlobalStatic._documentPdfLogo,null,x,-30,60,20,0,1,ColorSpace.DEVICE_RGB);
			}
			
			/** Footer  **/
			_PDF.beginFill					(new RGBColor(0xFFFFFF));
			_PDF.lineStyle					(new RGBColor(0xAAAAAA),0,0,1);
			//_PDF.drawRect					(new Rectangle(-5,(_pageOrientation == Orientation.PORTRAIT) ? _pageHeight-20 : _pageWidth-20,_pageHeight+10,25));
			_PDF.drawRect					(new Rectangle(-5, _pageHeight-20,_pageWidth+10,25));
			
			//new gnncAlert().__alert('_pageWidth:'+_pageWidth+'| _pageHeight:'+_pageHeight+'');
			//new gnncAlert().__alert('_pageWidthm:'+_pageWidthWithoutMargin+'| _pageHeightM:'+_pageHeightWithoutMargin+'');
			
			/** Footer Text **/
			_PDF.setFont					(_normalFont,6);
			_PDF.textStyle					(new RGBColor(0x555555),1);
			_PDF.moveTo						(0,0);
			_PDF.addText					("Gerado por: GNNC - Estratégia Empresarial (www.gnnc.com.br)  |  Pacote: DAYBYDAY  |  Aplicativo: "+gnncGlobalStatic._programName+" v"+gnncGlobalStatic._programVersion,60,_pageHeight-10 );
			_PDF.addText					("Página: "+_currentNumberPage+"  ( Emissão: "+gnncDate.__date2Legend('',new Date(),true,true,"Nenhuma data",true)+") ",_pageMarginLeft,_pageHeight-10 );
			
			_PDF.setFont					(_normalFont,10);
			//_PDF.addText					(_document_1_company,_pageMarginLeft,(_pageOrientation == Orientation.PORTRAIT) ? _pageHeight-13 : _pageWidth-13);
			_PDF.addText					(_document_1_company,_pageMarginLeft,_pageHeight-13);
			
			__clearFontStyle();
			__clearFillStyle();
			__clearStrokeStyle();
			
			_currentNumberPage++;
		}		
		
		private function __ifNoPage():void
		{
			if(!_currentNumberPage)
				__addPage();
		}

		public function __removeAllPages():void
		{
			_PDF.removeAllPages()
		}

		public function __removePageIndex(index_:uint):void
		{
			_PDF.removePage(index_);
		}

		public function __getPages():Array
		{
			return _PDF.getPages(); 
		}

		/**
		 * A4 wth margin = 190 or 260 
		 * 
		 * pageOrientation_ = Orientation.PORTRAIT; Orientation.LANDSCAPE
		 * pageUnit_        = Unit.MM; Unit.CM; Unit.POINT;Unit.INCHES;
		 * pageSize_        = Size.A4; Size.A3; Size.A5; Size.LEGAL; Size.LETTER;
		 */
		public function __addPage(pageOrientation_:String='',pageUnit_:String='',pageSize_:Size=null):void
		{
			_currentNumberPage++;

			/**  BEGIN  **/
			if(!_PDF)
			{
				//set var in global
				_pageSize 						= !pageSize_ 		? _pageSize 		: pageSize_;
				_pageUnit						= !pageUnit_ 		? _pageUnit 		: pageUnit_ ;
				_pageOrientation		 		= !pageOrientation_ ? _pageOrientation 	: pageOrientation_;

				//start PDF
				_PDF 							= new PDF(_pageOrientation,_pageUnit,_pageSize);
				_PDF.addEventListener			(PageEvent.ADDED,__addHeader);
				_PDF.addEventListener			(ProcessingEvent.COMPLETE,__complete);
				
				_PDF.addEventListener			(IOErrorEvent.IO_ERROR,__error);
				_PDF.addEventListener			(IOErrorEvent.STANDARD_ERROR_IO_ERROR,__error);
				_PDF.addEventListener			(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR,__error);
				_PDF.addEventListener			(IOErrorEvent.VERIFY_ERROR,__error);
				_PDF.addEventListener			(IOErrorEvent.DISK_ERROR,__error);
				//_PDF.addEventListener
				
				_PDF.setDisplayMode 			(Display.FULL_PAGE,Layout.ONE_COLUMN);
				
				_PDF.setTitle					('GNNC e gNial - Program: DAYBYDAY - '+gnncGlobalStatic._programName);
				_PDF.setAuthor					('NATAN CABRAL - GNNC e gNial - Program: DAYBYDAY - '+gnncGlobalStatic._programName);
				_PDF.setCreator					('NATAN CABRAL - GNNC e gNial - Program: DAYBYDAY - '+gnncGlobalStatic._programName);
				_PDF.setKeywords				("Design, Agency, Communication, Consult, etc. www.gnnc.com.br www.gnial.com.br");
				_PDF.setMargins					(_pageMarginLeft,_pageMarginTop,_pageMarginRight,_pageMarginBottom);
				
				_images							= new Array();
				_imagesCompletes				= new Array();
				_repeatSave						= 0;
			}
			
			_PDF.addPage					();
		}
		
		
		
		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  SETTINGS
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		public function __setXY(x_:Number,y_:Number):void
		{
			_PDF.setXY(x_,y_);
		}
		
		public var cellGlobalHeight:Number = 0;
		public var cellGlobalBgColor:Number = 0;
		public var cellGlobalBorderColor:Number = 0;
		//public var cellGlobalfontColor:Number = 0;
		//public var cellGlobalfontSize:Number = 0;
		
		public function setCell(height:Number=0,bgColor:uint=0,borderColor:uint=0,fontColor:uint=0,fontSize:Number=0):void
		{
			_PDF.endFill();
			_PDF.end();
			
			cellGlobalHeight      = height      > 0 ? height      : _normalHeightRow ;
			cellGlobalBgColor     = bgColor     > 0 ? bgColor     : cellGlobalBgColor ;
			cellGlobalBorderColor = borderColor > 0 ? borderColor : _normalBorder ;
			
		}		
		
		/**
		 * size:uint=NaN,
		 * color:uint=NaN,
		 * bold:Boolean=false,
		 * fontFamily:String = FontFamily.HELVETICA
		 * alpha:Number=NaN,
		 * letterSpace:Number=0,
		 * wordSpace_:Number=0 
		 * **/
		public function setFontStyle( 
			size:uint = NaN, 
			color:uint = NaN, 
			bold:Boolean = false,
			underline:Boolean = false,
			family:String = '',
			alpha:Number = NaN, 
			letterSpace:Number = 0,
			wordSpace:Number = 0,
			saveStyle:Boolean=true
		):void
		{
			if(saveStyle==true)
			{
				_fontPreserve.size      = size  ? size  : _normalFontSize ;
				_fontPreserve.color     = color ? color : _normalFontColor ;
				_fontPreserve.family    = family != '' ? family : _normalFontFamily ;
				_fontPreserve.alpha     = alpha ? alpha : 1 ;
				_fontPreserve.underline = underline ;

				_PDF.setFont  ( new CoreFont( bold == true ? FontFamily.HELVETICA_BOLD : _fontPreserve.family ), _fontPreserve.size, _fontPreserve.underline );
				_PDF.textStyle( new RGBColor( _fontPreserve.color ), _fontPreserve.alpha, 0, wordSpace, letterSpace, 100, 0 );
			}
			else
			{
				_PDF.setFont  ( new CoreFont( bold == true ? FontFamily.HELVETICA_BOLD : family ), size, underline );
				_PDF.textStyle( new RGBColor( color ), alpha, 0, wordSpace, letterSpace, 100, 0 );
			}
		}
		
		public function setFontStyleTemporary(
			size:uint = NaN, 
			color:uint = NaN, 
			bold:Boolean = false,
			underline:Boolean = false,
			family:String = '',
			alpha:Number = NaN, 
			letterSpace:Number = 0,
			wordSpace:Number = 0
		):void
		{
			setFontStyle(size,color,bold,underline,family,alpha,letterSpace,wordSpace,false);
		}

		public function clearFonrStyle():void
		{
			_fontPreserve.size      = _fontPreserve.hasOwnProperty('size')      ? _fontPreserve.size      : _normalFontSize ;
			_fontPreserve.color     = _fontPreserve.hasOwnProperty('color')     ? _fontPreserve.color     : _normalFontColor ;
			_fontPreserve.family    = _fontPreserve.hasOwnProperty('family')    ? _fontPreserve.family      : _normalFontFamily ;
			_fontPreserve.alpha     = _fontPreserve.hasOwnProperty('alpha')     ? _fontPreserve.alpha     : 1 ;
			_fontPreserve.underline = _fontPreserve.hasOwnProperty('underline') ? _fontPreserve.underline : false ;

			_PDF.setFont  ( new CoreFont( _fontPreserve.font  ), _fontPreserve.size, _fontPreserve.underline );
			_PDF.textStyle( new RGBColor( _fontPreserve.color ), _fontPreserve.alpha, 0, 0, 0, 100, 0 );
		}

		
		public function __setFontStyle( fontSize_:uint=NaN, fontColor_:uint=NaN, alpha_:Number=NaN, letterSpace_:Number=NaN, wordSpace_:Number=NaN ):void
		{
			_fontPreserve.font 		= _normalFontFamily ; //normal_ ? _normalFontFamily : FontFamily.HELVETICA_BOLD ;
			_fontPreserve.size 		= fontSize_ ? fontSize_ : _normalFontSize ;
			_fontPreserve.color 	= fontColor_ ? fontColor_ : _normalFontColor ;

			/** Font Settings **/
			_PDF.setFont			( new CoreFont( _fontPreserve.font ), _fontPreserve.size );
			_PDF.textStyle			( new RGBColor( _fontPreserve.color ),
				alpha_ 			? alpha_ 		: 1,
				0,
				wordSpace_ 		? wordSpace_ 	: 0,
				letterSpace_ 	? letterSpace_ 	: 0//,
				//fontScale 	? fontScale 	: 1
			);
		}
		
		public function __setFontWeight( normal_:Boolean, fontSize_:uint = NaN , underline_:Boolean = false ):void
		{
			_fontPreserve.font 		= normal_ ? _normalFontFamily : FontFamily.HELVETICA_BOLD ;
			_fontPreserve.size 		= fontSize_ ? fontSize_ : _normalFontSize ;
			_fontPreserve.underline = underline_ ;
			_fontPreserve

			/** Font Settings **/
			_PDF.setFont			( new CoreFont ( _fontPreserve.font ) , _fontPreserve.size , _fontPreserve.underline );
		}

		public function __clearFontStyle():void
		{
			/** ### **/
			_fontPreserve.font 		= _fontPreserve.hasOwnProperty('font')  	? _fontPreserve.font  		: _normalFontFamily ;
			_fontPreserve.size 		= _fontPreserve.hasOwnProperty('size')  	? _fontPreserve.size  		: _normalFontSize ;
			_fontPreserve.color 	= _fontPreserve.hasOwnProperty('color') 	? _fontPreserve.color 		: _normalFontColor ;
			_fontPreserve.underline = _fontPreserve.hasOwnProperty('underline') ? _fontPreserve.underline 	: false;
			/** ### **/
	
			/** Original Settings **/
			_PDF.setFont			( new CoreFont(_fontPreserve.font), _fontPreserve.size , _fontPreserve.underline );
			_PDF.textStyle			( new RGBColor(_fontPreserve.color) );

		}

		public function __setFillStyle(color_:uint,alpha_:uint=1):void
		{
			_PDF.beginFill(new RGBColor(color_),alpha_);
		}

		public function __clearFillStyle():void
		{
			_PDF.endFill();
			//_PDF.beginFill(new RGBColor(0xFFFFFF),0);
			//_PDF.endFill();
		}

		public function __setStrokeStyle(color_:uint,thickness_:Number=0.1):void
		{
			_PDF.lineStyle(new RGBColor(color_),thickness_);
		}

		public function __clearStrokeStyle():void
		{
			_PDF.end();
		}
		

		public function __clearAll():void
		{
			__clearFontStyle();
			__clearFillStyle();
			__clearStrokeStyle();
			__addCell(' ',1,'C',0.001,0,0); //remove style
			__breakLine(0.001);
		}

		
		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  PRIMITIVE SHAPES
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		
		
		public function __addRectangle(width_:uint,height_:uint,x_:uint,y_:uint,bgColor_:uint,borderColor_:uint):void 
		{
			__ifNoPage();
			__clearFontStyle();
			
			if(borderColor_)
				__setStrokeStyle		(borderColor_,1);
			else
				__clearStrokeStyle		();
			
			if(borderColor_)
				__setFillStyle			(bgColor_);
			else
				__clearFillStyle		();
			
			_PDF.drawRect				(new Rectangle( x_, y_, width_, height_ ));
		}
		
		public function __addLine(borderColor_:uint,thickness_:Number=0.1,forceX_:Number=0,forceY_:Number=0,forceWidth_:Number=0):void 
		{
			//_gnncFilePdf._PDF.lineStyle ( new RGBColor ( 0x000000 ), 0.1);//, .3, null, CapsStyle.ROUND, JointStyle.MITER);

			__ifNoPage();
			__clearFillStyle();
			
			var _x:Number = forceX_?forceX_:_pageMarginLeft;
			var _w:Number = Number(this._pageWidth)-_pageMarginLeft-_pageMarginRight;

			__setStrokeStyle( borderColor_ , thickness_ );
			_PDF.moveTo ( _x, forceY_?forceY_:_PDF.getY() );
			_PDF.lineTo ( forceWidth_?forceWidth_+_x:_w+_pageMarginLeft, forceY_?forceY_:_PDF.getY() );
			_PDF.end();
			
			__breakLine(thickness_-0.2);
			
		}
		
		
		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  PRINT, LINES and COLLECTIONS
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		
		
		public function __breakLine(rowHeight_:Number):void
		{
			if(rowHeight_>0){
				_PDF.newLine(rowHeight_);
			}

		}

		public function __addTextMultiCell(text_:String,width_:Number,heightLine_:Number,align_:String='L',fill_:int=0,border_:int=0):void
		{
			__ifNoPage();
			_PDF.addMultiCell(width_,heightLine_,text_,border_,align_,fill_);
		}

		public function __addTextHtml(textHtml_:String,pHeight_:uint=4):void
		{
			__ifNoPage();
			_PDF.writeFlashHtmlText(pHeight_,textHtml_);
		}
		
		public function __addTextFlow(textFlow_:TextFlow,pHeight_:uint=4):void
		{
			__ifNoPage();
			_PDF.writeFlashHtmlText(pHeight_,gnncDataHtml.__textFlow2FlashHtml(textFlow_));
		}
		
		public function __addText(text_:String,x:int=0,y:int=0):void
		{
			__ifNoPage();
			_PDF.addText(text_,x,y);
		}
		
		public function __addCellInLine(text_:String,alignText_L_C_R_:String='',rowHeight_:Number=10,bgColor:uint=0,borderColor:uint=0):void
		{ 
			__ifNoPage();

			_PDF.endFill();
			_PDF.end();
			
			if(borderColor)
				_PDF.lineStyle				(new RGBColor(borderColor),0);
			
			if(bgColor)
				_PDF.beginFill				(new RGBColor(bgColor));
				
			var _lineWidth:uint				= _pageWidthWithoutMargin;
			_PDF.addCell					(_lineWidth,rowHeight_,text_,borderColor?1:0,0,alignText_L_C_R_,bgColor?1:0);
			_PDF.newLine					(rowHeight_);
			
			_PDF.endFill();
			_PDF.end();
			
		}

		public function __addCell(text_:String,width_:Number,align_L_C_R:String,height_:Number=6,bgColor_:uint=0,borderColor:uint=0):void
		{ 
			__ifNoPage();
			
			_PDF.endFill();
			_PDF.end();
			
			if(borderColor)
				_PDF.lineStyle				(new RGBColor(borderColor),0);
			
			if(bgColor_)
				_PDF.beginFill				(new RGBColor(bgColor_));

			_PDF.addCell					(width_,height_,text_,borderColor?1:0,0,align_L_C_R,bgColor_?1:0);

			_PDF.endFill();
			_PDF.end();

		}
		
		/**
		 * Use setCell to define colors and heights
		 * 
		 * 
		 * **/
		public function addCell(label:Object,width:Number,alignLCR:String,height:Number=0,bgColor:uint=0):void
		{ 
			__ifNoPage();
			
			_PDF.endFill();
			_PDF.end();
			
			height  = height  > 0 ? height  : cellGlobalHeight ;
			bgColor = bgColor > 0 ? bgColor : cellGlobalBgColor;
			
			_PDF.lineStyle(new RGBColor(cellGlobalBorderColor),0);
			_PDF.beginFill(new RGBColor(bgColor));
			
			_PDF.addCell(width,height,String(label),cellGlobalBorderColor>0?1:0,0,alignLCR,bgColor?1:0);
			
			_PDF.endFill();
			_PDF.end();
		}
		
		public function addCellLine(label:Array,width:Array,alignLCR:Array,height:Number=0,bgColor:uint=0):void
		{
			__ifNoPage();
			var l:uint = 0;
			var i:uint = 0;
			for( i=0; i<l; i++ ){
			}
		}

		
		public function __addGrid(arrayC_:ArrayCollection,columnsHeanderName_:Array,columnsPropertyName_:Array,columnWidth_:Array=null):void
		{
			__ifNoPage();
			
			if(arrayC_==null)
				return;
			
			if(!arrayC_.length)
				return;
			
			//add event
			_PDF.addEventListener(PageEvent.ADDED,__setLine);
			
			function __setLine(event:PageEvent=null):void
			{
				__setFontStyle();
				//_PDF.lineStyle				(new RGBColor(0x888888),0,0,1);
			}

			var i:uint 						= 0;
			var columns:Array 				= [];
			var _widthLine:uint				= _pageWidth-(_pageMarginRight+_pageMarginLeft);
			var LIST_WIDTH_TOTAL:uint		= 0;

			if(columnWidth_!=null)
				for(var x:uint=0; x<columnsHeanderName_.length; x++)
					LIST_WIDTH_TOTAL = LIST_WIDTH_TOTAL+columnWidth_[x];

			if(columnWidth_==null)
			{
				for(var h:uint=0; h<columnsPropertyName_.length; h++)
					columnWidth_.push(_widthLine/columnsPropertyName_.length);
			}
			else if(columnWidth_.length < columnsPropertyName_.length)
			{
				columnWidth_.push(_widthLine-LIST_WIDTH_TOTAL);
			}		
			
			if(LIST_WIDTH_TOTAL>_widthLine)
			{
				LIST_WIDTH_TOTAL 			= LIST_WIDTH_TOTAL-columnWidth_[columnWidth_.length-1];
				columnWidth_.pop			();
				columnWidth_.push			(_widthLine-LIST_WIDTH_TOTAL);
			}
			
			while(i<columnsPropertyName_.length)
			{
				columns.push				(new GridColumn(columnsHeanderName_[i],columnsPropertyName_[i],columnWidth_[i], Align.CENTER, Align.LEFT));
				i++;
			}

			var grid:Grid 					= new Grid( arrayC_.toArray(), 100, 100, new RGBColor( 0xCCCCCC ), new RGBColor (0xf6f6f6), true, new RGBColor (0x888888), 1,"0j",columns);
			//grid.columns					= columns;
			_PDF.addGrid					( grid );
			
			//remove event
			_PDF.removeEventListener(PageEvent.ADDED,__setLine);

		}
		
		private function __addImageInGrid(INDEX_:uint=0,HEIGHT_:uint=0,DISPLAY_OBJECT_:DisplayObject=null,COLOR_RGB_:RGBColor=null):void
		{
			if(DISPLAY_OBJECT_ != null)
			{
				_PDF.addImage	(DISPLAY_OBJECT_,null,0,_PDF.getY()-this._pageMarginTop,HEIGHT_,HEIGHT_);
				_PDF.lineStyle	(COLOR_RGB_,0,0,1);
				_PDF.drawRect	(new Rectangle(_pageMarginLeft,_PDF.getY(),HEIGHT_,HEIGHT_));
			}
		}

		private function __labelInPaper(tryInBlock_:Boolean,arrayText_:Array,pageOrientationPortrait_:Boolean,marginTopBottomLeftRight_:Array,columnAndRow_:Array,gapHV_:Array,textLneHeight_:Number=3):void
		{
			if(marginTopBottomLeftRight_.length!=4 || columnAndRow_.length!=2)
			{
				new gnncAlert().__alert('Margens, colunas ou linhas estão incorretas.');
				return;
			}
			
			if(columnAndRow_[0] == 0 || columnAndRow_[1] == 0)
			{
				new gnncAlert().__alert('Colunas ou linhas não podem ter valor 0 (zero).');
				return;
			}

			if(!tryInBlock_ && !arrayText_.length)
			{
				new gnncAlert().__alert('A lista está vazia. Realize uma pesquisa antes de continuar.');
				return;
			}
			
			_pageOrientation 	= pageOrientationPortrait_ ? Orientation.PORTRAIT : Orientation.LANDSCAPE;
			_pageMarginTop 		= marginTopBottomLeftRight_[0];
			_pageMarginBottom 	= marginTopBottomLeftRight_[1];
			_pageMarginLeft 	= marginTopBottomLeftRight_[2];
			_pageMarginRight 	= marginTopBottomLeftRight_[3];
			_showHeader			= false;
			__addPage();
			
			var w:Number 				= _pageWidthWithoutMargin;
			var h:Number 				= _pageHeightWithoutMargin;
			var i:uint					= 0;
			var row:uint				= 0;
			var boxW:uint				= 0;
			var boxH:uint				= 0;
			var x:Array					= new Array();
			var y:Array					= new Array();
			var itensForPageCount:uint	= 0;
			var itensForPage:uint		= columnAndRow_[0]*columnAndRow_[1];
			
			w 							= w-(gapHV_[0]*(columnAndRow_[0]-1));
			h 							= h-(gapHV_[1]*(columnAndRow_[1]-1));
			
			boxW 						= w/columnAndRow_[0];
			boxH 						= h/columnAndRow_[1];
			
			//if(i==100)
			for(i=0; i<itensForPage; i++)
			{
				x.push(_x);
				y.push(_y);
				
				__addCell(_x+'-'+_y,boxW,"C",boxH,0xEEEEEE,0x999999);
				if(row < columnAndRow_[0] && gapHV_[0])
					__addCell('',gapHV_[0],"L",1);
				
				row++;
				if(row == columnAndRow_[0])
				{
					row=0;
					__breakLine(boxH+gapHV_[1]);
				}
			}
			
			if(!tryInBlock_)
				// remove all page with boxes
				__removeAllPages();
			else
				// remove all pages, but not first page
				for(var z:uint = 1; z<=__getPages().length; z++)
					__removePageIndex(z);
			
			if(!tryInBlock_)
				__addPage();
			
			_PDF.setXY( 0, 0);
			
			if(!tryInBlock_)
				for(i=0; i<arrayText_.length; i++)
				{
					__setFontStyle(8);
					_PDF.setXY( x[row], y[itensForPageCount]);
					_PDF.addMultiCell( boxW, textLneHeight_, arrayText_[i]);
					
					row++;
					itensForPageCount++;
					
					if(row == columnAndRow_[0])
					{
						row = 0;
						__setXY( _x, boxH);
						//_PDF.__breakLine(boxH);
					}
					
					if(itensForPageCount == itensForPage)
					{
						itensForPageCount = 0;
						__addPage();
						__setXY(0,0);
					}
				}
			
			///_PDF._PDF.addText("This is some addText() text \\n abc \n abc",20,5 );
			//_PDF._PDF.writeFlashHtmlText(
			
			__saveDesktop(_fileName);
		}

		
		
		/** ##########################################################
		 *  ##########################################################
		 *  CHARTs
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		
		public function __addChartPie(arraC_labelAndpercent_:ArrayCollection=null,legend_:Boolean=true,radiusPie_:Number=20,forceX_:Number=0,forceY_:Number=0,defaultStyles_:Boolean=true,legendRow:Number=3,legendPaddingLeft_:Number=2,legendGap_:Number=0.5,legendTitle_:String=''):void
		{
			__clearFillStyle();
			__clearStrokeStyle();
			__clearFontStyle();

			var i:uint 		= 0;
			var xc:Number 	= forceX_ ? forceX_ + radiusPie_ : _x + radiusPie_;
			var yc:Number 	= forceY_ ? forceY_ + radiusPie_ : _y + radiusPie_;
			
			var legendWidth:Number = radiusPie_*2;
			
			var a:Number 	= 0
			var b:Number 	= 0;
			var s:String = '';
			
			var colors:Array = [0x000000,0x222222,0x444444,0x666666,0x888888,0xAAAAAA,0xCCCCCC,0xEEEEEE,
								0x111111,0x333333,0x555555,0x777777,0x999999,0xBBBBBB,0xDDDDDD,0xFFFFFF,
								0x000000,0x222222,0x444444,0x666666,0x888888,0xAAAAAA,0xCCCCCC,0xEEEEEE,
								0x111111,0x333333,0x555555,0x777777,0x999999,0xBBBBBB,0xDDDDDD,0xFFFFFF];
			
			colors = gnncGlobalArrays._chartColorV3.toArray();
			
			var arrayTest:ArrayCollection = new ArrayCollection
				([
					{label:"opa",percent:15},
					{label:"ops!",percent:15},
					{label:"nossa",percent:10},
					{label:"aa",percent:10},
					{label:"bb",percent:20},
					{label:"vv",percent:30},
				]);
			
			if(!arraC_labelAndpercent_)
				arraC_labelAndpercent_ = arrayTest;
			
			if(!arraC_labelAndpercent_.length)
				arraC_labelAndpercent_ = arrayTest;
			
			if(!arraC_labelAndpercent_.getItemAt(0).hasOwnProperty('label') || !arraC_labelAndpercent_.getItemAt(0).hasOwnProperty('percent'))
				arraC_labelAndpercent_ = arrayTest;
			
			if(defaultStyles_)
				_PDF.lineStyle( new RGBColor ( 0x888888 ), .1 );
			
			for(i=0; i<arraC_labelAndpercent_.length; i++)
			{
				a = !i ? 0 : 360/100*Number(arraC_labelAndpercent_.getItemAt(i-1).percent) + a; //percentPie + oldPercentPiePosition
				b = 360/100*Number(arraC_labelAndpercent_.getItemAt(i).percent) + b; //percentPie + oldPercentPiePosition

				__setFillStyle(colors[i]);
				_PDF.drawSector(xc, yc, radiusPie_, a, b);
				
				s +="\n i:"+i+" - A:"+a+" - B:"+b;
			}

			if(legend_ && forceX_)
				__setXY(_x,forceY_);
			
			if(legendTitle_){

				if(defaultStyles_)
					__clearFontStyle();

				__addCell('',legendWidth+legendPaddingLeft_,"C",legendRow,0,0);
				__addCell(legendTitle_,legendRow*5,"L",legendRow,0,0);
				__breakLine(legendRow+legendGap_);

			}

			if(legend_)
				for(i=0; i<arraC_labelAndpercent_.length; i++)
				{
					if(defaultStyles_)
						__clearFontStyle();
					
					var p:Number = arraC_labelAndpercent_.getItemAt(i).percent;
					
					__addCell("",legendWidth+legendPaddingLeft_,"C",legendRow,0,0);
					__addCell((p>0?p+"%":''),legendRow*3,"L",legendRow,0,0);
					__addCell("",legendRow,"C",legendRow,colors[i],0x888888);
					__addCell(arraC_labelAndpercent_.getItemAt(i).label,legendWidth,"L",legendRow,0,0);
					__breakLine(legendRow+legendGap_);
				}
			
			//new gnncAlert().__alert(s);
			
			_PDF.end();
		}
		
		
		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  IMAGES
		 *  ##########################################################
		 *  ##########################################################
		 * **/

		public function __addImageGrid():void
		{
			var img:ByteArray = _pageOrientation == Orientation.PORTRAIT ? bgvByteArray as ByteArray : bghByteArray as ByteArray;
			_PDF.addImageStream	(img,ColorSpace.DEVICE_RGB,null,0,0,_pageWidth,_pageHeight,0,1);
		}
		
		public function __addImageUI(displayObject_:Object,resizeMode_:Resize=null,x_:Number=0,y_:Number=0,width_:Number=10,height_:Number=10,rotation_:Number=0,alpha_:Number=1):void
		{
			__ifNoPage();
			_PDF.addImage					(displayObject_ as DisplayObject,null,x_,y_,width_,height_,rotation_,alpha_);
		}
		
		public function __addImageByteArray(imageByteArray_:ByteArray,resizeMode_:Resize=null,x_:Number=0,y_:Number=0,width_:Number=10,height_:Number=10,rotation_:Number=0,alpha_:Number=1,colorSpace_:String=ColorSpace.DEVICE_RGB):void
		{
			__ifNoPage();
			_PDF.addImageStream				(imageByteArray_ as ByteArray,colorSpace_,resizeMode_,x_,y_,width_,height_,rotation_,alpha_);
		}
		
		public function __addImageUrl(url_or_path_:String,x_:Number,y_:Number,width_:Number,height_:Number,rotate_:Number=0,alpha_:Number=1):void
		{
			__ifNoPage();
			_images.push(1);

			var curr:uint					= _currentNumberPage;
			var urlLoader:URLLoader 		= new URLLoader();
			urlLoader.dataFormat 			= URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener		(Event.COMPLETE,function(event:Event):void
			{ 
				__addImageLoadComplete(event,x_,y_,width_,height_,rotate_,alpha_,url_or_path_.substr((url_or_path_.length-3),3),curr);//_PDF.totalPages       //_PDF.getCurrentPage().number
			});
			urlLoader.addEventListener		(IOErrorEvent.IO_ERROR,__erroImage);
			urlLoader.addEventListener		(SecurityErrorEvent.SECURITY_ERROR,__erroImage);
			urlLoader.load					(new URLRequest(url_or_path_));
		}
		
		private function __addImageLoadComplete(event:Event,x_:Number,y_:Number,width_:Number,height_:Number,rotate_:Number,alpha_:Number,extension_:String,page_:uint):void
		{
			__ifNoPage();
			_imagesCompletes.push(1);
			
			try
			{
				_PDF.gotoPage				(page_);
				_PDF.addImageStream			(ByteArray(event.target.data),ColorSpace.DEVICE_RGB, null, x_, y_, width_, height_, rotate_, alpha_);
			}
			catch(e:*)
			{
			}
		}
		

		
		
		/** ##########################################################
		 *  ##########################################################
		 *  EVENTS
		 *  ##########################################################
		 *  ##########################################################
		 * **/

		
		
		
		public function __erroImage(e:*):void
		{
			new gnncAlert(_parent).__error('Um ou mais imagens não foram encontradas.');
			_imagesCompletes.push(1);
		}

		public function __error(e:*):void
		{
			//ERRO;
			new gnncAlert(_parent).__error('Ocorreu um erro. Verifique se o arquivo já não está aberto ou se você tem permissão para salvar.');
			_gnncPopUP.__close();
		}
		
		protected function __complete(event:ProcessingEvent):void
		{
		}

		
		
		
		/** ##########################################################
		 *  ##########################################################
		 *  SAVE
		 *  ##########################################################
		 *  ##########################################################
		 * **/
		
		
		
		
		
		private function __saveDesktopRepeat():void{__saveDesktop(_fileName)}
		public function __saveDesktop(_fileName_:String='_fileNamePdf'):void
		{
			if(_images.length == _imagesCompletes.length)
			{
				var bytes:ByteArray = _PDF.save( Method.LOCAL );
				new gnncFilesNative(_parent).__writeNative(_fileName_,'pdf','GNNC/Export',false,true,_locationSystemSave_,null,null,bytes);
				_gnncPopUP.__close();
			} 
			else
			{
				if(_repeatSave<6)
				{
					_gnncPopUP.__loading('PDF...');
					new gnncTime().__start(3000,__saveDesktopRepeat,1);
					_repeatSave++;
				}
				else
				{
					new gnncAlert(_parent).__error('Erro. ['+_images.length+'|'+_imagesCompletes.length+']');
					_gnncPopUP.__close();
				}
			}
		}
		
		private function __saveRemoteRepeat():void{ __saveRemote(_fileName) }
		public function __saveRemote(fileName_:String='file'):void
		{
			_fileName = fileName_;

			var _fileNameArray:Array = _fileName.split(".");
			_fileName = _fileNameArray[0];
			
			if(_images.length == _imagesCompletes.length)
			{
				//Download.INLINE
				//Download.ATTACHMENT
				_PDF.save(Method.REMOTE,gnncGlobalStatic._httpHost + gnncGlobalArrays.serverFileOpenRemote,Download.INLINE,fileName_+'.pdf');
				_gnncPopUP.__close();
			} 
			else
			{
				if(_repeatSave<6)
				{
					_gnncPopUP.__loading('PDF...');
					new gnncTime().__start(3000,__saveRemoteRepeat,1);
					_repeatSave++;
				}
				else
				{
					new gnncAlert(_parent).__error('Erro. ['+_images.length+'|'+_imagesCompletes.length+']');
					_gnncPopUP.__close();
				}
			}
		}
		
		private function __saveBrowserRepeat():void{ __saveBrowser(_fileName) }
		public function __saveBrowser(fileName_:String='file'):void
		{
			_fileName = fileName_;
			
			var _fileNameArray:Array = _fileName.split(".");
			_fileName = _fileNameArray[0];
			
			if(_images.length == _imagesCompletes.length)
			{
				try
				{
					var bytes:ByteArray = _PDF.save(Method.LOCAL);
					var f:FileReference = new FileReference();
					f.addEventListener	(IOErrorEvent.IO_ERROR,__error);
					f.addEventListener	(SecurityErrorEvent.SECURITY_ERROR,__error);
					f.save				(bytes,fileName_+'.pdf');
					_gnncPopUP.__close();
				}
				catch(e:*)
				{
					new gnncAlert(_parent).__error('Ocorreu um erro. Verifique se o arquivo já não está aberto ou se você tem permissão para salvar.');
				}
			} 
			else
			{
				if(_repeatSave<6)
				{
					_gnncPopUP.__loading('PDF...');
					new gnncTime().__start(3000,__saveBrowserRepeat,1);
					_repeatSave++;
				}
				else
				{
					new gnncAlert(_parent).__error('Erro. ['+_images.length+'|'+_imagesCompletes.length+']');
					_gnncPopUP.__close();
				}
			}
		}

		
	}
}
	
