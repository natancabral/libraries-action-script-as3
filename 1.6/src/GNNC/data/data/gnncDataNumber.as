package GNNC.data.data
{
	import GNNC.data.globals.gnncGlobalLog;
	
	import flash.events.KeyboardEvent;
	
	import mx.formatters.PhoneFormatter;
	
	import spark.formatters.CurrencyFormatter;

	public class gnncDataNumber
	{
		private var _PARENT:Object;

		public function gnncDataNumber(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;
		}
		
		static public function __setZero(number_:uint,lenghNumber_:uint=2):String
		{
			var _withZeros:String = '00000000000000000000'+number_; //20*'0' + number
			
			return String(_withZeros).substr(_withZeros.length-lenghNumber_);
		}
		
		static public function __setThousand2(number_:uint,separatorHundred_:String='.'):String
		{
			var _numb:String 		= number_ + '';
			var _leng:uint 			= _numb.length;

			var _hundred:String 	= '';
			var _thousand:String 	= '';
			var _million:String 	= '';
			var _billion:String 	= '';
			
			return '';
		}
		
		static public function __setThousand(number_:uint,separatorHundred_:String='.'):String //numberWithCommas
		{
			return number_.toString().replace(/\B(?=(\d{3})+(?!\d))/g, separatorHundred_);
		}

		static public function __isPair(number_:uint):Boolean
		{
			return (number_%2) ? true : false;
			
			/*if(number_ % 2 == 1)
				return true;
			else
				return false;*/
		}

		static public function __int(NUMBER_:Number):uint
		{
			return Math.round(NUMBER_);
		}
		
		static public function __toHexColor(value_:uint,returnWith0x_:Boolean=false):String
		{
			var prefix:String = "000000";
			var hex:String = String(prefix + value_.toString(16)).substr(-6).toUpperCase();
			return (returnWith0x_?'0x':'') + hex;
		}
		
		static public function __clearNumberInNaNIfinity(value_:Number,round_:Boolean=false):Number
		{
			switch(value_)
			{
				case NaN:
				case Infinity:
				case -Infinity:
					return 0;
					break;
			}
			
			//if(isFinite(value_)) //Error
			//	return 0;

			if(isNaN(value_)) 
				return 0;

			return (round_)?Math.round(value_):value_;
		}

		static public function __safeClearString(value_:Object,decimal_:uint=2):String
		{
			return __safeClear(value_,decimal_).toFixed(decimal_);
		}
		
		static public function __safeClear(value_:Object,decimal_:uint=2):Number
		{
			var d1:String = '';
			var d2:String = '';
			var v:String = String(value_);
			//var b:String = String(gnncData.__clone(v));

			if(!decimal_)
			{
				v = gnncData.__replace(v,'.','');
				v = gnncData.__replace(v,',','');
				return Number(v);
			}

			v = gnncData.__trimText(gnncData.__replace(v,'R$',''));

			if(v.length < 3 && Number(value_))
				return Number(value_);

			d1 = v.substr(-3,1);
			d2 = v.substr(-4,1);
			//gnncGlobalLog.__add(d,'A');

			if(d1==='.' || d2==='.')
			{
				v = gnncData.__replace(v,',','');
				//gnncGlobalLog.__add(v,'B');
				if(Number(v))
				return Number(v);
			}
			else if(d1===',' || d2===',')
			{
				v = gnncData.__replace(v,'.','');
				v = gnncData.__replace(v,',','.');
				//gnncGlobalLog.__add(v,'C');
				if(Number(v))
				return Number(v);
			}
			else  {
				v = Number(v).toFixed(decimal_);
				//gnncGlobalLog.__add(v,'D');
				if(Number(v))
				return Number(v);
			}
			return 0;
		}

		static public function __weightString(value_:Object,decimal_:uint=3,type_:String='GG'):String
		{
			return String(__weight(value_,decimal_,type_));
		}

		static public function __weight(value_:Object,decimal_:uint=3,type_:String='GG'):Number
		{
			var d1:String = '';
			var d2:String = '';
			var v:String = String(value_);
			//var b:String = String(gnncData.__clone(v));
			
			v = gnncData.__replace(v,'.','');
			v = gnncData.__replace(v,',','');
			v = v+'.0';
			return Number(v);
		}

		static private var backSafeLimitNumber:String = '';
		static public function __safeKeyEvent(event_:*,setValueInTextInput_:Boolean=true,functionAfterKeyEvent_:Function=null,decimal_:uint=2,safeReal_:Boolean=true):String
		{
			var obj:Object = event_.currentTarget;
			var v:String   = String(obj.text);
			
			if(!decimal_)
			{
				if(setValueInTextInput_)
					obj.text = v;
				return v;
			}
			
			if(v.length>14){//100.100.100,90 = 14
				obj.text = backSafeLimitNumber;
				//data[property_] = back;
				//e.stopImmediatePropagation();
				//e.stopPropagation();
				//return;
			}
			
			var f:String = '';
			var d:String = '';
			var n:String = '';
			var l:uint   = 0;
			
			//gnncGlobalLog.__add('1:'+v);
			v = gnncData.__replace(v,',','');
			//gnncGlobalLog.__add('2:'+v);
			v = gnncData.__replace(v,'.','');
			//gnncGlobalLog.__add('3:'+v);
			n = String(Number(v));
			//gnncGlobalLog.__add('4:'+n);
			//v = v.length<3?v?Number(v).toFixed(2).toString();
			if(decimal_==2)
				f = !n.length?n:n.length==1?'0.0' +n:n.length==2?'0.' +n:v.substring(0,v.length-2)+'.'+v.substr(-2,2);
			else if(decimal_==3)
				f = !n.length?n:n.length==1?'0.00'+n:n.length==2?'0.0'+n:n.length==3?'0.'+n:v.substring(0,v.length-3)+'.'+v.substr(-3,3);
			//gnncGlobalLog.__add('5:'+f);
			if(safeReal_)
				v = __safeReal(Number(f),decimal_,'',',','.','','');
			else
				v = f;
			//gnncGlobalLog.__add('6:'+v);
			backSafeLimitNumber = v;
			if(setValueInTextInput_)
			{
				if(decimal_==2){
					var ch:Array = v.split(',');
					if(ch.length>1)
						if(String(ch[1]).length==3)
							__safeKeyEvent(event_,setValueInTextInput_,functionAfterKeyEvent_,decimal_,safeReal_);
				}
				
				obj.text = v;
				obj.text = v;
				//l = obj.text.length;
				//obj.selectRange(l,l);
				//obj.selectRange(l,l);
				
				if(!event_.hasOwnProperty('type'))
				{
					event_['type']    = '';
					event_['keyCode'] = '';
				}

				l = obj.selectionActivePosition;
				if ((event_.type == KeyboardEvent.KEY_UP && (event_.keyCode == 8 || event_.keyCode == 46)) || !Number(v) || l == (obj.text.length-1)) //8 backspace 46 delete
					l = obj.text.length;
				obj.selectRange(l,l);
				obj.selectRange(l,l);
			}
			if(functionAfterKeyEvent_ != null)
				functionAfterKeyEvent_.call();
			return gnncData.__trimText(v);
		}

		static public function __safeKeyEventItemRender(event_:*,data_:Object,property_:String='',decimal_:uint=2,safeReal_:Boolean=true):Object
		{
			var obj:Object  = event_.currentTarget;
			var v:String    = '';//String(obj.text);
			var l:uint      = 0;
			var d:String    = '';
			
			v = __safeKeyEvent(event_,false,null,decimal_,safeReal_);

			if(property_)
			if(data_.hasOwnProperty(property_)){
				d = v;
				d = gnncData.__replace(d,'.','');
				d = gnncData.__replace(d,',','.');
				data_[property_] = !Number(d) ? 0.01 : Number(d);
				//A.text = d;
				//gnncGlobalLog.__add('7:'+d);
			}
			obj.text = v;
			obj.text = v;
			//back
			//backSafeLimitNumber = v;
			//select last letter

			//l = obj.text.length;
			//obj.selectRange(l,l);
			//obj.selectRange(l,l);

			if(!event_.hasOwnProperty('type'))
			{
				event_['type']    = '';
				event_['keyCode'] = '';
			}

			l = obj.selectionActivePosition;
			if ((event_.type == KeyboardEvent.KEY_UP && (event_.keyCode == 8 || event_.keyCode == 46)) || !Number(v) || l == (obj.text.length-1)) //8 backspace 46 delete
				l = obj.text.length;
			obj.selectRange(l,l);
			obj.selectRange(l,l);
			
			return data_;
			//Object(owner).dispatchEvent(new gnncEventGeneral('INPUT_VALUE',data));
		}

		static public function __safeReal(value_:Object,decimal_:uint=2,symbol_:String="R$ ",centsSeparator_:String=",",thousandSeparator_:String=".",errorString_:String="Erro no valor!",ifZezo_:String=''):String
		{
			var _curFormatter:CurrencyFormatter 	= new CurrencyFormatter();
			_curFormatter.currencySymbol 			= symbol_?symbol_:'';
			_curFormatter.useCurrencySymbol 		= true;
			
			_curFormatter.negativeCurrencyFormat	= 2;
			_curFormatter.fractionalDigits          = decimal_;
			_curFormatter.trailingZeros             = true
			_curFormatter.leadingZero               = true;

			_curFormatter.decimalSeparator			= centsSeparator_;
			_curFormatter.groupingSeparator			= thousandSeparator_;
			_curFormatter.errorText					= errorString_;
			
			var _value:Number						= value_ is Number?value_ as Number:Number(value_);
			
			/*
			s:CurrencyFormatter 
			id="PRICE_" 
			currencySymbol="R$ " 
			useCurrencySymbol="true"
			negativeCurrencyFormat="2"
			positiveCurrencyFormat="0"
			decimalSeparator=","
			groupingSeparator="."
			errorText="Erro no valor!"/>
			*/

			if(!_value && ifZezo_)
				return ifZezo_;
			else
				return _curFormatter.format(value_);
		}
		
		static public function __clearPhoneNumber(value_:String,removeFirstZero_:Boolean=true,scape_:Boolean=true,errorReturnString_:String=''):String
		{
			var _filterPhone10:PhoneFormatter 	= new PhoneFormatter();
			_filterPhone10.error 				= '';
			_filterPhone10.formatString 		= "(##) ####-####";
			_filterPhone10.areaCodeFormat		= "(##)";

			var _filterPhone11:PhoneFormatter 	= new PhoneFormatter();
			_filterPhone11.error 				= '';
			_filterPhone11.formatString 		= "(##) #####-####";
			_filterPhone11.areaCodeFormat		= "(##)";

			if(scape_)
				gnncData.__scapeText([value_]);

			value_ 		= gnncData.__replace(String(value_)		,')','');
			value_ 		= gnncData.__replace(String(value_)		,'(','');
			value_ 		= gnncData.__replace(String(value_)		,']','');
			value_ 		= gnncData.__replace(String(value_)		,'[','');
			value_ 		= gnncData.__replace(String(value_)		,' ','');
			value_ 		= gnncData.__replace(String(value_)		,'-','');
			value_ 		= gnncData.__replace(String(value_)		,'.','');
			value_ 		= gnncData.__replace(String(value_)		,'+','');
			value_ 		= gnncData.__replace(String(value_)		,'"','');
			value_ 		= gnncData.__replace(String(value_)		,"'",'');
			value_ 		= gnncData.__replace(String(value_)		,"\\",'');
			value_ 		= gnncData.__replace(String(value_)		,"/",'');
			value_ 		= gnncData.__replace(String(value_)		,",",'');
			value_ 		= gnncData.__replace(String(value_)		,";",'');

			value_		= String(value_).toLowerCase();
			value_		= gnncData.__trimText(value_);
			
			value_ 		= gnncData.__replace(String(value_)		,"a",'');
			value_ 		= gnncData.__replace(String(value_)		,"b",'');
			value_ 		= gnncData.__replace(String(value_)		,"c",'');
			value_ 		= gnncData.__replace(String(value_)		,"d",'');
			value_ 		= gnncData.__replace(String(value_)		,"e",'');
			value_ 		= gnncData.__replace(String(value_)		,"f",'');
			value_ 		= gnncData.__replace(String(value_)		,"g",'');
			value_ 		= gnncData.__replace(String(value_)		,"h",'');
			value_ 		= gnncData.__replace(String(value_)		,"i",'');
			value_ 		= gnncData.__replace(String(value_)		,"j",'');
			value_ 		= gnncData.__replace(String(value_)		,"k",'');
			value_ 		= gnncData.__replace(String(value_)		,"l",'');
			value_ 		= gnncData.__replace(String(value_)		,"m",'');
			value_ 		= gnncData.__replace(String(value_)		,"n",'');
			value_ 		= gnncData.__replace(String(value_)		,"o",'');
			value_ 		= gnncData.__replace(String(value_)		,"p",'');
			value_ 		= gnncData.__replace(String(value_)		,"q",'');
			value_ 		= gnncData.__replace(String(value_)		,"r",'');
			value_ 		= gnncData.__replace(String(value_)		,"s",'');
			value_ 		= gnncData.__replace(String(value_)		,"t",'');
			value_ 		= gnncData.__replace(String(value_)		,"u",'');
			value_ 		= gnncData.__replace(String(value_)		,"v",'');
			value_ 		= gnncData.__replace(String(value_)		,"x",'');
			value_ 		= gnncData.__replace(String(value_)		,"y",'');
			value_ 		= gnncData.__replace(String(value_)		,"w",'');
			value_ 		= gnncData.__replace(String(value_)		,"z",'');

			if(removeFirstZero_)
			value_ 		= value_.substr(0,1)=='0'?value_.substring(1):value_;

			value_ 		= value_.length<8 ? errorReturnString_ : value_.length==10 ? _filterPhone10.format(value_) : value_.length==11 ? _filterPhone11.format(value_) : _filterPhone10.format(gnncDataNumber.__setZero(uint(value_),10));

			return value_;
		}
		
		public static function __safeLegend(valueSafe_:Object, insertCents_:Boolean=true):String
		{
			
			var valor:String	= gnncData.__replace(String(valueSafe_),",",".");
			valor				= gnncData.__replace(valor,"-","");
			
			var singular:Array	= new Array("centavo", "real", "mil", "milhão", "bilhão", "trilhão", "quatrilhão");
			var plural:Array	= new Array("centavos", "reais", "mil", "milhões", "bilhões", "trilhões","quatrilhões");
			
			var c:Array			= new Array("", "cem", "duzentos", "trezentos", "quatrocentos","quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos");
			var d:Array			= new Array("", "dez", "vinte", "trinta", "quarenta", "cinquenta","sessenta", "setenta", "oitenta", "noventa");
			var d10:Array		= new Array("dez", "onze", "doze", "treze", "quatorze", "quinze","dezesseis", "dezesete", "dezoito", "dezenove");
			var u:Array			= new Array("", "um", "dois", "três", "quatro", "cinco", "seis","sete", "oito", "nove");
			
			var z:Number 		= 0;
			var i:uint 			= 0;
			var ii:uint 		= 0;
			var fim:uint 		= 0;
			
			var rt:String		= "";
			var rc:String 		= ""; //centenas
			var rd:String 		= ""; //dezenas
			var ru:String 		= ""; //unidades
			var r:String 		= ""; //reais
			var t:uint 			= 0; //sei lá
			
			//valor = number_format(valor, 2, ".", ".");
			valor 			= gnncDataNumber.__safeReal(valor, 2, "", ".", ".", "", "");
			
			var inteiro:Array = valor.split(".");
			
			for(i=0; i<inteiro.length; i++)
				for(ii=String(inteiro[i]).length; ii<3; ii++)
					inteiro[i] = "0"+inteiro[i];
			
			//new gnncAlert().__alert(inteiro.toString()+'!!','1');
			
			// fim identifica onde que deve se dar junção de centenas por "e" ou por "," ;) 
			fim = inteiro.length - (inteiro[inteiro.length-1] > 0 ? 1 : 2);
			
			for (i=0; i<inteiro.length; i++)
			{
				valor = inteiro[i].toString();
				
				rc = ((Number(valor) > 100) && (Number(valor) < 200)) ? "cento" : c[Number(valor.substr(0,1))];
				rd = (Number(valor.substr(1,1)) < 2) ? "" : d[Number(valor.substr(1,1))];
				ru = (Number(valor) > 0) ? ((Number(valor.substr(1,1)) == 1) ? d10[Number(valor.substr(2,1))] : u[Number(valor.substr(2,1))]) : "";
				
				r = rc + ((rc && (rd || ru)) ? " e " : "") + rd + ((rd && ru) ? " e " : "") + ru;
				t = inteiro.length-1-i;
				
				if (insertCents_ == true)
				{
					r += r ? " "+(Number(valor) > 1 ? plural[t] : singular[t]) : "";
					if (valor == "000"){ z++; } else if (z > 0) {  z--; }
					if ((t==1) && (z>0) && (inteiro[0] > 0)) r += ((z>1) ? " de " : "")+plural[t]; 
				}
				
				if (r) rt = rt + (((i > 0) && (i <= fim) && (inteiro[0] > 0) && (z < 1)) ? ( (i < fim) ? ", " : " e ") : " ") + r;
			}
			
			return (rt ? gnncData.__trimText(rt) : "zero");
		}

		
	}
}