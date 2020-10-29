package GNNC.elements.component.list
{
	import GNNC.UI.components.componentLoadingBoxText;
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncList.gnncList;
	import GNNC.UI.gnncNotification.gnncNotification;
	import GNNC.UI.gnncPopUp.gnncPopUp;
	import GNNC.data.conn.gnncAMFPhp;
	import GNNC.data.data.gnncClipBoard;
	import GNNC.data.data.gnncData;
	import GNNC.data.data.gnncDataArrayCollection;
	import GNNC.data.data.gnncDataObject;
	import GNNC.data.date.gnncDate;
	import GNNC.data.file.gnncFilesRemote;
	import GNNC.data.globals.gnncGlobalStatic;
	import GNNC.data.permission.gnncPermission;
	import GNNC.data.sql.gnncSql;
	import GNNC.event.gnncCloseEvent;
	import GNNC.event.gnncEventGeneral;
	import GNNC.keyboard.gnncKeyboard;
	import GNNC.others.gnncFocus;
	import GNNC.sqlTables.table_star;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	import spark.layouts.ColumnAlign;
	import spark.layouts.TileLayout;
	import spark.layouts.TileOrientation;
	import spark.layouts.VerticalLayout;
	import spark.primitives.Rect;
	import spark.primitives.RectangularDropShadow;
	import spark.skins.spark.DefaultItemRenderer;
	
	public dynamic class conList_class extends Group
	{
		private var _parent:Object = null;
		
		public function conList_class(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
			
			__creationList();
			__creationLabel();
			
			callLater(__start);
		}
		
		/** 
		 * ################################################################ 
		 * var General to Change
		 * ################################################################ 
		 * **/
		
		public var _name:String 					= 'nameSimple'; //Sample: Job, Comment, Financial
		
		public var _itemRenderList:Class			= null;
		public var _itemRenderBox:Class				= null;
		public var _itemRenderListClear:Class		= null;
		public var _itemRenderBoxClear:Class		= null;
		
		public var _tableClass:Object				= null;
		public var _tableClassName:String			= '_tableClass'; //Or sample: Attach, Comment, Job, Client
		public var _tableClassMix:String			= '_MIX';
		
		/** 
		 * ################################################################ 
		 * **/
		
		/** Library GNNC **/
		public var _connList:gnncAMFPhp 			= new gnncAMFPhp();
		public var _connExec:gnncAMFPhp 			= new gnncAMFPhp();
		private var _gnncPopUp:gnncPopUp			= new gnncPopUp();
		
		/**
		 * Sample:
		 * {
		 *   label:'Visualizar',
		 *   enabled:_view,
		 *   separator:true,
		 *   visible:true,
		 *   dispatchEvent:gnncEventGeneral._view,
		 *   fName:__fView
		 * }
		 * */
		public var _contextMenuItems:ArrayCollection	= new ArrayCollection();
		public var _contextMenu:ContextMenu				= new ContextMenu();
		
		/** Obj, Index and Arr **/
		/*
		protected var selectedItem:Object	= null;
		protected var selectedIndex:int 		= -1;
		protected var IDXARRA:int 		= -1;
		*/
		
		/** Menu Context **/
		public var _view:Boolean 					= true;
		public var _new:Boolean 					= true;
		public var _edit:Boolean 					= true;
		public var _delete:Boolean 					= true;
		public var _refresh:Boolean 				= true;
		public var _copy:Boolean 					= true;
		
		/** Sql **/
		public var _sqlConsult:String               = '';
		public var _sqlConsultPrivate:String 		= '';
		public var _sqlOrderBy:Array				= ['ID'];
		public var _sqlWhere:Array					= null;
		public var _sqlOrderDesc:Boolean			= true;
		public var _sqlLimit:Array					= null;
		public var _sqlColumns:Array				= ['*'];
		public var _sqlShow:Boolean					= false;
		
		/** Items **/
		public var _selectFirstItem:Boolean 		= false;
		//public var _selectAutoAloneItem:Boolean = true;
		public var _scrollToEndInList:Boolean		= false;
		
		/** Keyboard Up, Down, Right, Enter... **/
		public var _allowKeyboardInList:Boolean		= true;
		
		/** Allow id duplicate in list **/
		public var _allowDuplicatePropertyId:Boolean = true;
		
		/** Events stop propagation **/
		public var _stopPropagation:Boolean			= false;
		
		/** After event change while close popUp Update Item or List  **/
		public var _afterChangeEventUpdateOnlyItem:Boolean = true;
		
		[Bindable] 
		public var _length:uint 					= 0;
		
		/** virtual layout **/
		public var list_:gnncList;
		public var labelLoading_:Label;
		public var backgLoading_:Rect;
		public var shadowLoading_:RectangularDropShadow;
		public var page:Object;
		
		public function stopAll():void
		{
			_connExec.__destroy();
			_connList.__destroy();
			//stopAllMovieClips();
		}

		public function set dataProviderArrayC(v:ArrayCollection):void 	{ list_.dataProvider = v; /* try */ _connList.DATA_ARR = v;	}
		public function get dataProviderArrayC():ArrayCollection 		{ return new ArrayCollection(list_.dataProvider.toArray())	}
		
		public function set dataProvider(v:IList):void 					{ list_.dataProvider = v as IList ; /* try */ _connList.DATA_ARR = new ArrayCollection(v.toArray());	}
		public function get dataProvider():IList 						{ return list_.dataProvider as IList 						}
		
		public function set selectedItems(v:Vector.<Object>):void   { list_.selectedItems = v }
		public function get selectedItems():Vector.<Object> 		{ return list_.selectedItems }
		
		public function set selectedItem(v:Object):void 			{ list_.selectedItem = v 								}
		public function get selectedItem():Object 					{ return !selected ? new Object() : !_length ? new Object() : list_.selectedItem }
		
		public function set selectedIndex(v:int):void 				{ list_.selectedIndex = v 							 	}
		public function get selectedIndex():int 					{ return list_.selectedIndex 							}
		
		public function get selectedItemslength():uint 				{ return !selected ? 0 : list_.selectedItems.length; }
		
		public function get selected():Boolean 						{ return selectedIndex < 0 ? false : true				}
		
		public function set _allowMultipleSelection(v:Boolean):void { list_.allowMultipleSelection = v 						}
		public function get _allowMultipleSelection():Boolean		{ return list_.allowMultipleSelection 					}
		
		public function set _dragEnabled(v:Boolean):void 			{ __dragEnabled(v) 										}
		public function get _dragEnabled():Boolean 					{ return __dragEnabled(list_.dragEnabled) 				}
		
		public function set _dragMoveEnabled(v:Boolean):void 		{ __dragMoveEnabled(v) 									}
		public function get _dragMoveEnabled():Boolean 				{ return __dragMoveEnabled(list_.dragMoveEnabled) 		}
		
		public function set _dropEnabled(v:Boolean):void 			{ __dropEnabled(v) 										}
		public function get _dropEnabled():Boolean 					{ return __dropEnabled(list_.dropEnabled) 				}
		
		public function set _borderVisible(v:Boolean):void 			{ list_.setStyle('borderVisible',v) 					}
		public function set _borderColor(v:uint):void 				{ list_.setStyle('borderColor',v) 						}
		public function set _backgroundAlpha(v:Number):void 		{ list_.setStyle('contentBackgroundAlpha',v) 			}
		public function set _backgroundColor(v:uint):void 			{ list_.setStyle('contentBackgroundColor',v)			}
		
		/** 
		 * 
		 * _itemRenderList
		 * _itemRenderBox
		 * _itemRenderListClear
		 * _itemRenderBoxClear
		 * 
		 * **/
		public function set itemRenderIndex(v:uint):void 			{ __itemRenderIndex(v) 									}
		public function set itemRenderClass(v:Class):void 			{ __itemRenderClass(v) 									}
		
		public function set value(value_:uint)						:void{ __selectId(value_) }
		public function get value()									:uint{ return list_.selectedIndex < 0 ? 0 : list_.dataProvider.getItemAt(list_.selectedIndex).ID }
		
		public function set _autoLoad(v:Boolean):void 				{ if(!v) return; __configSql(); __select(); 	}
		public function set _autoLoadStar(v:Boolean):void 			{ if(!v) return; __configSql(); __selectStar(); }
		
		/** Events **/
		
		public var _change:Boolean = false;
		
		public function set _changeEvent(v:Function):void 
		{
			if(v == null) return;
			//list_.addEventListener(IndexChangeEvent.CHANGE,v); 		//dont work
			//list_.addEventListener(IndexChangeEvent.CARET_CHANGE,v); 	//work but problem (very fast or faster)
			list_.addEventListener(FlexEvent.UPDATE_COMPLETE,v);		//work
		}
		
		/**
		 * Fast. First Execution
		 * **/
		public function set _changeIndexCaretEvent(v:Function):void 
		{
			if(v == null) return;
			list_.addEventListener(IndexChangeEvent.CARET_CHANGE,v); 	//work but problem (very fast or faster)
		}
		
		private function __removeItemsInList(allowMultiSelection_:Boolean=true):void
		{ 
			if(!_length || !selected)
				return;
			
			var _sel:Vector.<Object> = list_.selectedItems;
			var _len:uint = _sel.length
			var _i:uint	  = 0;
			
			__loading(true);
			
			if(!_len)
				return;
			
			//@removeItemAt
			if(_len > 1)
			{
				if(allowMultiSelection_)
				{
					for( _i = 0; _i < _len; _i++ )
						list_.dataProvider.removeItemAt( list_.dataProvider.getItemIndex( _sel[_i] ) );
				}
			}
			else
			{
				if(_len)
					list_.dataProvider.removeItemAt(selectedIndex);
			}
			
			list_.validateDisplayList();
			list_.validateNow();
			
			__loading(false);
		}
		
		public function set _removeItemEvent(v:Function):void 
		{
			if(v == null) return;
			
			//set event external function
			list_.addEventListener(gnncEventGeneral._removeItemList+'EventExternal',v);
		}
		
		public function removeItemAt(v:int):void
		{ 
			if(v < 0) return;
			
			selectedIndex = v;
			
			//@removeItemAt
			__removeItemsInList(false);
			
			//dispatch event external
			list_.dispatchEvent(new gnncEventGeneral(gnncEventGeneral._removeItemList+'EventExternal'));
		}
		
		private function __start():void
		{
			__config();
			__contextMenuModel();
			__dispatchEvent();
			
			callLater(__configSql);
		}
		
		private function __config():void
		{
			if(_tableClass==null)
			{
				new gnncNotification().__show('Problema','Não está defino a class de acesso.',null,null,false);
				return
			}
			else
			{
				if(_tableClassName == '_tableClass')
					if(_tableClass.hasOwnProperty('_TABLE'))
						_tableClassName = '_TABLE_'+_tableClass['_TABLE']; //'_TABLE_ATTACH'
			}
			
		}
		
		public function __configSql(e:*=null):void
		{
			//add params sql to refresh in all consult/select
		}
		
		public function __creationList():void
		{
			list_ 					= new gnncList();
			list_.dataProvider 		= new ArrayCollection();
			list_.percentWidth 		= 100;
			list_.percentHeight 	= 100;
			
			list_._contextMenuItems	= _contextMenuItems;
			list_._contextMenu		= _contextMenu;
			
			list_.setStyle			('focusAlpha',0);
			list_.setStyle			('borderVisible',false);
			list_.setStyle			('borderColor',0x999999);
			list_.setStyle			('contentBackgroundAlpha',1);
			list_.setStyle			('contentBackgroundColor',0xFFFFFF);
			list_.setStyle			('horizontalScrollPolicy','off');
			
			__itemRenderIndex(0);
			
			addElement(list_);
		}
		
		public function __layoutVertical(height_:Number=0,gap_:uint=0,
										 paddingTop:uint=0,paddingRight:uint=0,paddingBottom:uint=0,paddingLeft:uint=0):void
		{
			var _vLay:VerticalLayout = new VerticalLayout();
			
			if(height_)
				_vLay.rowHeight		= height_;
			
			_vLay.gap 				= gap_;
			
			_vLay.paddingLeft 		= paddingLeft;
			_vLay.paddingBottom 	= paddingBottom;
			_vLay.paddingRight 		= paddingRight;
			_vLay.paddingTop 		= paddingTop;
			
			list_.layout 			= _vLay;
		}
		
		public function __layoutTile(width_:Number=200,height_:Number=100,vGap_:uint=2,hGap_:uint=2,padding_:Array=null):void
		{
			var _tLay:TileLayout 	= new TileLayout();
			
			_tLay.columnWidth 		= width_;
			_tLay.rowHeight 		= height_;
			
			_tLay.horizontalGap 	= hGap_;
			_tLay.verticalGap 		= vGap_;
			
			_tLay.columnAlign 		= ColumnAlign.JUSTIFY_USING_WIDTH;
			_tLay.orientation 		= TileOrientation.ROWS;
			
			if(padding_ == null)
			{
				padding_ = new Array(5,5,5,5);
			}
			else if(padding_.length < 4)
			{
				var v:Number		= padding_[0];
				padding_.push		(v);
				padding_.push		(v);
				padding_.push		(v);
			}
			
			_tLay.paddingLeft 		= padding_[0];
			_tLay.paddingBottom 	= padding_[1];
			_tLay.paddingRight 		= padding_[2];
			_tLay.paddingTop 		= padding_[3];
			
			list_.layout 			= _tLay;
		}
		
		private function __classFactory(itemRender_:Class=null):void
		{
			list_.itemRenderer 		= new ClassFactory( itemRender_ != null ? itemRender_ : _itemRenderList != null ? _itemRenderList : DefaultItemRenderer );
		}
		
		private function __itemRenderIndex(value_:uint):void
		{
			switch(value_)
			{
				case 0:  __classFactory(_itemRenderList);		__layoutVertical(); break;
				case 1:  __classFactory(_itemRenderBox);		__layoutTile(); 	break;
				case 2:  __classFactory(_itemRenderListClear);	__layoutVertical(); break;
				case 3:  __classFactory(_itemRenderBoxClear);	__layoutTile(); 	break;
				default: __classFactory();
			}
			
		}
		
		private function __itemRenderClass(itemRender_:Class):void
		{
			__classFactory(itemRender_);
		}
		
		public function __itemUpdate(property_:String,value_:Object,index_:int=-2):void
		{
			if(!property_)
				return;
			
			if(index_ < -1)
				index_ = selectedIndex;
			
			if(index_ < 0)
				return;
			
			var _obj:Object = list_.dataProvider.getItemAt(index_);
			_obj[property_] = value_;
			
			list_.dataProvider.setItemAt(_obj,index_);
			//list_.selectedItem[property_] = value_;
			//list_.validateDisplayList();
			//list_.validateNow();
		}
		
		public function __itemUpdateObject(object_:Object,value_:Object,index_:int=-2):void
		{
			if(!object_)
				return;
			
			if(index_ < -1)
				index_ = selectedIndex;
			
			if(index_ < 0)
				return;
			
			var _obj:Object 				= list_.dataProvider.getItemAt(index_);
			var _objNamesAndValue:Array 	= gnncDataObject.__getPropertysNames(object_,'',true);
			var _i:uint 					= 0;
			
			for(_i=0;_i<_objNamesAndValue.length;_i++)
			{
				_obj[_objNamesAndValue[_i]] = _objNamesAndValue[(_i+1)];
				_i++;
			}
			
			list_.dataProvider.setItemAt(_obj,index_);
		}
		
		protected function __removeItemList(e:*):void
		{
			if(!_length || !selected)
				return;
			
			//@removeItemAt
			removeItemAt(selectedIndex);
		}
		
		public function __filterBy(value_:Object,propertyArray_:Array=null):void
		{
			//### Alert ###
			//no set dataProvider function
			//work with list_.dataProvider
			callLater(function():void{
				callLater(function():void{
					callLater(function():void{
						list_.dataProvider = new gnncDataArrayCollection().__filterArray(_connList.DATA_ARR,propertyArray_,value_);
					});
				});
			});
		}
		
		public function __creationLabel():void
		{
			labelLoading_			= new Label();
			
			labelLoading_.text		= 'carregando...';
			labelLoading_.visible	= false;
			labelLoading_.setStyle	('fontWeight'	,'bold');
			labelLoading_.setStyle	('font-weight'	,'bold');
			//labelLoading_.setStyle	('color'		,0xFFFFFF);
			
			labelLoading_.horizontalCenter 	= 0;
			labelLoading_.verticalCenter 	= 0;
			
			backgLoading_			= new Rect();
			backgLoading_.fill		= new SolidColor(0xeeeeee);//0x0084ff
			backgLoading_.width		= 100;
			backgLoading_.height	= 22;
			backgLoading_.radiusX	= 3;
			backgLoading_.visible	= false;
			
			backgLoading_.horizontalCenter 	= 0;
			backgLoading_.verticalCenter 	= 0;
			
			shadowLoading_			= new RectangularDropShadow();
			shadowLoading_.width	= backgLoading_.width;
			shadowLoading_.height	= backgLoading_.height;
			shadowLoading_.blurX 	= 4;
			shadowLoading_.blurY 	= 4;
			shadowLoading_.distance = 0;
			shadowLoading_.visible	= false;
			
			shadowLoading_.horizontalCenter = 0;
			shadowLoading_.verticalCenter 	= 0;
			
			addElement				(shadowLoading_);
			addElement				(backgLoading_);
			addElement				(labelLoading_);
		}
		
		private var load:componentLoadingBoxText = null;
		
		public function __loading(value_:Boolean=true):void
		{
			//shadowLoading_.visible = value_;
			//backgLoading_.visible  = value_;
			//labelLoading_.visible  = value_;
			
			list_.enabled = !value_;
			
			if(value_==true && load==null){
				load = new componentLoadingBoxText();
				addElement(load);
			}else if(value_==false && load!=null){
				removeElement(load);
				callLater(function():void{
					load = null;
				})
			}
		}
		
		private function __dragEnabled(enabled_:Boolean):Boolean
		{
			list_.dragEnabled		= enabled_; 
			return list_.dragEnabled;
		}
		
		private function __dropEnabled(enabled_:Boolean):Boolean
		{
			list_.dropEnabled		= enabled_;
			return list_.dropEnabled;
		}
		
		private function __dragMoveEnabled(enabled_:Boolean):Boolean
		{
			list_.dragMoveEnabled	= enabled_;
			return list_.dragMoveEnabled;
		}
		
		private function __dispatchEvent():void
		{
			//list_.addEventListener(IndexChangeEvent.CARET_CHANGE		,__stopPropagationEvent,false,4);
			
			/*
			this.addEventListener(MouseEvent.MOUSE_DOWN					,__menuRightList);
			this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN			,__menuRightList);
			*/
			
			list_.addEventListener(MouseEvent.MOUSE_DOWN				,__contextMenu);
			list_.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN			,__contextMenu,false,2);
			
			list_.addEventListener(IndexChangeEvent.CHANGE				,__selectedItem,false,3);
			list_.addEventListener(IndexChangeEvent.CARET_CHANGE		,__selectedItem,false,3);
			list_.addEventListener(FlexEvent.DATA_CHANGE				,__selectedItem,false,3);
			list_.addEventListener(FlexEvent.VALUE_COMMIT				,__selectedItem,false,3);
			list_.addEventListener(FlexEvent.UPDATE_COMPLETE			,__selectedItem,false,3);
			
			list_.addEventListener(DragEvent.DRAG_COMPLETE				,__dropComplete);
			list_.addEventListener(DragEvent.DRAG_EXIT					,__dropComplete);
			list_.addEventListener(DragEvent.DRAG_DROP					,__dropComplete);
			list_.addEventListener(DragEvent.DRAG_DROP					,__dropCompleteAndSaveOrder);
			
			list_.addEventListener(gnncEventGeneral._complete			,__null);
			list_.addEventListener(gnncEventGeneral._control			,__null);
			list_.addEventListener(gnncEventGeneral._delete 			,__null);
			list_.addEventListener(gnncEventGeneral._edit  				,__null);
			list_.addEventListener(gnncEventGeneral._error				,__null);
			list_.addEventListener(gnncEventGeneral._free				,__null);
			list_.addEventListener(gnncEventGeneral._loading			,__null);
			list_.addEventListener(gnncEventGeneral._rightMouseUp		,__null);
			list_.addEventListener(gnncEventGeneral._rightMouseDown		,__contextMenu,false,2);
			list_.addEventListener(gnncEventGeneral._rightMouseClick	,__null);
			list_.addEventListener(gnncEventGeneral._mouseDoubleClick	,__fView);
			list_.addEventListener(gnncEventGeneral._mouseClick			,__null);
			list_.addEventListener(gnncEventGeneral._mouseDown			,__null);
			list_.addEventListener(gnncEventGeneral._mouseUp			,__null);
			list_.addEventListener(gnncEventGeneral._selectItem			,__selectedItem);
			list_.addEventListener(gnncEventGeneral._new				,__null);
			list_.addEventListener(gnncEventGeneral._paste				,__null);
			list_.addEventListener(gnncEventGeneral._refresh			,__fRefresh);
			list_.addEventListener(gnncEventGeneral._removeItemList		,__removeItemList);
			list_.addEventListener(gnncEventGeneral._update				,__null);
			list_.addEventListener(gnncEventGeneral._free				,__null);
			list_.addEventListener(gnncEventGeneral._star				,__fStar);
			list_.addEventListener(gnncEventGeneral._dateFinalAuto		,__fDateFinal);
			list_.addEventListener(gnncEventGeneral._dateCanceledAuto	,__fDateCanceled);
			
			list_.addEventListener(gnncEventGeneral._hierarchyPrevLevel	,__fHierarchyPrevLevel);
			list_.addEventListener(gnncEventGeneral._hierarchyNextLevel	,__fHierarchyNextLevel);
			
			list_.addEventListener(KeyboardEvent.KEY_DOWN				,__keyboardEventDown);
			list_.addEventListener(KeyboardEvent.KEY_UP					,__null);
			
			if(!_allowKeyboardInList)
			{
				list_.addEventListener(KeyboardEvent.KEY_UP				,__stopKeyboardEvent,false,1);
				list_.addEventListener(KeyboardEvent.KEY_DOWN			,__stopKeyboardEvent,false,1);
			}
		}
		
		private function __stopKeyboardEvent(e:KeyboardEvent=null):void
		{
			e.stopImmediatePropagation();
			e.stopPropagation();
			return;
		}
		
		private function __keyboardEventDown(e:KeyboardEvent=null):void
		{
			if(_stopPropagation)
				return;
			
			if(!_allowMultipleSelection)
				return;
			
			if(gnncKeyboard.__controlA(e))
			{
				/** try */
				//list_.selectedIndices
				//list_.selectedItems = new Vector.<Object>[list_.dataProvider];
				
				/** longhand */
				
				var _idx:Vector.<int> = new Vector.<int>();
				var _i:uint = 0;
				
				for(_i = 0; _i < _length; _i++)
					_idx.push(_i);
				
				//_idx.push(1, 3);
				list_.selectedIndices = _idx;
				
				
				/** shorthand */
				//list_.selectedIndices = new <int>[1, 3];
			}
		}
		
		private function __stopPropagationEvent(e:*=null):void
		{
			if(!_stopPropagation)
				return;
			
			e.stopImmediatePropagation();
			e.stopPropagation();
			return;
		}
		
		private function __null(e:*=null):void
		{
		}
		
		private function __selectedItem(e:*=null):void
		{
			if(_stopPropagation)
			{
				__stopPropagationEvent(e);
				return;
			}
			
			if(list_.dataProvider)
				_length = list_.dataProvider.length;
			
			//list_.validateDisplayList();
			//list_.validateNow();
			
			return;
			
			if( !_length || selectedIndex < 0 )
			{
				this.contextMenu = null;
				
				selectedItem		= null;
				selectedIndex		= -1;
				return;
			}
			
			selectedItem			= list_.selectedItem;
			selectedIndex			= list_.selectedIndex;
		}
		
		private function __dropComplete(e:*=null):void
		{
			_length = list_.dataProvider.length;
			
			if(!_allowDuplicatePropertyId)
				callLater(__fFilterDuplicateProperty,['ID']);
		}
		
		private function __dropCompleteAndSaveOrder(e:*=null):void
		{
			callLater(__fSaveOrder);
		}
		
		public function __contextMenuModel():void
		{
			/*
			if(_menuContext.hasOwnProperty('length'))
			if(_menuContext.length)
			return;
			*/
			
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._view, 		fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._new, 		fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._edit, 		fName:__fEdit	},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._delete, 	fName:__fDelete	},
					{label:'Atualizar',		enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._refresh, 	fName:__fRefresh},
					{label:'Copiar',		enabled:_copy,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._copy, 		fName:__fCopy	}
				]
			);
			
		}
		
		private function __contextMenu(e:*=null):void
		{
			if(!_length || !selected)
				return;
			
			if(!_contextMenuItems)
				return;
			
			if(!_contextMenuItems.length)
				return;
			
			var _i:uint;
			var _menuArray:Array 		= new Array();
			var cm:ContextMenu 			= new ContextMenu();
			var j:ContextMenuItem		= null;
			var fMenu:String			= '';
			
			/*
			_menuContextFirst
			fMenu = 
			selectedItem.hasOwnProperty('FILE_LINK') 	? selectedItem.NAME.substr(0,15) + '...' + ' (' + selectedItem.EXTENSION + ')':
			selectedItem.hasOwnProperty('NAME') 		? selectedItem.NAME.substr(0,15) + '...' : 
			selectedItem.hasOwnProperty('TITLE') 		? selectedItem.TITLE.substr(0,15) + '...' : '---';
			
			_menuArray.push			(new ContextMenuItem(fMenu,false,false,true));
			*/
			
			_contextMenuItems = new ArrayCollection(
				[
					{label:'Visualizar',	enabled:_view,		separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._view, 		fName:__fView	},
					{label:'Novo',			enabled:_new,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._new, 		fName:__fNew	},
					{label:'Editar',		enabled:_edit,		separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._edit, 		fName:__fEdit	},
					{label:'Excluir',		enabled:_delete,	separator:false,	visible:true,	dispatchEvent:gnncEventGeneral._delete, 	fName:__fDelete	},
					{label:'Atualizar',		enabled:_refresh,	separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._refresh, 	fName:__fRefresh},
					{label:'Copiar',		enabled:_copy,		separator:true,		visible:true,	dispatchEvent:gnncEventGeneral._copy, 		fName:__fCopy	}
				]
			);

			
			for(_i=0; _i<_contextMenuItems.length; _i++) 
			{
				var o:Object 			= _contextMenuItems.getItemAt(_i);
				j						= new ContextMenuItem(o.label,o.separator,o.enabled,o.visible);
				
				if(o.fName != null)
					j.addEventListener	(Event.SELECT,o.fName);
				else
					j.addEventListener	(Event.SELECT,function(e:*):void{ Object(owner).dispatchEvent(new gnncEventGeneral(o.dispatchEvent)) });
				
				_menuArray.push			(j);
			}
			
			cm.hideBuiltInItems			();
			cm.customItems 				= _menuArray;
			
			//this.contextMenu			= cm;
			list_._contextMenuItems		= _contextMenuItems;
			list_._contextMenu			= cm;
		}
		
		public function __fView(event:*=null,fRemove_:Function=null):void
		{
			if(!_length || !selected)
				return;
			
			function __fRemove(e:*):void
			{ 
				__afterChangeEvent(page);
			}
			
			if(__pageView()==null)
				return;
			
			page = __pageView() as IFlexDisplayObject;
			
			new gnncPopUp(_parent).__creation(page as IFlexDisplayObject,true,false,fRemove_!=null?fRemove_:__fRemove);
		}
		
		public function __pageView():Object
		{
			return new Object();
		}
		
		public function __fNew(event:*=null,fRemove_:Function=null):void
		{
			function __fRemove(e:*):void{
				_change = true;
				__afterChangeEvent(page);
			}
			
			if(__pageNew()==null)
				return;

			page = __pageNew() as IFlexDisplayObject;
			
			new gnncPopUp(_parent).__creation(page as IFlexDisplayObject,true,false,fRemove_!=null?fRemove_:__fRemove);
		}
		
		public function __pageNew():Object
		{
			return new Object();
		}
		
		public function __fEdit(event:*=null,fRemove_:Function=null):void
		{
			if(!_length || !selected)
				return;
			
			if( 
				_tableClass._TABLE == 'COMMENT' && 
				gnncGlobalStatic._userId != selectedItem.ID_USER/* ||
				gnncGlobalStatic._userIdClient != selectedItem.ID_CLIENT*/
			){
				gnncPermission.__alert();
				return;
			}
			
			function __fRemove(e:*):void
			{ 
				_change = true;
				__afterChangeEvent(page);
			}

			if(__pageEdit()==null)
				return;

			page = __pageEdit() as IFlexDisplayObject;
			
			new gnncPopUp(_parent).__creation(page as IFlexDisplayObject,true,false,fRemove_!=null?fRemove_:__fRemove);
		}
		
		public function __pageEdit():Object
		{
			return new Object();
		}
		
		public function __fDelete(event:*=null):void
		{
			if(!_length || !selected)
				return;
			
			if(selectedItemslength > 1){
				new gnncAlert().__alert('Não é possível excluir mais de um item.');
				return;
			}
			
			if( 
				_tableClass._TABLE == 'COMMENT' && 
				gnncGlobalStatic._userId != selectedItem.ID_USER/* ||
				gnncGlobalStatic._userIdClient != selectedItem.ID_CLIENT*/
			){
				gnncPermission.__alert();
				return;
			}

			gnncAlert.__delete("Você deseja excluir este item definitivamente?",'Excluir',__closeAlert,[gnncAlert.YES,gnncAlert.CANCEL]);
		}
		
		private function __closeAlert(event:gnncCloseEvent):void
		{
			if(event.detail != gnncAlert.YES)
				return;
			
			_gnncPopUp.__loading('Excluindo...');
			
			function __fFault(e:*):void
			{ 
				_gnncPopUp.__close();
			}
			
			function __fResult(e:*):void
			{ 
				_change = true;
				if(selectedItem.hasOwnProperty('FILE_LINK'))
					__removeFile(String(selectedItem.FILE_LINK));
				
				//@removeItemAt
				removeItemAt(selectedIndex);
				
				//refresh
				__selectedItem();
				
			}
			
			var _sql:String = new gnncSql(null,_sqlShow).__DELETE(gnncData.__clone(_tableClass),[selectedItem.ID],true);
			
			if(_sqlShow)
				new gnncAlert().__alert(_sql,'Sql fDelete');
			
			if(selectedItem.ID)
				_connExec.__sql(_sql,'','',__fResult,__fFault);
		}
		
		private function __removeFile(fileLinkName_:String):void
		{
			var _params:Object 		= new Object();
			_params._fileName		= fileLinkName_;
			_params._dataBaseName	= gnncGlobalStatic._dataBase;
			
			var a:gnncFilesRemote   = new gnncFilesRemote();
			a._allowGlobalError     = false;
			a.__loadUrl				('filePhpUploadDelete',__fResult,__fFault,_params,'POST',true);
			
			function __fFault(e:*):void{ 
				_gnncPopUp.__close();
			}
			
			function __fResult(e:*):void{ 
				_gnncPopUp.__close();
			}
		}
		
		public function __fRefresh(event:Event=null):void
		{
			__select(true);
		}
		
		public function __fCopy(event:Event=null):void
		{
			if(selectedIndex < 0)
				return;
			
			if(selectedItem.hasOwnProperty('FILE_LINK'))
			{
				var _url:String = selectedItem.FILE_HTTP+'ATTACH/'+gnncGlobalStatic._dataBase.toUpperCase()+'/'+selectedItem.FILE_LINK+'?'+Math.random();
				gnncClipBoard.__copyText(_url);
				new gnncNotification().__show('Copiado','A url do arquivo copiada.',null,_url);
			}
			else if (selectedItem.hasOwnProperty('NAME'))
			{
				gnncClipBoard.__copyText(selectedItem['NAME']);
			}
		}
		
		public function __select(refresh_:Boolean=false,fResult_:Function=null,fFault_:Function=null):void
		{
			if(!gnncGlobalStatic._userId)
			{
				callLater(__select,[refresh_]);
				return;
			}
			
			if(!_tableClass)
				return;
			
			//__configSql(); //refresh
			
			function __fFault(event:*):void
			{
				__loading(false);
				
				if(fFault_!=null)
					fFault_.call();
				
				list_.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));

			}
			
			function __fResult(event:*):void
			{			
				dataProvider 		= _connList.DATA_ARR;
				
				__loading(false);
				
				if(fResult_!=null)
					fResult_.call();
				
				if(_selectFirstItem && _length)
				{
					list_.selectedIndex = 0;
					gnncFocus.__set(list_);
				}

				list_.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));

				//if(_scrollToEndInList)
				//list_ = gnncScrollPosition.__setEnd(list_) as gnncList;
			}
			
			list_.dataProvider 		= new ArrayCollection();
			
			__loading(true);
			
			if(_sqlConsult)
				_sqlConsultPrivate = _sqlConsult;
			else
				_sqlConsultPrivate = refresh_ ? _sqlConsultPrivate : new gnncSql().__SELECT(_tableClass,false,_sqlColumns,null,null,_sqlWhere,null,_sqlOrderBy,_sqlOrderDesc,_sqlLimit);
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sqlConsultPrivate,'Sql select');
			}
			
			_connList.__destroy		();
			_connList 				= new gnncAMFPhp();
			_connList.__sql			(_sqlConsultPrivate,'','',__fResult,__fFault);
		}
		
		public function __selectId(value_:uint,updateAndReplaceItemSelected_:Boolean=false,fResult_:Function=null,fFault_:Function=null):void
		{
			if(!_tableClass || !value_)
				return;
			
			//__configSql(); //refresh
			
			function __fFault(event:*):void
			{
				__loading(false);
				
				if(fFault_!=null)
					fFault_.call();
			}
			
			function __fResult(event:*):void
			{			
				if(!updateAndReplaceItemSelected_)
				{
					dataProvider = _connList.DATA_ARR;
				}
				else
				{
					//_connList.DATA_ARR.setItemAt(_connExec.DATA_ARR.getItemAt(0),selectedIndex);
					list_.dataProvider.setItemAt(_connExec.DATA_ARR.getItemAt(0),selectedIndex);
					
					list_.validateDisplayList();
					list_.validateNow();
				}
				
				__loading(false);
				
				if(_length)
				{
					list_.selectedIndex = updateAndReplaceItemSelected_ ? selectedIndex : 0;
					gnncFocus.__set		(list_);
				}
				
				if(fResult_!=null)
					fResult_.call();
			}
			
			if(!updateAndReplaceItemSelected_)
				dataProvider 	= new ArrayCollection();
			
			__loading(true);
			
			_sqlConsultPrivate = "select "+_sqlColumns.toString()+" from dbd_" + String(_tableClass['_TABLE']).toLocaleLowerCase() + " where ID = '" + value_ + "' ";
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sqlConsultPrivate,'Sql selectId');
				new gnncAlert().__alert(_sqlColumns.toString(),'Sql columns');
			}
			
			_connExec.__destroy		();
			_connExec.__
			_connExec.__sql(_sqlConsultPrivate,'','',__fResult,__fFault);
			
		}
		
		public function __selectStar(mixPersonal_:String = ''):void
		{
			if(!gnncGlobalStatic._userId)
			{
				callLater(__selectStar);
				return;
			}
			
			if(!_tableClass)
				return;
			
			//__configSql(); //refresh
			
			function __fFault(event:*):void
			{
				__loading(false);
			}
			
			function __fResult(event:*):void
			{			
				dataProvider 		= _connList.DATA_ARR;
				
				__loading(false);
			}
			
			__loading(true);
			
			list_.dataProvider 		= new ArrayCollection();
			
			mixPersonal_ = mixPersonal_ ? mixPersonal_ : _tableClass['_TABLE'];
			
			_sqlConsultPrivate 		= "select "+_sqlColumns.toString()+" from dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" right join dbd_star s ON ( s.ID_MIX = dbd_"+String(_tableClass['_TABLE']).toLowerCase()+".ID ) where s.MIX like '"+mixPersonal_+"' AND s.ENABLED = 1 AND s.ID_USER = '"+gnncGlobalStatic._userId+"' group by s.ID_MIX order by dbd_"+String(_tableClass['_TABLE']).toLowerCase()+".NAME";
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sqlConsultPrivate,'Sql selectStar');
				new gnncAlert().__alert(_sqlColumns.toString(),'Sql columns');
			}
			
			_connList.__destroy		();
			_connList.__sql			(_sqlConsultPrivate,'','',__fResult,__fFault);
		}
		
		/**
		 * column_:Array = new Array('NAME','NICK_NAME','TITLE')
		 * **/
		public function __selectWhere(value_:Object, column_:Array = null, andWhere_:String = '', variableValue_:Boolean=true, fResult_:Function=null, fFault_:Function=null):void
		{
			if(!_tableClass)
				return;
			
			if(!value_)
			{
				__select();
				return;
			}
			
			function __fFault(event:*):void
			{
				__loading(false);
				
				if(fFault_!=null)
					fFault_.call(null);
			}
			
			function __fResult(event:*):void
			{			
				dataProvider 		= _connList.DATA_ARR;
				
				__loading(false);
				
				if(fResult_!=null)
					fResult_.call(null);
			}
			
			dataProvider 		= new ArrayCollection();
			
			__loading(true);
			
			//__configSql(); //refresh
			
			var _i:uint 			= 0;
			var _where:String 		= '';
			var _w:String 			= '';
			var _v:String 			= variableValue_ ? '%' : '';
			
			for(_i=0; _i<column_.length; _i++)
			{
				if(selectedItem.hasOwnProperty(column_[_i]) || _tableClass.hasOwnProperty(column_[_i]))
					_where 			+= " " + column_[_i] + " like '" + _v + value_ + _v + "' or";
			}
			
			if(_where)
				_where 				= " where ("+_where.substr(0,-2)+") ";
			
			if(andWhere_)
				andWhere_ 			= " and " + andWhere_;
			
			if(!column_)
				column_ = ['NAME','NICK_NAME','TITLE'];
			
			//set values
			_w   					= _where + " " + andWhere_;
			
			_sqlConsultPrivate 		= " select "+_sqlColumns.toString()+
				" from dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" "+
				_w.toString() +
				" order by "+_sqlOrderBy.toString()+" "+
				(_sqlOrderDesc?' desc ':' asc '); //dbd_"+String(_tableClass['_TABLE']).toLowerCase()+".NAME
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sqlConsultPrivate,'Sql selectWhere');
				new gnncAlert().__alert(_sqlColumns.toString(),'Sql columns');
				new gnncAlert().__alert(_where.toString().substr(0,-2),'Sql where');
			}
			
			_connList.__destroy		();
			_connList.__sql			(_sqlConsultPrivate,'','',__fResult,__fFault);
		}
		
		/**
		 * 
		 * **/
		public function __selectLast(rows_:uint=10, andWhere_:String = ''):void
		{
			if(!_tableClass)
				return;
			
			if(!rows_)
				rows_ = 0;
			
			if(!andWhere_)
				andWhere_ = " ID > '0' "
			
			function __fFault(event:*):void
			{
				__loading(false);
			}
			
			function __fResult(event:*):void
			{			
				dataProvider 		= _connList.DATA_ARR;
				__loading(false);
			}
			
			dataProvider 		= new ArrayCollection();
			__loading(true);
			
			_sqlConsultPrivate 		= "select "+_sqlColumns.toString()+" from dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" where "+andWhere_+" order by dbd_"+String(_tableClass['_TABLE']).toLowerCase()+".DATE desc limit 0,"+rows_+" ";
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sqlConsultPrivate,'Sql selectWhere');
				new gnncAlert().__alert(_sqlColumns.toString(),'Sql columns');
			}
			
			_connList.__destroy		();
			_connList.__sql			(_sqlConsultPrivate,'','',__fResult,__fFault);
			
		}
		
		public function __fSaveOrder(fResult_:Function=null,fFault_:Function=null):void
		{
			if(!_length)
				return;
			
			if(!_tableClass.hasOwnProperty('ORDER_ITEM'))
				return;
			
			var _i:uint 			= 0;
			var _sql:String 		= '';
			var _obj:Object;
			
			//var _tem:Vector.<Object> = new Vector.<Object>;
			
			function __fFault(event:*):void
			{
				if(fResult_!=null)
					fResult_.call(null);
				__loading(false);
			}
			
			function __fResult(event:*):void
			{
				if(fFault_!=null)
					fFault_.call(null);
				__loading(false);
			}
			
			__loading(true);
			
			for(_i=0; _i<_length; _i++)
			{
				_obj 					= new Object();
				_obj._TABLE				= _tableClass['_TABLE'];
				_obj.ID					= list_.dataProvider.getItemAt(_i).ID;
				_obj.ORDER_ITEM			= _i;
				
				_sql += new gnncSql().__UPDATE(_obj,null,true,null) + gnncGlobalStatic._breakSql;
			}
			
			if(_sqlShow)
				new gnncAlert().__alert(_sql,'Sql fSaveOrder');
			
			_connExec.__destroy		();
			_connExec.__sql(_sql,'','',__fResult,__fFault);
		}
		
		public function __fStar(e:* = null, mixPersonal_:String = ''):void
		{
			if(!_length || !selected)
				return;
			
			if(!selectedItem.hasOwnProperty('STAR') || !selectedItem.hasOwnProperty('ID_STAR'))
				return;
			
			function __fFault(event:*):void
			{
				__loading(false);
			}
			
			function __fResult(event:*):void
			{
				var _obj:Object 	= selectedItem;
				_obj.STAR 			= _value;
				
				if(_obj.ID_STAR)
				{
					//_connList.DATA_ARR.setItemAt(selectedItem,selectedIndex);
					list_.dataProvider.setItemAt(selectedItem,selectedIndex);
					
					list_.validateDisplayList();
					list_.validateNow();
					
					__loading(false);
					
				}
				else
				{
					__selectId(_obj.ID,true);
				}
				
			}
			
			__loading(true);
			
			var _value:uint			= selectedItem.STAR == 1 ? 0 : 1;
			var _table:table_star	= new table_star();
			
			_table.ID				= selectedItem.ID_STAR
			_table.ID_USER			= gnncGlobalStatic._userId;
			_table.ID_CLIENT		= gnncGlobalStatic._userIdClient;
			
			_table.MIX				= mixPersonal_ ? mixPersonal_ : _tableClass['_TABLE'];
			_table.ID_MIX			= selectedItem.ID;
			_table.ENABLED			= _value;
			
			var _sql:String = new gnncSql().__INSERT(_table,false,true,true);
			
			if(_sqlShow)
			{
				new gnncAlert().__alert(_sql,'Sql fStar');
			}
			
			_connExec.__destroy		();
			_connExec.__sql(_sql,'','',__fResult,__fFault);
		}
		
		public function __fDateFinal(auto_:Boolean=true,date_:Date=null,askBefore_:Boolean=false,fResult_:Function=null,fFault_:Function=null):void
		{
			__fDate('DATE_FINAL',auto_,date_,askBefore_,fResult_,fFault_);
		}
		
		public function __fDateCanceled(auto_:Boolean=true,date_:Date=null,askBefore_:Boolean=false,fResult_:Function=null,fFault_:Function=null):void
		{
			__fDate('DATE_CANCELED',auto_,date_,askBefore_,fResult_,fFault_);
		}
		
		protected function __fDate(nameProperty_:String,auto_:Boolean=true,date_:Date=null,askBefore_:Boolean=false,fResult_:Function=null,fFault_:Function=null):void
		{
			if(!_length)
				return;
			
			if(!selected)
				return;
			
			if(!selectedItem.hasOwnProperty(nameProperty_))
				return;
			
			//if(!_allowMultipleSelection)
			//	return;
			
			//var _tem:Vector.<Object> = new Vector.<Object>;
			
			function __fFault(event:*):void
			{
				if(fResult_!=null)
					fResult_.call(null);
				__loading(false);
			}
			
			function __fResult(event:*):void
			{
				if(fFault_!=null)
					fFault_.call(null);
				//__loading(false);
				
				__selectId(selectedItem.ID,true);
			}
			
			__loading(true);
			
			var _date:String		= '';
			var _sql:String 		= '';
			var _obj:Object;
			
			if(auto_)
			{
				_date				= gnncDate.__isNull(selectedItem[nameProperty_]) ? gnncDate.__date2String(new Date()) : '' ;
			}
			else
			{
				_date				= date_ == null ? '' : gnncDate.__date2String(date_) ; 
			}
			
			
			_obj 					= new Object();
			_obj._TABLE				= _tableClass['_TABLE'];
			_obj.ID					= selectedItem.ID;
			
			_obj.DATE_FINAL			= '';
			_obj.DATE_CANCELED		= '';
			
			_obj[nameProperty_]		= _date;
			
			_sql = new gnncSql().__UPDATE(_obj,null,true,null);
			
			if(_sqlShow)
				new gnncAlert().__alert(_sql,'Sql fSaveOrder');
			
			_connExec.__destroy		();
			_connExec.__sql(_sql,'','',__fResult,__fFault);
		}
		
		
		public function __fRemoveItemList(e:*=null):void
		{ 
			if(!_length || !selected)
				return;
			
			//@removeItemAt
			__removeItemsInList();
		}
		
		public function __fFilterDuplicateProperty(property_:String='ID'):void
		{ 
			//if(!_length || !property_)
			//return;
			
			dataProvider = new gnncDataArrayCollection().__filterDuplicateProperty(new ArrayCollection(dataProvider.toArray()),'ID');
		}
		
		public function __clear():void
		{
			this.contextMenu = null;
			
			_connList.__destroy();
			_connExec.__destroy();
			
			list_.dataProvider = new ArrayCollection();
			
			callLater(__selectedItem);
			
			//_tableClass['ID'] = 0;
		}
		
		/**
		 * After event change while close popUp Update Item or List
		 * **/
		private function __afterChangeEvent(page_:Object):void
		{
			if(page_.hasOwnProperty('_change'))
			{
				if(!page_['_change'])
					return;
				
				__refreshData();
				
			}
			else if(page_.hasOwnProperty('_CHANGE'))
			{
				if(!page_['_CHANGE'])
					return;
				
				__refreshData();
			}
			else
			{
				if(_afterChangeEventUpdateOnlyItem && selected)
					__selectId(selectedItem.ID,true);
				else
					__select(true);
			}
			
			
			function __refreshData():void
			{
				//#########################################
				//please, change this
				//#########################################
				
				var _t0:String = _tableClassName;
				var _t1:String = '_table'+_tableClassMix;
				var _t2:String = '_TABLE_'+_tableClassMix.toUpperCase();
				
				if(page_.hasOwnProperty(_tableClassName))
				{
					var a:Object = page_[_tableClassName];
					var b:uint   = uint(a['ID']);
					
					if(b > 0 && selected)
						__selectId(selectedItem.ID,true);
					else
						__select(true);
				}
				else if(page_.hasOwnProperty(_t1))
				{
					new gnncAlert().__alert(_t1,'Problem Change in Close popUp T1');
				}
				else if(page_.hasOwnProperty(_t2))
				{
					new gnncAlert().__alert(_t2,'Problem Change in Close popUp T2');
				}
				else
				{
					return;
				}
				
				//#########################################
				
			}
			
		}
		
		public function __fHierarchyPrevLevel(e:*=null):void
		{
			__fHierarchyChange('prev');
			
			_stopPropagation = true;
			//__stopPropagationEvent(e);
			//e.stopImmediatePropagation();
			//e.stopPropagation();
		}
		
		public function __fHierarchyNextLevel(e:*=null):void
		{
			__fHierarchyChange('next');
			_stopPropagation = true;
			//__stopPropagationEvent(e);
			//e.stopImmediatePropagation();
			//e.stopPropagation();
		}
		
		private function __fHierarchyChange(leveltype_:String):void
		{
			//first item ever level 0
			
			if(!_length)
				return;
			
			if( selectedIndex < 0 )
				return;
			
			if( !selectedItem.hasOwnProperty('ID') || 
				!selectedItem.hasOwnProperty('ID_FATHER') || 
				!selectedItem.hasOwnProperty('LEVEL') )
				return;
			
			var _select:uint = gnncData.__clone(selectedIndex) as uint;
			var _sql:String  = '';
			
			var i:int		 = 0;
			var r:int		 = 0;
			
			var x:int 		 = selectedIndex-1; //prev index
			var o:Object 	 = dataProvider.getItemAt(x); //prev item
			var y:Object 	 = dataProvider.getItemAt(0); //first item
			
			var _idFather:int  = 0; //change to id_father
			var _block:Boolean = false; //???
			
			var prevIdx:int  = selectedIndex > 0 ? x			: -1;
			//var prevNm:String= selectedIndex > 0 ? o.NAME		: '';
			var prevId:uint  = selectedIndex > 0 ? o.ID			: 0;
			var prevIdF:uint = selectedIndex > 0 ? o.ID_FATHER	: 0;
			var prevLev:uint = selectedIndex > 0 ? o.LEVEL		: 0;
			
			var idx:int 	 = selectedIndex;
			var nm:String 	 = selectedItem.NAME;
			var id:uint  	 = selectedItem.ID;
			var idF:uint 	 = selectedItem.ID_FATHER;
			var lev:uint 	 = selectedItem.LEVEL;
			
			
			
			
			
			if(x === 333) //no enter here never
			{
			
			
			
			var ooo2:Array = new Array();
			
			//list_.dataProvider.getItemAt(idx).NAME  = nm+'@';
			
			if(leveltype_=='next')
				list_.dataProvider.getItemAt(idx).LEVEL = uint(lev+1);
			else
				list_.dataProvider.getItemAt(idx).LEVEL = uint(lev-1);

			list_.dataProvider = new ArrayCollection(list_.dataProvider.toArray());
			list_.validateDisplayList();
			list_.validateNow();

			var xlev:uint 		= 0;
			var xprevLev:uint 	= 0;

			for( i=(_length-1); i>-1; i-- )
			{
				//item actual
				idx	= i;
				id  = list_.dataProvider.getItemAt(i).ID;
				nm  = list_.dataProvider.getItemAt(i).NAME;
				idF = list_.dataProvider.getItemAt(i).ID_FATHER;
				lev = list_.dataProvider.getItemAt(i).LEVEL;

				//item actual
				if( i > 0 )
				{
					prevIdx	= i-1;
					prevId  = list_.dataProvider.getItemAt(i-1).ID;
					prevIdF = list_.dataProvider.getItemAt(i-1).ID_FATHER;
					prevLev = list_.dataProvider.getItemAt(i-1).LEVEL;
				}

				//get level up idFather
				for( r=i; r>0; r-- )
				{
					if(_block == false)
					{
						if(!lev)
						{
							_idFather   = 0;
							_block 		= true;
						}
						else if(lev > 0)
						{
							xprevLev	= list_.dataProvider.getItemAt(r-1).LEVEL;//level de cima, e de cima, e de cima...
							xlev		= (lev-1); //level que eu preciso
							
							if(xlev == xprevLev)
							{
								_idFather 	= list_.dataProvider.getItemAt(r-1).ID;
								_block 		= true;
							}
							else
							{
								_idFather  = 0;
							}//if
						}//if 
					}//if
				}//for

				_block 		= false;

				ooo2.push('i ' + i + ' | id ' + id + ' | idF ' + idF + ':' + _idFather + ' | idx ' + idx + ' | level ' + lev + ' | ' + nm.substr(0,6) );// + ' name ' + nm;
			}//for
			
			
			ooo2 = ooo2.reverse();
			
			//new gnncAlert().__alert(_length+' < length');
			new gnncAlert().__alert(ooo2.join("\n").toString());
			
			return;
			
			
			
			}
			
			
			
			
			
			
			
			
			
			
			
			
			//#############################################################
			//** OLD AND WORK!!!!!!
			
			//first item to level 0 and id_father = 0
			_sql = " UPDATE dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" SET LEVEL = '0', ID_FATHER = '0' WHERE ID like '"+y.ID+"' ";
			_sql += gnncGlobalStatic._breakSql;
			
			switch(leveltype_)
			{
				case 'next':
					
					//no more
					if( lev > prevLev )
						return;
					
					var ooo:String = '';
					
					//se estão no mesmo nivel então será capturado o ID de cima para o ID_FATHER de baixo
					if(lev == prevLev)
					{
						_idFather = prevId;
					}
					else
						//busca o id superior
						//if(lev < prevLev)
					{
						for(i=prevIdx; i>-1; i--)
						{
							prevId  = dataProvider.getItemAt(i).ID;
							prevIdF = dataProvider.getItemAt(i).ID_FATHER;
							prevLev = dataProvider.getItemAt(i).LEVEL;
							prevIdx	= i;
							
							ooo += 'i ' + i+' id ' + prevId+' idF '+prevIdF+ ' idx '+prevIdx+ ' lv '+prevLev+' | LEVEL '+lev+"\n";
							
							if(lev == (prevLev-1) && _block == false)
							{
								_idFather = prevIdF;
								_block = true;
							}
						}
					}
					
					//new gnncAlert().__alert(ooo);
					//new gnncAlert().__alert('id' + prevId+' idF '+prevIdF+ ' idx '+prevIdx+ ' lv '+prevLev);
					
					_sql += " UPDATE dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" SET LEVEL = (LEVEL+1), ID_FATHER = '"+_idFather+"' WHERE ID = '"+id+"' ";
					_sql += gnncGlobalStatic._breakSql;
					
					//atualiza nivel dos itens que estão subordinados
					_sql += " UPDATE dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" SET LEVEL = (LEVEL+1) WHERE ID_FATHER like '"+id+"' "; //'"+(lev+2)+"'
					_sql += gnncGlobalStatic._breakSql;
					
					break;
				
				case 'prev':
					
					//no less
					if( !lev )
						return;
					
					var oo:String = '';
					
					//se estão no mesmo nivel então será capturado o ID de cima para o ID_FATHER de baixo
					if(lev == 1)
					{
						_idFather = 0;
					}
						/*if(lev > prevLev)
						{
						_idFather = prevIdF;
						}*/
					else //busca o id superior
					{
						for(i=prevIdx; i>-1; i--)
						{
							prevId  = dataProvider.getItemAt(i).ID;
							prevIdF = dataProvider.getItemAt(i).ID_FATHER;
							prevLev = dataProvider.getItemAt(i).LEVEL;
							prevIdx	= i;
							
							oo += 'i ' + i+' id ' + prevId+' idF '+prevIdF+ ' idx '+prevIdx+ ' lv '+prevLev+' | LEVEL '+lev+"\n";
							
							if(lev == (prevLev+1) && _block == false)
							{
								_idFather = prevIdF;
								_block = true;
							}
							
						}
					}
					
					//new gnncAlert().__alert(oo);
					//new gnncAlert().__alert('id' + prevId+' idF '+prevIdF+ ' idx '+prevIdx+ ' lv '+prevLev);
					
					_sql += " UPDATE dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" SET LEVEL = (LEVEL-1), ID_FATHER = '"+_idFather+"' WHERE ID = '"+id+"' ";
					_sql += gnncGlobalStatic._breakSql;
					
					//atualiza nivel dos itens que estão subordinados
					_sql += " UPDATE dbd_"+String(_tableClass['_TABLE']).toLowerCase()+" SET LEVEL = (LEVEL-1) WHERE ID_FATHER like '"+id+"' ";
					_sql += gnncGlobalStatic._breakSql;
					
					break;
				
				default:
					break;
			}
			
			__loading(true);
			
			function __fFault(event:*):void
			{
				//if(fResult_!=null)
				//	fResult_.call(null);
				__loading(false);
				_stopPropagation = false;
			}
			
			function __fResult(event:*):void
			{
				//if(fFault_!=null)
				//	fFault_.call(null);
				//__loading(false);
				
				__select(true,fr,ff);
				
				function fr(e:*=null):void
				{
					selectedIndex = _select;
					__fSaveOrder(frOrder,ffOrder);
					
					function frOrder(e:*=null):void
					{
						_stopPropagation = false;
					}
					
					function ffOrder(e:*=null):void
					{
						_stopPropagation = false;
					}
					
				}
				
				function ff(e:*=null):void
				{
					__loading(false);
					_stopPropagation = false;
				}
				
			}
			
			//new gnncAlert().__alert(_sql);
			
			_connExec.__sql(_sql,'','',__fResult,__fFault);
			
		}
		
		
		
		
	}
	
}
