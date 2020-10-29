package GNNC.data.sql
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.sqlTables.table_sql;
	
	public class gnncSql
	{
		private var _PARENT:Object;
		private var SQL:String;
		private var D:gnncSqlCreation = new gnncSqlCreation();
		public var TRY:Boolean = false;
		
		public function gnncSql(parentApplication_:Object=null,TRY_:Boolean=false)
		{
			_PARENT = parentApplication_;
			TRY = TRY_;
		}
		
		public function __SELECT(TABLE_:Object=null,RETURN_A__COUNT__:Boolean=false,COLUMNS_RETURN_:Array=null,JOIN_:Array=null,COUNTS_COLUMNS:Array=null,WHERE_AND_:Array=null,WHERE_OR_:Array=null,ORDER_BY_:Array=null,DESC_:Boolean=true,LIMIT_:Array=null,ACCEPT_RELATIVE_COLUMNS_:Array=null,CASE_SENSITIVE_IN_:Array=null,IF_:Array=null):String
		{
			SQL = "SELECT " + 
				D.__COLUMNS_RETURN		(TABLE_,COLUMNS_RETURN_,RETURN_A__COUNT__)+ 
				D.__TABLE				(TABLE_,true)+ 
				D.__WHERE				(TABLE_,ACCEPT_RELATIVE_COLUMNS_,CASE_SENSITIVE_IN_,WHERE_AND_,WHERE_OR_)+
				D.__ORDER_BY			(ORDER_BY_,DESC_)+ 
				D.__LIMIT				(LIMIT_);
			
			__show(SQL);
			return SQL;
		}
		
		public function __INSERT(TABLE_:Object=null,RETURN_LAST_ID_:Boolean=false,IF_EXIST_ID_UPDATE_:Boolean=false,ACCEPT_NULL_VALUES_:Boolean=false):String
		{
			if(IF_EXIST_ID_UPDATE_ && TABLE_.ID)
			{
				var ID_TABLE:table_sql = new table_sql();
				ID_TABLE.ID = TABLE_.ID;
				return __UPDATE(TABLE_,ID_TABLE,ACCEPT_NULL_VALUES_);
			}
			
			SQL = "INSERT INTO " + D.__TABLE(TABLE_) + D.__WHERE_INSERT(TABLE_,ACCEPT_NULL_VALUES_);
			
			if(RETURN_LAST_ID_)
				SQL += D.__RETURN_LAST_ID(TABLE_); 
			
			__show(SQL);
			
			return SQL;
		}
		
		public function __UPDATE(tableValuesUpdate_:Object,tableWhere_:Object=null,updateWithNullValues_:Boolean=false,columnsAndValues:Array=null):String
		{
			/** WHERE = ID **/
			if(tableValuesUpdate_.ID && tableWhere_ == null)
			{ 
				tableWhere_ 			= new Object();
				tableWhere_['ID'] 		= tableValuesUpdate_.ID;
				tableWhere_['_TABLE'] 	= tableValuesUpdate_._TABLE;
			}
			
			//COLUMNS_AND_VALUES_ = COLUMNS_AND_VALUES_ ? COLUMNS_AND_VALUES_ : [" "];
			
			SQL = "UPDATE " + D.__TABLE(tableValuesUpdate_) + " SET " + D.__WHERE_UPDATE(tableValuesUpdate_,updateWithNullValues_,columnsAndValues) + D.__WHERE(tableWhere_);
			
			__show(SQL);
			
			return SQL.replace(" ,  WHERE ("," WHERE (");
		}
		
		public function __DELETE(TABLE_:Object=null,IDS_:Array=null,TRUE_IF_YES_:Boolean=false):String
		{
			SQL = "DELETE " + D.__TABLE(TABLE_,true) + D.__WHERE_DELETE("ID",IDS_);
			
			if(!TRUE_IF_YES_) 
				SQL = "";
			
			__show(SQL);
			
			return SQL;
		}
		
		public function __ROWS(TABLES_:Array=null, ... WHERE):String
		{
			SQL = "SELECT " + D.__ROWS_TABLES(TABLES_);
			
			__show(SQL);
			
			return SQL;
		}
		
		private  function __show(SQL_:String):void
		{
			if(TRY) new gnncAlert().__alert(SQL_);
		}
		
		
	}
}