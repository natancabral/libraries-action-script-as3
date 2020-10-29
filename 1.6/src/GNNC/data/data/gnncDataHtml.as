package GNNC.data.data
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.date.gnncDate;
	
	import flash.external.ExternalInterface;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.FlowGroupElement;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	import mx.collections.ArrayCollection;
	
	import spark.utils.TextFlowUtil;

	public class gnncDataHtml
	{
		private var _parent:Object = null;
		
		static private var i:uint;
		static private var e:uint;
		static private var _arrayC:ArrayCollection;
		static private var _html:String;
		static private var _htmlStyle:String;
		static private var _htmlColor:String;

		public function gnncDataHtml(parentApplication_:Object=null,TRY_:Boolean=false)
		{
			_parent = parentApplication_;
		}
		
		/** 
		 * Only for HTML PROJECT WEB FLASH 
		 * **/
		static public function __externalJavaScript(functionName_:String,...parameters):void
		{
			ExternalInterface.call(functionName_,parameters);
		}
		
		static public function array2Table(arrayC:ArrayCollection,headerName:Array,propertyName:Array,widthColumns:Array,setStyle:Boolean=true):String
		{ 
			//replace space null in table
			var nullToSpaceBlank_:String = '&nbsp;';
			var _break:String = "\n";
			var w:String = '';
			var v:String = '';
			
			function wPercent(v:Object,set:String=''):String{
				return String(v).indexOf('%')>-1 ? String(v) : String(v).split('px').join('')+set ;
			}
			
			_arrayC 	= gnncData.__clone(arrayC) as ArrayCollection;
			_html 		= "";
			_htmlStyle 	= "";
			
			_html += _break;
			_html += _break;
			
			if(setStyle) _htmlStyle = "style='border: 1px solid #999; font-family: Arial; width:100%;'";
			_html += "<table width='100%' "+_htmlStyle+" >";
			_html += _break;
			
			if(headerName.length>0)
			{
				if(setStyle) _htmlStyle = "style='background-color: #888; color: #FFF '";
				_html += "<tr "+_htmlStyle+" >";
				_html += _break;
				
				for(i=0; i<headerName.length; i++){
					if(i < propertyName.length){
						w = (i < widthColumns.length) ? ' width:' + wPercent(widthColumns[i],'px;') : '' ;
						if(setStyle) _htmlStyle = "style='color: #FFF; padding: 3px; "+w+" '";
						w = (i < widthColumns.length) ? ' width="' + wPercent(widthColumns[i]) + '"' : '' ;
						_html += "  <td "+_htmlStyle+" "+w+">"+headerName[i]+"</td>";
						_html += _break;
					}
				}
				_html += "</tr>";
				_html += _break;
			}
			
			for(i=0; i<_arrayC.length; i++)
			{
				_htmlColor = i%2?"FFF":"EEE";
				if(setStyle) _htmlStyle = "style='background-color: #"+_htmlColor+"; padding: 3px; '";
				
				if(_arrayC.getItemAt(i) != null){
					_html += "<tr class='line-"+(i+1)+"'>";
					_html += _break;
					
					for(e=0; e<propertyName.length; e++){
						var _content:String = _arrayC.getItemAt(i)[propertyName[e]];
						_html += "  <td "+_htmlStyle+">";
						
						if(propertyName[e].toString().substr(0,4)=='DATE') // If Date
							_html += gnncDate.__date2Legend(_content);
						else
							_html += gnncData.__trimText(_content) == 'null' ? nullToSpaceBlank_ : _content ;
						
						_html += "  </td>";
						_html += _break;
					}
					_html += "</tr>";
					_html += _break;
				}
			}
			
			_html += "</table>";
			_html += _break;
			_html += _break;
			
			return _html;
		}
		
		static public function __array2Html(arrayCollection_:ArrayCollection,header_:Array,property_:Array,styleLines:Boolean,idNameTable_:String='all',nullToSpaceBlank_:String='&nbsp;',header_gnncHtmlStyles_:Object=null,general_gnncHtmlStyles_:Object=null):String
		{
			var _break:String = "\n";
			
			_arrayC 	= gnncData.__clone(arrayCollection_) as ArrayCollection;
			_html 		= "";
			_htmlStyle 	= "";
			
			//replace space null in table
			nullToSpaceBlank_ = !nullToSpaceBlank_ ? '&nbsp;' : nullToSpaceBlank_;
			
			_html += _break;
			_html += _break;
			
			if(styleLines) _htmlStyle = "style='border: 1px solid #999; font-family: Arial'";
			_html += "<table width='100%' "+_htmlStyle+" class='web-table-daybyday web-table-id-"+idNameTable_+"' >";
			_html += _break;
			
			if(header_.length>0)
			{
				if(styleLines) _htmlStyle = "style='background-color: #888; color: #FFF '";
				_html += "<tr "+_htmlStyle+" class='web-table-header-tr line-0' >";
				_html += _break;
				
				for(i=0; i<header_.length; i++)
				{
					if(i < property_.length)
					{
						if(styleLines) _htmlStyle = "style='color: #FFF; padding: 3px; '";
						_html += "  <td "+_htmlStyle+" class='web-table-header-td column-"+i+"'>"+header_[i]+"</td>";
						_html += _break;
					}
				}
				
				_html += "</tr>";
				_html += _break;
			}
			
			for(i=0; i<_arrayC.length; i++)
			{
				var _lineColor:String = i%2?"web-table-line-td-01":"web-table-line-td-02";
				
				_htmlColor = i%2?"FFF":"EEE";
				if(styleLines) _htmlStyle = "style='background-color: #"+_htmlColor+"; padding: 3px; '";
				
				if(_arrayC.getItemAt(i) != null)
				{
					_html += "<tr class='line-"+(i+1)+"'>";
					_html += _break;
					
					for(e=0; e<property_.length; e++)
					{
						var _content:String = _arrayC.getItemAt(i)[property_[e]];
						_html += "  <td "+_htmlStyle+" class='"+_lineColor+" column-"+(e)+"' >";
						
						if(property_[e].toString().substr(0,4)=='DATE') // If Date
							_html += gnncDate.__date2Legend(_content);
						else
							_html += gnncData.__trimText(_content) == 'null' ? nullToSpaceBlank_ : _content ;
						
						_html += "  </td>";
						_html += _break;
					}
					
					_html += "</tr>";
					_html += _break;
				}
			}
			
			_html += "</table>";
			
			_html += _break;
			_html += _break;
			
			return _html;
		}
		
		static public function __removeHtmlTags( inputStr : String , br2break_:Boolean = true) : String
		{
			var _str:String = inputStr;
			
			if(br2break_)
			{
				_str = gnncData.__replace(_str,'<br>',"\n")
				_str = gnncData.__replace(_str,'<br/>',"\n")
				_str = gnncData.__replace(_str,'</br>',"\n")
			}
			
			return _str.replace(RegExp(/<.*?>/g),"" );
		}

		static public function __removeTags(html:String, tagsNoReplace_:String = ""):String
		{
			tagsNoReplace_ = gnncData.__replace(tagsNoReplace_,";",",");
			
			var tagsToBeKept:Array = new Array();
			if (tagsNoReplace_.length > 0)
				tagsToBeKept = tagsNoReplace_.split(new RegExp("\\s*,\\s*"));
			
			var tagsToKeep:Array = new Array();
			for (var i:int = 0; i < tagsToBeKept.length; i++)
			{
				if (tagsToBeKept[i] != null && tagsToBeKept[i] != "")
					tagsToKeep.push(tagsToBeKept[i]);
			}
			
			var toBeRemoved:Array = new Array();
			var tagRegExp:RegExp = new RegExp("<([^>\\s]+)(\\s[^>]+)*>", "g");
			
			var foundedStrings:Array = html.match(tagRegExp);
			for (i = 0; i < foundedStrings.length; i++) 
			{
				var tagFlag:Boolean = false;
				if (tagsToKeep != null) 
				{
					for (var j:int = 0; j < tagsToKeep.length; j++)
					{
						var tmpRegExp:RegExp = new RegExp("<\/?" + tagsToKeep[j] + "( [^<>]*)*>", "i");
						var tmpStr:String = foundedStrings[i] as String;
						if (tmpStr.search(tmpRegExp) != -1) 
							tagFlag = true;
					}
				}
				if (!tagFlag)
					toBeRemoved.push(foundedStrings[i]);
			}
			for (i = 0; i < toBeRemoved.length; i++) 
			{
				var tmpRE:RegExp = new RegExp("([\+\*\$\/])","g");
				var tmpRemRE:RegExp = new RegExp((toBeRemoved[i] as String).replace(tmpRE, "\\$1"),"g");
				html = html.replace(tmpRemRE, "");
			} 
			return html;
		}
		
		/** 
		 * DAYBYDAY: __textFlow2FlashHtml
		 * For COMPONENT_TEXTEDIT.editor.textFlow -> FLASHHTML
		 * PDF.writeFlashHtmlText();
		 * **/
		
		/** 
		 * TEXTFLOW -> HTML
		 * **/
		static public function __textFlow2FlashHtml(textFlow_:TextFlow):String
		{
			return TextConverter.export(textFlow_,TextConverter.TEXT_FIELD_HTML_FORMAT,ConversionType.STRING_TYPE).toString();
		}

		/** 
		 * TEXTFLOW -> STRING
		 * **/
		static public function __textFlow2String(textFlow_:TextFlow):String
		{
			return TextConverter.export(textFlow_,TextConverter.PLAIN_TEXT_FORMAT,ConversionType.STRING_TYPE).toString();
		}

		/** 
		 * TEXTFLOW -> XML
		 * **/
		static public function __textFlow2Xml(textFlow_:TextFlow):XML
		{
			XML.ignoreWhitespace = false;
			return TextFlowUtil.export(textFlow_);
		}

		/** 
		 * STRING -> TEXTFLOW
		 * **/
		static public function __html2TextFlow(textHtml_:Object):TextFlow
		{
			return TextConverter.importToFlow(textHtml_,TextConverter.TEXT_FIELD_HTML_FORMAT);
		}

		/** 
		 * STRING -> TEXTFLOW
		 * **/
		static public function __string2TextFlow(text_:String,preserveWhiteSpace_:String=WhiteSpaceCollapse.PRESERVE):TextFlow
		{
			try
			{
				return TextFlowUtil.importFromString(text_,preserveWhiteSpace_);
			} 
			catch(e:*)
			{
				new gnncAlert().__error('Erro. Provavelmente o conteúdo não seja uma string.');
			}
			
			return new TextFlow(); 
		}

		/** 
		 * XML -> TEXTFLOW
		 * **/
		static public function __xml2TextFlow(textXml_:XML,preserveWhiteSpace_:String=WhiteSpaceCollapse.PRESERVE):TextFlow
		{
			XML.ignoreWhitespace = false;
			return TextFlowUtil.importFromXML(textXml_,preserveWhiteSpace_);
		}

		/**
		 * 
		 * TESTING - LINK IN TEXTFLOW
		 * 
		 * **/
		
		/**
		 * Converts the html string (from the resources) into a TextFlow object
		 * using the TextConverter class. Then it iterates through all the 
		 * elements in the TextFlow until it finds a LinkElement, and adds a 
		 * FlowElementMouseEvent.CLICK event handler to that Link Element.
		 */
		
		public static function __addClickInLInk(html:String, linkClickedHandler:Function):TextFlow 
		{
			var textFlow:TextFlow = TextConverter.importToFlow(html, TextConverter.TEXT_FIELD_HTML_FORMAT);
			var link:LinkElement = __findLinkElement(textFlow);
			
			if (link != null) 
			{
				link.addEventListener(FlowElementMouseEvent.CLICK, 
					linkClickedHandler, false, 0, true);
			} 
			else 
			{
				trace("Warning - couldn't find link tag in: " + html);
			}
			
			return textFlow;
		}
		
		/**
		 * Finds the first LinkElement recursively and returns it.
		 */
		private static function __findLinkElement(group:FlowGroupElement):LinkElement 
		{
			var childGroups:Array = [];
			
			// First check all the child elements of the current group,
			// Also save any children that are FlowGroupElement
			
			for (var i:int = 0; i < group.numChildren; i++) 
			{
				var element:FlowElement = group.getChildAt(i);
				
				if (element is LinkElement) 
				{
					return (element as LinkElement);
				} 
				else if (element is FlowGroupElement) 
				{
					childGroups.push(element);
				}
			}
			
			// Recursively check the child FlowGroupElements now
			
			for (i = 0; i < childGroups.length; i++) 
			{
				var childGroup:FlowGroupElement = childGroups[i];
				var link:LinkElement = __findLinkElement(childGroup);
				
				if (link != null) {
					return link;
				}
			}
			
			return null;
		}
		
		private static function __htmlChars():Object
		{
			//var a:Array = new Array("	","!","'","--- ",'"',"#","%","$",'¹','²','³','ª','º','°','¤','£','¢','»','¿','¡','µ','ß','À','à','Á','á','Â','â','Ã','ã','Ä','ä','Å','å','Æ','æ','Ç','ç','Ð','ð','È','è','É','é','Ê','ê','Ë','ë','Ì','ì','Í','í','Î','î','Ï','ï','Ñ','ñ','Ò','ò','Ó','ó','Ô','ô','Õ','õ','Ö','ö','Ø','ø','Œ','œ','ß','Þ','þ','Ù','ù','Ú','ú','Û','û','Ü','ü','Ý','ý','Ÿ','ÿ');
			//var b:Array = new Array("&Tab;","&excl;","&apos;","&deg;","&quot;","&num;","&percnt;","&dollar;",'&cedil;','&sup2;','&sup3;','&uml;','&sup1;','&deg;','&pound;','&cent;','&iexcl;','&ordm;','&frac12;','&nbsp;','&acute;','&Yacute;','&Agrave;','&agrave;','&Aacute;','&aacute;','&Acirc;','&acirc;','&Atilde;','&atilde;','&Auml;','&auml;','&Aring;','&aring;','&AElig;','&aelig;','&Ccedil;','&ccedil;','&ETH;','&eth;','&Egrave;','&egrave;','&Eacute;','&eacute;','&Ecirc;','&ecirc;','&Euml;','&euml;','&Igrave;','&igrave;','&Iacute;','&iacute;','&Icirc;','&icirc;','&Iuml;','&iuml;','&Ntilde;','&ntilde;','&Ograve;','&ograve;','&Oacute;','&oacute;','&Ocirc;','&ocirc;','&Otilde;','&otilde;','&Ouml;','&ouml;','&Oslash;','&oslash;','&OElig;','&oelig;','&szlig;','&THORN;','&thorn;','&Ugrave;','&ugrave;','&Uacute;','&uacute;','&Ucirc;','&ucirc;','&Uuml;','&uuml;','&Yacute;','&yacute;','&Yuml;','&yuml;');

			var obj:Object = new Object();
			obj["&"]="&amp;";
			obj["<"]="&lt;";
			obj[">"]="&gt;";
			obj["	"]="&Tab;";
			obj["!"]="&excl;";
			obj["'"]="&apos;";
			obj["--- "]="&deg; ";
			obj['"']="&quot;";
			obj["#"]="&num;";
			obj["%"]="&percnt;";
			obj["$"]="&dollar;";
			obj['¹']='&cedil;';
			obj['²']='&sup2;';
			obj['³']='&sup3;';
			obj['ª']='&uml;';
			obj['º']='&sup1;';
			obj['°']='&deg;';
			obj['¤']='&pound;';
			obj['£']='&cent;';
			obj['¢']='&iexcl;';
			obj['»']='&ordm;';
			obj['¿']='&frac12;';
			obj['¡']='&nbsp;';
			obj['µ']='&acute;';
			obj['ß']='&Yacute;';
			obj['À']='&Agrave;';
			obj['à']='&agrave;';
			obj['Á']='&Aacute;';
			obj['á']='&aacute;';
			obj['Â']='&Acirc;';
			obj['â']='&acirc;';
			obj['Ã']='&Atilde;';
			obj['ã']='&atilde;';
			obj['Ä']='&Auml;';
			obj['ä']='&auml;';
			obj['Å']='&Aring;';
			obj['å']='&aring;';
			obj['Æ']='&AElig;';
			obj['æ']='&aelig;';
			obj['Ç']='&Ccedil;';
			obj['ç']='&ccedil;';
			obj['Ð']='&ETH;';
			obj['ð']='&eth;';
			obj['È']='&Egrave;';
			obj['è']='&egrave;';
			obj['É']='&Eacute;';
			obj['é']='&eacute;';
			obj['Ê']='&Ecirc;';
			obj['ê']='&ecirc;';
			obj['Ë']='&Euml;';
			obj['ë']='&euml;';
			obj['Ì']='&Igrave;';
			obj['ì']='&igrave;';
			obj['Í']='&Iacute;';
			obj['í']='&iacute;';
			obj['Î']='&Icirc;';
			obj['î']='&icirc;';
			obj['Ï']='&Iuml;';
			obj['ï']='&iuml;';
			obj['Ñ']='&Ntilde;';
			obj['ñ']='&ntilde;';
			obj['Ò']='&Ograve;';
			obj['ò']='&ograve;';
			obj['Ó']='&Oacute;';
			obj['ó']='&oacute;';
			obj['Ô']='&Ocirc;';
			obj['ô']='&ocirc;';
			obj['Õ']='&Otilde;';
			obj['õ']='&otilde;';
			obj['Ö']='&Ouml;';
			obj['ö']='&ouml;';
			obj['Ø']='&Oslash;';
			obj['ø']='&oslash;';
			obj['Œ']='&OElig;';
			obj['œ']='&oelig;';
			obj['ß']='&szlig;';
			obj['Þ']='&THORN;';
			obj['þ']='&thorn;';
			obj['Ù']='&Ugrave;';
			obj['ù']='&ugrave;';
			obj['Ú']='&Uacute;';
			obj['ú']='&uacute;';
			obj['Û']='&Ucirc;';
			obj['û']='&ucirc;';
			obj['Ü']='&Uuml;';
			obj['ü']='&uuml;';
			obj['Ý']='&Yacute;';
			obj['ý']='&yacute;';
			obj['Ÿ']='&Yuml;';
			obj['ÿ']='&yuml;';
			
			//return gnncDataObject.__object2ArrayCollection(obj);
			return obj;
		}

		/** 
		 * Html Char to Symbol
		 *  
		 *  "&amp;" => "&"
		 *	"&lt;" => "<"
		 *  "&gt;" => ">"
		 * 
		 * if REPLACE_ null, replace all
		 * 
		 * */
		public static function __htmlDecode(string_:String,replace_:Array=null):String
		{
			var i:uint				= 0;
			var stg:String 			= String(string_);
			var obj:Object			= __htmlChars();
			var pro:Array			= gnncDataObject.__getPropertysNames(obj);
			var len:uint			= pro.length;

			if(replace_ == null)
				for(i=0; i<len; i++)
				{
					//obj[pro[i]] = "&amp;";
					//pro[i] = "&";
					stg = gnncData.__replace(stg, obj[pro[i]], pro[i]);
				}
			else
				for(i=0; i<replace_.length; i++)
				{
					//obj[replace_[i]] = "&amp;";
					//replace_[i] = "&";
					stg = gnncData.__replace(stg, obj[replace_[i]], replace_[i]);
				}
				
			return stg;

		}
		
		/**
		 * Symbol to Html Char
		 * 
		 *  "&" => "&amp;"
		 *	"<" => "&lt;"
		 *  ">" => "&gt;"
		 * 
		 * if REPLACE_ null, replace all
		 * 
		 * */
		public static function __htmlEncode(string_:String,replace_:Array=null):String
		{
			var i:uint				= 0;
			var stg:String 			= String(string_);
			var obj:Object			= __htmlChars();
			var pro:Array			= gnncDataObject.__getPropertysNames(obj);
			var len:uint			= pro.length;
			
			if(replace_ == null)
				for(i=0; i<len; i++)
				{
					//obj[pro[i]] = "&amp;";
					//pro[i] = "&";
					stg = gnncData.__replace(stg, pro[i], obj[pro[i]]);
				}
			else
				for(i=0; i<replace_.length; i++)
				{
					//obj[replace_[i]] = "&amp;";
					//replace_[i] = "&";
					stg = gnncData.__replace(stg, replace_[i], obj[replace_[i]]);
				}
			
			return stg;
		}
		
		public static function isUrl(url_:String):Boolean {
			var regexp:RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			return regexp.test(url_);
		}
	
	}
}