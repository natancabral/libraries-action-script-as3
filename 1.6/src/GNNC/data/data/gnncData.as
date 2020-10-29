package GNNC.data.data
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	import flash.utils.ByteArray;
	
	import flashx.textLayout.elements.TextFlow;
	
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	
	public class gnncData
	{
		private var _parent:Object;
		
		public function gnncData(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		
		/** ####################################################################### **/
		/** ############################## FUNCTIONS ############################## **/
		/** ####################################################################### **/

		public static function addSlash(str:String):String
		{
			str = gnncData.__replace(str,'"','\"');
			str = gnncData.__replace(str,"'","\'");
			return str;
		}

		public static function removeSlash(str:String):String
		{
			str = gnncData.__replace(str,'\\"','"');
			str = gnncData.__replace(str,"\\'","'");
			str = gnncData.__replace(str,'\"','"');
			str = gnncData.__replace(str,"\'","'");
			return str;
		}

		public static function __clone(object_:Object):Object
		{
			return ObjectUtil.clone(object_);
		}

		public static function labelFunctionFirstLetter(item:Object):String {
			return __firstLetterUpperCase(item.hasOwnProperty('item') ? item.label : item.hasOwnProperty('NAME') ? item.NAME : 'labelFunction');
		}

		static public function __ifTrue(showAlert_:Boolean=false,input_:Array=null,DropDownList_:Array=null,variable_:Array=null):Boolean 
		{
			var I:uint;
			var	OBJ:Object;
			var VALUE:Boolean			= true;
			var QNT:uint				= 0;
			
			if(variable_)
				for(I=0; I<variable_.length; I++)
				{
					if(variable_[I] != null)
					{
						OBJ	= variable_[I];
						if(OBJ == '')
						{
							VALUE = false;
							QNT++;
						}
					}
				}
			
			if(input_)
				for(I=0; I<input_.length; I++)
				{
					if(input_[I] != null)
					{
						OBJ	= input_[I];
						if(OBJ.text == '')
						{
							VALUE = false;
							QNT++;
						}
					}
				}
			
			if(DropDownList_)
				for(I=0; I<DropDownList_.length; I++)
				{
					if(DropDownList_[I] != null)
					{
						OBJ	= DropDownList_[I];
						if(OBJ.selectedIndex == -1)
						{
							VALUE = false;
							QNT++;
						}
					}
				}
			
			if(!VALUE && showAlert_)
				new gnncAlert().__alert('Preencha os campos obrigatórios. Falta(m) '+QNT+' campo(s) .');
			
			return VALUE;
		}		
		
		static public function __trimText(string_:String):String
		{
			return StringUtil.trim(string_);
			
			if(!string_ || string_ == null) return '';
			
			var startIndex:int = 0;
			
			while (__isWhitespace(string_.charAt(startIndex)))
				++startIndex;
			
			var endIndex:int = string_.length - 1;
			
			while (__isWhitespace(string_.charAt(endIndex)))
				--endIndex;
			
			if (endIndex >= startIndex)
				return string_.slice(startIndex, endIndex + 1);
			else
				return "";
		}
		
		public static function __isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}

		
		static public function __scapeWhitespace(string_:String):void
		{
			var rslt:Object = new Object();
			//members of SpaceSeparator category
			rslt[0x0020] =  true;  //SPACE
			rslt[0x1680] =  true;  //OGHAM SPACE MARK
			rslt[0x180E] =  true;  //MONGOLIAN VOWEL SEPARATOR
			rslt[0x2000] =  true;  //EN QUAD
			rslt[0x2001] =  true;  //EM QUAD
			rslt[0x2002] =  true;  //EN SPACE
			rslt[0x2003] =  true;  //EM SPACE
			rslt[0x2004] =  true;  //THREE-PER-EM SPACE
			rslt[0x2005] =  true;  //FOUR-PER-EM SPACE
			rslt[0x2006] =  true;  //SIZE-PER-EM SPACE
			rslt[0x2007] =  true;  //FIGURE SPACE
			rslt[0x2008] =  true;  //PUNCTUATION SPACE
			rslt[0x2009] =  true;  //THIN SPACE
			rslt[0x200A] =  true;  //HAIR SPACE
			rslt[0x202F] =  true;  //NARROW NO-BREAK SPACE
			rslt[0x205F] =  true;  //MEDIUM MATHEMATICAL SPACE
			rslt[0x3000] =  true;  //IDEOGRAPHIC SPACE
			//members of LineSeparator category
			rslt[0x2028] =  true;  //LINE SEPARATOR
			//members of ParagraphSeparator category
			rslt[0x2029] =  true;
			//Other characters considered to be a space
			rslt[0x0009] =  true; //CHARACTER TABULATION
			rslt[0x000A] =  true; //LINE FEED
			rslt[0x000B] =  true; //LINE TABULATION
			rslt[0x000C] =  true; //FORM FEED
			rslt[0x000D] =  true; //CARRIAGE RETURN
			rslt[0x0085] =  true; //NEXT LINE
			rslt[0x00A0] =  true; //NO-BREAK SPACE  
	
			//Não remover espaço em branco, erro nos websites. Utilize o recurso em php __ignoreErrorChar()
			//var _reg3:RegExp = /\x2000|\x2001|\x2002|\x2003|\x2004|\x2005|\x2006|\x2007|\x2008|\x200A|\x200B|\x200C|\x200D|\x200E|\x200F|\x202A|\x202B|\x202C|\x202D|\x202E|\x202F|\x206A|\x206B|\x206C|\x206D|\x206E|\x206F/g;  // ESPACOS EM BRANCO inválidos!

		}

		static public function __removeBreak(text_:String):String
		{
			/*
			Old Sample
			var myString:String = "text\r\ntext\r\ntext\r\n";
			myString = myString.split("\r").join("\n").split("\n\n").join("\n");
			*/
			
			//var _reg1:RegExp = /^[\r\n]+/g; // remove breakLines or new lines
			var _reg1:RegExp = /\r\n|\r|\n/gm; // remove breakLines or new lines
			return gnncData.__trimText(text_.replace(_reg1,' '));;
		}
		
		static public function __friendly(text_:String):String
		{
			var str:String  = text_;
			
			str = str.toLowerCase();
			str = gnncData.__trimText(str);
			str = gnncData.__removeBreak(str);
			str = gnncData.__scapeString(str);
			str = gnncData.__scapeTextWord(str);
			str = gnncData.__removeAcentos(str);
			
			str = gnncData.__replace(str,' ','-');
			str = gnncData.__replace(str,'&','e');
			str = gnncData.__replaceArr(str,['!','@','"',"'",'$','%','*','¨','(',')','[',']','´','`','~','{','}',':',';','.',',','<','>','|','\\','/'],'');

			var r1:RegExp 	= /[^a-z0-9\s]/gi; 
			var r2:RegExp 	= /[_\s]/g;

			str = gnncData.__replace(str,'--','-');

			return str
				.replace(r1,'-')
				//.replace(r2,'-')
				/*
				.replace(ra,'a')
				.replace(re,'e')
				.replace(ri,'i')
				.replace(ro,'o')
				.replace(ru,'u')
				.replace(rc,'c')
				*/
		}

		static public function __scapeTextWord(text_:String):String
		{
			var _reg1:RegExp = /–/g; 						// tarço longo do MS WORD
			var _reg2:RegExp = /\x201C|\x201D|\x201E/g;  	// Aspas: duplas e invertidas
			var _reg3:RegExp = /\x22|\x27|\x60/g;  			// Aspas: simples
			
			text_ = text_.replace(_reg1,'\-');
			text_ = text_.replace(_reg2,'\"');
			text_ = text_.replace(_reg3,'\"');
			
			return text_;
		}
		
		static public function __scapeText(string_:Array=null,input_:Array=null):Array
		{
			var I:uint;
			var	OBJ:Object;
			var VALUE:Array	= new Array();
			
			//http://gskinner.com/RegExr/
			var EXREG1:RegExp = /–/g; // tarço longo do MS WORD
			var EXREG2:RegExp = /\x22|\x27|\x60|\x201C|\x201D|\x201E/g;  // ASPAS: simples | invertida | duplas e outras aspas
			var EXREG3:RegExp = /\xA0|\x00A0|\x2000|\x2001|\x2002|\x2003|\x2004|\x2005|\x2006|\x2007|\x2008|\x200A|\x200B|\x200C|\x200D|\x200E|\x200F|\x202A|\x202B|\x202C|\x202D|\x202E|\x202F|\x206A|\x206B|\x206C|\x206D|\x206E|\x206F/g;  // ESPACOS EM BRANCO inválidos!
			
			if(string_)
				for(I=0; I<string_.length; I++)
				{
					OBJ = string_[I];
					OBJ = '';
					OBJ = OBJ.replace(EXREG1,'-');
					OBJ = OBJ.replace(EXREG2,'\"');
					OBJ = OBJ.replace(EXREG3,' ');
					var OBJ_TEXT:String = OBJ as String;
					OBJ = StringUtil.trim(OBJ_TEXT);
					VALUE.push(OBJ);
				}
			
			if(input_)
				for(I=0; I<input_.length; I++)
				{
					OBJ = input_[I];
					OBJ.text = OBJ.text.replace(EXREG1,'-');
					OBJ.text = OBJ.text.replace(EXREG2,'\"');
					OBJ.text = StringUtil.trim(OBJ.text);
					VALUE.push(OBJ);
				}

			return VALUE;
		}
		
		static public function __removeAcentos(string_:String):String
		{
			var str:String = string_;
			
			var f:Array = new Array("á","à","ã","ä","â",
				"é","è","ê","ë",
				"í","ì","ï","î",
				"ó","ò","õ","ô","ö",
				"ú","ù","ü","û",
				"ç",
				"Á","À","Ã","Ä","Â",
				"É","À","Ê","Ë",
				"Í","Ì","Ï","Î",
				"Ó","Ò","Õ","Ô","Ö",
				"Ú","Ù","Ü","Û",
				"Ç");
			
			var r:Array = new Array("a","a","a","a","a",
				"e","e","e","e",
				"i","i","i","i",
				"o","o","o","o","o",
				"u","u","u","u",
				"c",
				"a","a","a","a","a",
				"e","e","e","e",
				"i","i","i","i",
				"o","o","o","o","o",
				"u","u","u","u",
				"c");
			
			var ra:RegExp 	= /[âãáàä]/gi; 
			var re:RegExp 	= /[êéèë]/gi; 
			var ri:RegExp 	= /[îíìï]/gi; 
			var ro:RegExp 	= /[ôõóòö]/gi; 
			var ru:RegExp 	= /[ûúùü]/gi; 
			var rc:RegExp 	= /[ç\s]/gi; 
			
			return gnncData.__replaceArr(str,f,r);

		}
		
		static public function __scapeString(string_:String):String
		{
			var	str:String = string_;
			
			//http://gskinner.com/RegExr/
			var exp1:RegExp = /–/g; // tarço longo do MS WORD
			var exp2:RegExp = /\x22|\x27|\x60|\x201C|\x201D|\x201E/g;  // ASPAS: simples | invertida | duplas e outras aspas
			var exp3:RegExp = /\xA0|\x00A0|\x2000|\x2001|\x2002|\x2003|\x2004|\x2005|\x2006|\x2007|\x2008|\x200A|\x200B|\x200C|\x200D|\x200E|\x200F|\x202A|\x202B|\x202C|\x202D|\x202E|\x202F|\x206A|\x206B|\x206C|\x206D|\x206E|\x206F/g;  // ESPACOS EM BRANCO inválidos!

			var x:Array = new Array ("ã¡","ã¢","ã£","ã¤","ã¥","ã¦","ã§","ã¨","ã©",
				"ãª","ã«","ã¬","ã­","ã®","ã¯","ã°","ã±","ã²","ã³","ã´",
				"ãµ","ã¶","ã¸","ã¹","ãº","ã»","ã¼","ã½","ã¾","ã¿","ã€",
				"ã","ã‚","ãƒ","ã„","ã…","ã†","ã‡","ãˆ","ã‰","ãŠ","ã‹",
				"ãŒ","ã","ãŽ","ã","ã“","ã”","ã•",
				"ã˜","ã™","ãš","ã›","ãœ","ã","ãž","â‚¬","”","ãŸ","â¢","â£","â¤","â¥","â¦","â§","â¨","â©","âª","â«",
				"â¬","â­","â®","â¯","â°","â±","â²","â³","â´","âµ","â¶",
				"â·","â¸","â¹","âº","â»","â¼","â½","â¾");
			
			str = gnncData.__replaceArr(str,x,'a');

			str = str.replace(exp1,'-');
			str = str.replace(exp2,'\"');
			str = str.replace(exp3,' ');
			str = gnncData.__trimText(str);
			
			return str;
		}

		/**
		Example
		$firstName_:2 + $lastName_:1 = 3 
		**/
		static public function __lessName(str_:String,firstName_:int=2,lastName_:Boolean=true,initials_:Boolean=false):String
		{
			var strReturn:String = '';
			var aSplit:Array     = gnncData.__trimText(str_).split(' ');
			var ttl:int          = aSplit.length;
			var i:int            = 0;
			var sum:int          = firstName_ + (lastName_==true?1:0);

			if(ttl <= 2)
				return gnncData.__trimText(str_);

			if(ttl <= sum)
				return gnncData.__trimText(str_);
			
			if( lastName_ == true ) //obriga utilizar o sobrenome
				if( firstName_ < 1 && ttl > 2 )
					firstName_--;
			
			for each (var temp:String in aSplit)
			{
				i++;
				if( ttl > firstName_ )
					if( i <= firstName_ ){
						strReturn += temp+' ';
					}else if(initials_ && temp.length>3){
						if((lastName_ == false && ttl == i) || (lastName_ == true && ttl > i))
							strReturn += temp.substr(0,1).toUpperCase()+'. ';
					}
			}
			
			if( lastName_ == true )
				strReturn += aSplit[(ttl-1)];
			
			return strReturn;
		}
		
		static public function __firstLetterUpperCase(string_:String='',removeTwoSpaces_:Boolean=true,spaceAfterDot_:Boolean=false):String
		{
			if(!string_)
				return '';
			
			var _i:uint;
			var _words:Array;
			var _text:String = string_.toLowerCase();
			
			function __split(stringSplit_:String,splitWord_:String):void
			{
				_words = stringSplit_.split(splitWord_);
				_text = '';

				for(_i=0; _i<_words.length; _i++)
					_text += _words[_i].toString().substr(0,1).toUpperCase() + _words[_i].toString().substr(1,_words[_i].toString().length) + splitWord_;
				
				_text = _text.substr(0,_text.length-1); 
			}
			
			if(spaceAfterDot_)
			{
				_text = gnncData.__replace(_text,'.','. ');
				_text = gnncData.__replace(_text,'. . . ','...');
			}
			
			if(removeTwoSpaces_)
				_text = gnncData.__replace(_text,'  ',' ');
			
			__split(_text," ");
			__split(_text,"/");
			__split(_text,".");
			
			_text = gnncData.__replace(_text,' E ',' e ');
			_text = gnncData.__replace(_text,' É ',' é ');
			_text = gnncData.__replace(_text,' A ',' a ');
			_text = gnncData.__replace(_text,' As ',' as ');
			_text = gnncData.__replace(_text,' O ',' o ');
			_text = gnncData.__replace(_text,' Os ',' os ');
			
			_text = gnncData.__replace(_text,' De ',' de ');
			_text = gnncData.__replace(_text,' Da ',' da ');
			_text = gnncData.__replace(_text,' Das ',' das ');
			_text = gnncData.__replace(_text,' Do ',' do ');
			_text = gnncData.__replace(_text,' Dos ',' dos ');
			
			_text = gnncData.__replace(_text,' Em ',' em ');
			_text = gnncData.__replace(_text,' Na ',' na ');
			_text = gnncData.__replace(_text,' Nas ',' nas ');
			_text = gnncData.__replace(_text,' No ',' no ');
			_text = gnncData.__replace(_text,' Nos ',' nos ');
			
			_text = gnncData.__replace(_text,' Ii ',' II ');
			_text = gnncData.__replace(_text,' Iii ',' III ');
			_text = gnncData.__replace(_text,' Iv ',' IV ');
			_text = gnncData.__replace(_text,' Vi ',' VI ');
			_text = gnncData.__replace(_text,' Vii ',' VII ');
			_text = gnncData.__replace(_text,' Viii ',' VIII ');
			_text = gnncData.__replace(_text,' Ix ',' IX ');

			_text = gnncData.__replace(_text,'Gnnc','GNNC');
			_text = gnncData.__replace(_text,'Gnial','gNial');
			_text = gnncData.__replace(_text,'Cep ',' CEP ');
			_text = gnncData.__replace(_text,'Cep:',' CEP:');

			return _text;
		}
		
		/**
		 * var name:string;
		 * var yearOld:int;
		 * 
		 * __substitute("Meu nome é {0}, e eu tenho {1} anos.",name,yearOld);
		 * 
		 * */
		static public function __substitute(str:String, ... rest):String
		{
			if (str == null) return '';
			
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			
			return str;
		}
		
		static public function __replace(string_:String,find_:String,replace_:String):String
		{
			return string_.split(find_).join(replace_);
		}

		static public function __replaceArr(string_:String,findArray_:Array,replaceStringOrArray_:*):String
		{
			if(!findArray_)
				return string_;

			var v:String = string_;
			var f:Array  = findArray_;
			var r:* 	 = replaceStringOrArray_;
			var len:uint = findArray_.length; 
			var i:uint   = 0;

			if(!len)
				return string_;

			for(i=0; i<len; i++)
			{
				v = v.split(String(f[i])).join(String( r is String ? r : r[i] ));
			}
			
			return v;
		}

		static public function __replaceRegExp(TEXT_:String,FIND_:String,REPLACE_:String):String
		{
			new gnncAlert().__error('Ocorreu algum erro.');
			var str:String = TEXT_;
			return str.replace(new RegExp(FIND_, "g"),REPLACE_);
		}
		
		static public function __replace2(input:String, replace:String, replaceWith:String):String
		{
			//change to StringBuilder
			var sb:String = new String();
			var found:Boolean = false;
			
			var sLen:Number = input.length;
			var rLen:Number = replace.length;
			
			for (var i:Number = 0; i < sLen; i++)
			{
				if(input.charAt(i) == replace.charAt(0))
				{  
					found = true;
					for(var j:Number = 0; j < rLen; j++)
					{
						if(!(input.charAt(i + j) == replace.charAt(j)))
						{
							found = false;
							break;
						}
					}
					
					if(found)
					{
						sb += replaceWith;
						i = i + (rLen - 1);
						continue;
					}
				}
				sb += input.charAt(i);
			}
			//TODO : if the string is not found, should we return the original
			//string?
			return sb;
		}
		
		public static function __replaceTextFlow(textFlow_:TextFlow,find_:String,replace_:String):TextFlow
		{
			var textFlow:TextFlow		= textFlow_;
			var textHtml:String			= gnncDataHtml.__textFlow2FlashHtml(textFlow_);

			textHtml = gnncData.__replace(textHtml,find_,replace_);

			textFlow = gnncDataHtml.__html2TextFlow(textHtml);
			
			//var startIndex = 100;
			//var endIndex = 150;
			
			//var copy:String = textFlow_.getText(0,-1,"<br/>");
			// replace the text
			//copy = copy.substring(0,startIndex) + "*** You just replaced me ***" + copy.substring(endIndex);
			// reimport - expensive (makes a new TextFlow) and probably looses some fidelity (styles, etc)
			//return TextFlowUtil.importFromString(copy);
			
			return textFlow;
		}

		static public function __isNumeric( inputStr : String ) : Boolean
		{
			var obj:RegExp = /^(0|[1-9][0-9]*)$/;
			return obj.test(inputStr);
		}

		public static function __removeDuplicateWords( inputStr : String ) : String
		{
			var arr:Array = inputStr.split(" ");
			return gnncDataArray.__removeDuplicates(arr).join(" ");
			
			//var obj:RegExp = new RegExp("\\b (?<word>[a-z]+) \\s+ \\k<word> \\b", "gix")
			//return inputStr.replace(obj, "" );
		}
		
		public static function __toArray( inputStr_ : String , separator_:String = ",") : Array
		{
			return inputStr_.split(separator_);
		}
		
		public static function __string2ByteArray(string_:String):ByteArray
		{
			var _byteArr:ByteArray		= new ByteArray();
			/*var _decoder:Base64Decoder	= new Base64Decoder();
			
			_decoder.decode				(string_);
			_byteArr					= _decoder.toByteArray();*/
			
			_byteArr.writeUTF(string_);
			
			return _byteArr;
		}

		
		public static function str_rot(s:String, n:uint = 13):String
		{
			var i:uint = 0;
			var l:uint = 0;
			var letters:String = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
			n = n % 26;
			if (!n) return s;
			//if (n == 13) return str_rot13($s);
			for (i = 0, l = s.length; i < l; i++) 
			{
				var c:String = s.substr(i,1);
				if (c >= 'a' && c <= 'z') {
					s[i] = letters[(String(c).charCodeAt(0) - 71 + n) % 26];
				} else if (c >= 'A' && c <= 'Z') {
					s[i] = letters[(String(c).charCodeAt(0) - 39 + n) % 26 + 26];
				}
			}
			return s;
		}
		
		public static function str_rot2(s:String, n:uint = 13):String
		{
			var letters:String = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
			n = n % 26;
			if (!n) return s;
			if (n < 0) n += 26;
			//if ($n == 13) return str_rot13($s);
			var rep:String = letters.substr(n * 2) + letters.substr(0, n * 2);
			//return s.strtr(letters, rep);
			return s;
		}
		
		//trace(String.fromCharCode(65))  // "A" //
		//trace(("A").charCodeAt(0))      // 65 //ord
		
		//var str:String = "A";
		//trace("ASCII dec: " + str.charCodeAt(0));
		//trace("ASCII hex: " + str.charCodeAt(0).toString(16));
		//trace("Character: " + String.fromCharCode(str.charCodeAt(0)));
		
	}
}