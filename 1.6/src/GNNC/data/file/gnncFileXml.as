package GNNC.data.file
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncLoading.gnncLoading;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.data.gnncDataXml;
	import GNNC.data.globals.gnncGlobalArrays;
	import GNNC.data.globals.gnncGlobalStatic;

	public class gnncFileXml
	{
		//[Bindable] 
		public var DATA_XML:XML 				= new XML();
		public var TRY:Boolean 					= false;
		
		public  var _noCacheFile:Boolean		= false;
		public  var _allowGlobalError:Boolean 	= true;
		
		private var _parent:Object				= null;
		private var _params:Object				= null;
		private var _urlFileNameXml:String		= '';
		private var _fileLoader:URLLoader		= null;
		private var _fileRequest:URLRequest		= null;
		private	var _filePathServer:String		= gnncGlobalArrays.serverPathXML; // '/services/files/filesXml/' // '/services/XML_FILES/'
		private var _fileExtension:String		= '.php';
		
		private var _percent:Number				= 0;

		public function gnncFileXml(parentApplication_:Object = null,TRY_:Boolean = false)
		{
			_parent 							= parentApplication_;
			TRY									= TRY_;
		}
		
		public function __load(fileNameXml_or_Url_:String='fileXmlTrial',thisXmlFilesDaybyday_:Boolean=true,paramsNamesAndValues_:Object=null,AFTER_Event_:Function=null,AFTER_IOErrorEvent_:Function=null,method_:String='POST',loading_:Boolean=true):void
		{
			_urlFileNameXml 					= (thisXmlFilesDaybyday_) ? gnncGlobalStatic._httpHost + _filePathServer + fileNameXml_or_Url_ + _fileExtension : fileNameXml_or_Url_ ;
			_params								= paramsNamesAndValues_ ? paramsNamesAndValues_ : new Object();

			_fileLoader			 				= new URLLoader();
			__dispatcher						(_fileLoader);

			_fileRequest 						= new URLRequest(_noCacheFile ? _urlFileNameXml + '?' + Math.random() : _urlFileNameXml);
			_fileRequest.data					= gnncDataObject.__object2URLVariables(_params);
			_fileRequest.method 				= method_;
			
			/*
			if(POST_PARAMS_NAME_ && POST_PARAMS_VALUE_ && POST_PARAMS_NAME_.length == POST_PARAMS_VALUE_.length)
				for(var i:uint=0;i<POST_PARAMS_NAME_.length;i++)
					request.data[POST_PARAMS_NAME_[i]] = POST_PARAMS_VALUE_[i];
			*/

			try 
			{
				_fileLoader.load(_fileRequest);
			} 
			catch (error:Error) 
			{
				__handleIOErrorEvent();
			}

			if(AFTER_Event_ != null) 				_fileLoader.addEventListener(Event.COMPLETE,			AFTER_Event_		,false);
			if(AFTER_IOErrorEvent_ != null) 		_fileLoader.addEventListener(IOErrorEvent.IO_ERROR, 	AFTER_IOErrorEvent_	,false);	
		}

		private function __dispatcher(dispatcher:IEventDispatcher):void 
		{
			dispatcher.addEventListener(Event.COMPLETE,			__handleEventComplete);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR,	__handleIOErrorEvent);
			dispatcher.addEventListener(ProgressEvent.PROGRESS,	__handleProgress);
		}

		private function __handleProgress(event:ProgressEvent):void
		{
			/*
			PERCENT	= Math.round((Number(event.bytesLoaded) / Number(event.bytesTotal)) * 100);
			
			if(!OK)
			{
				PAGE = new PAGE_LOADING();
				PopUpManager.addPopUp(PAGE,_parent as DisplayObject,true);
				OK = true;
			}
			
			PAGE._TEXT_LOADING = 'Download...' + PERCENT + '%';
			PopUpManager.centerPopUp(PAGE);
			*/
		}

		private function __handleEventComplete(event:Event):void
		{ 
			var loader:URLLoader 		= URLLoader(event.target);
			
			DATA_XML 					= new XML(loader.data);
			
			if(!gnncDataXml.__isValidXML(loader.data) && _allowGlobalError) //Verifica se não existe uma autenticação de acesso a internet.
				new gnncAlert().__error("Problema no arquivo XML carregado.\n\n" + String(loader.data).substr(0,20),'Erro <?xml ... ?>');
		}

		private function __handleIOErrorEvent(event:*=null):void //IOErrorEvent
		{
			if(_allowGlobalError)
				new gnncAlert().__error("Falha ao tentar carregar o arquivo.");
		}

	}
}


/**

	package com.DAYBYDAY
	{
	import gNial.COMPONENTS.ALERT.*;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.*;
	
	import mx.controls.ProgressBar;
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	
	[Bindable]
	dynamic public class XML_CLASS extends Sprite 
	{
	
	public var MYXML:XML;
	public var TRY:Boolean 					= false;
	protected var NAME:String 				= 'CLASS';
	protected var PARAMS:URLVariables;
	public var PROGRESS:ProgressBar = new ProgressBar(); 
	
	public function XML_CLASS() 
	{
}

public function DATA_GO(PARAMS:URLVariables,WHY:String):void 
{
	var loader:URLLoader 		= new URLLoader();
	configureListeners			(loader,WHY);
	
	var PREFIX:String 			= '';
	switch(WHY){
		case 'GET': PREFIX 		= 'XML'; break;
		case 'SET': PREFIX 		= 'PHP'; break;
	}
	
	var request:URLRequest 		= new URLRequest(FlexGlobals.topLevelApplication.MYGLOBAL.HTTPHOST+PREFIX+'-'+WHY+'-'+NAME+'.php?' + Math.random());
	
	PARAMS.KEY 					= FlexGlobals.topLevelApplication.MYGLOBAL.KEY;
	PARAMS.DATABASE 			= FlexGlobals.topLevelApplication.MYGLOBAL.DATABASE;
	PARAMS.SISTEMAIDGERAL 		= FlexGlobals.topLevelApplication.MYGLOBAL.SISTEMAIDGERAL;
	PARAMS.CLIENTEIDGERAL 		= FlexGlobals.topLevelApplication.MYGLOBAL.CLIENTEIDGERAL;
	PARAMS.USUARIOIDGERAL 		= FlexGlobals.topLevelApplication.MYGLOBAL.USUARIOIDGERAL;
	
	request.data 				= PARAMS;
	request.method 				= URLRequestMethod.POST;
	if(TRY) FlexGlobals.topLevelApplication._ALERT.aviso('URL: ' + request.url.toString());
	try {
		loader.load				(request);
	} catch (error:Error) {
		new DAYBYDAY_ALERT._ERROR(null,NAME + '... Falha ao corregar o arquivo.');
	}
	
}

private function configureListeners(dispatcher:IEventDispatcher,WHY:String):void 
{
	switch(WHY)
	{
		case 'GET': dispatcher.addEventListener(Event.COMPLETE,COMPLETE_GET); break;
		case 'SET': dispatcher.addEventListener(Event.COMPLETE,COMPLETE_SET); break;
	}
	if(TRY) dispatcher.addEventListener(Event.OPEN,openHandler);
	dispatcher.addEventListener(ProgressEvent.PROGRESS,progressHandler);
	dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
	//dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);
	dispatcher.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
}

private function COMPLETE_GET(event:Event):void 
{
	var loader:URLLoader 		= URLLoader(event.target);
	var GETXML:XML 				= new XML(loader.data);
	MYXML 						= GETXML;
	if(TRY) FlexGlobals.topLevelApplication._ALERT.aviso('XML in XMLString: ' + GETXML.toXMLString());
	if(TRY) FlexGlobals.topLevelApplication._ALERT.aviso('XML in String: ' + GETXML.toString());
	AFTER_GET();
	progressRemove();
}

private function COMPLETE_SET(event:Event):void 
{
	var loader:URLLoader 		= URLLoader(event.target);
	var GETXML:String 			= loader.data as String;
	if(GETXML == 'ok'){
		FlexGlobals.topLevelApplication._ALERT.aviso('Operação realizada com sucesso!');
		AFTER_SET();
		progressRemove();
	}else{
		FlexGlobals.topLevelApplication._ALERT.aviso('Erro no servidor: ' + GETXML);
	}
}
dynamic internal function AFTER_SET():void 
{
}
dynamic internal function AFTER_GET():void 
{
}

private function openHandler(event:Event):void 
{
}

private function progressHandler(event:ProgressEvent):void 
{
	var PERCENT:Number		= Math.round((Number(event.bytesLoaded) / Number(event.bytesTotal)) * 100);
	PROGRESS.label			= NAME + ' ( '+event.bytesLoaded+' bytes )' + ' ...carregando... '+ PERCENT +'%'
	PROGRESS.percentWidth	= 100;
	PROGRESS.setStyle		('color','#FFFFFF');
	PROGRESS.mode			= 'manual';
	//PROGRESS.indeterminate	= true;
	PROGRESS.labelPlacement = 'top';
	PROGRESS.setProgress	(PERCENT, 100);
	PROGRESS.addEventListener(FlexEvent.HIDE,  function():void{_ALERT.ALERT('a')});
	PROGRESS.addEventListener(FlexEvent.HIDE,  function():void{_ALERT.ALERT('a')});
	FlexGlobals.topLevelApplication.PROG.addElement(PROGRESS);
	
	new DAYBYDAY_ALERT._ERROR(null,NAME + ' : ' + event.bytesLoaded + '/' + event.bytesTotal + ' = ' + Math.round((Number(event.bytesLoaded) / Number(event.bytesTotal)) * 100) + '%');
}

private function progressRemove():void
{
	PROGRESS.deleteReferenceOnParentDocument(FlexGlobals.topLevelApplication.PROG);
}

private function httpStatusHandler(event:HTTPStatusEvent):void 
{
	new DAYBYDAY_ALERT._ERROR(null,NAME + '... Status: ' + event);
	progressRemove();
}

private function securityErrorHandler(event:SecurityErrorEvent):void 
{
	new DAYBYDAY_ALERT._ERROR(null,NAME + '... Protocolo inseguro.');
	progressRemove();
}

private function ioErrorHandler(event:IOErrorEvent):void 
{
	new DAYBYDAY_ALERT._ERROR(null,NAME + '... Problema ao carregar o arquivo.');
	progressRemove();
}
	
}
}
**/