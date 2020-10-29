package GNNC.data.date
{		
	//http://www.calculateme.com/Time/Minutes/ToMilliseconds.htm
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataNumber;
	import GNNC.data.globals.gnncGlobalArrays;
	
	import com.adobe.utils.DateUtil;
	
	import mx.formatters.DateFormatter;
	
	public class gnncDate 
	{
		
		public static const SECONDS_PER_MINUTE:uint 		= 60;
		public static const SECONDS_PER_TWO_MINUTES:uint 	= 120;
		public static const SECONDS_PER_HOUR:uint 			= 3600;
		public static const SECONDS_PER_TWO_HOURS:uint 		= 7200;
		public static const SECONDS_PER_DAY:uint 			= 86400;
		public static const SECONDS_PER_TWO_DAYS:uint 		= 172800;
		public static const SECONDS_PER_THREE_DAYS:uint 	= 259200;
		
		public function gnncDate()
		{
		}

		public static function getDate():Date
		{
			return DateUtils.dateAdd(DateUtils.HOURS,0,new Date());
		}

		/**
		 * Creates a human-readable String representing the difference
		 * in time from the date provided and now.  This method handles
		 * dates in both the past and the future (e.g. "2 hours ago"
		 * and "2 hours from now".  For any date beyond 3 days difference
		 * from now, then a standard format is returned.
		 *
		 * @param date The date for which to compare against.
		 *
		 * @return Human-readable String representing the time elapsed.
		 */
		public static function __relativeDateFromNow(date_:Object, capitalizeFirstLetter:Boolean = false, errorMessage_:String = ''):String
		{
			if(date_ is String)
				if(String(date_).substr(0,4)=='0000')
					return errorMessage_;
			
			date_ = date_ is Date ? date_ as Date : date_ is String ? gnncDate.__string2Date(date_ as String) as Date : null;

			if(date_ == null)
				return errorMessage_;
			
			return __relativeDate(date_, new Date(), capitalizeFirstLetter);
		}
		
		/**
		 * Creates a human-readable String representing the difference
		 * in time from the first date provided with respect to the
		 * second date provided.  If no second date is provided, then
		 * the relative date will be calcluated with respect to "now".
		 * This method handles dates in both the past and the
		 * future (e.g. "2 hours ago" and "2 hours from now".  For
		 * any date beyond 3 days difference from now, then a
		 * standard format is returned.
		 *
		 * @param firstDate The date for which to compare against.
		 * @param secondDate The date to use as "present" when comparing against firstDate.
		 *
		 * @return Human-readable String representing the time elapsed.
		 */
		public static function __relativeDate(firstDate_:Object, secondDate_:Object = null, capitalizeFirstLetter:Boolean = false, errorMessage_:String='error'):String
		{
			if(firstDate_ is Date)
			{
				firstDate_ = firstDate_ as Date;
				
				if(secondDate_ is Date)
					secondDate_ = secondDate_ as Date;
			}
			else if(firstDate_ is String)
			{
				firstDate_ = gnncDate.__string2Date(firstDate_.toString(),false);
				
				if(secondDate_ is String)
					secondDate_ = gnncDate.__string2Date(secondDate_.toString(),false);
			}
			else 
			{
				return errorMessage_;
			}

			var relativeDate:String;
			var isFuture:Boolean = false;
			
			if (secondDate_ == null)
			{
				secondDate_ = new Date();
			}
			
			// the difference between the passed-in date and now, in seconds
			var secondsElapsed:Number = (secondDate_.getTime() - firstDate_.getTime()) / 1000;
			
			if (secondsElapsed < 0)
			{
				isFuture = true;
				secondsElapsed = Math.abs(secondsElapsed);
			}
			
			var varFuture:String 	= "a vir"; //from now
			var varPast:String		= "atrás"; //ago
			
			switch(true)
			{
				case secondsElapsed < SECONDS_PER_MINUTE:
					relativeDate = "agora mesmo";
					break;
				case secondsElapsed < SECONDS_PER_TWO_MINUTES:
					relativeDate = "1 minuto " + ((isFuture) ? varFuture : varPast );
					break;
				case secondsElapsed < SECONDS_PER_HOUR:
					relativeDate = int(secondsElapsed / SECONDS_PER_MINUTE) + " minutos " + ((isFuture) ? varFuture : varPast );
					break;
				case secondsElapsed < SECONDS_PER_TWO_HOURS:
					relativeDate = "em torno de uma hora " + ((isFuture) ? varFuture : varPast );
					break;
				case secondsElapsed < SECONDS_PER_DAY:
					relativeDate = int(secondsElapsed / SECONDS_PER_HOUR) + " horas " + ((isFuture) ? varFuture : varPast );
					break;
				case secondsElapsed < SECONDS_PER_TWO_DAYS:
					relativeDate = ((isFuture) ? "amanhã" : "ontem") + " as " + DateUtil.getShortHour(firstDate_ as Date) + ":" + __getMinutesString(firstDate_ as Date) + ' ' + __getAMPM2Words(firstDate_ as Date).toLowerCase();
					break;
				case secondsElapsed < SECONDS_PER_THREE_DAYS:
					relativeDate = DateUtil.getFullDayName(firstDate_ as Date) + " de " + DateUtil.getShortHour(firstDate_ as Date) + ":" + __getMinutesString(firstDate_ as Date) + ' ' + __getAMPM2Words(firstDate_ as Date).toLowerCase();
					break;
				default:
					relativeDate = firstDate_.getDate() + " de " + DateUtil.getFullMonthName(firstDate_ as Date) + " as " + DateUtil.getShortHour(firstDate_ as Date) + ":" + __getMinutesString(firstDate_ as Date) + ' ' + __getAMPM2Words(firstDate_ as Date).toLowerCase()
					break;
			}
			
			return ((capitalizeFirstLetter) ? relativeDate.substring(0, 1).toUpperCase() + relativeDate.substring(1, relativeDate.length) : relativeDate);
		}
		
		/**
		 * @private
		 */
		private static function __getMinutesString(date:Date):String
		{
			return ((date.minutes < 10) ? "0" : "") + date.minutes;
		}
		
		/**
		 * @private
		 */
		private static function __getAMPM2Words(date_:Date,am_:String='da manhã',pm_:String='da tarde'):String
		{
			var d:String = String(DateUtil.getAMPM(date_)).toLowerCase();
			return d == 'am' ? am_ : d == 'pm' ? pm_ : 'error';
		}

		
		/**
		 * ################################################
		 * 
		 * **/
		
		public static function __leftInDays(dateStart_:Object,dateEnd_:Object,clearHour_:Boolean=true,errorMessage_:String='Error'):Object
		{
			var _dS:Date;
			var _dE:Date;
			
			if(dateStart_ is Date && dateEnd_ is Date)
			{
				_dS = dateStart_ as Date;
				_dE = dateEnd_ as Date;
			}
			else if(dateStart_ is String && dateEnd_ is String)
			{
				_dS = gnncDate.__string2Date(dateStart_.toString(),false);
				_dE = gnncDate.__string2Date(dateEnd_.toString(),false);
			}
			else 
			{
				return errorMessage_;
			}
			
			if(clearHour_)
			{
				_dS.hours 			= _dE.hours 		= 0;
				_dS.minutes 		= _dE.minutes 		= 0;
				_dS.seconds 		= _dE.seconds 		= 0;
				_dS.milliseconds 	= _dE.milliseconds 	= 0;
			}
			
			return DateUtils.dateDiff(DateUtils.DAY_OF_MONTH,_dS,_dE);
		}		
		
		public static function __DATE_LEFT__START2END(RETURN_STRING_:Boolean,data_:Object):Object
		{
			var today:Date 			= new Date();
			//var DATE_TODAY:String 	= DAYBYDAY_DATE.__DATE2STRING(today,false);
			var start:Date 			= gnncDate.__string2Date(data_.DATE_START,false);
			var end:Date 			= gnncDate.__string2Date(data_.DATE_END,false);
			
			
			/** Se DATE_FINAL no banco tiver alguma data registrada então é uma data finalizada **/
			if(String(data_.DATE_FINAL).substr(0,10)!='0000-00-00')
				return (RETURN_STRING_)?'':0;
			if(String(data_.DATE_START).substr(0,10)=='0000-00-00')
				return (RETURN_STRING_)?'Indeterminado':0;
			//if(String(data_.DATE_END).substr(0,10)=='0000-00-00')
			//return (RETURN_STRING_)?'':0;
			
			if(today.time<start.time)
			{
				return 'Início '+DateUtils.dateDiff('date',new Date(),gnncDate.__string2Date(data_.DATE_START))+' dias';
			}
			else if(today.time>start.time && today.time<end.time)
			{
				return 'Término '+DateUtils.dateDiff('date',new Date(),gnncDate.__string2Date(data_.DATE_END))+' dias';
			}
			else if(today.time>end.time)
			{
				return 'Passou '+(DateUtils.dateDiff('date',new Date(),gnncDate.__string2Date(data_.DATE_END))*-1)+' dias';
			}
			
			return (RETURN_STRING_)?'Finalizado':0;//new Date(2012,03,15));
		}
		
		public static function __DATE_LEFT(RETURN_STRING_:Boolean,DATE_END_:String,DATE_FINAL_:String,or_DateStart:Date=null,or_DateEnd:Date=null,RETURN_IN__HOUR_DAY_WEEK_MONTH_YEAR_:String='DAY'):Object
		{
			/** Se DATE_FINAL no banco tiver alguma data registrada então é uma data finalizada **/
			if(DATE_FINAL_.substr(0,10)!='0000-00-00')
				return (RETURN_STRING_)?'':0;
			if(DATE_END_.substr(0,10)=='0000-00-00')
				return (RETURN_STRING_)?'':0;
			if(or_DateEnd!=null)
				if(!or_DateEnd.fullYear)
					return (RETURN_STRING_)?'':0;;
			
			var _TYPE:String;
			switch(_TYPE)
			{
				case 'HOUR': 	_TYPE = DateUtils.HOURS; 		break;
				case 'DAY': 	_TYPE = DateUtils.DAY_OF_MONTH; break;
				case 'WEEK': 	_TYPE = DateUtils.WEEK; 		break;
				case 'MONTH': 	_TYPE = DateUtils.MONTH; 		break;
				case 'YEAR': 	_TYPE = DateUtils.YEAR; 		break;
			}
			
			if(or_DateStart==null)
				or_DateStart	= new Date();
			//or_DateStart	= __string2Date(DATE_START_or_TODAY_);
			
			if(or_DateEnd==null)
				or_DateEnd		= __string2Date(DATE_END_,false);
			
			return DateUtils.dateDiff('date',new Date(),or_DateEnd);//new Date(2012,03,15));
		}
		
		public static function __DATE_LEFT_TEXT(DateLeft_in_Days:Number,DATE_FINAL_:String,or_DATE_START_:String=null,or_DATE_END_:String=null):String
		{
			if(or_DATE_START_!=null && or_DATE_END_!=null)
				DateLeft_in_Days = Number(__DATE_LEFT(true,or_DATE_END_,DATE_FINAL_));
			
			/** Se DATE_FINAL no banco tiver alguma data registrada então é uma data finalizada **/
			if(DATE_FINAL_.substr(0,10)!='0000-00-00')
				return 'Finalizado';
			/** Se DATE_END no banco for 0000-00-00 então não se pode calcular **/
			else if(__DATE_LEFT(true,or_DATE_END_,DATE_FINAL_)==='')
				return 'Indeterminado';
			/** Verifica o tempo da data **/
			else
			switch(DateLeft_in_Days)
			{
				case -1: 				return 'Ontem'; 	break;
				case 0: 				return 'Hoje';		break;
				case 1: 				return 'Amanhã';	break;
				default:
					if(DateLeft_in_Days<-365)	return '1 ano atrasado ou mais';
					else if(DateLeft_in_Days>0)	return 'Faltam '+DateLeft_in_Days+' dias';
					else if(DateLeft_in_Days<0)	return 'Atrasado '+(DateLeft_in_Days*-1)+' dias';
					else						return 'Impossível calcular';
			}
			return '...';
		}
		
		public static function __DATE_LEFT_COLOR(DateLeft_in_Days:Number,DATE_FINAL_:String,or_DATE_START_:String=null,or_DATE_END_:String=null):uint
		{
			if(or_DATE_START_!=null && or_DATE_END_!=null)
				DateLeft_in_Days = Number(__DATE_LEFT(true,or_DATE_END_,DATE_FINAL_));
			
			if(DATE_FINAL_=='0000-00-00 00:00:00')
				switch(DateLeft_in_Days)
				{
					case -1: 				return gnncGlobalArrays._TIMELINECOLOR[5];	break;
					case 0: 				return 0x0084ff;						break;
					case 1: 				return gnncGlobalArrays._TIMELINECOLOR[30];	break;
					default:
						if(DateLeft_in_Days>5)		return gnncGlobalArrays._TIMELINECOLOR[100];
						if(DateLeft_in_Days>0)		return gnncGlobalArrays._TIMELINECOLOR[30];
						else if(DateLeft_in_Days<0)	return gnncGlobalArrays._TIMELINECOLOR[5];
				}
			return gnncGlobalArrays._TIMELINECOLOR[100];
		}
		
		public static function __string2Date(DATE_YYYYMMDD_HHMMSS_:String,INCLUDE_HOUR_:Boolean=true):Date
		{
			//var DateMysql:uint = 1; //month Jan = 1 = zero ou 0 = one;
			var DT:Date = new Date();
			DT.setFullYear(DATE_YYYYMMDD_HHMMSS_.substr(0,4),Number(DATE_YYYYMMDD_HHMMSS_.substr(5,2))-1,DATE_YYYYMMDD_HHMMSS_.substr(8,2));
			
			if(INCLUDE_HOUR_)
				if(DATE_YYYYMMDD_HHMMSS_.length>11)
					DT.setHours(DATE_YYYYMMDD_HHMMSS_.substr(11,2),DATE_YYYYMMDD_HHMMSS_.substr(14,2),DATE_YYYYMMDD_HHMMSS_.substr(17,2));
			return DT;
		}
		
		public static function __date2String(Date_:Date,INCLUDE_HOUR_:Boolean=true,mileSeconds_:Boolean=false,returnError_:String=''):String
		{
			if(!Date_ || Date_ == null)
				return returnError_;
			
			var Y:String;
			var M:String;
			var D:String;
			
			var H:String;
			var I:String;
			var S:String;
			
			var HMS:String = '';
			var MLS:String = mileSeconds_ ? ' ' + gnncDataNumber.__setZero(Date_.milliseconds,3) : '';
			
			Y = Date_.fullYear.toString			();
			M = String(uint(Date_.month + 1)); 			if(M.length < 2) M = '0'+M;
			D = Date_.date.toString				(); 	if(D.length < 2) D = '0'+D;
			
			if(INCLUDE_HOUR_)
			{
				H 	= Date_.hours.toString		();		if(H.length < 2) H = '0'+H;
				I 	= Date_.minutes.toString	(); 	if(I.length < 2) I = '0'+I;
				S 	= Date_.seconds.toString	(); 	if(S.length < 2) S = '0'+S;
				HMS = ' '+ H + ':' + I + ':' + S;
			}
			
			return Y + '-' + M + '-' + D + HMS + MLS;
		}
		
		public static function __date2Timestamp(date:Date,withHour:Boolean=true,format:String=""):String
		{
			var dateFormatter:DateFormatter 	= new DateFormatter();
			dateFormatter.formatString 			= (withHour)?"YYYY-MM-DD,J:NN:SS":"YYYY-MM-DD";
			
			var dateString:String 				= dateFormatter.format(date);
			var replaceSpace:String				= (dateString.length < 19)?" 0":" ";
			dateString 							= dateString.replace(",",replaceSpace);
			
			return dateString;
		}
		
		public static function __date2Legend(DATE_YYYYMMDD_HHMMSS_:String,or_Date:Date=null,INCLUDE_YEAR_:Boolean=true,INCLUDE_HOUR_:Boolean=false,LEGENDA_NULL_or_ZERO_:String='Nenhuma data',year2Numbers_:Boolean=false,day2Numbers_:Boolean=true,separationDateAndHour_:String=''):String
		{
			//if(DATE_YYYYMMDD_HHMMSS_ is Date)
			
			if(DATE_YYYYMMDD_HHMMSS_.substr(0,10)=='1900-01-01')
				return LEGENDA_NULL_or_ZERO_;
			if(DATE_YYYYMMDD_HHMMSS_.substr(0,10)=='0000-00-00')
				return LEGENDA_NULL_or_ZERO_;
			if(DATE_YYYYMMDD_HHMMSS_==='' && or_Date==null)
				return LEGENDA_NULL_or_ZERO_;
			
			var D:String			= ' ';
			var Y:String			= ' ';
			var H:String			= ' ';
			
			if(or_Date==null)
				or_Date = __string2Date(DATE_YYYYMMDD_HHMMSS_,true);

			or_Date.month = or_Date.month;
			D = day2Numbers_ ? gnncDataNumber.__setZero(or_Date.date) : or_Date.date + '';
			
			if(INCLUDE_YEAR_) Y = ' ' + or_Date.fullYear.toString();
			if(INCLUDE_HOUR_) H = ' '+separationDateAndHour_+' ' + gnncDataNumber.__setZero(or_Date.hours) + ':' + gnncDataNumber.__setZero(or_Date.minutes);
			if(INCLUDE_YEAR_ && year2Numbers_) Y = ' ' + Y.substr(3,2);
			
			return D+' '+gnncGlobalArrays._MONTH.getItemAt(or_Date.month).NICK_NAME+Y+H;
		}
		
		public static function __dayWeekName(DATE_YYYYMMDD_:String,or_Date:Date=null,NICK_NAME_:Boolean=false):String
		{
			if((DATE_YYYYMMDD_=='' || String(DATE_YYYYMMDD_).substr(0,10)=='0000-00-00') && or_Date==null )
				return '';
			
			if(or_Date==null)
				or_Date = __string2Date(DATE_YYYYMMDD_,false);
			or_Date.month = or_Date.month+1;
			var DW:int = DateUtils.dayOfWeek(or_Date);
			return (NICK_NAME_)?gnncGlobalArrays._WEEK.getItemAt(DW).NICK_NAME:gnncGlobalArrays._WEEK.getItemAt(DW).label;
		}
		
		/** ######################################################################################################################## **/
		/** ######################################################################################################################## **/
		/** OLD **/
		/** ######################################################################################################################## **/
		/** ######################################################################################################################## **/
		
		public static function __setRightDateString(dateStringFree_:String,oldFormatWithSeparator:String='D-M-Y',newFormatWithSeparator:String='D-M-Y',separator_:String='-',faultReturn_:String=''):String 
		{
			if(!dateStringFree_ || dateStringFree_.length<4)
				return (faultReturn_) ? faultReturn_ : dateStringFree_;
			
			var _y:String;
			var _m:String;
			var _d:String;
			
			dateStringFree_ 		= gnncData.__replace(dateStringFree_,"/","-");
			dateStringFree_ 		= gnncData.__replace(dateStringFree_,".","-");
			dateStringFree_ 		= gnncData.__replace(dateStringFree_,",","-");
			
			oldFormatWithSeparator 	= gnncData.__replace(oldFormatWithSeparator,"/","-");
			oldFormatWithSeparator 	= gnncData.__replace(oldFormatWithSeparator,".","-");
			oldFormatWithSeparator 	= gnncData.__replace(oldFormatWithSeparator,",","-");
			
			newFormatWithSeparator 	= gnncData.__replace(newFormatWithSeparator,"/","-");
			newFormatWithSeparator 	= gnncData.__replace(newFormatWithSeparator,".","-");
			newFormatWithSeparator 	= gnncData.__replace(newFormatWithSeparator,",","-");
			
			if(dateStringFree_.length > 5 && dateStringFree_.indexOf("-") < 0)
			{
				//Brazilian
				if(oldFormatWithSeparator == 'D-M-Y') //31122034
				{
					dateStringFree_ = dateStringFree_.substr(0,2)+'-'+dateStringFree_.substr(2,2)+'-'+dateStringFree_.substr(4);
				}
					
					//International
				else if(oldFormatWithSeparator == 'Y-M-D')
				{
					if(dateStringFree_.length == 6) //983112
					{
						dateStringFree_ = dateStringFree_.substr(0,2)+'-'+dateStringFree_.substr(2,2)+'-'+dateStringFree_.substr(4);
					}
					else if(dateStringFree_.length == 8) //19983112
					{
						dateStringFree_ = dateStringFree_.substr(0,4)+'-'+dateStringFree_.substr(4,2)+'-'+dateStringFree_.substr(6);
					}
				}
			}
			
			if(dateStringFree_.indexOf("-") < 0)
				return (faultReturn_) ? faultReturn_ : dateStringFree_;
			
			var _values:Array 			= dateStringFree_.split('-');
			var _newF:Array 			= newFormatWithSeparator.split('-'); //sample: Y-M-D
			var _oldF:Array 			= oldFormatWithSeparator.split('-'); //sample: D-M-Y
			var _dateFinal:String 		= '';
			
			for(var i:uint=0; i<3; i++)
			{
				if(_oldF[i] == 'D'){ _d = gnncDataNumber.__setZero(uint(_values[i])) } 
				if(_oldF[i] == 'M'){ _m = gnncDataNumber.__setZero(uint(_values[i])) }
				if(_oldF[i] == 'Y'){ _y = (String(_values[i]).length==4) ? _values[i] : __year1900(String(_values[i])) }
			}
			
			for(var e:uint=0; e<3; e++)
			{
				if(_newF[e] == 'D') _dateFinal += _d;
				if(_newF[e] == 'M') _dateFinal += _m;
				if(_newF[e] == 'Y') _dateFinal += _y;
				if(e<2) _dateFinal += separator_;
			}
			
			return _dateFinal;
		}
		
		private static function __year1900(year_:String):String
		{
			if(!year_.length)
				return new Date().fullYear.toString();
			
			if(year_.length>3)
				return year_;
			
			var _thisYear:String =  new Date().fullYear.toString().substr(2);
			
			if(year_.length == 1)
				year_ = gnncDataNumber.__setZero(uint(year_));
			else if(year_.length == 3)
				year_ = year_.substr(-2,2);
			
			return (int(year_) > (int(_thisYear)+10)) ? '19'+year_: '20'+year_;
		}
		
		public static function __age(dateBirth_yyyymmddOrDate:Object,today_:Date=null):String
		{
			
			var ageDays:int 	= 0;
			var ageYears:int 	= 0;
			var ageRmdr:int 	= 0;
			
			var _d:Array		= new Array();
			var _birth:Date		= new Date();
			
			if(dateBirth_yyyymmddOrDate is String)
			{
				_d					= dateBirth_yyyymmddOrDate.toString().substr(0,10).split('-');
				_birth.fullYear		= _d[0];
				_birth.month		= _d[1];
				_birth.date			= _d[2];
			}
			else if (dateBirth_yyyymmddOrDate is Date)
			{
				_birth				= dateBirth_yyyymmddOrDate as Date;
			}
			else
			{
				return '-';
			}

			//year null
			if(!_birth.fullYear || _birth.fullYear == 0000 || _birth.fullYear == 1900)
				return '-';

			if(!today_) 
				today_ = new Date();
			
			var _diff:Number 		= today_.getTime() - _birth.getTime();
			
			ageDays 				= _diff / 86400000;
			ageYears 				= Math.floor(ageDays / 365.24);
			ageRmdr 				= Math.floor( (ageDays - (ageYears*365.24)) / 30.4375 );
			
			if(ageRmdr == 12)
				ageRmdr = 11;
			
			return ageYears + '';
		}
		
		/** 
		 * If Null return true
		 * **/
		public static function __isNull(date_:Object):Boolean
		{
			if(date_ is String)
				return String(date_).length==0 ? true : String(date_).substr(0,10) == '0000-00-00' ? true : false ;		
			if(date_ is Date)
				return !date_ ? true : date_ == null ? true : false ;

			return true;
		}

		/** 
		 * If Valid return true
		 * **/
		public static function __isValid(date_:Object):Boolean
		{
			return !__isNull(date_);
		}
	}
}