package GNNC.data.sql
{
	import GNNC.UI.gnncAlert.gnncAlert;
	
	public class gnncSqlModel
	{
		private var _PARENT:Object;
		private var SQL:String = "";
		
		public function gnncSqlModel(parentApplication_:Object=null)
		{
			parentApplication_ = _PARENT;
		}
		
		public function __HELP():void
		{
			SQL = "SQL DATE:\n " +
				"NOW() = 2011-05-20 00:32:21 \n" +
				"CURDATE() = 2011-05-20 \n" +
				"CURRENT_DATE() = 2011-05-20 \n" +
				"YEAR('2011-12-31') = 2011 \n" +
				"MONTH(NOW()) = 9 \n" +
				"DAYOFMONTH(NOW()) = 31 \n" +
				"HOUR(NOW()) = 2 \n" +
				"MINUTE(NOW()) = 32 \n" +
				"SECOND(NOW()) = 21 \n" +
				"DAYNAME('2000-01-01') = Saturday \n" +
				"DAYOFWEEK('2000-01-01') = 7 \n" +
				"DAYOFYEAR('2000-12-31') = ...\n" +
				"DATEDIFF('2011-12-21','1980-03-28') = 31 \n";
			
			new gnncAlert().__alert(SQL);
				
		}
		
		public function __DATE_ALERT():String
		{
			SQL = 	" SELECT  dbd_client.ID,  dbd_client.NAME,	" + 
				"	CASE									" +
				"		WHEN ID < 30 THEN 'Menor que 30'	" +
				"		WHEN ID < 40 THEN 'Menor que 40'	" +
				"		WHEN ID < 50 THEN 'Menor que 50'	" +
				"		ELSE 'Outros'						" +
				"	END AS NUMBER							" +
				" FROM dbd_client WHERE 					" +
				" NAME LIKE '%MARIA%' 						" +
				" AND RG_REGISTER LIKE '%10%'				" +
				" AND LAST_NAME LIKE '%JOSÉ%' 				" +
				" OR CPF_CNPJ LIKE '%00%'					";
			
			return SQL;
		}
		
		public function __AGE(TABLE_:Object=null,COLUMN_BIRTH_:String="DATE_BIRTH"):String
		{
			/** SAMPLE SQL AGE **/
			//SQL = "(SELECT DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(" + COLUMN_BIRTH_ + ")), '%Y')+0 FROM dbd_" + TABLE_._TABLE.toString().toLowerCase() + ")  AS AGE";
			//SQL = "(SELECT floor(datediff (NOW(), DATE_BIRTH)/365) as AGE
			//SQL = " CURDATE() AS TODAY, (YEAR(CURDATE()) - YEAR(DATE_BIRTH)) - (RIGHT(CURDATE(),5) < RIGHT(DATE_BIRTH,5)) AS AGE ";
			SQL = " CURDATE() AS TODAY, (SELECT floor(DATEDIFF (NOW(), " + COLUMN_BIRTH_ + ")/365)) CASE WHEN > 10 THEN '100' END AS AGE ";
			return SQL;
		}
		
		public function __DAY_of_DATEBIRTH(COLUMN_BIRTH_:String="DATE_BIRTH",RETURN_COLUMN_:String="DAY"):String
		{
			SQL = " (RIGHT(DATE_BIRTH,2)) AS "+RETURN_COLUMN_+" ";
			return SQL;
		}
		
		/**
		UNIO
		//Pode ser de tabelas diferentes ou mesmas tabelas
		
		//sql UNION - two consults on once return
		
		SELECT * FROM clientes WHERE idcidade = 1 LIMIT 3)
		UNION (SELECT * FROM clientes WHERE idcidade = 5 LIMIT 3)
		UNION (SELECT * FROM clientes WHERE idcidade = 8 LIMIT 3)
		
		//sql UNION ALL traz retuns rows repeats

		
		
		//if clear return
		//coalesce(,'se nulo isso aqui') as VAR
		
		//update dbd_attach SET NAME = REPLACE(NAME,'-',''), NAME2=REPLACE(NAME,'-','') WHERE...; Replace Value in SQL
		
		// if if if if if
		UPDATE elec_products SET
		`status` = IF(programname='Argos', 1, IF(programname='sify', 2, 3) )
		WHERE programname IS NOT NULL
  

		//update table set SET bankmoney = IF (bankmoney * .02 < 1000, bankmoney * .02, bankmoney + 1000)
		
		//update dbd_client SET PROFESSIONAL_STATE = IF (PROFESSIONAL_NUMBER LIKE '%CE%', 'CE', '') where PROFESSIONAL_NUMBER like ''
		
		//update dbd_job SET DATE = NOW() WHERE DATE like '0000-00-00 00:00:00'
		
		//DELETE FROM table_name WHERE some_column = some_value;
		
		/*CASE									" +
			"		WHEN ID < 30 THEN 'Menor que 30'	" +
			"		WHEN ID < 40 THEN 'Menor que 40'	" +
			"		WHEN ID < 50 THEN 'Menor que 50'	" +
			"		ELSE 'Outros'						" +
			"	END AS NUMBER							" +
			" FROM dbd_client WHERE 					" +*/
		
		//NO NULL
		
		/*
		
		INSERT INTO table_name (column1, column2, column3,...)
		VALUES (value1, value2, value3,...) 
		
		*/
		
		/*
		
		select *,
		coalesce((SELECT c.NAME from dbd_client c, dbd_course_teacher j where j.ID_PROJECT LIKE  s.ID_PROJECT AND c.ID like j.ID_CLIENT AND j.THEMAN LIKE '1' LIMIT 0,1) ,'-') NAME_TEACHER_THEMAN 
		from dbd_course_student s where s.ID_PROJECT like '0' ORDER BY NAME_STUDENT ASC 

		
		view
		
		this
		select p.*,f.VALUE_IN_PAY from dbd_course_parcel_pay p join dbd_financial f where p.ID_FINANCIAL like f.ID 
		to this
		Create view view_course_parcel_pay_value_in as (select p.*,f.VALUE_IN_PAY from dbd_course_parcel_pay p join dbd_financial f where p.ID_FINANCIAL like f.ID )
		
		*/
		
		
		
		/** return list duplicate values, all duplicate names in list **/
		/*
		
		
		SELECT dbd_client.NAME,ID FROM dbd_client
		INNER JOIN 
		(SELECT d.NAME FROM dbd_client as d GROUP BY d.NAME HAVING count(d.ID) > 1) dup 
		ON dbd_client.NAME = dup.NAME
		
		
		or
		
		
		SELECT dbd_client.NAME,ID FROM dbd_client
		INNER JOIN 
		(SELECT d.NAME FROM dbd_client as d WHERE d.ID_GROUP = '1' GROUP BY d.NAME HAVING count(d.ID) > 1) dup 
		ON dbd_client.NAME = dup.NAME

		*/

		
		/**
		 * 
		 * SELECT 
		 * CONCAT('R$ ',2.1) as V1
		 * CAST(23.11122 AS DECIMAL(20,2))  as V2
		 * FROM `dbd_financial_book` WHERE 1
		 * 
		 * result
		 * 
		 * R$ 2.1
		 * 23,11
		 * 
		 * **/
		

/**
-- VIEW
create view history_itemvalue_pivot_pretty as (
  select 
    hostid, 
    coalesce(A, 0) as A, 
    coalesce(B, 0) as B, 
    coalesce(C+1, 0) as C
  from history_itemvalue_pivot 
);

select * from history_itemvalue_pivot_pretty;

+--------+------+------+------+
| hostid | A    | B    | C    |
+--------+------+------+------+
|      1 |   10 |    3 |    0 |
|      2 |    9 |    0 |   41 |
+--------+------+------+------+
 
**/ 
		
		
		
	}
}