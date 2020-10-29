package GNNC.data.validator
{
	import mx.utils.StringUtil;
	import mx.validators.ValidationResult;
	
	import spark.validators.NumberValidator;
	
	public class gnncValidatorPhoneBr extends NumberValidator
	{
		
		public function gnncValidatorPhoneBr()  
		{  
			super();  
		}
		
		override protected function doValidation(value:Object):Array 
		{
			var results:Array = super.doValidation(value.text);
			
			//\d{2}/\d{2}/\d{4} for DD/DD/DDDD
			//\d\d?/\d\d?/\d{4} for D/D/DDDD and DD/DD/DDDD
			//DB2_.text = dateFormatter.format(DB2_.text);
			
			var o:Object = value;//e.currentTarget;
			var s:String = o.text;
			var max:uint = 12;
			var mArr:Array = 
				[
					"",
					"({0}",
					"({0}{1}",
					"({0}{1}) {2}",
					"({0}{1}) {2}{3}",
					"({0}{1}) {2}{3}{4}",
					"({0}{1}) {2}{3}{4}{5}",
					"({0}{1}) {2}{3}{4}{5}{6}",
					"({0}{1}) {2}{3}{4}{5}{6}-{7}",
					"({0}{1}) {2}{3}{4}{5}{6}-{7}{8}",
					"({0}{1}) {2}{3}{4}{5}{6}-{7}{8}{9}",
					"({0}{1}) {2}{3}{4}{5}{6}-{7}{8}{9}{10}",
					"({0}{1}) {2}{3}{4}{5}{6}-{7}{8}{9}{10}{11} "
				]; //(00) 0000-0000 = 14/15
			var f:String = ''; //final
			var c:uint = 0;//cont
			
			s = s.split('(').join('').split(')').join('').split(' ').join('').split('-').join('').split('{').join('').split('}').join('');
			c = s.length;
			s = s+'   '; //15 spaces
			//StringUtil.substitute(m,);
			
			f = mArr[c];
			//
			//if(!backSpace)
			for(var i:uint=0;i<c+3;i++){
				if(i>max)
					continue;
				f = f
					.replace(
						new RegExp("\\{"+i+"\\}", "g"), 
						i<=10?
						s.substr(i,1):''
					); 
			}
			
			f = StringUtil.trim(f);
			o.text = f;
			//o.selectRange(p2,p1);
			o.selectRange(f.length,f.length);
			//o.selectRange(s.length,s.length);
			
			//results.push(new ValidationResult(true, null, "Erro","Número do CNPJ inválido!"));

			return results;
		}
		
		override protected function getValueFromSource():Object
		{
			var value:Object = {};
			value.text = super.getValueFromSource();
			return  value;
		}
	}
}