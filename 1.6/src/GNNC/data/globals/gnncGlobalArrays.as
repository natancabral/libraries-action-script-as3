package GNNC.data.globals
{
	import GNNC.sqlTables.table_attach;
	import GNNC.sqlTables.table_calendar;
	import GNNC.sqlTables.table_category;
	import GNNC.sqlTables.table_client;
	import GNNC.sqlTables.table_comment;
	import GNNC.sqlTables.table_contract;
	import GNNC.sqlTables.table_departament;
	import GNNC.sqlTables.table_financial;
	import GNNC.sqlTables.table_financial_account;
	import GNNC.sqlTables.table_financial_future;
	import GNNC.sqlTables.table_form_model;
	import GNNC.sqlTables.table_group;
	import GNNC.sqlTables.table_job;
	import GNNC.sqlTables.table_login;
	import GNNC.sqlTables.table_permission;
	import GNNC.sqlTables.table_process_calendar;
	import GNNC.sqlTables.table_product;
	import GNNC.sqlTables.table_project;
	import GNNC.sqlTables.table_series;
	import GNNC.sqlTables.table_step;
	
	import mx.collections.ArrayCollection;
	
	public class gnncGlobalArrays
	{
		/**
		 * app = local
		 * server = remote
		 */
		//update
		static public const serverUpdatePath:String       = 'https://gnnc.com.br/daybyday/download/update/';
		static public const serverUpdateFile:String       = 'gnnc-daybyday-update.json';
		//user documents
		static public const appUpdateDownload:String      = 'GNNC/AppUpdate';
		static public const appUpdateFileName:String      = 'Setup-GNNC-{{programName}}-v{{version}}'; //no extension
		//program files
		static public const appProgramFilesGroup:String   = 'GNNC/';
		static public const appProgramFiles:String        = 'Daybyday - App{{programName}}/';
		static public const appAdobeRunTime:String        = 'Adobe AIR/Versions/1.0/Adobe AIR.dll';
		//server notification push v1
		static public const serverNotificationPush:String = '/librarys/collection/cron/notification/notification.php';
		//server connection
		static public const serverGateway:String          = '/librarys/amfphp/2.2.2/Amfphp/index.php';
		//permissions roles
		static public const permissionsRoles:String       = '/librarys/app/permissions/permission-{{programName}}.php'
		//server files upload
		static public const serverFileUpload:String       = '/librarys/collection/data/files/upload/uploadOnce.php';   //'/librarys/files/filesPhp/filePhpUploadOnce.php';
		static public const serverFileUploadList:String   = '/librarys/collection/data/files/upload/uploadList.php';   //'/librarys/files/filesPhp/filePhpUploadList.php';
		static public const serverFileOpenRemote:String   = '/librarys/collection/data/files/upload/openRemote.php';   //'/librarys/files/filesPhp/filePhpRemote.php';
		static public const serverFileDelete:String       = '/librarys/collection/data/files/upload/uploadDelete.php'; //'/librarys/files/filesPhp/filePhpUploadDelete.php';
		/*static public const serverFileUpload:String       = '/librarys/files/filesPhp/filePhpUploadOnce.php';
		static public const serverFileUploadList:String   = '/librarys/files/filesPhp/filePhpUploadList.php';
		static public const serverFileOpenRemote:String   = '/librarys/files/filesPhp/filePhpRemote.php';
		static public const serverFileDelete:String       = '/librarys/files/filesPhp/filePhpUploadDelete.php';*/
		//server path
		static public const serverPathXML:String          = '/services/files/filesXml/';
		static public const serverPathJSon:String         = '/services/files/filesJson/';
		//others
		static public const serverTime:String             = '/librarys/collection/data/files/server/serverTime.php';
		static public const serverMailer:String           = '/librarys/collection/data/files/mailer/index.php';
		
		static public const _HTTPHOST:ArrayCollection = new ArrayCollection
			([
				{label:'gnnc', 			server:'gnncServer',			http:'https://daybyday.gnnc.com.br/'	, domain:'https://gnnc.com.br/'	},
				//{label:'gnial', 		server:'gnialServer',			http:'https://daybyday.gnial.com.br/'	, domain:'https://gnial.com.br/'	},
				{label:'local.1', 		server:'localhost1',			http:'http://127.0.0.1/daybyday/'		, domain:'http://127.0.0.1/'	},
				{label:'local.2', 		server:'localhost2',			http:'http://127.0.0.1/daybyday2/'		, domain:'http://127.0.0.1/'	},
				{label:'server:99',     server:'localserver99',			http:'http://192.168.1.99/daybyday/'	, domain:'http://192.168.1.99/'	}
			]);

		static public const _PROGRAMS:ArrayCollection = new ArrayCollection
			([ 
				{NAME:'PROJECT', 		ID:1		, label:'appProject',nick:'project'},
				{NAME:'EDUC', 		    ID:8		, label:'appEduc',nick:'educ'},
				{NAME:'MONEY', 			ID:9		, label:'appMoney',nick:'money'},
				{NAME:'DOCUMENT', 		ID:13		, label:'appDocument',nick:'document'},
				{NAME:'STOCK', 			ID:14		, label:'appStock',nick:'stock'},
				{NAME:'PROCESS', 		ID:18		, label:'appProcess',nick:'process'},
				{NAME:'SAD', 		    ID:21		, label:'appSAD',nick:'sad'},
				//{NAME:'CLIENT', 		ID:2		},
				//{NAME:'DAY', 			ID:4		},
				//{NAME:'NOTE', 			ID:5		},
				//{NAME:'USER', 			ID:7		},
				//{NAME:'NEXTDAY', 		ID:10		},
				{NAME:'BIGBANG', 		ID:11		, label:'appBigBang',nick:'bigbang'}
				//{NAME:'DESKTOP', 		ID:12		},
				//{NAME:'DOWNLOAD', 		ID:15		},
				//{NAME:'SHARE', 			ID:16		},
				//{NAME:'EDUCTEACHER', 	ID:19		},
				//{NAME:'EDUCSTUDENT', 	ID:20		},
				//{NAME:'JOB', 			ID:21		},
				//{NAME:'PROCESSODONTO', 	ID:22		}
			]);
		
		static public const _SETTINGS:ArrayCollection = new ArrayCollection
			([
				{label: 'Banco de Dados para Teste (Teste)',    data: 'DATABASE_TRY'},
				
				{label: 'Upload limite (MB).', 					data: 'FILE_UPLOAD_MB'},
				{label: 'Mensagem do sistema.', 				data: 'SYSTEM_MESSAGE'},
				{label: 'Identificado do "cliente_curso".', 	data: 'ID_COURSE'},
				{label: 'Nota mínima para os cursos.', 			data: 'COURSE_GRADE_LIMIT'},
				{label: 'Hora local para o servidor. Em horas.',data: 'HOUR_LOCAL_TO_SERVER'}, //Diferença entre um para outro	
				{label: 'Id Cliente General.', 					data: 'ID_CLIENT_GENERAL'}, //Cadastro do cliente DATABASE = aco, ID_CLIENT_GENERAL = 1222(id cadastro)

				{label: 'PDF. Logotipo do cliente. 500x168px', 	data: 'DOCUMENT_LOGO'}, //null or blank or Class or Url or DisplayObject or ByteArray -> 500 x 168
				{label: 'PDF. Nome do cliente no documento.', 	data: 'DOCUMENT_COMPANY'},
				{label: 'PDF. Descrição do cliente ou Slogan.', data: 'DOCUMENT_DESCRIPTION'},
				{label: 'PDF. Recibo: CNPJ, endereço e CEP.', 	data: 'DOCUMENT_RECEIPT'},

				{label: 'Processo. Letra padrão do financeiro. A, B, C e D.', 					data: 'PROCESS_NUMBER_LETTER'},
				{label: 'Processo. Identificador do plano de contas.', 							data: 'PROCESS_ID_GROUP'},
				//{label: 'Processo. Comissão geral paga nas vendas e procedimentos. 30(30%)', 	data: 'PROCESS_COMMISSION_PERCENT'},
				//{label: 'Processo. Tipo de processo padrão. PROCESSO_DENTAL, _JOB', 			data: 'PROCESS_TYPE'},
				//{label: 'Processo. Inserir o usuário autom. no campo profissional. 0 ou 1=Sim', data: 'PROCESS_AUTO_USER_PROFISSIONAL'},
				//{label: 'Processo. Apenas Clientes com o Profissional Indicado. 0 ou 1=Sim', 	data: 'PROCESS_GET_ONLY_INDICATED_CLIENT'},
				
				{label: 'Grupo. Pacientes ', 								data: 'ID_GROUP_CLIENT_PATIENT'			},
				{label: 'Grupo. Colaboradores (funcionário) ', 				data: 'ID_GROUP_CLIENT_EMPLOYEE'		},
				{label: 'Grupo. Profissional (ex. Médico)', 				data: 'ID_GROUP_CLIENT_PROFESSIONAL'	},
				{label: 'Grupo. Professores / Coordenadores (curso)', 		data: 'ID_GROUP_CLIENT_THEATER'			},
				
				{label: 'Grupo. Serviços Odonto Diagnósticos (doenças)', 	data: 'ID_GROUP_PRODUCT_DIAGNOSTIC'		},
				{label: 'Grupo. Serviços Odonto Procedimentos (tratamento)',data: 'ID_GROUP_PRODUCT_TREATMENT'		}
				
			]);

		static public const _permissionSet:ArrayCollection = new ArrayCollection
			([
				{label: 'Contas Financeiro', data: 'FINANCIAL_ACCOUNT'}
			]);

		static public const _MODULES:ArrayCollection = new ArrayCollection
			([ 
			]);
		
		static public const _MIX:ArrayCollection = new ArrayCollection
			([ 
				{NAME:'Cliente', 					DATA:'CLIENT'			,table: new table_client()		},
				{NAME:'Projeto', 					DATA:'PROJECT'			,table: new table_project()		},
				{NAME:'Curso', 						DATA:'COURSE'			,table: new table_project()		},
				//{NAME:'Etapa', 						DATA:'STEP'				,table: new table_step()		},
				{NAME:'Disciplina', 				DATA:'DISCIPLINE'		,table: new table_step()		},
				//{NAME:'Comentário', 				DATA:'COMMENT'			,table: new table_comment()		},
				//{NAME:'Solicitação', 				DATA:'JOB'				,table: new table_job()			},
				//{NAME:'Arquivo', 					DATA:'ATTACH'			,table: new table_attach()		},
				{NAME:'Produto', 					DATA:'PRODUCT'			,table: new table_product()		},
				{NAME:'Contrato', 					DATA:'CONTRACT'			,table: new table_contract()	},
				{NAME:'Financeiro', 				DATA:'FINANCIAL'		,table: new table_financial()	},
				//{NAME:'Financeiro - Receita', 		DATA:'FINANCIAL_IN'		,table: new table_financial()	},
				//{NAME:'Financeiro - Despesa', 		DATA:'FINANCIAL_OUT'	,table: new table_financial()	},
				//{NAME:'Financeiro - Transferência', DATA:'FINANCIAL_TRANS'	,table: new table_financial()	},
				//{NAME:'Financeiro - Previsão', 		DATA:'FINANCIAL_FUTURE'	,table: new table_financial_future()			},
				//{NAME:'Financeiro - Nota', 			DATA:'FINANCIAL_NOTE'	,table: new table_financial()					},
				//{NAME:'Financeiro - Contas', 		DATA:'FINANCIAL_ACCOUNT',table: new table_financial_account()			},
				//{NAME:'Financeiro - Recibo Modelo', DATA:'FINANCIAL_RECEIPT_MODEL',table: new table_series()				},
				{NAME:'Departamento', 				DATA:'DEPARTAMENT'		,table: new table_departament()	},
				{NAME:'Grupo', 						DATA:'GROUP'			,table: new table_group()		}
				//{NAME:'Categoria', 					DATA:'CATEGORY'			,table: new table_category()	},
				//{NAME:'Usuário', 					DATA:'USER'				,table: new table_login()		},
				//{NAME:'Agendamento', 				DATA:'CALENDAR'			,table: new table_calendar()	},
				//{NAME:'Permissão', 					DATA:'PERMISSION'		,table: new table_permission()	},
				//{NAME:'Web', 						DATA:'WEB'				,table: null					},
				//{NAME:'Web - Menu', 				DATA:'WEB_MENU'			,table: new table_category()	},
				//{NAME:'Web - Link', 				DATA:'WEB_LINK'			,table: new table_step()		},
				//{NAME:'Web - Page', 				DATA:'WEB_PAGE'			,table: new table_job()			},
				//{NAME:'Web - Table', 				DATA:'WEB_TABLE'		,table: new table_job()			},
				//{NAME:'Process', 					DATA:'PROCESS'			,table: new table_pro()			},
				//	{NAME:'Formulário Modelo',			DATA:'FORM_MODEL'				,table: new table_form_model()			},
				//{NAME:'Process - Calendário',		DATA:'PROCESS_CALENDAR'			,table: new table_process_calendar()	},
				//{NAME:'Process - Formulário',		DATA:'PROCESS_FORM'				,table: new table_form_model()			},
				//{NAME:'Process Odonto - Calendário',DATA:'PROCESS_ODONTO_CALENDAR'	,table: new table_process_calendar()	},
				//{NAME:'Process Odonto - Formulário',DATA:'PROCESS_ODONTO_FORM'		,table: new table_form_model()			},
				//{NAME:'Process Odonto - Triagen',	DATA:'PROCESS_ODONTO_TRIAGE'	,table: new table_form_model()			}
			]);
		
		static public const _localSaveFiles:ArrayCollection = new ArrayCollection
			([
				{label: 'Desktop', 					labelEnglish: 'Desktop'						, data: 'DSK'},
				{label: 'Arquivos Temporários', 	labelEnglish: 'Temp Directory'				, data: 'TMP'},
				{label: 'Meus Documentos', 			labelEnglish: 'Document Directory'			, data: 'DOC'},
				{label: 'Meu Usuário', 				labelEnglish: 'User Directory'				, data: 'USE'},
				{label: 'Pasta do Aplicativo', 		labelEnglish: 'Application Directory'		, data: 'APP'},
				{label: 'Pasta de Armazenamento', 	labelEnglish: 'Application Storage'			, data: 'APS'}
			]);


		static public const courseActive:ArrayCollection = new ArrayCollection
			([
				{label: 'Em Processo', 		data: 0},
				{label: 'Pré-Inscrição', 	data: 1},
				{label: 'Em Andamento', 	data: 2},
				{label: 'Concluída', 		data: 3}
			]);

		static public const _TIMELINECOLOR:Array = new Array 
			(
				0xcc0202,0xcc0202,0xcd0702,0xcd0702,0xcf0e02,0xcf0e02,0xd21602,0xd21602,0xd41e02,0xd41e02,
				0xd72802,0xd72802,0xda3202,0xda3202,0xde3d02,0xde3d02,0xe14901,0xe14901,0xe45402,0xe45402,
				0xe86001,0xe86001,0xec6d01,0xec6d01,0xf07901,0xf07901,0xf38601,0xf38601,0xf79200,0xf79200,
				0xfa9f01,0xfa9f01,0xfcab00,0xfcab00,0xffb600,0xffb600,0xffc101,0xffc101,0xffcc00,0xffcc00,
				0xffd500,0xffd500,0xffdd00,0xffdd00,0xffe500,0xffe500,0xffec00,0xffec00,0xfff200,0xfff200,
				0xfff600,0xfff600,0xfcf600,0xfcf600,0xf7f600,0xf7f600,0xf2f600,0xf2f600,0xecf600,0xecf600,
				0xe5f600,0xe5f600,0xddf600,0xddf600,0xd5f600,0xd5f600,0xccf400,0xccf400,0xc2ef00,0xc2ef00,
				0xb9ec00,0xb9ec00,0xafe800,0xafe800,0xa4e300,0xa4e300,0x9ade00,0x9ade00,0x90d900,0x90d900,
				0x86d300,0x86d300,0x7cce00,0x7cce00,0x72c800,0x72c800,0x69c400,0x69c400,0x60bf00,0x60bf00,
				0x50b700,0x50b700,0x4fb700,0x4fb700,0x48b300,0x48b300,0x42af00,0x42af00,0x3dad00,0x3dad00,
				0x3dad00 //<--101
			);

		static public const _TIMELINECOLOR_COLLECTION:ArrayCollection = new ArrayCollection(_TIMELINECOLOR);
		
		static public function __TIMELINE_COLOR(NUMBER_0_100_:uint):uint
		{
			//FlexGlobals.topLevelApplication.parent.addElement();
			//new DAYBYDAY_ALERT()._ALERT(''+uint(_TIMELINECOLOR_COLLECTION.getItemAt(Math.round(NUMBER_0_100_/2))));
			return _TIMELINECOLOR[NUMBER_0_100_];
		}

		public static function __daysOfMonth(month_:uint=0):ArrayCollection
		{
			var obj:Object = new Object();
			var arr:ArrayCollection = new ArrayCollection();
			arr.addItem(obj);
			return arr;
		}

		static public const _days:ArrayCollection = new ArrayCollection
		([
			{label: '01', data: '01', value: 1},
			{label: '02', data: '02', value: 2},
			{label: '03', data: '03', value: 3},
			{label: '04', data: '04', value: 4},
			{label: '05', data: '05', value: 5},
			{label: '06', data: '06', value: 6},
			{label: '07', data: '07', value: 7},
			{label: '08', data: '08', value: 8},
			{label: '09', data: '09', value: 9},
			{label: '10', data: '10', value: 10},
			{label: '11', data: '11', value: 11},
			{label: '12', data: '12', value: 12},
			{label: '13', data: '13', value: 13},
			{label: '14', data: '14', value: 14},
			{label: '15', data: '15', value: 15},
			{label: '16', data: '16', value: 16},
			{label: '17', data: '17', value: 17},
			{label: '18', data: '18', value: 18},
			{label: '19', data: '19', value: 19},
			{label: '20', data: '20', value: 20},
			{label: '21', data: '21', value: 21},
			{label: '22', data: '22', value: 22},
			{label: '23', data: '23', value: 23},
			{label: '24', data: '24', value: 24},
			{label: '25', data: '25', value: 25},
			{label: '26', data: '26', value: 26},
			{label: '27', data: '27', value: 27},
			{label: '28', data: '28', value: 28},
			{label: '29', data: '29', value: 29},
			{label: '30', data: '30', value: 30},
			{label: '31', data: '31', value: 31}
		]);

		static public const _MONTH:ArrayCollection = new ArrayCollection
			([
				{label: 'Janeiro', 		days: 31,		NICK_NAME:'Jan', 	data: '01', value:1},
				{label: 'Fevereiro', 	days: 29,		NICK_NAME:'Fev', 	data: '02', value:2},
				{label: 'Março', 		days: 31,		NICK_NAME:'Mar', 	data: '03', value:3},
				{label: 'Abril', 		days: 30,		NICK_NAME:'Abr', 	data: '04', value:4},
				{label: 'Maio', 		days: 31,		NICK_NAME:'Mai', 	data: '05', value:5},
				{label: 'Junho', 		days: 30,		NICK_NAME:'Jun', 	data: '06', value:6},
				{label: 'Julho', 		days: 31,		NICK_NAME:'Jul', 	data: '07', value:7},
				{label: 'Agosto', 		days: 31,		NICK_NAME:'Ago', 	data: '08', value:8},
				{label: 'Setembro', 	days: 30,		NICK_NAME:'Set', 	data: '09', value:9},
				{label: 'Outubro', 		days: 31,		NICK_NAME:'Out', 	data: '10', value:10},
				{label: 'Novembro', 	days: 30,		NICK_NAME:'Nov', 	data: '11', value:11},
				{label: 'Dezembro', 	days: 31,		NICK_NAME:'Dez', 	data: '12', value:12}
			]);	
		
		static public const _WEEK:ArrayCollection = new ArrayCollection
			([
				{label: 'Domingo', 		NICK_NAME:'Dom', 	data: 0},
				{label: 'Segunda', 		NICK_NAME:'Seg', 	data: 1},
				{label: 'Terça', 		NICK_NAME:'Ter', 	data: 2},
				{label: 'Quarta', 		NICK_NAME:'Qua', 	data: 3},
				{label: 'Quinta', 		NICK_NAME:'Qui', 	data: 4},
				{label: 'Sexta', 		NICK_NAME:'Sex', 	data: 5},
				{label: 'Sábado', 		NICK_NAME:'Sab', 	data: 6}
			]);

		static public const _timeHour:ArrayCollection = new ArrayCollection
			([
				{label: '00', 			NICK_NAME:'', 	data: '00'},
				{label: '01', 			NICK_NAME:'', 	data: '01'},
				{label: '02', 			NICK_NAME:'', 	data: '02'},
				{label: '03', 			NICK_NAME:'', 	data: '03'},
				{label: '04', 			NICK_NAME:'', 	data: '04'},
				{label: '05', 			NICK_NAME:'', 	data: '05'},
				{label: '06', 			NICK_NAME:'', 	data: '06'},
				{label: '07', 			NICK_NAME:'', 	data: '07'},
				{label: '08', 			NICK_NAME:'', 	data: '08'},
				{label: '09', 			NICK_NAME:'', 	data: '09'},
				{label: '10', 			NICK_NAME:'', 	data: '10'},
				{label: '11', 			NICK_NAME:'', 	data: '11'},
				{label: '12', 			NICK_NAME:'', 	data: '12'},
				{label: '13', 			NICK_NAME:'', 	data: '13'},
				{label: '14', 			NICK_NAME:'', 	data: '14'},
				{label: '15', 			NICK_NAME:'', 	data: '15'},
				{label: '16', 			NICK_NAME:'', 	data: '16'},
				{label: '17', 			NICK_NAME:'', 	data: '17'},
				{label: '18', 			NICK_NAME:'', 	data: '18'},
				{label: '19', 			NICK_NAME:'', 	data: '19'},
				{label: '20', 			NICK_NAME:'', 	data: '20'},
				{label: '21', 			NICK_NAME:'', 	data: '21'},
				{label: '22', 			NICK_NAME:'', 	data: '22'},
				{label: '23', 			NICK_NAME:'', 	data: '23'}
			]);

		static public const _timeMinute:ArrayCollection = new ArrayCollection
			([
				{label: '00', 			NICK_NAME:'', 	data: '00'},
				{label: '05', 			NICK_NAME:'', 	data: '05'},
				{label: '10', 			NICK_NAME:'', 	data: '10'},
				{label: '15', 			NICK_NAME:'', 	data: '15'},
				{label: '20', 			NICK_NAME:'', 	data: '20'},
				{label: '25', 			NICK_NAME:'', 	data: '25'},
				{label: '30', 			NICK_NAME:'', 	data: '30'},
				{label: '35', 			NICK_NAME:'', 	data: '35'},
				{label: '40', 			NICK_NAME:'', 	data: '40'},
				{label: '45', 			NICK_NAME:'', 	data: '45'},
				{label: '50', 			NICK_NAME:'', 	data: '50'},
				{label: '55', 			NICK_NAME:'', 	data: '55'}
			]);

		static public const _PERIOD_TIME:ArrayCollection = new ArrayCollection
			([
				{label: 'Matutino (manhã)', 	data: 1, HOUR_START:'08:00:00', HOUR_END:'12:00:00'},
				{label: 'Vespertino (tarde)', 	data: 2, HOUR_START:'13:00:00', HOUR_END:'19:00:00'},
				{label: 'Noturno (noite)', 		data: 3, HOUR_START:'18:00:00', HOUR_END:'22:00:00'}
			]);
		
		static public const ACTIVE:ArrayCollection = new ArrayCollection
			([
				{label: '0 - CONTROLE', 	id: 0},
				{label: '1 - PROJETO', 		id: 1},
				{label: '2 - AGENDADO', 	id: 2}
			]);
		
		static public const _LEVEL:ArrayCollection = new ArrayCollection
			([
				{label: '0 - CONTROLE', 	id: 0},
				{label: '1 - PROJETO', 		id: 1},
				{label: '2 - AGENDADO', 	id: 2}
			]);
		
		static public const _ROWS:ArrayCollection = new ArrayCollection
			([
				{label: '10 valores', 	data: 10},
				{label: '20 valores', 	data: 20},
				{label: '30 valores', 	data: 30},
				{label: '40 valores', 	data: 40},
				{label: '50 valores', 	data: 50},
				{label: '100 valores', 	data: 100},
				{label: '200 valores', 	data: 200},
				{label: '300 valores', 	data: 300},
				{label: '400 valores', 	data: 400},
				{label: 'Tudo', 		data: 50000}
			]);

		static public const _CLIENT_STATUS:ArrayCollection = new ArrayCollection
			([
				{label: 'Inativo', 		data: 0,	value: 0},
				{label: 'Ativo', 		data: 1,	value: 1},
				{label: 'Em espera', 	data: 2,	value: 2},
				{label: 'Indefinido', 	data: 3,	value: 3}
			]);

		static public const _colors:ArrayCollection = new ArrayCollection
			([
				{bgColor:0xFFFFFF,		color:0xFFFFFF,		bgDark:false},
				{bgColor:0xffef01,		color:0xFFFFFF,		bgDark:false},
				{bgColor:0xea8d98,		color:0xFFFFFF,		bgDark:false},
				{bgColor:0x8b0d3d,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0xcf1321,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0xf8ad2e,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x6cb831,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x004517,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x0194da,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x004890,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x002647,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x632d81,		color:0xFFFFFF,		bgDark:true},
				{bgColor:0x1a1a1a,		color:0xFFFFFF,		bgDark:true}
			]);
		
		static public const _CHART_COLOR:ArrayCollection = new ArrayCollection
			([
				0xd9e7d5,0xc9d7e2,0xf2e7d5,0xebd7c8,
				0x95b9d2,0x95b9d2,0xe8d7d7,0xc4df9b,
				0x9fe6da,0xbacad9,0xf3b4f1,0xb8d5de,
				0xdfccd2,0xf2eeb8,0xe8eccb,0xe3d9e4,
				0xcadbe3,0xeedcd5,0xcdc5d5,0xf9ced5,
				0x9adaec,0xdad7b7,0xc9d7cb,0xf3b4f1
			]);
		

		static public const _chartColorV2:ArrayCollection = new ArrayCollection
			([
				0xaacca0,0x83a5c0,0xe7cca0,0xd6a580,
				0x145c99,0xe7dd59,0xcfa5a5,0x76b814,
				0x1bc9ad,0x5d85aa,0xea4ee5,0x59a0b6,
				0xb88999,0xe7dd59,0xcfd887,0xc3aac4,
				0x85aec3,0xddb1a0,0x8c78a0,0xf68fa0,
				0x14add8,0xada556,0x83a587,0xe050db,
				0xcadbe3,0xeedcd5,0xcdc5d5,0xf9ced5
			]);
		
		static public const _chartColorV3:ArrayCollection = new ArrayCollection
			([
				
				0x8b0d3d,
				0xcf1321,
				0xf8ad2e,
				0x6cb831,
				0x004517,
				0x0194da,
				0x004890,
				0x002647,
				0x632d81,
				0xffef01,
				0xea8d98,
				0xea8d98,
				
				0xff0000,
				0xff9900,
				0xffff00,
				0x33cc00,
				0x3366ff	
			]);
		
		static public const _COUNTRY:ArrayCollection = new ArrayCollection 
			([ 
				{ISO:'AD', NAME:'ANDORRA', 					NICK_NAME:'Andorra', 				ISO3:'AND', CODE:'20' },
				{ISO:'AE', NAME:'UNITED ARAB EMIRATES', 	NICK_NAME:'United Arab Emirates', 	ISO3:'ARE', CODE:'784'},
				{ISO:'AF', NAME:'AFGHANISTAN', 				NICK_NAME:'Afghanistan', 			ISO3:'AFG', CODE:'4'},
				{ISO:'AG', NAME:'ANTIGUA AND BARBUDA', 		NICK_NAME:'Antigua and Barbuda', 	ISO3:'ATG', CODE:'28'},
				{ISO:'AI', NAME:'ANGUILLA', 				NICK_NAME:'Anguilla', 				ISO3:'AIA', CODE:'660'},
				{ISO:'AL', NAME:'ALBANIA', 					NICK_NAME:'Albania', 				ISO3:'ALB', CODE:'8'},
				{ISO:'AM', NAME:'ARMENIA', 					NICK_NAME:'Armenia', 				ISO3:'ARM', CODE:'51'},
				{ISO:'AN', NAME:'NETHERLANDS ANTILLES',		NICK_NAME:'Netherlands Antilles', 	ISO3:'ANT', CODE:'530'},
				{ISO:'AO', NAME:'ANGOLA', 					NICK_NAME:'Angola', 				ISO3:'AGO', CODE:'24'},
				{ISO:'AQ', NAME:'ANTARCTICA', 				NICK_NAME:'Antarctica', 			ISO3:'NULL', CODE:'NULL'},
				{ISO:'AR', NAME:'ARGENTINA', 				NICK_NAME:'Argentina', 				ISO3:'ARG', CODE:'32'},
				{ISO:'AS', NAME:'AMERICAN SAMOA', 			NICK_NAME:'American Samoa', 		ISO3:'ASM', CODE:'16'},
				{ISO:'AT', NAME:'AUSTRIA', 					NICK_NAME:'Austria', 				ISO3:'AUT', CODE:'40'},
				{ISO:'AU', NAME:'AUSTRALIA', 				NICK_NAME:'Australia', 				ISO3:'AUS', CODE:'36'},
				{ISO:'AW', NAME:'ARUBA', 					NICK_NAME:'Aruba', 					ISO3:'ABW', CODE:'533'},
				{ISO:'AZ', NAME:'AZERBAIJAN', 				NICK_NAME:'Azerbaijan', 			ISO3:'AZE', CODE:'31'},
				{ISO:'BA', NAME:'BOSNIA AND HERZEGOVINA', 	NICK_NAME:'Bosnia and Herzegovina', ISO3:'BIH', CODE:'70'},
				{ISO:'BB', NAME:'BARBADOS', 				NICK_NAME:'Barbados', 				ISO3:'BRB', CODE:'52'},
				{ISO:'BD', NAME:'BANGLADESH', 				NICK_NAME:'Bangladesh', 			ISO3:'BGD', CODE:'50'},
				{ISO:'BE', NAME:'BELGIUM', 					NICK_NAME:'Belgium', 				ISO3:'BEL', CODE:'56'},
				{ISO:'BF', NAME:'BURKINA FASO', 			NICK_NAME:'Burkina Faso', 			ISO3:'BFA', CODE:'854'},
				{ISO:'BG', NAME:'BULGARIA', 				NICK_NAME:'Bulgaria', 				ISO3:'BGR', CODE:'100'},
				{ISO:'BH', NAME:'BAHRAIN', 					NICK_NAME:'Bahrain', 				ISO3:'BHR', CODE:'48'},
				{ISO:'BI', NAME:'BURUNDI', 					NICK_NAME:'Burundi', 				ISO3:'BDI', CODE:'108'},
				{ISO:'BJ', NAME:'BENIN', 					NICK_NAME:'Benin', 					ISO3:'BEN', CODE:'204'},
				{ISO:'BM', NAME:'BERMUDA', 					NICK_NAME:'Bermuda', ISO3:'BMU', CODE:'60'},
				{ISO:'BN', NAME:'BRUNEI DARUSSALAM', 		NICK_NAME:'Brunei Darussalam', ISO3:'BRN', CODE:'96'},
				{ISO:'BO', NAME:'BOLIVIA', 					NICK_NAME:'Bolivia', ISO3:'BOL', CODE:'68'},
				{ISO:'BR', NAME:'BRAZIL', 					NICK_NAME:'Brasil', ISO3:'BRA', CODE:'76'},
				{ISO:'BS', NAME:'BAHAMAS', 					NICK_NAME:'Bahamas', ISO3:'BHS', CODE:'44'},
				{ISO:'BT', NAME:'BHUTAN',					NICK_NAME:'Bhutan', ISO3:'BTN', CODE:'64'},
				{ISO:'BV', NAME:'BOUVET ISLAND',			NICK_NAME:'Bouvet Island', ISO3:'NULL', CODE:'NULL'},
				{ISO:'BW', NAME:'BOTSWANA', 				NICK_NAME:'Botswana', ISO3:'BWA', CODE:'72'},
				{ISO:'BY', NAME:'BELARUS', 					NICK_NAME:'Belarus', ISO3:'BLR', CODE:'112'},
				{ISO:'BZ', NAME:'BELIZE', 					NICK_NAME:'Belize', ISO3:'BLZ', CODE:'84'},
				{ISO:'CA', NAME:'CANADA', 					NICK_NAME:'Canada', ISO3:'CAN', CODE:'124'},
				{ISO:'CC', NAME:'COCOS (KEELING) ISLANDS', 	NICK_NAME:'Cocos (Keeling) Islands', ISO3:'NULL', CODE:'NULL'},
				{ISO:'CD', NAME:'CONGO, THE DEMOCRATIC REPUBLIC OF THE', NICK_NAME:'Congo, the Democratic Republic of the', ISO3:'COD', CODE:'180'},
				{ISO:'CF', NAME:'CENTRAL AFRICAN REPUBLIC', NICK_NAME:'Central African Republic', ISO3:'CAF', CODE:'140'},
				{ISO:'CG', NAME:'CONGO', 					NICK_NAME:'Congo', ISO3:'COG', CODE:'178'},
				{ISO:'CH', NAME:'SWITZERLAND', 				NICK_NAME:'Switzerland', ISO3:'CHE', CODE:'756'},
				{ISO:'CI', NAME:'COTE D\'IVOIRE', 			NICK_NAME:'Cote D\'Ivoire', ISO3:'CIV', CODE:'384'},
				{ISO:'CK', NAME:'COOK ISLANDS', 			NICK_NAME:'Cook Islands', ISO3:'COK', CODE:'184'},
				{ISO:'CL', NAME:'CHILE', 					NICK_NAME:'Chile', ISO3:'CHL', CODE:'152'},
				{ISO:'CM', NAME:'CAMEROON', 				NICK_NAME:'Cameroon', ISO3:'CMR', CODE:'120'},
				{ISO:'CN', NAME:'CHINA', 					NICK_NAME:'China', ISO3:'CHN', CODE:'156'},
				{ISO:'CO', NAME:'COLOMBIA', 				NICK_NAME:'Colombia', ISO3:'COL', CODE:'170'},
				{ISO:'CR', NAME:'COSTA RICA', 				NICK_NAME:'Costa Rica', ISO3:'CRI', CODE:'188'},
				{ISO:'CS', NAME:'SERBIA AND MONTENEGRO', 	NICK_NAME:'Serbia and Montenegro', ISO3:'NULL', CODE:'NULL'},
				{ISO:'CU', NAME:'CUBA', 					NICK_NAME:'Cuba', ISO3:'CUB', CODE:'192'},
				{ISO:'CV', NAME:'CAPE VERDE', 				NICK_NAME:'Cape Verde', ISO3:'CPV', CODE:'132'},
				{ISO:'CX', NAME:'CHRISTMAS ISLAND', 		NICK_NAME:'Christmas Island', ISO3:'NULL', CODE:'NULL'},
				{ISO:'CY', NAME:'CYPRUS', 					NICK_NAME:'Cyprus', ISO3:'CYP', CODE:'196'},
				{ISO:'CZ', NAME:'CZECH REPUBLIC', 			NICK_NAME:'Czech Republic', ISO3:'CZE', CODE:'203'},
				{ISO:'DE', NAME:'GERMANY', 					NICK_NAME:'Germany', ISO3:'DEU', CODE:'276'},
				{ISO:'DJ', NAME:'DJIBOUTI', 				NICK_NAME:'Djibouti', ISO3:'DJI', CODE:'262'},
				{ISO:'DK', NAME:'DENMARK', 					NICK_NAME:'Denmark', ISO3:'DNK', CODE:'208'},
				{ISO:'DM', NAME:'DOMINICA', 				NICK_NAME:'Dominica', ISO3:'DMA', CODE:'212'},
				{ISO:'DO', NAME:'DOMINICAN REPUBLIC',		NICK_NAME:'Dominican Republic', ISO3:'DOM', CODE:'214'},
				{ISO:'DZ', NAME:'ALGERIA', 					NICK_NAME:'Algeria', ISO3:'DZA', CODE:'12'},
				{ISO:'EC', NAME:'ECUADOR', 					NICK_NAME:'Ecuador', ISO3:'ECU', CODE:'218'},
				{ISO:'EE', NAME:'ESTONIA', 					NICK_NAME:'Estonia', ISO3:'EST', CODE:'233'},
				{ISO:'EG', NAME:'EGYPT', 					NICK_NAME:'Egypt', ISO3:'EGY', CODE:'818'},
				{ISO:'EH', NAME:'WESTERN SAHARA', 			NICK_NAME:'Western Sahara', ISO3:'ESH', CODE:'732'},
				{ISO:'ER', NAME:'ERITREA', 					NICK_NAME:'Eritrea', ISO3:'ERI', CODE:'232'},
				{ISO:'ES', NAME:'SPAIN', 					NICK_NAME:'Spain', ISO3:'ESP', CODE:'724'},
				{ISO:'ET', NAME:'ETHIOPIA', 				NICK_NAME:'Ethiopia', ISO3:'ETH', CODE:'231'},
				{ISO:'FI', NAME:'FINLAND', 					NICK_NAME:'Finland', ISO3:'FIN', CODE:'246'},
				{ISO:'FJ', NAME:'FIJI', 					NICK_NAME:'Fiji', ISO3:'FJI', CODE:'242'},
				{ISO:'FK', NAME:'FALKLAND ISLANDS (MALVINAS)', NICK_NAME:'Falkland Islands (Malvinas)', ISO3:'FLK', CODE:'238'},
				{ISO:'FM', NAME:'MICRONESIA, FEDERATED STATES OF', NICK_NAME:'Micronesia, Federated States of', ISO3:'FSM', CODE:'583'},
				{ISO:'FO', NAME:'FAROE ISLANDS', 			NICK_NAME:'Faroe Islands', ISO3:'FRO', CODE:'234'},
				{ISO:'FR', NAME:'FRANCE',					NICK_NAME:'France', ISO3:'FRA', CODE:'250'},
				{ISO:'GA', NAME:'GABON', 					NICK_NAME:'Gabon', ISO3:'GAB', CODE:'266'},
				{ISO:'GB', NAME:'UNITED KINGDOM', 			NICK_NAME:'United Kingdom', ISO3:'GBR', CODE:'826'},
				{ISO:'GD', NAME:'GRENADA', 					NICK_NAME:'Grenada', ISO3:'GRD', CODE:'308'},
				{ISO:'GE', NAME:'GEORGIA', 					NICK_NAME:'Georgia', ISO3:'GEO', CODE:'268'},
				{ISO:'GF', NAME:'FRENCH GUIANA', NICK_NAME:'French Guiana', ISO3:'GUF', CODE:'254'},
				{ISO:'GH', NAME:'GHANA', NICK_NAME:'Ghana', ISO3:'GHA', CODE:'288'},
				{ISO:'GI', NAME:'GIBRALTAR', NICK_NAME:'Gibraltar', ISO3:'GIB', CODE:'292'},
				{ISO:'GL', NAME:'GREENLAND', NICK_NAME:'Greenland', ISO3:'GRL', CODE:'304'},
				{ISO:'GM', NAME:'GAMBIA', NICK_NAME:'Gambia', ISO3:'GMB', CODE:'270'},
				{ISO:'GN', NAME:'GUINEA', NICK_NAME:'Guinea', ISO3:'GIN', CODE:'324'},
				{ISO:'GP', NAME:'GUADELOUPE', NICK_NAME:'Guadeloupe', ISO3:'GLP', CODE:'312'},
				{ISO:'GQ', NAME:'EQUATORIAL GUINEA', NICK_NAME:'Equatorial Guinea', ISO3:'GNQ', CODE:'226'},
				{ISO:'GR', NAME:'GREECE', NICK_NAME:'Greece', ISO3:'GRC', CODE:'300'},
				{ISO:'GS', NAME:'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', NICK_NAME:'South Georgia and the South Sandwich Islands', ISO3:'NULL', CODE:'NULL'},
				{ISO:'GT', NAME:'GUATEMALA', NICK_NAME:'Guatemala', ISO3:'GTM', CODE:'320'},
				{ISO:'GU', NAME:'GUAM', NICK_NAME:'Guam', ISO3:'GUM', CODE:'316'},
				{ISO:'GW', NAME:'GUINEA-BISSAU', NICK_NAME:'Guinea-Bissau', ISO3:'GNB', CODE:'624'},
				{ISO:'GY', NAME:'GUYANA', NICK_NAME:'Guyana', ISO3:'GUY', CODE:'328'},
				{ISO:'HK', NAME:'HONG KONG', NICK_NAME:'Hong Kong', ISO3:'HKG', CODE:'344'},
				{ISO:'HM', NAME:'HEARD ISLAND AND MCDONALD ISLANDS', NICK_NAME:'Heard Island and Mcdonald Islands', ISO3:'NULL', CODE:'NULL'},
				{ISO:'HN', NAME:'HONDURAS', NICK_NAME:'Honduras', ISO3:'HND', CODE:'340'},
				{ISO:'HR', NAME:'CROATIA', NICK_NAME:'Croatia', ISO3:'HRV', CODE:'191'},
				{ISO:'HT', NAME:'HAITI', NICK_NAME:'Haiti', ISO3:'HTI', CODE:'332'},
				{ISO:'HU', NAME:'HUNGARY', NICK_NAME:'Hungary', ISO3:'HUN', CODE:'348'},
				{ISO:'ID', NAME:'INDONESIA', NICK_NAME:'Indonesia', ISO3:'IDN', CODE:'360'},
				{ISO:'IE', NAME:'IRELAND', NICK_NAME:'Ireland', ISO3:'IRL', CODE:'372'},
				{ISO:'IL', NAME:'ISRAEL', NICK_NAME:'Israel', ISO3:'ISR', CODE:'376'},
				{ISO:'IN', NAME:'INDIA', NICK_NAME:'India', ISO3:'IND', CODE:'356'},
				{ISO:'IO', NAME:'BRITISH INDIAN OCEAN TERRITORY', NICK_NAME:'British Indian Ocean Territory', ISO3:'NULL', CODE:'NULL'},
				{ISO:'IQ', NAME:'IRAQ', NICK_NAME:'Iraq', ISO3:'IRQ', CODE:'368'},
				{ISO:'IR', NAME:'IRAN, ISLAMIC REPUBLIC OF', NICK_NAME:'Iran, Islamic Republic of', ISO3:'IRN', CODE:'364'},
				{ISO:'IS', NAME:'ICELAND', NICK_NAME:'Iceland', ISO3:'ISL', CODE:'352'},
				{ISO:'IT', NAME:'ITALY', NICK_NAME:'Italy', ISO3:'ITA', CODE:'380'},
				{ISO:'JM', NAME:'JAMAICA', NICK_NAME:'Jamaica', ISO3:'JAM', CODE:'388'},
				{ISO:'JO', NAME:'JORDAN', NICK_NAME:'Jordan', ISO3:'JOR', CODE:'400'},
				{ISO:'JP', NAME:'JAPAN', NICK_NAME:'Japan', ISO3:'JPN', CODE:'392'},
				{ISO:'KE', NAME:'KENYA', NICK_NAME:'Kenya', ISO3:'KEN', CODE:'404'},
				{ISO:'KG', NAME:'KYRGYZSTAN', NICK_NAME:'Kyrgyzstan', ISO3:'KGZ', CODE:'417'},
				{ISO:'KH', NAME:'CAMBODIA', NICK_NAME:'Cambodia', ISO3:'KHM', CODE:'116'},
				{ISO:'KI', NAME:'KIRIBATI', NICK_NAME:'Kiribati', ISO3:'KIR', CODE:'296'},
				{ISO:'KM', NAME:'COMOROS', NICK_NAME:'Comoros', ISO3:'COM', CODE:'174'},
				{ISO:'KN', NAME:'SAINT KITTS AND NEVIS', NICK_NAME:'Saint Kitts and Nevis', ISO3:'KNA', CODE:'659'},
				{ISO:'KP', NAME:'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', NICK_NAME:'Korea, Democratic People\'s Republic of', ISO3:'PRK', CODE:'408'},
				{ISO:'KR', NAME:'KOREA, REPUBLIC OF', NICK_NAME:'Korea, Republic of', ISO3:'KOR', CODE:'410'},
				{ISO:'KW', NAME:'KUWAIT', NICK_NAME:'Kuwait', ISO3:'KWT', CODE:'414'},
				{ISO:'KY', NAME:'CAYMAN ISLANDS', NICK_NAME:'Cayman Islands', ISO3:'CYM', CODE:'136'},
				{ISO:'KZ', NAME:'KAZAKHSTAN', NICK_NAME:'Kazakhstan', ISO3:'KAZ', CODE:'398'},
				{ISO:'LA', NAME:'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', NICK_NAME:'Lao People\'s Democratic Republic', ISO3:'LAO', CODE:'418'},
				{ISO:'LB', NAME:'LEBANON', NICK_NAME:'Lebanon', ISO3:'LBN', CODE:'422'},
				{ISO:'LC', NAME:'SAINT LUCIA', NICK_NAME:'Saint Lucia', ISO3:'LCA', CODE:'662'},
				{ISO:'LI', NAME:'LIECHTENSTEIN', NICK_NAME:'Liechtenstein', ISO3:'LIE', CODE:'438'},
				{ISO:'LK', NAME:'SRI LANKA', NICK_NAME:'Sri Lanka', ISO3:'LKA', CODE:'144'},
				{ISO:'LR', NAME:'LIBERIA', NICK_NAME:'Liberia', ISO3:'LBR', CODE:'430'},
				{ISO:'LS', NAME:'LESOTHO', NICK_NAME:'Lesotho', ISO3:'LSO', CODE:'426'},
				{ISO:'LT', NAME:'LITHUANIA', NICK_NAME:'Lithuania', ISO3:'LTU', CODE:'440'},
				{ISO:'LU', NAME:'LUXEMBOURG', NICK_NAME:'Luxembourg', ISO3:'LUX', CODE:'442'},
				{ISO:'LV', NAME:'LATVIA', NICK_NAME:'Latvia', ISO3:'LVA', CODE:'428'},
				{ISO:'LY', NAME:'LIBYAN ARAB JAMAHIRIYA', NICK_NAME:'Libyan Arab Jamahiriya', ISO3:'LBY', CODE:'434'},
				{ISO:'MA', NAME:'MOROCCO', NICK_NAME:'Morocco', ISO3:'MAR', CODE:'504'},
				{ISO:'MC', NAME:'MONACO', NICK_NAME:'Monaco', ISO3:'MCO', CODE:'492'},
				{ISO:'MD', NAME:'MOLDOVA, REPUBLIC OF', NICK_NAME:'Moldova, Republic of', ISO3:'MDA', CODE:'498'},
				{ISO:'MG', NAME:'MADAGASCAR', NICK_NAME:'Madagascar', ISO3:'MDG', CODE:'450'},
				{ISO:'MH', NAME:'MARSHALL ISLANDS', NICK_NAME:'Marshall Islands', ISO3:'MHL', CODE:'584'},
				{ISO:'MK', NAME:'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', NICK_NAME:'Macedonia, the Former Yugoslav Republic of', ISO3:'MKD', CODE:'807'},
				{ISO:'ML', NAME:'MALI', NICK_NAME:'Mali', ISO3:'MLI', CODE:'466'},
				{ISO:'MM', NAME:'MYANMAR', NICK_NAME:'Myanmar', ISO3:'MMR', CODE:'104'},
				{ISO:'MN', NAME:'MONGOLIA', NICK_NAME:'Mongolia', ISO3:'MNG', CODE:'496'},
				{ISO:'MO', NAME:'MACAO', NICK_NAME:'Macao', ISO3:'MAC', CODE:'446'},
				{ISO:'MP', NAME:'NORTHERN MARIANA ISLANDS', NICK_NAME:'Northern Mariana Islands', ISO3:'MNP', CODE:'580'},
				{ISO:'MQ', NAME:'MARTINIQUE', NICK_NAME:'Martinique', ISO3:'MTQ', CODE:'474'},
				{ISO:'MR', NAME:'MAURITANIA', NICK_NAME:'Mauritania', ISO3:'MRT', CODE:'478'},
				{ISO:'MS', NAME:'MONTSERRAT', NICK_NAME:'Montserrat', ISO3:'MSR', CODE:'500'},
				{ISO:'MT', NAME:'MALTA', NICK_NAME:'Malta', ISO3:'MLT', CODE:'470'},
				{ISO:'MU', NAME:'MAURITIUS', NICK_NAME:'Mauritius', ISO3:'MUS', CODE:'480'},
				{ISO:'MV', NAME:'MALDIVES', NICK_NAME:'Maldives', ISO3:'MDV', CODE:'462'},
				{ISO:'MW', NAME:'MALAWI', NICK_NAME:'Malawi', ISO3:'MWI', CODE:'454'},
				{ISO:'MX', NAME:'MEXICO', NICK_NAME:'Mexico', ISO3:'MEX', CODE:'484'},
				{ISO:'MY', NAME:'MALAYSIA', NICK_NAME:'Malaysia', ISO3:'MYS', CODE:'458'},
				{ISO:'MZ', NAME:'MOZAMBIQUE', NICK_NAME:'Mozambique', ISO3:'MOZ', CODE:'508'},
				{ISO:'NA', NAME:'NAMIBIA', NICK_NAME:'Namibia', ISO3:'NAM', CODE:'516'},
				{ISO:'NC', NAME:'NEW CALEDONIA', NICK_NAME:'New Caledonia', ISO3:'NCL', CODE:'540'},
				{ISO:'NE', NAME:'NIGER', NICK_NAME:'Niger', ISO3:'NER', CODE:'562'},
				{ISO:'NF', NAME:'NORFOLK ISLAND', NICK_NAME:'Norfolk Island', ISO3:'NFK', CODE:'574'},
				{ISO:'NG', NAME:'NIGERIA', NICK_NAME:'Nigeria', ISO3:'NGA', CODE:'566'},
				{ISO:'NI', NAME:'NICARAGUA', NICK_NAME:'Nicaragua', ISO3:'NIC', CODE:'558'},
				{ISO:'NL', NAME:'NETHERLANDS', NICK_NAME:'Netherlands', ISO3:'NLD', CODE:'528'},
				{ISO:'NO', NAME:'NORWAY', NICK_NAME:'Norway', ISO3:'NOR', CODE:'578'},
				{ISO:'NP', NAME:'NEPAL', NICK_NAME:'Nepal', ISO3:'NPL', CODE:'524'},
				{ISO:'NR', NAME:'NAURU', NICK_NAME:'Nauru', ISO3:'NRU', CODE:'520'},
				{ISO:'NU', NAME:'NIUE', NICK_NAME:'Niue', ISO3:'NIU', CODE:'570'},
				{ISO:'NZ', NAME:'NEW ZEALAND', NICK_NAME:'New Zealand', ISO3:'NZL', CODE:'554'},
				{ISO:'OM', NAME:'OMAN', NICK_NAME:'Oman', ISO3:'OMN', CODE:'512'},
				{ISO:'PA', NAME:'PANAMA', NICK_NAME:'Panama', ISO3:'PAN', CODE:'591'},
				{ISO:'PE', NAME:'PERU', NICK_NAME:'Peru', ISO3:'PER', CODE:'604'},
				{ISO:'PF', NAME:'FRENCH POLYNESIA', NICK_NAME:'French Polynesia', ISO3:'PYF', CODE:'258'},
				{ISO:'PG', NAME:'PAPUA NEW GUINEA', NICK_NAME:'Papua New Guinea', ISO3:'PNG', CODE:'598'},
				{ISO:'PH', NAME:'PHILIPPINES', NICK_NAME:'Philippines', ISO3:'PHL', CODE:'608'},
				{ISO:'PK', NAME:'PAKISTAN', NICK_NAME:'Pakistan', ISO3:'PAK', CODE:'586'},
				{ISO:'PL', NAME:'POLAND', NICK_NAME:'Poland', ISO3:'POL', CODE:'616'},
				{ISO:'PM', NAME:'SAINT PIERRE AND MIQUELON', NICK_NAME:'Saint Pierre and Miquelon', ISO3:'SPM', CODE:'666'},
				{ISO:'PN', NAME:'PITCAIRN', NICK_NAME:'Pitcairn', ISO3:'PCN', CODE:'612'},
				{ISO:'PR', NAME:'PUERTO RICO', NICK_NAME:'Puerto Rico', ISO3:'PRI', CODE:'630'},
				{ISO:'PS', NAME:'PALESTINIAN TERRITORY, OCCUPIED', NICK_NAME:'Palestinian Territory, Occupied', ISO3:'NULL', CODE:'NULL'},
				{ISO:'PT', NAME:'PORTUGAL', NICK_NAME:'Portugal', ISO3:'PRT', CODE:'620'},
				{ISO:'PW', NAME:'PALAU', NICK_NAME:'Palau', ISO3:'PLW', CODE:'585'},
				{ISO:'PY', NAME:'PARAGUAY', NICK_NAME:'Paraguay', ISO3:'PRY', CODE:'600'},
				{ISO:'QA', NAME:'QATAR', NICK_NAME:'Qatar', ISO3:'QAT', CODE:'634'},
				{ISO:'RE', NAME:'REUNION', NICK_NAME:'Reunion', ISO3:'REU', CODE:'638'},
				{ISO:'RO', NAME:'ROMANIA', NICK_NAME:'Romania', ISO3:'ROM', CODE:'642'},
				{ISO:'RU', NAME:'RUSSIAN FEDERATION', NICK_NAME:'Russian Federation', ISO3:'RUS', CODE:'643'},
				{ISO:'RW', NAME:'RWANDA', NICK_NAME:'Rwanda', ISO3:'RWA', CODE:'646'},
				{ISO:'SA', NAME:'SAUDI ARABIA', NICK_NAME:'Saudi Arabia', ISO3:'SAU', CODE:'682'},
				{ISO:'SB', NAME:'SOLOMON ISLANDS', NICK_NAME:'Solomon Islands', ISO3:'SLB', CODE:'90'},
				{ISO:'SC', NAME:'SEYCHELLES', NICK_NAME:'Seychelles', ISO3:'SYC', CODE:'690'},
				{ISO:'SD', NAME:'SUDAN', NICK_NAME:'Sudan', ISO3:'SDN', CODE:'736'},
				{ISO:'SE', NAME:'SWEDEN', NICK_NAME:'Sweden', ISO3:'SWE', CODE:'752'},
				{ISO:'SG', NAME:'SINGAPORE', NICK_NAME:'Singapore', ISO3:'SGP', CODE:'702'},
				{ISO:'SH', NAME:'SAINT HELENA', NICK_NAME:'Saint Helena', ISO3:'SHN', CODE:'654'},
				{ISO:'SI', NAME:'SLOVENIA', NICK_NAME:'Slovenia', ISO3:'SVN', CODE:'705'},
				{ISO:'SJ', NAME:'SVALBARD AND JAN MAYEN', NICK_NAME:'Svalbard and Jan Mayen', ISO3:'SJM', CODE:'744'},
				{ISO:'SK', NAME:'SLOVAKIA', NICK_NAME:'Slovakia', ISO3:'SVK', CODE:'703'},
				{ISO:'SL', NAME:'SIERRA LEONE', NICK_NAME:'Sierra Leone', ISO3:'SLE', CODE:'694'},
				{ISO:'SM', NAME:'SAN MARINO', NICK_NAME:'San Marino', ISO3:'SMR', CODE:'674'},
				{ISO:'SN', NAME:'SENEGAL', NICK_NAME:'Senegal', ISO3:'SEN', CODE:'686'},
				{ISO:'SO', NAME:'SOMALIA', NICK_NAME:'Somalia', ISO3:'SOM', CODE:'706'},
				{ISO:'SR', NAME:'SURINAME', NICK_NAME:'Suriname', ISO3:'SUR', CODE:'740'},
				{ISO:'ST', NAME:'SAO TOME AND PRINCIPE', NICK_NAME:'Sao Tome and Principe', ISO3:'STP', CODE:'678'},
				{ISO:'SV', NAME:'EL SALVADOR', NICK_NAME:'El Salvador', ISO3:'SLV', CODE:'222'},
				{ISO:'SY', NAME:'SYRIAN ARAB REPUBLIC', NICK_NAME:'Syrian Arab Republic', ISO3:'SYR', CODE:'760'},
				{ISO:'SZ', NAME:'SWAZILAND', NICK_NAME:'Swaziland', ISO3:'SWZ', CODE:'748'},
				{ISO:'TC', NAME:'TURKS AND CAICOS ISLANDS', NICK_NAME:'Turks and Caicos Islands', ISO3:'TCA', CODE:'796'},
				{ISO:'TD', NAME:'CHAD', NICK_NAME:'Chad', ISO3:'TCD', CODE:'148'},
				{ISO:'TF', NAME:'FRENCH SOUTHERN TERRITORIES', NICK_NAME:'French Southern Territories', ISO3:'NULL', CODE:'NULL'},
				{ISO:'TG', NAME:'TOGO', NICK_NAME:'Togo', ISO3:'TGO', CODE:'768'},
				{ISO:'TH', NAME:'THAILAND', NICK_NAME:'Thailand', ISO3:'THA', CODE:'764'},
				{ISO:'TJ', NAME:'TAJIKISTAN', NICK_NAME:'Tajikistan', ISO3:'TJK', CODE:'762'},
				{ISO:'TK', NAME:'TOKELAU', NICK_NAME:'Tokelau', ISO3:'TKL', CODE:'772'},
				{ISO:'TL', NAME:'TIMOR-LESTE', NICK_NAME:'Timor-Leste', ISO3:'NULL', CODE:'NULL'},
				{ISO:'TM', NAME:'TURKMENISTAN', NICK_NAME:'Turkmenistan', ISO3:'TKM', CODE:'795'},
				{ISO:'TN', NAME:'TUNISIA', NICK_NAME:'Tunisia', ISO3:'TUN', CODE:'788'},
				{ISO:'TO', NAME:'TONGA', NICK_NAME:'Tonga', ISO3:'TON', CODE:'776'},
				{ISO:'TR', NAME:'TURKEY', NICK_NAME:'Turkey', ISO3:'TUR', CODE:'792'},
				{ISO:'TT', NAME:'TRINIDAD AND TOBAGO', NICK_NAME:'Trinidad and Tobago', ISO3:'TTO', CODE:'780'},
				{ISO:'TV', NAME:'TUVALU', NICK_NAME:'Tuvalu', ISO3:'TUV', CODE:'798'},
				{ISO:'TW', NAME:'TAIWAN, PROVINCE OF CHINA', NICK_NAME:'Taiwan, Province of China', ISO3:'TWN', CODE:'158'},
				{ISO:'TZ', NAME:'TANZANIA, UNITED REPUBLIC OF', NICK_NAME:'Tanzania, United Republic of', ISO3:'TZA', CODE:'834'},
				{ISO:'UA', NAME:'UKRAINE', NICK_NAME:'Ukraine', ISO3:'UKR', CODE:'804'},
				{ISO:'UG', NAME:'UGANDA', NICK_NAME:'Uganda', ISO3:'UGA', CODE:'800'},
				{ISO:'UM', NAME:'UNITED STATES MINOR OUTLYING ISLANDS', NICK_NAME:'United States Minor Outlying Islands', ISO3:'NULL', CODE:'NULL'},
				{ISO:'US', NAME:'UNITED STATES', NICK_NAME:'United States', ISO3:'USA', CODE:'840'},
				{ISO:'UY', NAME:'URUGUAY', NICK_NAME:'Uruguay', ISO3:'URY', CODE:'858'},
				{ISO:'UZ', NAME:'UZBEKISTAN', NICK_NAME:'Uzbekistan', ISO3:'UZB', CODE:'860'},
				{ISO:'VA', NAME:'HOLY SEE (VATICAN CITY STATE)', NICK_NAME:'Holy See (Vatican City State)', ISO3:'VAT', CODE:'336'},
				{ISO:'VC', NAME:'SAINT VINCENT AND THE GRENADINES', NICK_NAME:'Saint Vincent and the Grenadines', ISO3:'VCT', CODE:'670'},
				{ISO:'VE', NAME:'VENEZUELA', NICK_NAME:'Venezuela', ISO3:'VEN', CODE:'862'},
				{ISO:'VG', NAME:'VIRGIN ISLANDS, BRITISH', NICK_NAME:'Virgin Islands, British', ISO3:'VGB', CODE:'92'},
				{ISO:'VI', NAME:'VIRGIN ISLANDS, U.S.', NICK_NAME:'Virgin Islands, U.s.', ISO3:'VIR', CODE:'850'},
				{ISO:'VN', NAME:'VIET NAM', NICK_NAME:'Viet Nam', ISO3:'VNM', CODE:'704'},
				{ISO:'VU', NAME:'VANUATU', NICK_NAME:'Vanuatu', ISO3:'VUT', CODE:'548'},
				{ISO:'WF', NAME:'WALLIS AND FUTUNA', NICK_NAME:'Wallis and Futuna', ISO3:'WLF', CODE:'876'},
				{ISO:'WS', NAME:'SAMOA', NICK_NAME:'Samoa', ISO3:'WSM', CODE:'882'},
				{ISO:'YE', NAME:'YEMEN', NICK_NAME:'Yemen', ISO3:'YEM', CODE:'887'},
				{ISO:'YT', NAME:'MAYOTTE', NICK_NAME:'Mayotte', ISO3:'NULL', CODE:'NULL'},
				{ISO:'ZA', NAME:'SOUTH AFRICA', NICK_NAME:'South Africa', ISO3:'ZAF', CODE:'710'},
				{ISO:'ZM', NAME:'ZAMBIA', NICK_NAME:'Zambia', ISO3:'ZMB', CODE:'894'},
				{ISO:'ZW', NAME:'ZIMBABWE', NICK_NAME:'Zimbabwe', ISO3:'ZWE', CODE:'716'} 
		]); 
		
		static public const _ACADEMIC_DEGREE:ArrayCollection = new ArrayCollection
			([
				{label: 'Nenhum', 			NICK_NAME: 'NU',	data: 'NU'},
				{label: 'Graduado', 		NICK_NAME: 'GR',	data: 'GR'},
				{label: 'Especialista', 	NICK_NAME: 'ES',	data: 'ES'},
				{label: 'Mestre', 			NICK_NAME: 'ME',	data: 'ME'},
				{label: 'Doutor', 			NICK_NAME: 'DR',	data: 'DR'}
			]);

		static public const _FINANCIAL_ACCOUNT_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'Cartão de Crédito', 	data: 'CCREDT'},
				{label: 'Cobrança Bancária', 	data: 'COBBAN'},
				{label: 'Conta-Corrente', 		data: 'CCORRE'},
				{label: 'Dinheiro', 			data: 'DINHEI'},
				{label: 'Poupança', 			data: 'CPOUPA'},
				{label: 'Cofre', 				data: 'CCOFRE'},
				{label: 'Caixa Financeiro', 	data: 'CCAIXA'}
			]);

		static public const _financialIconsGroupsSafe:ArrayCollection = new ArrayCollection
			([
				{label: 'Energia & Luz',         group: 'general',   data: 'G1' , image: ''},
				{label: 'Água & Esgoto',         group: 'general',   data: 'G2' , image: ''},
				{label: 'Carro & Automóvel',     group: 'general',   data: 'G3' , image: ''},
				{label: 'Impostos',              group: 'general',   data: 'G4' , image: ''},
				{label: 'Imóvel',                group: 'general',   data: 'G5' , image: ''},
				{label: 'Aluguel',               group: 'general',   data: 'G6' , image: ''},
				{label: 'Investimento',          group: 'general',   data: 'G7' , image: ''},
				{label: 'Material de Limpeza',   group: 'general',   data: 'G8' , image: ''},
				{label: 'Reformas',              group: 'general',   data: 'G9' , image: ''},

				{label: 'Fornecedores',          group: 'company', data: 'C1' , image: ''},
				{label: 'Prestação de Serviço',  group: 'company', data: 'C2' , image: ''},
				{label: 'Escritório',            group: 'company', data: 'C3' , image: ''},
				{label: 'Colaboradores Empresa', group: 'company', data: 'C4' , image: ''},
				{label: 'Comissão',              group: 'company', data: 'C5' , image: ''},
				{label: '',  group: 'company', data: 'C6' , image: ''},

				{label: 'Presentes & Compras',   group: 'personal', data: 'P1' , image: ''},
				{label: 'Eletrônico & Eletrodoméstico', group: 'personal', data: 'P2' , image: ''},
				{label: 'Decoração',             group: 'personal', data: 'P3' , image: ''},
				{label: 'Educação',              group: 'personal', data: 'P4' , image: ''},
				{label: 'Alimentação',           group: 'personal', data: 'P5' , image: ''}
			]);
		
		static public const _FINANCIAL_PAY_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'Dinheiro', 			data: 'DINHEI', nick:'Dinheiro',  typeIn:'1', typeOut:'1'},
				{label: 'Cartão de Crédito', 	data: 'CCREDT', nick:'CCrédito',  typeIn:'1', typeOut:'1'},
				{label: 'Cartão de Débito', 	data: 'CDEBIT', nick:'CDébito',   typeIn:'1', typeOut:'1'},
				{label: 'Cheque', 				data: 'CHEQUE', nick:'Cheque',    typeIn:'1', typeOut:'1'},
				{label: 'Crédito Próprio', 		data: 'CREDTP', nick:'CrédPróp',  typeIn:'1', typeOut:'1'},
				{label: 'Depósito em CC', 	    data: 'DEPOCC', nick:'Depósito',  typeIn:'1', typeOut:'1'},
				{label: 'Débito em Conta', 		data: 'DEBTCC', nick:'DébitoCC',  typeIn:'1', typeOut:'1'},
				{label: 'Transf. Bancária', 	data: 'TRANSB', nick:'Transf.B.', typeIn:'1', typeOut:'1'},
				{label: 'Boleto', 	            data: 'BOLETO', nick:'Boleto.B.', typeIn:'1', typeOut:'0'}
			]);

		static public const _FINANCIAL_DOCUMENT_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'Boleto', 				data: 1,  typeIn:'1', typeOut:'1', nick:'Boleto'},
				{label: 'Carnê', 				data: 2,  typeIn:'1', typeOut:'1', nick:'Carnê'},
				{label: 'Cartão de Crédito', 	data: 3,  typeIn:'1', typeOut:'1', nick:'CCrédito'}, //desuso
				{label: 'Cartão de Débito', 	data: 4,  typeIn:'1', typeOut:'1', nick:'CDébito'}, //desuso
				{label: 'Crédito Próprio', 		data: 5,  typeIn:'1', typeOut:'1', nick:'CrédPróp'},
				{label: 'Cheque', 				data: 6,  typeIn:'1', typeOut:'1', nick:'Cheque'},
				//{label: 'Cheque + Dinheiro', 	data: 16, typeIn:'1', typeOut:'1', nick:''}, //desuso
				{label: 'DARF', 				data: 7,  typeIn:'0', typeOut:'1', nick:'DARF'},
				{label: 'Depósito em Conta', 	data: 8,  typeIn:'1', typeOut:'1', nick:'Depósito'},
				{label: 'Dinheiro', 			data: 9,  typeIn:'1', typeOut:'1', nick:'Dinheiro'}, //desuso
				{label: 'Duplicata', 			data: 10, typeIn:'1', typeOut:'1', nick:'Duplicata'},
				{label: 'Débito em Conta', 		data: 11, typeIn:'1', typeOut:'1', nick:'Débito'},
				{label: 'Estorno de Pagamento', data: 16, typeIn:'1', typeOut:'1', nick:'Estorno'},
				{label: 'Fatura', 				data: 12, typeIn:'0', typeOut:'1', nick:'Fatura'},
				//{label: 'Fatura / Duplicata', 	data: 13, typeIn:'0', typeOut:'0', nick:''},
				{label: 'Nota Promissória', 	data: 14, typeIn:'1', typeOut:'1', nick:'Promiss.'},
				{label: 'Outros', 				data: 15, typeIn:'1', typeOut:'1', nick:'Outros'},
				{label: 'Transf. entre Contas', data: 99, typeIn:'0', typeOut:'0', nick:'Transf.'}
			]);

		static public const _FINANCIAL_FINE_PERCENT:ArrayCollection = new ArrayCollection
			([
				{label: 'Diário (1 dia)', 		data: 1},
				{label: 'Semanal (7 dias)', 	data: 7},
				{label: 'Mensal (30 dias)', 	data: 30},
				{label: 'Quinzenal (15 dias)', 	data: 15},
				{label: 'Trimestral (90 dias)', data: 90},
				{label: 'Semestre (180 dias)', 	data: 180},
				{label: 'Anual (365 dias)', 	data: 365}
			]);

		static public const _financialBankSimple:ArrayCollection = new ArrayCollection
			([
				{label: 'Banrisul',				data: '041', 	image: 'banrisul'	,nickname: 'Banrisul'	,dataname: 'BANRS' },
				{label: 'Banco do Brasil',		data: '001', 	image: 'bb'			,nickname: 'BB'			,dataname: 'BBRAS' },
				{label: 'Bradesco',				data: '036', 	image: 'bradesco'	,nickname: 'Bradesco'	,dataname: 'BRADE' },
				{label: 'Caixa',				data: '104', 	image: 'caixa'		,nickname: 'Caixa'		,dataname: 'CAIXA' },
				{label: 'Citibank',				data: '745', 	image: 'citibank'	,nickname: 'Citibank'	,dataname: 'CITIB' },
				{label: 'Digio',				data: '998', 	image: 'digio'	    ,nickname: 'Digio'	    ,dataname: 'DIGIO' },
				{label: 'HSBC',					data: '399', 	image: 'hsbc'		,nickname: 'HSBC'		,dataname: 'HSBCC' },
				{label: 'Itaú',					data: '479', 	image: 'itau'		,nickname: 'Itaú'		,dataname: 'ITAUU' },
				{label: 'NuBank',				data: '260', 	image: 'nubank'	    ,nickname: 'NuBank'	    ,dataname: 'NUBNK' },
				{label: 'Santander',			data: '033', 	image: 'santander'	,nickname: 'Santander'	,dataname: 'SANTA' },
				{label: 'PagSeguro Uol',		data: '999', 	image: 'pagseguro'	,nickname: 'PagSeguro'	,dataname: 'PAGSE' },
				{label: 'Outro',		        data: '000', 	image: 'other'	    ,nickname: 'Outro'		,dataname: 'OUTRO' }
			]);

		static public const _financialBankFlagSimple:ArrayCollection = new ArrayCollection
			([
				{label: 'America Express',		data: 'AME', 	image: 'americanex'		},
				{label: 'Dinesclub',			data: 'DIN', 	image: 'dinesclub'		},
				{label: 'Elo',					data: 'ELO', 	image: 'elo'			},
				{label: 'MasterCard',			data: 'MAS', 	image: 'mastercard'		},
				{label: 'Visa',					data: 'VIS', 	image: 'visa'			},
				{label: 'Hipercard',			data: 'HIP', 	image: 'hipercard'		},
				{label: 'Outro',			    data: 'OTH', 	image: 'otherflag'		}
			]);

		static public const _FINANCIAL_BANK:ArrayCollection = new ArrayCollection
			([
				{label: 'ABC Brasil S.A.',										data: '246', website: 'www.abcbrasil.com.br'},
				{label: 'Alfa S.A.',											data: '025', website: 'www.bancoalfa.com.br'},
				{label: 'Alvorada S.A.',										data: '641', website: ''},
				{label: 'Banerj S.A.',											data: '029', website: 'www.banerj.com.br'},
				{label: 'Bankpar S.A.',											data: 'z01', website: 'www.aexp.com'},
				{label: 'Barclays S.A.',										data: '740', website: 'www.barclays.com'},
				{label: 'BBM S.A.',												data: '107', website: 'www.bbmbank.com.br'},
				{label: 'Beg S.A.',												data: '031', website: 'www.itau.com.br'},
				{label: 'BGN S.A.',												data: '739', website: 'www.bgn.com.br'},
				{label: 'BM&F de Serviços de Liquidação e Custódia S.A',		data: '096', website: 'www.bmf.com.br'},
				{label: 'BMG S.A.',												data: '318', website: 'www.bancobmg.com.br'},
				{label: 'BNP Paribas Brasil S.A.',								data: '752', website: 'www.bnpparibas.com.br'},
				{label: 'Boavista Interatlântico S.A.',							data: '248', website: ''},
				{label: 'Bonsucesso S.A.',										data: '218', website: 'www.bancobonsucesso.com.br'},
				{label: 'Bracce S.A.',											data: '065', website: 'www.lemon.com'},
				{label: 'Bradesco BBI S.A.',									data: '036', website: ''},
				{label: 'Bradesco Cartões S.A.',								data: '204', website: 'www.iamex.com.br'},
				{label: 'Bradesco Financiamentos S.A.',							data: '394', website: 'www.bmc.com.br'},
				{label: 'Bradesco S.A.',										data: '237', website: 'www.bradesco.com.br'},
				{label: 'Brascan S.A.',											data: '225', website: 'www.bancobrascan.com.br'},
				{label: 'BTG Pactual S.A.',										data: '208', website: 'www.pactual.com.br'},
				{label: 'BVA S.A.',												data: '044', website: 'www.bancobva.com.br'},
				{label: 'Cacique S.A.',											data: '263', website: 'www.bancocacique.com.br'},
				{label: 'Caixa Geral - Brasil S.A.',							data: '473', website: ''},
				{label: 'Cargill S.A.',											data: '040', website: 'www.bancocargill.com.br'},
				{label: 'Citibank S.A.',										data: '745', website: 'www.citibank.com.br'},
				{label: 'Citicard S.A.',										data: 'M08', website: 'www.credicardbanco.com.br'},
				{label: 'CNH Capital S.A.',										data: 'M19', website: 'www.bancocnh.com.br'},
				{label: 'Comercial e de Investimento Sudameris S.A.',			data: '215', website: 'www.sudameris.com.br'},
				{label: 'Cooperativo do Brasil S.A. - BANCOOB',					data: '756', website: 'www.bancoob.com.br'},
				{label: 'Cooperativo Sicredi S.A.',								data: '748', website: 'www.sicredi.com.br'},
				{label: 'Credit Agricole Brasil S.A.',							data: '222', website: 'www.calyon.com.br'},
				{label: 'Credit Suisse (Brasil) S.A.',							data: '505', website: 'www.csfb.com'},
				{label: 'Banco Cruzeiro do Sul S.A.',							data: '229', website: 'www.bcsul.com.br'},
				{label: 'CSF S.A.',												data: 'z02', website: ''},
				{label: 'Banco da Amazônia S.A.',								data: '003', website: 'www.bancoamazonia.com.br'},
				{label: 'Banco da China Brasil S.A.',							data: '833', website: ''},
				{label: 'Daycoval S.A.',										data: '707', website: 'www.daycoval.com.br'},
				{label: 'Banco de Lage Landen Brasil S.A.',						data: 'M06', website: 'www.delagelanden.com'},
				{label: 'Banco de Pernambuco S.A. - BANDEPE',					data: '024', website: 'www.bandepe.com.br'},
				{label: 'Banco de Tokyo-Mitsubishi UFJ Brasil S.A.',			data: '456', website: 'www.btm.com.br'},
				{label: 'Dibens S.A.',											data: '214', website: 'www.bancodibens.com.br'},
				{label: 'Banco do Brasil S.A.',									data: '001', website: 'www.bb.com.br'},
				{label: 'Central do Brasil.',									data: '002', website: ''},
				{label: 'Banco do Estado de Sergipe S.A.',						data: '047', website: 'www.banese.com.br'},
				{label: 'Banco do Estado do Pará S.A.',							data: '037', website: 'www.banparanet.com.br'},
				{label: 'Banco do Estado do Rio Grande do Sul S.A.',			data: '041', website: 'www.banrisul.com.br'},
				{label: 'Banco do Nordeste do Brasil S.A.',						data: '004', website: 'www.banconordeste.gov.br'},
				{label: 'Fator S.A.',											data: '265', website: 'www.bancofator.com.br'},
				{label: 'Fiat S.A.',											data: 'M03', website: 'www.bancofiat.com.br'},
				{label: 'Fibra S.A.',											data: '224', website: 'www.bancofibra.com.br'},
				{label: 'Ficsa S.A.',											data: '626', website: 'www.ficsa.com.br'},
				{label: 'Fidis S.A.',											data: 'z03', website: 'www.bancofidis.com.br'},
				{label: 'Ford S.A.',											data: 'M18', website: 'www.bancoford.com.br'},
				{label: 'GE Capital S.A.',										data: '233', website: 'www.ge.com.br'},
				{label: 'GMAC S.A.',											data: 'M07', website: 'www.bancogm.com.br'},
				{label: 'Guanabara S.A.',										data: '612', website: 'www.bcoguan.com.br'},
				{label: 'Honda S.A.',											data: 'M22', website: 'www.bancohonda.com.br'},
				{label: 'Ibi S.A. Múltiplo',									data: '063', website: 'www.ibi.com.br'},
				{label: 'IBM S.A.',												data: 'M11', website: 'www.ibm.com/br/financing/'},
				{label: 'Industrial do Brasil S.A.',							data: '604', website: 'www.bancoindustrial.com.br'},
				{label: 'Industrial e Comercial S.A.',							data: '320', website: 'www.bicbanco.com.br'},
				{label: 'Indusval S.A.',										data: '653', website: 'www.indusval.com.br'},
				{label: 'Investcred UniS.A.',									data: '249', website: ''},
				{label: 'Itaú BBA S.A.',										data: '184', website: 'www.itaubba.com.br'},
				{label: 'ItaúBank S.A',											data: '479', website: 'www.itaubank.com.br'},
				{label: 'Itaucard S.A.',										data: 'z04', website: ''},
				{label: 'Itaucred Financiamentos S.A.',							data: 'M09', website: 'www.itaucred.com.br'},
				{label: 'J. P. Morgan S.A.',									data: '376', website: 'www.jpmorgan.com'},
				{label: 'J. Safra S.A.',										data: '074', website: 'www.jsafra.com.br'},
				{label: 'John Deere S.A.',										data: '217', website: 'www.johndeere.com.br'},
				{label: 'Luso Brasileiro S.A.',									data: '600', website: 'www.lusobrasileiro.com.br'},
				{label: 'Mercantil do Brasil S.A.',								data: '389', website: 'www.mercantil.com.br'},
				{label: 'Modal S.A.',											data: '746', website: 'www.bancomodal.com.br'},
				{label: 'NuBank',				     						    data: '260', website: 'www.nubank.com.br' },
				{label: 'Opportunity S.A.',										data: '045', website: 'www.opportunity.com.br'},
				{label: 'Panamericano S.A.',									data: '623', website: 'www.panamericano.com.br'},
				{label: 'Paulista S.A.',										data: '611', website: 'www.bancopaulista.com.br'},
				{label: 'Pine S.A.',											data: '643', website: 'www.bancopine.com.br'},
				{label: 'Prosper S.A.',											data: '638', website: 'www.bancoprosper.com.br'},
				{label: 'Rabobank International Brasil S.A.',					data: '747', website: 'www.rabobank.com.br'},
				{label: 'Real S.A.',											data: '356', website: 'www.bancoreal.com.br'},
				{label: 'Rendimento S.A.',										data: '633', website: 'www.rendimento.com.br'},
				{label: 'Rodobens S.A.',										data: 'M16', website: 'www.rodobens.com.br'},
				{label: 'Rural Mais S.A.',										data: '072', website: 'www.rural.com.br'},
				{label: 'Rural S.A.',											data: '453', website: 'www.rural.com.br'},
				{label: 'Safra S.A.',											data: '422', website: 'www.safra.com.br'},
				{label: 'Santander (Brasil) S.A.',								data: '033', website: 'www.santander.com.br'},
				{label: 'Schahin S.A.',											data: '250', website: 'www.bancoschahin.com.br'},
				{label: 'Simples S.A.',											data: '749', website: 'www.bancosimples.com.br'},
				{label: 'Société Générale Brasil S.A.',							data: '366', website: 'www.sgbrasil.com.br'},
				{label: 'Sofisa S.A.',											data: '637', website: 'www.sofisa.com.br'},
				{label: 'Standard de Investimentos S.A.',						data: '012', website: 'www.standardbank.com'},
				{label: 'Sumitomo Mitsui Brasileiro S.A.',						data: '464', website: 'não possue site'},
				{label: 'Topázio S.A.',											data: '082', website: 'www.bancotopazio.com.br'},
				{label: 'Toyota do Brasil S.A.',								data: 'M20', website: 'www.bancotoyota.com.br'},
				{label: 'Triângulo S.A.',										data: '634', website: 'www.tribanco.com.br'},
				{label: 'Volkswagen S.A.',										data: 'M14', website: 'www.bancovw.com.br'},
				{label: 'Volvo (Brasil) S.A.',									data: 'M23', website: ''},
				{label: 'Votorantim S.A.',										data: '655', website: 'www.bancovotorantim.com.br'},
				{label: 'VR S.A.',												data: '610', website: 'www.vr.com.br'},
				{label: 'WestLB do Brasil S.A.',								data: '370', website: 'www.westlb.com.br'},
				{label: 'Yamaha Motor S.A.',									data: 'z05', website: 'www.yamaha-motor.com.br'},
				{label: 'BANESTES S.A. do Estado do Espírito Santo',			data: '021', website: 'www.banestes.com.br'},
				{label: 'Banif-Internacional do Funchal (Brasil)S.A.',			data: '719', website: 'www.banif.com.br'},
				{label: 'Bank of America Merrill Lynch Múltiplo S.A.',			data: '755', website: 'www.ml.com'},
				{label: 'BB Popular do Brasil S.A.',							data: '073', website: 'www.bancopopulardobrasil.com.br'},
				{label: 'BES Investimento do Brasil S.A.-de Investimento',		data: '078', website: 'www.besinvestimento.com.br'},
				{label: 'BPN Brasil Múltiplo S.A.',								data: '069', website: 'www.bpnbrasil.com.br'},
				{label: 'BRB - de Brasília S.A.',								data: '070', website: 'www.brb.com.br'},
				{label: 'Caixa Econômica Federal',								data: '104', website: 'www.caixa.gov.br'},
				{label: 'Citibank N.A.',										data: '477', website: 'www.citibank.com/brasil'},
				{label: 'Concórdia S.A.',										data: '081', website: 'www.concordiabanco.com'},
				{label: 'Deutsche Bank S.A. - Alemão',							data: '487', website: 'www.deutsche-bank.com.br'},
				{label: 'Dresdner Bank Brasil S.A. - Múltiplo',					data: '751', website: 'www.dkib.com.br'},
				{label: 'Goldman Sachs do Brasil Múltiplo S.A.',				data: '064', website: 'www.goldmansachs.com'},
				{label: 'Hipercard Múltiplo S.A.',								data: '062', website: 'www.hipercard.com.br'},
				{label: 'HSBC Bank Brasil S.A. - Múltiplo',						data: '399', website: 'www.hsbc.com.br'},
				{label: 'ING Bank N.V.',										data: '492', website: 'www.ing.com'},
				{label: 'Itaú UniHolding S.A.',									data: '652', website: 'www.itau.com.br'},
				{label: 'Itaú UniS.A.',											data: '341', website: 'www.itau.com.br'},
				{label: 'JBS S.A.',												data: '079', website: 'www.bancojbs.com.br'},
				{label: 'JPMorgan Chase Bank',									data: '488', website: 'www.jpmorganchase.com'},
				{label: 'Standard Chartered Bank (Brasil) S/A–Bco Invest.',		data: 'z06', website: 'www.standardchartered.com'},
				{label: 'UNI- União de Bancos Brasileiros S.A.',				data: '409', website: 'www.unibanco.com.br'},
				{label: 'Unicard Múltiplo S.A.',								data: '230', website: 'www.unicard.com.br'},
				{label: 'Digio',												data: '998', website: 'www.digio.com.br'},
				{label: 'PagSeguro Uol',										data: '999', website: 'www.pagseguro.com.br'}
			]);

		static public const _FINANCIAL_MONEY_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'Real (R$)', 		data: 1},
				{label: 'Dolar ($)', 		data: 2}
			]);

		static public const _WEIGHT_TYPE:ArrayCollection = new ArrayCollection
			([
				/*{label: 'mg (miligramas)', 	data: 'MG'},*/
				{label: 'g (gramas)', 		data: 'GG'},//index 1
				{label: 'Kg (quilos)', 		data: 'KG'},
				{label: 't (toneladas)', 	data: 'TT'}
			]);

		static public const _SIZE_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'mm (milímetros)', 	data: 'MM'},
				{label: 'cm (centímetros)', data: 'CM'}, //index 1
				{label: 'dm (decímetros)', 	data: 'DM'},
				{label: 'm (metros)', 		data: 'M_'},
				{label: 'km (quilômetros)', data: 'KM'},
				{label: 'm2 (metros quad.)',data: 'M2'}
			]);

		static public const _UNIT_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'Unidade', 			data: 'UN'},//index 0
				{label: 'Caixas', 			data: 'BX'},
				/*{label: 'g (gramas)', 		data: 'GG'},*/
				{label: 'ml (mililitros)', 	data: 'ML'}, //ML
				{label: 'Kg (quilos)', 		data: 'KG'}//index 1
				/*{label: 't (toneladas)', 	data: 'TT'}*/
			]);

		static public const _UNIT_TYPE2:ArrayCollection = new ArrayCollection
			([
				{label: 'Unidade', 			data: 'UN'},//index 0
				{label: 'Caixas', 			data: 'BX'},
				{label: 'g (gramas)', 		data: 'GG'},//GG
				{label: 'ml (mililitros)', 	data: 'ML'} //ML
 				//{label: 'Kg (quilos)', 		data: 'KG'}//index 1
				/*{label: 't (toneladas)', 	data: 'TT'}*/
			]);

		static public const _TIME_TYPE:ArrayCollection = new ArrayCollection
			([
				{label: 'segundo(s)', 		data: 'SE'},
				{label: 'minuto(s)', 		data: 'MN'},
				{label: 'hora(s)', 			data: 'HR'},
				{label: 'dia(s)', 			data: 'DA'},
				{label: 'semana(s)', 		data: 'WE'},
				{label: 'mês(es)', 			data: 'MO'},
				{label: 'ano(s)', 			data: 'YE'}
			]);

		static public const _activeProdcutStock:ArrayCollection = new ArrayCollection
			([
				{label: 'Orçamento'  , data: 0, color:0x006699 },
				{label: 'Em Espera'  , data: 1, color:0x00cccc },
				{label: 'Em Execução', data: 2, color:0xff9900 },
				{label: 'Finalizado' , data: 3, color:0x00cc00 },
				{label: 'A Caminho'  , data: 4, color:0x990099 },
				{label: 'Entregue'   , data: 5, color:0x000000 }, //0x339999
				{label: 'Cancelado'  , data: 9, color:0xcc0000 }
			]);

		/*
		
		change stock: 2, 3 ,4, 5
		NO change stock: 0, 1, 9
		
		0?0x006699:
		1?0x00cccc:
		2?0xff9900:
		3?0x00cc00:
		
		9?0xcc0000:
		0x666666
		 * */
		
		static public const _BAD_WORKS:Array =  new Array(
			'arrombado',
			'arrombada',
			'buceta',
			'boceta',
			'bocetao',
			'bucetinha',
			'bucetao',
			'bucetaum',
			'blowjob',
			'#@?$%~',
			'caralinho',
			'caralhao',
			'caralhaum',
			'caralhex',
			'c*',
			'cacete',
			'cacetinho',
			'cacetao',
			'cacetaum',
			'epenis',
			'foder',
			'f****',
			'foda-se',
			'fodase',
			'fodasi',
			'fodassi',
			'fodassa',
			'fodinha',
			'fodao',
			'fodaum',
			'foda1',
			'fodona',
			'f***',
			'fodeu',
			'fodasse',
			'fuckoff',
			'fuckyou',
			'fuck',
			'fidaputa',
			'fidapu',
			'fidaput',
			'filhodaputa',
			'filhadaputa',
			'gozo',
			'gozar',
			'gozada',
			'gozadanacara',
			'm*****',
			'merdao',
			'merdaum',
			'merdinha',
			'vadia',
			'vasefoder',
			'venhasefoder',
			'voufoder',
			'vasefuder',
			'venhasefuder',
			'voufuder',
			'vaisefoder',
			'vaisefuder',
			'venhasefuder',
			'vaisifude',
			'v****',
			'vaisifuder',
			'vasifuder',
			'vasefuder',
			'vasefoder',
			'pirigueti',
			'piriguete',
			'p****',
			'porraloca',
			'porraloka',
			'porranacara',
			'#@?$%~',
			'putinha',
			'putona',
			'putassa',
			'putao',
			'punheta',
			'putamerda',
			'putaquepariu',
			'putaquemepariu',
			'putaquetepariu',
			'putavadia',
			'pqp',
			'putaqpariu',
			'putaqpario',
			'putaqparil',
			'peido',
			'peidar',
			'xoxota',
			'xota',
			'xoxotinha',
			'xoxotona'
		);

		static public const _UTC:ArrayCollection = new ArrayCollection
			([
				{label: 'Fortaleza', 		data: 'BET', GMT: '-03:00', value: '-3'},
				{label: 'Brasília', 		data: 'BET', GMT: '-03:00', value: '-3'},
				{label: 'São Paulo', 		data: 'BET', GMT: '-03:00', value: '-3'}
			]);
		
		
		static public const _operatorCelPhone:ArrayCollection = new ArrayCollection
			([
				{label: 'Fixo', 			data: 1},
				{label: 'Tim', 				data: 41},
				{label: 'Oi', 				data: 31},
				{label: 'Claro', 			data: 21},
				{label: 'Nextel', 			data: 77},
				{label: 'Vivo', 			data: 20},
				{label: 'Brasil Telecom', 	data: 14},
				{label: 'Telemig', 			data: 23},
				{label: 'CTBC', 			data: 12},
				{label: 'Amazonia', 		data: 24},
				{label: 'Unicel', 			data: 37},
				{label: 'Sercomercio', 		data: 43},
				{label: 'Datora', 			data: 81},
				{label: 'Skype', 			data: 2},
				{label: 'GVT', 				data: 25}
			]);
		
		
		/*
		
		Name 	Description 	Relative to GMT
		'GMT' 	'Greenwich Mean Time 			GMT
		'UTC' 	'Universal Coordinated Time 	GMT
		'ECT' 	'European Central Time 			GMT+1:00
		'EET' 	'Eastern European Time 			GMT+2:00
		'ART' 	'(Arabic) Egypt Standard Time 	GMT+2:00
		'EAT' 	'Eastern African Time 			GMT+3:00
		'MET' 	'Middle East Time 				GMT+3:30
		'NET' 	'Near East Time 	GMT+4:00
		'PLT' 	'Pakistan Lahore Time 	GMT+5:00
		'IST' 	'India Standard Time 	GMT+5:30
		'BST' 	'Bangladesh Standard Time 	GMT+6:00
		'VST' 	'Vietnam Standard Time 	GMT+7:00
		'CTT' 	'China Taiwan Time 	GMT+8:00
		'JST' 	'Japan Standard Time 	GMT+9:00
		'ACT' 	'Australia Central Time 	GMT+9:30
		'AET' 	'Australia Eastern Time 	GMT+10:00
		'SST' 	'Solomon Standard Time 	GMT+11:00
		'NST' 	'New Zealand Standard Time 	GMT+12:00
		'MIT' 	'Midway Islands Time 	GMT-11:00
		'HST' 	'Hawaii Standard Time 	GMT-10:00
		'AST' 	'Alaska Standard Time 	GMT-9:00
		'PST' 	'Pacific Standard Time 	GMT-8:00
		'PNT' 	'Phoenix Standard Time 	GMT-7:00
		'MST' 	'Mountain Standard Time 	GMT-7:00
		'CST' 	'Central Standard Time 	GMT-6:00
		'EST' 	'Eastern Standard Time 	GMT-5:00
		'IET' 	'Indiana Eastern Standard Time 	GMT-5:00
		'PRT' 	'Puerto Rico and US Virgin Islands Time 	GMT-4:00
		'CNT' 	'Canada Newfoundland Time 	GMT-3:30
		'AGT' 	'Argentina Standard Time 	GMT-3:00
		'BET' 	'Brazil Eastern Time 	GMT-3:00
		'CAT' 	'Central African Time 	GMT-1:00
		*/
		
		/** ########################################################################### **/
		/** ########################################################################### **/
		/** ########################################################################### **/
		/** ########################################################################### **/
		/** ########################################################################### **/
		/** ########################################################################### **/
		/** ########################################################################### **/

		static public function __programId(nameProgram_:String):uint
		{
			for(var i:uint=0; i<gnncGlobalArrays._PROGRAMS.length; i++ )
			{
				if(gnncGlobalArrays._PROGRAMS[i].NAME == nameProgram_)
					return Number(gnncGlobalArrays._PROGRAMS[i].ID);
			}
			return 0;
		}

		static public function __programName(idProgram_:uint):String
		{
			for(var i:uint=0; i<gnncGlobalArrays._PROGRAMS.length; i++ )
			{
				if(gnncGlobalArrays._PROGRAMS[i].ID === idProgram_)
					return String(gnncGlobalArrays._PROGRAMS[i].NAME);
			}
			return 'Nenhum encontrado';
		}

		public function gnncGlobalArrays()
		{
			super();
		}
		
	}
}