package GNNC.data.sql
{
	import mx.collections.ArrayCollection;

	public class gnncSqlTable
	{
		private var _PARENT:Object;

		public function gnncSqlTable(parentApplication_:Object=null)
		{
			_PARENT = parentApplication_;
		}

		public function __CREATE_TABLE(TABLE_:Object,NEW_COLUMNS__NAME_TYPE_NUMBER:ArrayCollection,IF_NOT_EXISTS:Boolean=false,AUTO_INCREMENT_:uint=0):String
		{
			//CREATE TABLE IF NOT EXISTS
			var _SQL:String = "CREATE TABLE "+TABLE_._TABLE+" {}";
			return _SQL;
		}

		public function __ADD_COLUMN(TABLE_:Object,NEW_COLUMNS__NAME_TYPE_NUMBER:ArrayCollection):String
		{
			//ALTER TABLE clientes CHANGE fone fone char(30) not null; 
			var _SQL:String = "ALTER TABLE "+TABLE_._TABLE+" ADD newtable2 INT(2)";
			return _SQL;
		}

		public function __DROP_COLUMN(TABLE_:Object=null):String
		{
			var _SQL:String = "ALTER TABLE "+TABLE_._TABLE+" DROP `newtable2`";
			return _SQL;
		}
		
		//OPTIMIZE TABLE `dbd_client` 

	}
}