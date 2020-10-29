package GNNC.modules.client.report
{
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataNumber;
	import GNNC.data.date.gnncDate;
	import GNNC.data.file.gnncFileReport;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.sql.gnncSql;
	import GNNC.sqlTables.table_client;
	import GNNC.time.gnncTime;
	
	import mx.collections.ArrayCollection;
	
	public class gnncFileReport_client_viewClient extends gnncFileReport
	{
		private var _headerFont:uint 		= 10;
		private var _headerRow:uint 		= 4
		private var _normalFont:uint		= 10
		private var _normalRow:uint 		= 7;

		public function gnncFileReport_client_viewClient()
		{
		}
		
		protected override function __addHeader(e:*=null):void
		{
			//A4 wth margin = 190 or 260 
		} 
		
		protected override function __addResume(object_:Object):void
		{
			//A4 wth margin = 190 or 260 
		}
		
		protected override function __addFinalObservation(object_:Object):void
		{
			//A4 wth margin = 190 or 260
		}
		
		protected override function __itemRender(object_:Object,i_:uint,objectAlternative_:Object=null):void
		{
			var _personalBorder:uint = 0xCCCCCC;
			
			//A4 wth margin = 190 or 260 
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Nome Completo'									,160,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(''												,30,"L",(_normalRow*4+2),_normalBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.NAME)	,160,"L",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Nascimento'										,25 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Cadastrado'										,25 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'':'Sexo'						,15 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Indicação de'									,95,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(gnncDate.__date2Legend(object_.DATE_BIRTH)		,25	,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncDate.__date2Legend(object_.DATE)				,25 ,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'':object_.SEX					,15 ,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__setFontStyle(_normalFont-2);
			_gnncFilePdf.__addCell(object_.NAME_CLIENT								,95,"L",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+2);
			
			_gnncFilePdf.__setFontStyle(_headerFont+2);
			_gnncFilePdf.__addCell('Registro'										,190,"L",_headerRow+2,0,0);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'CNPJ':'CPF'						,65,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'Inscrição Estadual':'RG'		,65 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'SSP':'UF'						,10 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Nacionalidade'									,50 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(String(object_.CPF_CNPJ).substr(0,4)=='2626'?'':object_.CPF_CNPJ,65,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.RG_REGISTER								,65 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.RG_REGISTER_UF							,10 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.ISO_NACIONALITY							,50 ,"L",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Matrícula'										,65,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('E-mail'											,100,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Acesso Web'										,25 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(object_.ENROLLMENT								,65 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(String(object_.EMAIL).toLowerCase()				,100,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.ACCESS_WEB?'Sim':'Não'					,25 ,"C",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+2);
			
			_gnncFilePdf.__setFontStyle(_headerFont+2);
			_gnncFilePdf.__addCell('Profissão'										,190,"L",_headerRow+2,0,0);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell(object_.COMPANY==1?'Área de Atuação':'Profissão'	,140,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Registro Prof.'									,25 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Registro UF'									,25 ,"C",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(''												,140,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.PROFESSIONAL_NUMBER						,25 ,"R",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.PROFESSIONAL_STATE						,25 ,"L",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+2);
			
			_gnncFilePdf.__setFontStyle(_headerFont+2);
			_gnncFilePdf.__addCell('Contato'										,190,"L",_headerRow+2,0,0);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			var o1:String = __operatorName(object_.PHONE_OPERATOR).toString();
			var o2:String = __operatorName(object_.PHONE_CEL_OPERATOR).toString();
			var o3:String = __operatorName(object_.PHONE_COMPANY_OPERATOR).toString();
			var o4:String = __operatorName(object_.PHONE_FAX_OPERATOR).toString();
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Telefone'										,47,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Telefone Celular'								,48 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Telefone Empresarial'							,47 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Telefone Fax'									,48 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE)			,32 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(o1														,15,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_CEL)		,33 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(o2														,15,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_COMPANY)	,32 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(o3														,15,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncDataNumber.__clearPhoneNumber(object_.PHONE_FAX)		,33 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(o4														,15,"C",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			var cep:String		= object_.ZIPCODE ? '(CEP: '+object_.ZIPCODE+')' : '(Nenhum CEP)';
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Logradouro '+cep										,70,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Núm.'													,13,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Compl.'													,15,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Bairro'													,32,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Cidade'													,30,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Estado'													,30,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont-1);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.ADDRESS)			,70,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.ADDRESS_NUMBER									,13,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.ADDRESS_COMPLEMENT								,15,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.NEIGHBORHOOD)	,32,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.CITY)			,30,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(object_.STATE)			,30,"L",_normalRow,_normalBg,_personalBorder);
			
			_gnncFilePdf.__breakLine(_normalRow+2);
			
			_gnncFilePdf.__setFontStyle(_normalFont+2);
			_gnncFilePdf.__addCell('Classificação'											,190,"L",_headerRow+2,0,0);
			
			_gnncFilePdf.__breakLine(_normalRow+1);
			
			_gnncFilePdf.__setFontStyle(_headerFont-2);
			_gnncFilePdf.__addCell('Departamento'											,55,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Grupo'													,55 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Categoria'												,55 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__addCell('Estrelas'												,25 ,"L",_headerRow,_headerBg,_personalBorder);
			_gnncFilePdf.__breakLine(_headerRow);
			_gnncFilePdf.__setFontStyle(_normalFont);
			_gnncFilePdf.__addCell(object_.NAME_DEPARTAMENT									,55 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.NAME_GROUP										,55 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.NAME_CATEGORY									,55 ,"L",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__addCell(object_.STAR_RATING										,25 ,"C",_normalRow,_normalBg,_personalBorder);
			_gnncFilePdf.__breakLine(_normalRow+2);

			var x:uint = 0;
			var tt:uint = _courses.length;
			var cObj:Object = new Object();
			var sigla:String = '';
			if(tt)
			{
				_gnncFilePdf.__setFontStyle(_normalFont+2);
				_gnncFilePdf.__addCell('Curso(s) Matriculado(s)'		,190,"L",_headerRow+2,0,0);
				
				_gnncFilePdf.__breakLine(_normalRow+1);
				
				_gnncFilePdf.__setFontStyle(_headerFont-2);
				_gnncFilePdf.__addCell('Id'								,10,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__addCell('Sigla'							,17,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__addCell('Turma'							,100 ,"L",_headerRow,_headerBg,_personalBorder);
				//_gnncFilePdf.__addCell('Grupo'						,20 ,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__addCell('Início'							,21 ,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__addCell('Término'						,21 ,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__addCell('Concluído'						,21 ,"L",_headerRow,_headerBg,_personalBorder);
				_gnncFilePdf.__breakLine(_headerRow);
				
				_gnncFilePdf.__setFontStyle(_normalFont-1);
	
				for(x=0;x<tt;x++)
				{
					cObj = _courses.getItemAt(x);
					//sigla = 'T' + .substr(strtoupper($_row['NAME_GROUP']),0,1).'-'.substr('00'.$_row['ID'],-3);

					_gnncFilePdf.__addCell(cObj.ID_PROJECT				,10 ,"L",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__addCell(sigla						,17 ,"L",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__addCell(gnncData.__firstLetterUpperCase(cObj.NAME_COURSE)	,100 ,"L",_normalRow,_normalBg,_personalBorder);
					//_gnncFilePdf.__addCell(cObj.NAME_GROUP			,20 ,"L",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__addCell(gnncDate.__date2Legend(cObj.DATE_START)				,21 ,"C",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__addCell(gnncDate.__date2Legend(cObj.DATE_END)				,21 ,"C",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__addCell(gnncDate.__date2Legend(cObj.DATE_FINAL)				,21 ,"C",_normalRow,_normalBg,_personalBorder);
					_gnncFilePdf.__breakLine(_normalRow);
				}
			}

			if(_object.hasOwnProperty('PHOTO'))
				if(_object.PHOTO)
					_gnncFilePdf.__addImageUI(_object.PHOTO,null,161,1,28,28);
		}
		
		protected override function __finalReport(e:*=null):void
		{
		}
		
		protected override function __setValues():void
		{
			_fileName = "DAYBYDAY - USER - Ficha Cadastral";
			_documentTitle = "Ficha Cadastral - "+gnncDate.__date2Legend('',_dateStart);
			
			var COLUMN:Array = [
				"*",
				"coalesce((SELECT NAME FROM dbd_client as a		WHERE a.ID 					LIKE dbd_client.INDICATED_CLIENT						),'Nenhuma') NAME_CLIENT",
				"coalesce((SELECT NAME FROM dbd_departament 	WHERE dbd_departament.ID 	LIKE dbd_client.ID_DEPARTAMENT							),'Nenhum') NAME_DEPARTAMENT",
				"coalesce((SELECT NAME FROM dbd_group 			WHERE dbd_group.ID 			LIKE dbd_client.ID_GROUP								),'Nenhum') NAME_GROUP",
				"coalesce((SELECT NAME FROM dbd_category 		WHERE dbd_category.ID 		LIKE dbd_client.ID_CATEGORY								),'Nenhum') NAME_CATEGORY",
				"coalesce((select FILE_LINK from dbd_attach 	WHERE MIX like 'CLIENT' and ID_MIX like dbd_client.ID AND (EXTENSION like 'jpg' or EXTENSION like 'png' or EXTENSION like 'gif') ORDER BY ORDER_ITEM LIMIT 0,1	),0)  ATTACH_CLIENT"
			];
			
			var _table:table_client = new table_client(_object.ID);
			_table.ACTIVE 			= 0;
			_table.VISIBLE 			= 0;
			
			_sql					= new gnncSql().__SELECT(_table,false,COLUMN);
		}
		
		private function __operatorName(operatorNumber_:Object):String
		{
			if(operatorNumber_==null)
				return '';
			/** 
			 * ATENCAO::::::::::::::::::::::::::::::::::::::::::: 
			 * 
			 * Nem todos estao aqui. fazer uma funcao dentro do gnncglobalarray
			 * 
			 * ATENCAO::::::::::::::::::::::::::::::::::::::::::: 
			 * **/
			switch(operatorNumber_)
			{
				case 41:
					return 'TIM';
					break;
				case 31:
					return 'OI';
					break;
				case 21:
					return 'CLARO';
					break;
				case 77:
					return 'NEXT';
					break;
				case 20:
					return 'VIVO';
					break;
				case 14:
					return 'BRTEL';
					break;
				default:
					return '';
			}
			return '';
		}

		private function __setSql():void
		{
			
			var COLUMN:Array = [
				"*",
				"coalesce((SELECT NAME FROM dbd_client as a		WHERE a.ID 					LIKE dbd_client.INDICATED_CLIENT						),'Nenhuma') NAME_CLIENT",
				"coalesce((SELECT NAME FROM dbd_departament 	WHERE dbd_departament.ID 	LIKE dbd_client.ID_DEPARTAMENT							),'Nenhum') NAME_DEPARTAMENT",
				"coalesce((SELECT NAME FROM dbd_group 			WHERE dbd_group.ID 			LIKE dbd_client.ID_GROUP								),'Nenhum') NAME_GROUP",
				"coalesce((SELECT NAME FROM dbd_category 		WHERE dbd_category.ID 		LIKE dbd_client.ID_CATEGORY								),'Nenhum') NAME_CATEGORY",
				"coalesce((select FILE_LINK from dbd_attach 	WHERE MIX like 'CLIENT' and ID_MIX like dbd_client.ID AND (EXTENSION like 'jpg' or EXTENSION like 'png' or EXTENSION like 'gif') ORDER BY ORDER_ITEM LIMIT 0,1	),0)  ATTACH_CLIENT"
			];
			
			var _table:table_client = new table_client(_object['ID']);
			_table.ACTIVE 			= 0;
			_table.VISIBLE 			= 0;
			
			_sql					= new gnncSql().__SELECT(_table,false,COLUMN);
		}
		
		/**
		 * Com listagem de cursos abaixo
		 * */
		[Bindable] private var _gnncGlobal:gnncGlobalStatic = new gnncGlobalStatic(true);
		private var _courses:ArrayCollection = new ArrayCollection();110
		
		public function __createPersonalWithListCourse(idClient_:uint,photo_:Object):void
		{			
			//new gnncAlert().__description('Estamos processando as informações.','Aguarde...');

			var _idCourse:uint 				= uint(new gnncDataArrayCollection().__search(_gnncGlobal._SETTINGS.DATA_ARR,'NAME','ID_COURSE','VALUE'));
			var _reportCourse:gnncAMFPhp	= new gnncAMFPhp();
			
			if(_idCourse)
			{
				var _sqlCourse:String 	= " select ID_PROJECT," +
					"(select NAME 			from dbd_project p where p.ID = s.ID_PROJECT ) as NAME_COURSE, " +
					"(select DATE_START 	from dbd_project p where p.ID = s.ID_PROJECT ) as DATE_START, " +
					"(select DATE_END 		from dbd_project p where p.ID = s.ID_PROJECT ) as DATE_END, " +
					"(select DATE_FINAL 	from dbd_project p where p.ID = s.ID_PROJECT ) as DATE_FINAL " +
					"from dbd_course_student s where s.ID_CLIENT = '"+idClient_+"' limit 0,7 "; //ID_CLIENT = '"+_idCourse+"'
				_reportCourse.__sql(_sqlCourse,'','',__fResultCourse,__fFaultCourse);
				//new gnncAlert().__alert(_sqlCourse);
			}
			else
			{
				__fResultCourse.call();
			}
			
			function __fFaultCourse(e:*=null):void
			{
				//new gnncAlert().__alert("#error#");
			}
			
			function __fResultCourse(e:*=null):void
			{
				var _gnncTime:gnncTime = new gnncTime();
				_gnncTime.__start(1000,function(e:*=null):void{
					
					//new gnncAlert().__dataGrid(_reportCourse.DATA_ARR,'Grid');
					_courses			= _reportCourse.DATA_ARR;
					
					_dateStart 			= new Date();
					
					_object				= new Object();
					_object['ID']		= idClient_;
					_object['PHOTO']	= photo_;
					
					_documentTitle  	= "Ficha Cadastral - "+gnncDate.__date2Legend('',_dateStart);
					
					//_sql = "";
					__setSql();
					__create();
					
				},1);
			}
			
		}

	}
}