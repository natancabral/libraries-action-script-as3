package GNNC.data.data
{
	public class gnncDataRegExp
	{
		public function gnncDataRegExp()
		{
		}
		//http://gnosis.cx/publish/programming/regular_expressions.html
		
		public function _SEPARATOR(START_SYMBOL:String='[',END_SYMBOL:String=']'):String
		{
			// split in point, example: 
			//[NOME]sdasdasdasdasd;[TEL]adasdasdasdasd;[AMIGO]sadsadasdasds;
			//trace:  NOME: sdasdasdasdasd \n ...
			
			//\[[^<]+?\]   ===> texto [pega aqui dentro] texto
			//<[^<]+?>   ==> tags
			
			/**
			var I:uint;
			var	OBJ:Object;
			var VALUE:Array	= new Array();
			//http://gskinner.com/RegExr/
			var EXREG1:RegExp = /–/g; // tarço longo do MS WORD
			var EXREG2:RegExp = /\x22|\x27|\x60|\x201C|\x201D|\x201E/g;  // ASPAS: simples | invertida | duplas e outras aspas
			
			OBJ = STRING[I];
			OBJ = '';
			OBJ = OBJ.replace(EXREG1,'-');
			OBJ = OBJ.replace(EXREG2,'\"');
			var OBJ_TEXT:String = OBJ as String;
			OBJ = StringUtil.trim(OBJ_TEXT);
			VALUE.push(OBJ);
			**/
			
			return '';
		}
		


	}
}