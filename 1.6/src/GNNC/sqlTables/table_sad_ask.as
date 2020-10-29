package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_sad_ask extends table_
	{
		public var ID_FATHER:uint         = 0;
		public var LEVEL:uint             = 0;

		public var MIX:String             = '';
		public var MIX_TYPE:String        = '';
		//public var ID_MIX:String        = '';

		public var ORDER_ITEM:uint        = 0;
		public var ID_GROUP_SPHERE:uint   = 0;
		public var ID_GROUP:uint          = 0;
		
		public var IS_ASK:uint            = 0;
		public var ANSWERS:String         = '';
		public var WEIGHT:Number          = 0;
		public var PERCENT:Number         = 0;

		public var NAME:String            = '';
		public var TITLE:String           = '';
		public var DESCRIPTION:String     = '';
		public var LEVEL_EDUCATION:String = '';

		public var DATA:String  = '';//json
		public var ACTIVE:uint  = 1;

		/*
		`ID` int(9) NOT NULL AUTO_INCREMENT,
		`ID_FATHER` int(6) NOT NULL,
		`LEVEL` int(1) NOT NULL,
		`MIX` varchar(30) NOT NULL COMMENT 'COMP,META,ASPE',
		`MIX_TYPE` varchar(30) NOT NULL COMMENT 'SPHERE(nome de uma esfera),ITEM(um idem ou pergunta)',
		
		`ORDER_ITEM` int(3) NOT NULL,
		`ID_GROUP_SPHERE` int(6) NOT NULL COMMENT 'Esferas Gerais sao 3, comp, metas, asp admin',
		`ID_GROUP` int(6) NOT NULL,

		`IS_ASK` varchar(1) NOT NULL COMMENT '1-sim 0-nao',
		`ANSWERS` varchar(30) NOT NULL COMMENT '1,2,3,4,5 hoje separado por virgulas, amanha sera campo',
		`WEIGHT` double NOT NULL COMMENT 'peso sobre a resposta',

		`NAME` varchar(50) NOT NULL,
		`TITLE` varchar(250) NOT NULL,
		`DESCRIPTION` mediumtext NOT NULL,
		`LEVEL_EDUCATON_1` varchar(30) NOT NULL COMMENT 'FUN,MED,SUP,DOC,MES',
		`DATA` text NOT NULL COMMENT 'json need',
		`DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		`ACTIVE` int(1) NOT NULL,
		PRIMARY KEY (`ID`)
		*/
		
		public function table_sad_ask(ID_:uint=0)
		{
			_TABLE = 'SAD_ASK';
			ID = ID_;
			table_data();
		}
	}
}