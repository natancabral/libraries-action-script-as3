package GNNC.others
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataVector;
	import GNNC.data.globals.gnncGlobalLog;
	import GNNC.time.gnncTime;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.List;

	public class gnncUpdateItemList
	{
		private var connExec11:gnncAMFPhp  = new gnncAMFPhp(); //update
		private var connExec12:gnncAMFPhp  = new gnncAMFPhp(); //update
		private var connExec13:gnncAMFPhp  = new gnncAMFPhp(); //update

		public var tableObject:Object      = null;
		public var listElement:Object      = null;
		public var amfPhpElement:Object    = null;
		
		public var sqlOrder:String         = '';
		public var sqlColumns:Array        = [];
		public var sqlColumnsPredix:String = '';

		/**
		 * " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} "
		 * **/
		public var sqlBaseToIds:String   = " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} ";
		/**
		 * " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} "
		 * **/
		public var sqlBaseToKey:String   = " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} ";
		/**
		 * " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} "
		 * **/
		public var sqlBaseToIdKey:String = " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{property}} IN ({{values}}) {{order}} ";
		
		/** 
		 * functionLoading = function(show:Boolean){}
		 * **/
		public var functionLoading:Function  = null;
		public var functionInit:Function     = null;
		public var functionComplete:Function = null;
		
		public var propertyId:String       = 'ID';
		public var propertyKey:String      = 'KEY';
		public var propertyIdKey:String    = 'ID_KEY';
		
		/**
		 * //setUpdate \\n
		 * private function updateItemRender(ids:Array=null,key:Array=null,idKey:Array=null):void{ \\n
		 *   var u:gnncUpdateItemList = new gnncUpdateItemList(ID','KEY','ID_KEY'); \n
		 *   u.listElement = list_; \n
		 *   u.amfPhpElement = connListJob; \n
		 *   u.sqlColumnsPredix = 'j'; \n
		 *   u.sqlColumns = getColumns('j'); \n
		 *   u.tableObject = new table_job(); \n
		 *   u.functionInit = function():void{}; \n
		 *   u.functionComplete = function():void{}; \n
		 *   u.updateItemRender(ids,key,idKey); \n
		 * }
		 * **/
		public function gnncUpdateItemList(idProp:String='ID',keyProp:String='KEY',idKeyProp:String='ID_KEY')
		{
			if(idProp)
				propertyId = idProp;
			if(keyProp)
				propertyKey = keyProp;
			if(idKeyProp)
				propertyIdKey = idKeyProp;
		}
		
		/* ------------------------------------------------------------------------------------------------------------------------------------------ */
		/* ------------------------------------------------------------------------------------------------------------------------------------------ */
		/* ------------------------------------------------------------------------------------------------------------------------------------------ */
		/* ------------------------------------------------------------------------------------------------------------------------------------------ */

		private function checkNeed():Boolean
		{
			if(!sqlOrder)
				sqlOrder = " order by "+sqlColumnsPredix+".ID asc ";
			
			var err:Array = new Array();
			if(!sqlColumnsPredix)
				err.push('Definia o prefixo da tabela');
			if(!tableObject)
				err.push('Definia a tabela');
			if(!listElement)
				err.push('Defina a listagem');
			if(!amfPhpElement)
				err.push('Defina o amfPhp');
			if(sqlColumns.length==0)
				err.push('Defina as colunas do select');
			
			if(err.length>0){
				gnncAlert.__alert(err.join(",<br>\n"),'Defina');
				return false;
			}
			
			return true;
		}

		public function replaceSql(sqlBase:String,table:String,prefix:String,columns:Array,propertyName:String,values:Array,valuesAreNumbers:Boolean,orderBy:String):String
		{
			//sqlBase = " select {{columns}} from {{table}} as {{prefix}} where {{prefix}}.{{propertyId}} IN ({{valuesId}}) {{order}} ";
			sqlBase = gnncData.__replace(sqlBase,'{{table}}'     ,table);
			sqlBase = gnncData.__replace(sqlBase,'{{prefix}}'    ,prefix);
			sqlBase = gnncData.__replace(sqlBase,'{{columns}}'   ,columns.join(','));
			sqlBase = gnncData.__replace(sqlBase,'{{property}}'  ,propertyName);
			sqlBase = gnncData.__replace(sqlBase,'{{order}}'     ,orderBy);
			
			if(valuesAreNumbers==true)
				sqlBase = gnncData.__replace(sqlBase,'{{values}}',values.join(','));
			else
				sqlBase = gnncData.__replace(sqlBase,'{{values}}',"'"+values.join("','")+"'");

			return sqlBase;
		}

		/**
		 * 
		 * var u:gnncUpdateItemList = new gnncUpdateItemList(); 
		 * 
		 * **/
		public function updateItemRender(ids:Array=null,key:Array=null,idKey:Array=null):*
		{
			if(!ids && !key && !idKey)
				return listElement;
			
			if(!checkNeed())
				return listElement;
			
			var objDat:Object         = listElement.selectedItem;
			var idxDat:int            = listElement.selectedIndex;
			//var idxArr:int            = _financial.DATA_ARR.getItemIndex(objDat);
			var itens:Vector.<Object> = listElement.selectedItems;
			var itensCount:uint       = itens.length;
			
			var idsB:Boolean = false; //id
			var kefB:Boolean = false; //key_financial // other property
			var idkB:Boolean = false; //id_key
			
			var sqlArr:Array = new Array();
			var sqlGer:String = '';
			var sql1:String   = ''; //id
			var sql2:String   = ''; //key_financial // other property
			var sql3:String   = ''; //id_key
			
			var connectionsTimes:int = 0;
			var gnncScroll:gnncScrollPosition = new gnncScrollPosition();
			
			var order:String = sqlOrder; 
			
			//--------------------------------------------------
			if(ids){
				if(ids.length>0){
					if(String(ids[0])!=''){
						idsB = true; 
						connectionsTimes++; 
					}
				}
			}
			if(key){
				if(key.length>0){
					if(String(key[0])!=''){
						kefB = true; 
						connectionsTimes++; 
					}
				}
			}
			if(idKey){
				if(idKey.length>0){
					if(String(idKey[0])!=''){
						idkB = true; 
						connectionsTimes++; 
					}
				}
			}
			//--------------------------------------------------
			//motivo: não adianta atualizar os dados de ids, pois só trará a listagem do KEY
			//--------------------------------------------------
			if(idsB && kefB){
				idsB = false; 
				connectionsTimes = connectionsTimes-1; 
			}
			if(idkB && kefB){
				idkB = false; 
				connectionsTimes = connectionsTimes-1; 
			}
			//--------------------------------------------------
			
			var tab:String = 'dbd_'+String(tableObject._TABLE).toLowerCase();
			//se prefixo nao definido entao coloca nome da tabela
			sqlColumnsPredix = sqlColumnsPredix ? sqlColumnsPredix : tab ;
			
			if(idsB){
				sql1 = replaceSql(sqlBaseToIds,tab,sqlColumnsPredix,sqlColumns,propertyId,ids,true,order);
				/*sql1 = " select " + sqlColumns.join(',') + 
					" from "+tab+" "+sqlColumnsPredix+" where " +
					" "+sqlColumnsPredix+"."+propertyId+" IN (" + ids.join(',') + ") " + order;*/
				sqlArr.push(sql1);
			}
			if(kefB){
				sql2 = replaceSql(sqlBaseToKey,tab,sqlColumnsPredix,sqlColumns,propertyKey,key,false,order);
				/*sql2 = " select " + sqlColumns.join(',') + 
					" from "+tab+" "+sqlColumnsPredix+" where " +
					" "+sqlColumnsPredix+"."+propertyKey+" IN ('" + key.join("','") + "') " + order;*/
				sqlArr.push(sql2);
			}
			if(idkB){
				sql3 = replaceSql(sqlBaseToIdKey,tab,sqlColumnsPredix,sqlColumns,propertyIdKey,idKey,false,order);
				/*sql3 = " select " + sqlColumns.join(',') + 
					" from "+tab+" "+sqlColumnsPredix+" where " +
					" "+sqlColumnsPredix+"."+propertyIdKey+" IN ('" + idKey.join("','") + "') " + order;*/
				sqlArr.push(sql3);
			}
			
			sqlGer = sqlArr.join(' UNION ALL ') + order ;
			
			if(connectionsTimes>0){
				if(functionLoading!=null)
					functionLoading.call([true]);
				loading(true);
				if(functionInit!=null)
					functionInit.call([true]);
			}
			
			//_connExec.__clear();
			//_connExec.__sql(sqlGer,'','',__fResult,__fFault);
			
			gnncGlobalLog.__add(connectionsTimes,'connTimes');
			
			if(idsB)
				connExec11.__sql(sql1,'','',__fResult_1,__fFault);
			if(kefB)
				connExec12.__sql(sql2,'','',__fResult_2,__fFault);
			if(idkB)
				connExec13.__sql(sql3,'','',__fResult_3,__fFault);
			
			gnncScroll.__getListValues(listElement as List,true);
			
			//atualiza os ids, normalmente os que estão selecionados;
			function __fResult_1(e:*):void
			{
				gnncGlobalLog.__add(connectionsTimes,'connTimes1 ('+connExec11.DATA_ROWS+')');
				if(connExec11.DATA_ROWS==0){
					connectionsTimes = connectionsTimes-1;
					if(connectionsTimes<1){
						if(functionLoading!=null)
							functionLoading.call([false]);
						loading(false);
					}
					return;
				}
				var i:uint = 0;
				var idx:int = -1;
				var oId:uint = 0;
				var o:Object = new Object();
				var arr:Array = gnncDataVector.__vector2Array(itens);
				var arC:ArrayCollection = new ArrayCollection(listElement.dataProvider.toArray());
				var naC:ArrayCollection = new ArrayCollection();
				var totalUpdate:uint = 0;
				
				if(itensCount>1)
				{
					gnncGlobalLog.__add('updatesRows:'+itensCount);
					//atualizar itens selecionados
					for(i=0;i<itensCount;i++)
					{
						//transforma o primeiro vetor selecionado em objeto
						o = arr[i] as Object;
						//captura o id do objeto
						oId = o.ID;
						//pega o index dele na listagem principal, FINANCIAL_, onde foram selecionados os lançamentos manualmente
						idx = arC.getItemIndex(o);
						//filtra os elementos com o mesmo id
						naC = new gnncDataArrayCollection().__filterNumeric(connExec11.DATA_ARR,'ID',oId);
						
						if(naC.length==1 && idx>-1){
							//posiciona o index e joga na lista
							o = naC.getItemAt(0);
							listElement.dataProvider.setItemAt(o,idx);
							amfPhpElement.DATA_ARR.setItemAt(o,idx);
							totalUpdate++;
						}else if(naC.length==0){
							//erro - add na lista (nao encontrol o id)
						}else {}
					}
					//se não encontrar na lista add no final
					if(totalUpdate != itensCount){
						for(i=0;i<connExec11.DATA_ROWS;i++)
						{
							o = connExec11.DATA_ARR.getItemAt(i);
							oId = o.ID;
							naC = new gnncDataArrayCollection().__filterNumeric(connExec11.DATA_ARR,'ID',oId);
							if(naC.length==0){
								listElement.dataProvider.addItem(o);
								amfPhpElement.DATA_ARR.addItem(o);
							}								
							
						}
					}
					amfPhpElement.DATA_ARR.refresh();
				}
				else
				{
					o = connExec11.DATA_ARR.getItemAt(0);
					listElement.dataProvider.setItemAt(o,idxDat);
					//update
					amfPhpElement.DATA_ARR = new ArrayCollection(listElement.dataProvider.toArray());
					amfPhpElement.DATA_ARR.refresh();
				}						
				
				gnncScroll.__setListValues(listElement as List);
				
				connectionsTimes = connectionsTimes-1;
				if(connectionsTimes<1){
					if(functionLoading!=null)
						functionLoading.call([false]);
					loading(false);
				}
			}
			
			//insere na listagem secundária as parcelas agrupadas
			function __fResult_2(e:*):void
			{
				gnncGlobalLog.__add(connectionsTimes,'connTimes2 ('+connExec12.DATA_ROWS+')');
				if(connExec12.DATA_ROWS==0){
					connectionsTimes = connectionsTimes-1;
					if(connectionsTimes<1){
						if(functionLoading!=null)
							functionLoading.call([false]);
						loading(false);
					}
					return;
				}
				var i:uint = 0;
				
				/*
				panel(false,false);
				listPanel_.dataProvider = connExec12.DATA_ARR;
				panel(true,true);
				*/
				listElement.dataProvider = connExec12.DATA_ARR;
				amfPhpElement.DATA_ARR   = connExec12.DATA_ARR;
				amfPhpElement.DATA_ARR.refresh();
				
				/*
				for(i=0;i<_connExec.DATA_ROWS;i++)
				FINANCIAL_.dataProvider.addItem(connExec12.DATA_ARR.getItemAt(i));
				
				_financial.DATA_ARR = new ArrayCollection(FINANCIAL_.dataProvider.toArray());
				_financial.DATA_ARR.refresh();
				
				//_financial.DATA_ARR.addAll(connExec12.DATA_ARR);
				//_financial.DATA_ARR.refresh();
				*/
				
				gnncScrollPosition.__setEnd(listElement as List);
				
				connectionsTimes = connectionsTimes-1;
				if(connectionsTimes<1){
					if(functionLoading!=null)
						functionLoading.call([false]);
					loading(false);
				}
			}
			
			//adiciona no final da linha o que foi gravado no banco
			function __fResult_3(e:*):void
			{
				gnncGlobalLog.__add(connectionsTimes,'connTimes3 ('+connExec13.DATA_ROWS+')');
				if(connExec13.DATA_ROWS==0){
					connectionsTimes = connectionsTimes-1;
					if(connectionsTimes<1){
						if(functionLoading!=null)
							functionLoading.call([false]);
						loading(false);
					}
					return;
				}
				var i:uint = 0;
				
				for(i=0;i<connExec13.DATA_ROWS;i++)
					listElement.dataProvider.addItem(connExec13.DATA_ARR.getItemAt(i));
				
				amfPhpElement.DATA_ARR = new ArrayCollection(listElement.dataProvider.toArray());
				amfPhpElement.DATA_ARR.refresh();
				
				//_financial.DATA_ARR.addAll(_connExec.DATA_ARR);
				//_financial.DATA_ARR.refresh();
				
				gnncScrollPosition.__setEnd(listElement as List);
				
				connectionsTimes = connectionsTimes-1;
				if(connectionsTimes<1){
					if(functionLoading!=null)
						functionLoading.call([false]);
					loading(false);
				}
			}
			
			function __fFault(e:*):void
			{
				connectionsTimes = connectionsTimes-1;
				if(connectionsTimes==0){
					if(functionLoading!=null)
						functionLoading.call([false]);
					loading(false);
				}
			}
			
			return listElement as List;
		}

		/**
		 * 
		 * getColumns('fin',['ID','NAME','MIX'])
		 * 
		 * **/
		public function getColumns(prefix:String,columns:Array=null):void
		{
			if(prefix){
				sqlColumnsPredix = prefix+'.';
			}else if(tableObject){
				sqlColumnsPredix = 'dbd_'+String(tableObject._TABLE).toLowerCase()+'.';
			}else if(tableObject==null){
				//gnncAlert.__alert('Defina a tabela','Defina a tabela em "gnncUpdateItemList.tableObject = new table()" ');
			}
			
			if(columns){
				var i:uint = 0;
				var arr:Array = new Array();
				var len:uint = columns.length;
				for(i=0;i<len;i++){
					arr.push(sqlColumnsPredix+columns[i]);
				}
				sqlColumns = arr;
			}

			var col:Array = [
				sqlColumnsPredix+"*"
			];
			sqlColumns = col;
		}

		private var timeLoading:gnncTime = new gnncTime();
		private function loading(show:Boolean=true):void
		{
			if(show){
				timeLoading.__start(45000,function(e:*=null):void{ loading(false) },1); //35000 = 35seg
			}else{
				timeLoading.__stop();
				if(functionComplete!=null)
					functionComplete.call();
			}
			
			listElement.enabled = !show;
		}

		
	}
}