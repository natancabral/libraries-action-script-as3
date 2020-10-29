package GNNC.sqlTables
{
	import GNNC.data.globals.gnncGlobalStatic;
	
	public class table_sql extends table_
	{
		public var SQLVALUE:String;
		
		public function table_sql(SQLVALUE_:String=null)
		{
			_TABLE = '_gnncAmfPhp';
			SQLVALUE = SQLVALUE_;
			table_data();
		}
		
	}
}