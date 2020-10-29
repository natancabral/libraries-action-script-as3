package GNNC.elements.component.list
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.data.gnncDataBindable;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.event.gnncEventGeneral;
	import GNNC.modules.client.formNew.newClient;
	import GNNC.modules.client.formView.viewClient;
	import GNNC.modules.client.itemRender.itemRender_clientPhoto_forList;
	import GNNC.modules.client.itemRender.itemRender_clientSimpleList_forList;
	import GNNC.modules.client.itemRender.itemRender_client_forList;
	import GNNC.sqlTables.table_client;
	
	import flashx.textLayout.elements.TabElement;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;
	import mx.events.FlexEvent;
	import mx.states.OverrideBase;
	
	import spark.components.Image;
	
	//[Bindable]
	public class conList_client extends conList_class
	{
		//override public var _length:uint;
		
		public function conList_client()
		{
			__config();
			gnncDataBindable.__loginSession(__configSql);
			addEventListener(FlexEvent.CREATION_COMPLETE,__configSql);
		}
		
		private function __config():void
		{
			_name							= 'Cliente';
			
			_itemRenderList					= itemRender_client_forList;
			_itemRenderBox					= itemRender_clientPhoto_forList;
			_itemRenderListClear			= itemRender_clientSimpleList_forList;
			_itemRenderBoxClear				= itemRender_clientPhoto_forList;
			
			_tableClass						= new table_client();
			_tableClassName					= '_TABLE_CLIENT';
			
			itemRenderIndex 				= 0;
		}

		public override function __configSql(e:*=null):void
		{
			//_sqlConsult		 				= '';
			_sqlOrderBy						= ['NAME'];
			_sqlWhere						= null;
			_sqlOrderDesc					= false;
			_sqlLimit						= [0,100];
			_sqlColumns						= [
				'dbd_client.ID',
//				'ID',
				'NAME',
				'DATE_BIRTH',
				'COMPANY',
				'SEX',
				'STAR_RATING',
				'NICK_NAME',
				'EMAIL',
				'PROFESSIONAL_NUMBER',
				'PROFESSIONAL_STATE',
				'ACTIVE',
				'CONTROL',

				//birthday
				'(RIGHT(DATE_BIRTH,2)) AS DAY',

				//attach
				"coalesce((select FILE_LINK from dbd_attach 	where MIX like 'CLIENT' and ID_MIX like dbd_client.ID AND (EXTENSION like 'jpg' or EXTENSION like 'png' or EXTENSION like 'gif') ORDER BY ORDER_ITEM LIMIT 0,1),0) ATTACH_CLIENT",
				
				//names
				"coalesce((select NAME 		from dbd_group 		where dbd_group.ID 			like dbd_client.ID_GROUP		),'') NAME_GROUP",
				"coalesce((select NAME 		from dbd_category 	where dbd_category.ID 		like dbd_client.ID_CATEGORY		),'') NAME_CATEGORY",
				
				//rows
				"coalesce((select count(*)	from dbd_project 	where dbd_project.ID_CLIENT like dbd_client.ID				),'') ROWS_PROJECT",
				
				//star
				"coalesce((select ID 		from dbd_star s 	where s.ID_MIX like dbd_client.ID AND s.MIX like 'CLIENT' AND s.ID_USER like '"+gnncGlobalStatic._userId+"' LIMIT 0,1 ),0) ID_STAR",
				"coalesce((select ENABLED 	from dbd_star s 	where s.ID_MIX like dbd_client.ID AND s.MIX like 'CLIENT' AND s.ID_USER like '"+gnncGlobalStatic._userId+"' LIMIT 0,1 ),0) STAR"
			];
		}

		public override function __contextMenuModel():void
		{
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._view, 		fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._new, 		fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._edit, 		fName:__fEdit	},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._delete, 	fName:__fDelete	},
					{label:'Atualizar',		enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._refresh, 	fName:__fRefresh},
					{label:'Copiar Nome',	enabled:_copy,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._copy, 		fName:__fCopy	},
					
					{label:'Remover item(ns) da lista',	enabled:true,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._removeItemList, fName:__fRemoveItemList	}
				]
			);
		}
		
		public override function __pageView():Object
		{
			var _table:table_client 		= new table_client();
			_table.ID	 					= selectedItem.ID;
			
			var _page:viewClient			= new viewClient();
			_page._tableClient				= _table;
			
			return _page;
		}
		
		public override function __pageNew():Object
		{
			var _table:table_client 		= new table_client();
			_table.ID_DEPARTAMENT			= _tableClass.ID_DEPARTAMENT;
			_table.ID_GROUP					= _tableClass.ID_GROUP;
			_table.ID_CATEGORY				= _tableClass.ID_CATEGORY;

			_table.COMPANY					= _tableClass.COMPANY;

			var _page:newClient 			= new newClient();
			_page._TABLE_CLIENT 			= _table;
			
			return _page;
		}
		
		public override function __pageEdit():Object
		{
			var _page:newClient			= new newClient();
			_page._TABLE_CLIENT				= new table_client(selectedItem.ID);
			
			return _page;
		}

		public function __selectCourseAll(idCourse_:uint,fResul_:Function=null,fFault_:Function=null):void
		{
			__selectCourseClients('all',idCourse_,fResul_,fFault_);
		}

		public function __selectCourseTeachers(idCourse_:uint,fResul_:Function=null,fFault_:Function=null):void
		{
			__selectCourseClients('teacher',idCourse_,fResul_,fFault_);
		}

		public function __selectCourseStudents(idCourse_:uint,fResul_:Function=null,fFault_:Function=null):void
		{
			__selectCourseClients('student',idCourse_,fResul_,fFault_);
		}
		
		private function __selectCourseClients(type_:String,idCourse_:uint,fResul_:Function=null,fFault_:Function=null):void
		{
			__loading(true);
			
			var _sql:String = '';
			
			if(type_ == 'all')
				_sql = ' ( ' + __selectCourseSql('student',idCourse_) + ' ) UNION ( ' + __selectCourseSql('teacher',idCourse_) + ' ) ';
			else
				_sql = __selectCourseSql(type_,idCourse_);
			
			//new gnncAlert().__alert(_sql);
			
			_connList.__sql(_sql,'','',__fResult,__fFault);
			
			function __fResult(e:*):void
			{
				__loading(false);

				if(fResul_!=null)
					fResul_.call(null);

				list_.dataProvider = _connList.DATA_ARR;
			}
			
			function __fFault(e:*):void
			{
				__loading(false);
				
				if(fFault_!=null)
					fFault_.call(null);
				
			}
			
		}
		
		private function __selectCourseSql(typeTableName_:String,idCourse_:uint):String
		{
			var _sql:String = " select c.*, " +
				
				//birthday
				" (RIGHT(DATE_BIRTH,2)) AS DAY, " +
				
				//names
				" coalesce((select NAME 	from dbd_group 		where dbd_group.ID 			like c.ID_GROUP			),'') NAME_GROUP, " +
				" coalesce((select NAME 	from dbd_category 	where dbd_category.ID 		like c.ID_CATEGORY		),'') NAME_CATEGORY, " +
				
				//star
				" coalesce((select ID 		from dbd_star s where s.ID_MIX like c.ID AND s.MIX like 'CLIENT' AND s.ID_USER like '"+gnncGlobalStatic._userId+"' LIMIT 0,1 ),0) ID_STAR, " +
				" coalesce((select ENABLED 	from dbd_star s where s.ID_MIX like c.ID AND s.MIX like 'CLIENT' AND s.ID_USER like '"+gnncGlobalStatic._userId+"' LIMIT 0,1 ),0) STAR, " +
				
				//attach
				" coalesce((select FILE_LINK from dbd_attach where MIX like 'CLIENT' and ID_MIX like c.ID AND (EXTENSION like 'jpg' or EXTENSION like 'png' or EXTENSION like 'gif') ORDER BY ORDER_ITEM LIMIT 0,1),0) ATTACH_CLIENT " +
				
				" from dbd_course_"+typeTableName_+" s join dbd_client c " +
				" where s.ID_CLIENT = c.ID AND s.ID_PROJECT like '"+idCourse_+"' " +
				" order by c.NAME ASC ";
			
			//new gnncAlert().__alert(_sql);
			
			return _sql;
		}

		public function __selectBirthday(day_:uint,month_:uint,year_:uint,fResul_:Function=null,fFault_:Function=null):void
		{
		}

		public function __selectBirthdayToday(date_:Date=null,fResul_:Function=null,fFault_:Function=null):void
		{
		}

		public function __selectBirthdayWeek(date_:Date=null,dayWeek_:uint=0,fResul_:Function=null,fFault_:Function=null):void
		{
		}


		
		
		
	}
}