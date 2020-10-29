package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_sad_answer extends table_
	{
		public var ID_SAD_ASK:uint        = 0;
		public var LEVEL:uint             = 0;
		
		public var ID_CLIENT_EMPLOYEE:uint = 0; //avaliado
		public var ID_CLIENT_ANSWER:uint   = 0; //quem respondeu
		
		public var MIX:String             = '';
		public var MIX_TYPE:String        = '';
		//public var ID_MIX:String        = '';
		
		public var ID_GROUP_SPHERE:uint   = 0;
		public var ID_GROUP:uint          = 0;
		
		public var VALUE_INT:uint         = 0;
		public var VALUE_TEXT:String      = '';
		public var WEIGHT:Number          = 0;
		public var RESULT:Number          = 0;

		public var LEVEL_EDUCATON:String  = '';

		public var DATA:String  = '';//json

		/*
		CREATE TABLE `dbd_data_answer` (
		`ID` int(9) NOT NULL AUTO_INCREMENT,
		`ID_DATA_ASK` int(6) NOT NULL,
		
		`MIX` varchar(30) NOT NULL COMMENT 'COMP,META,ASPE',
		`MIX_TYPE` varchar(30) NOT NULL COMMENT 'SPHERE(nome de uma esfera),ITEM(um idem ou pergunta)',
		
		`ID_GROUP_SPHERE` int(6) NOT NULL COMMENT 'Esferas Gerais sao 3, comp, metas, asp admin',
		`ID_GROUP` int(6) NOT NULL COMMENT '',
		
		`VALUE_INT` varchar(1) NOT NULL COMMENT 'resposta numero',
		`VALUE_TEXT` varchar(150) NOT NULL COMMENT 'resposta texto',
		`WEIGHT` double NOT NULL COMMENT 'peso sobre a resposta',
		`RESULT` double NOT NULL COMMENT 'resultado',
		
		`LEVEL_EDUCATON` varchar(30) NOT NULL COMMENT 'FUN,MED,SUP,DOC,MES' ,
		
		`DATA` text NOT NULL COMMENT 'json need',
		`DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		
		PRIMARY KEY (`ID`)
		) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=utf8
		*/
		public function table_sad_answer(ID_:uint=0)
		{
			_TABLE = 'SAD_ANSWER';
			ID = ID_;
			table_data();
		}
		
	}
}