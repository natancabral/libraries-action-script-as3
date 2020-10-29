package GNNC.data.globals
{
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncDataBindable;
	
	import flash.events.EventDispatcher;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	import mx.utils.ObjectProxy;

	public class gnncGlobalStaticProjects extends ObjectProxy
	{
		[Bindable] static private var _arrClient:ArrayCollection  = new ArrayCollection();
		[Bindable] static private var _arrProject:ArrayCollection = new ArrayCollection();
		[Bindable] static private var _arrStep:ArrayCollection    = new ArrayCollection();

		static private var _connClient:gnncAMFPhp      = new gnncAMFPhp();
		static private var _connProject:gnncAMFPhp     = new gnncAMFPhp();
		static private var _connStep:gnncAMFPhp        = new gnncAMFPhp();
		
		public static var changeClient:Date          = null;
		public static var changeProject:Date         = null;
		public static var changeStep:Date            = null;

		[Bindable] private static var _teste:String = '';
		
		private static const maxCount:uint   = 3;
		private static var clientCount:uint  = 0;
		private static var projectCount:uint = 0;
		private static var stepCount:uint    = 0;

		public function gnncGlobalStaticProjects()
		{
		}

		public static function getAll():void 
		{
			getClientList();
			getProjectList();
			getStepList();
		}
		
		/* --------------------------------------------------------------------------- */

		public static function getClientList(fResult:Function=null,fFault:Function=null):void 
		{
			var sql:String = "";
			if(gnncGlobalStatic._userAdmin == true && gnncGlobalStatic._userClient == false)
				sql = " " +
					" select c.NAME, c.ID, COUNT(p.ID) as ROWS_PROJECT " +
					" from dbd_client as c " +
					" inner join dbd_project as p ON (p.ID_CLIENT = c.ID) " +
					" where " +
					" c.ID >= 0 " +
					" group by c.ID " +
					" order by c.NAME asc ";
			else
				sql = " " +
					" select c.NAME, " +
					" c.ID, COUNT(p.ID) as ROWS_PROJECT " +
					" from dbd_client as c " +
					" inner join dbd_project as p ON (p.ID_CLIENT = c.ID) " +
					" inner join dbd_project_team t ON (t.ID_CLIENT = c.ID) " +
					" where " +
					" c.ID >= 0 AND " +
					" t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" " +
					" group by c.ID " +
					" order by c.NAME asc ";
			
			_connClient = new gnncAMFPhp();
			_connClient.__sql(sql,'','',fR,fF);
			
			watchChangeClient(null);
			watchChangeClient2(fR);
			
			function fR(e:*=null):void 
			{
				gnncGlobalStaticProjects._arrClient = _connClient.DATA_ARR;
				setChangeClient();
				
				if(fResult!=null)
					fResult.call();
				
			}
			function fF(e:*=null):void 
			{
				if(clientCount > maxCount)
					return;
				clientCount++;
				getClientList(fResult,fFault);
				
				if(fFault!=null)
					fFault.call();
			}
		}

		public static function getProjectList(fResult:Function=null,fFault:Function=null):void 
		{
			var sql:String = "";
			if(gnncGlobalStatic._userAdmin == true && gnncGlobalStatic._userClient == false)
				sql = " " +
					" select " +
					" p.NAME, " +
					" p.ID, " +
					" p.ID_CLIENT, " +
					" COUNT(s.ID) as ROWS_STEP " +
					" from dbd_project as p " +
					" left join dbd_step as s ON (s.ID_PROJECT = p.ID) " +
					" where " +
					" p.ID >= 0 " +
					" group by p.ID " +
					" order by NAME asc,ID asc ";
			else
				sql = " " +
					" SELECT " +
					" p.NAME, " +
					" p.ID as ID, " +
					" p.ID_CLIENT, " +
					" COUNT(s.ID) as ROWS_STEP " +
					" from dbd_project as p " +
					" left join dbd_project_team as t ON (t.ID_CLIENT = p.ID_CLIENT) " +
					" left join dbd_step as s ON (s.ID_PROJECT = p.ID) " +
					" WHERE " +
					" (t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" AND t.ID_PROJECT = 0 ) OR "+
					" (t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" AND t.ID_PROJECT = p.ID )"+
					" group by p.ID"+
					" order by NAME asc,ID asc ";
			
			_connProject = new gnncAMFPhp();
			_connProject.__sql(sql,'','',fR,fF);
			
			watchChangeProject(fR);
			//watchChangeProject2(null);
			
			function fR(e:*=null):void 
			{
				gnncGlobalStaticProjects._arrProject = _connProject.DATA_ARR;
				setChangeProject();

				if(fResult!=null)
					fResult.call();
				
			}
			function fF(e:*=null):void 
			{
				if(projectCount > maxCount)
					return;
				projectCount++;
				getProjectList(fResult,fFault);

				if(fFault!=null)
					fFault.call();
			}
		}

		public static function getStepList(fResult:Function=null,fFault:Function=null):void 
		{
			var sql:String = "";
			if(gnncGlobalStatic._userAdmin == true && gnncGlobalStatic._userClient == false)
				sql = " " +
					" select " +
					" s.NAME, " +
					" s.ID as ID, " +
					" s.ID_CLIENT, " +
					" s.ID_PROJECT, " +
					" s.ORDER_ITEM as ORDER_ITEM, " +
					" (select COUNT(x.ID) from dbd_job x where x.DATE_FINAL < 1 AND x.ID_STEP = s.ID ) as ROWS_JOB, " +
					" (select COUNT(x.ID) from dbd_job x where x.DATE_FINAL > 1 AND x.ID_STEP = s.ID ) as ROWS_JOB_FINAL " +
					" from dbd_step as s " +
					" where " +
					" 1 " +
					" group by s.ID " +
					" order by s.ORDER_ITEM asc, s.NAME asc, s.ID asc ";
			else
				sql = ""+
					" select " +
					" p.NAME, " +
					" p.ID as ID, " +
					" p.ID_CLIENT, " +
					" p.ID_PROJECT, " +
					" p.ORDER_ITEM as ORDER_ITEM, " +
					" (select COUNT(x.ID) from dbd_job x where x.DATE_FINAL < 1 AND x.ID_STEP = p.ID ) as ROWS_JOB, " +
					" (select COUNT(x.ID) from dbd_job x where x.DATE_FINAL > 1 AND x.ID_STEP = p.ID ) as ROWS_JOB_FINAL " +
					" from dbd_step as p " +
					" left join dbd_project_team as t ON (t.ID_CLIENT = p.ID_CLIENT) " +
					" where " +
					" (t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" AND t.ID_PROJECT = 0 ) OR"+
					" (t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" AND t.ID_PROJECT = p.ID_PROJECT AND t.ID_STEP = 0) OR"+
					" (t.ID_CLIENT_TEAM = "+gnncGlobalStatic._userIdClient+" AND t.ID_PROJECT = p.ID_PROJECT AND t.ID_STEP = p.ID) "+
					" group by p.ID"+
					" order by ORDER_ITEM asc, p.NAME asc, p.ID asc ";

			_connStep= new gnncAMFPhp();
			_connStep.__sql(sql,'','',fR,fF);
			
			//watchChangeStep(null);
			//watchChangeStep2(null);
			
			function fR(e:*=null):void 
			{
				gnncGlobalStaticProjects._arrStep = _connStep.DATA_ARR;
				setChangeStep();
				
				if(fResult!=null)
					fResult.call();
			}
			function fF(e:*=null):void 
			{
				if(stepCount > maxCount)
					return;
				stepCount++;
				getStepList(fResult,fFault);

				if(fFault!=null)
					fFault.call();
			}
		}

		/* --------------------------------------------------------------------------- */

		public static function get arrClient():ArrayCollection {
			return _arrClient;
		}
		public static function set arrClient(v:ArrayCollection):void{
			_arrClient = v;
			_arrClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		public static function get arrProject():ArrayCollection {
			return _arrProject;
		}
		public static function set arrProject(v:ArrayCollection):void{
			_arrProject = v;
			_arrClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		public static function get arrStep():ArrayCollection {
			return _arrStep;
		}
		public static function set arrStep(v:ArrayCollection):void{
			_arrStep = v;
			_arrClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		/* --------------------------------------------------------------------------- */

		public static function get connClient():gnncAMFPhp {
			return _connClient;
		}
		public static function set connClient(v:gnncAMFPhp):void{
			_connClient = v;
			_connClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		public static function get connProject():gnncAMFPhp {
			return _connProject;
		}
		public static function set connProject(v:gnncAMFPhp):void{
			_connProject = v;
			_connClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		public static function get connStep():gnncAMFPhp {
			return _connStep;
		}
		public static function set connStep(v:gnncAMFPhp):void{
			_connStep = v;
			_connClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}

		/* --------------------------------------------------------------------------- */

		public static function get teste():String {
			return _teste;
		}
		public static function set teste(v:String):void{
			_teste = v;
		}

		public static function setChangeClient():void{
			changeClient = new Date();
			arrClient.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public static function setChangeProject():void{
			changeProject= new Date();	
			arrProject.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public static function setChangeStep():void{
			changeStep = new Date();	
			arrStep.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public static function watchChangeClient(function_PropertyChangeEvent:Function):void{
			BindingUtils.bindProperty(gnncGlobalStaticProjects, "arrClient", gnncGlobalStaticProjects, "arrClient");
			
			if(function_PropertyChangeEvent!=null)
				new gnncDataBindable().__monitoring(gnncGlobalStatic,'changeClient',function_PropertyChangeEvent);
		}
		
		public static function watchChangeProject(function_PropertyChangeEvent:Function):void{
			gnncGlobalStaticProjects._arrProject.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			
			if(function_PropertyChangeEvent!=null)
				new gnncDataBindable().__monitoring(gnncGlobalStatic,'changeProject',function_PropertyChangeEvent);
		}
		
		public static function watchChangeStep(function_PropertyChangeEvent:Function):void{
			BindingUtils.bindProperty(gnncGlobalStaticProjects, "arrStep", gnncGlobalStaticProjects, "arrStep");
			gnncGlobalStaticProjects._arrStep.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
			
			if(function_PropertyChangeEvent!=null)
				new gnncDataBindable().__monitoring(gnncGlobalStatic,'changeStep',function_PropertyChangeEvent);
		}

		public static function watchChangeClient2(function_PropertyChangeEvent:Function):void{
			arrClient.addEventListener(CollectionEvent.COLLECTION_CHANGE,function_PropertyChangeEvent);
		}
		public static function watchChangeProject2(function_PropertyChangeEvent:Function):void{
			arrProject.addEventListener(CollectionEvent.COLLECTION_CHANGE,function_PropertyChangeEvent);
		}
		public static function watchChangeStep2(function_PropertyChangeEvent:Function):void{
			arrStep.addEventListener(CollectionEvent.COLLECTION_CHANGE,function_PropertyChangeEvent);
		}

	}
}