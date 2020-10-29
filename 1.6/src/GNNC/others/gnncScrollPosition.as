package GNNC.others
{
	import spark.components.DataGrid;
	import spark.components.List;
	import spark.components.TextArea;
	import spark.components.gridClasses.GridSelectionMode;
	import spark.core.NavigationUnit;

	public class gnncScrollPosition
	{
		private var _parent:Object 				= null;
		
		private var _selectedIndex:Boolean		= true;
		
		private var _verticalDelta:Number 		= 0;
		private var _horizontalDelta:Number 	= 0;
		private var _selectedIndexValue:int 	= 0;
		private var _vector:Vector.<int>;

		private var _verticalValue:Number 		= 0;
		private var _horizontalValue:Number 	= 0;

		private var _hoverRowIndex:Number		= 0;
		private var _hoverColumnIndex:Number	= 0;

		/**
		 * 
		 * ######################################
		 * 
		 * read
		 * http://flexponential.com/2010/12/05/saving-scroll-position-between-views-in-a-mobile-flex-application/
		 * 
		 * **/
		
		public function gnncScrollPosition(parentApplication_:Object=null)
		{
			_parent = parentApplication_;
		}
		
		public function __getListValues(list_:List,selectedIndex_:Boolean=true):List
		{
			_selectedIndex 									= selectedIndex_;

			list_.validateNow();
			
			_verticalDelta									= list_.layout.verticalScrollPosition;
			_horizontalDelta								= list_.layout.horizontalScrollPosition;
			
			if(!list_.allowMultipleSelection)
				_selectedIndexValue							= list_.selectedIndex;
			else
				_vector										= list_.selectedIndices;
			
			return list_;
		}
		
		public function __setListValues(list_:List):List
		{
			list_.layout.verticalScrollPosition 			= _verticalDelta; 
			list_.layout.horizontalScrollPosition 			= _horizontalDelta; 

			list_.validateNow();

			if(!list_.allowMultipleSelection)
				list_.selectedIndex							= _selectedIndexValue;
			else
				list_.selectedIndices						= _vector;
			
			return list_;
		}
		
		/**
		 * Sample:
		 * list_ = gnncScrollPosition.__setEnd(list_);
		 * 
		 * */
		public static function __setEnd(list_:List):List
		{
			var delta:Number = 0;
			var count:int = 0;
			
			while (count++ < 10)
			{
				list_.validateNow();
				
				delta = list_.layout.getVerticalScrollPositionDelta(NavigationUnit.END);
				list_.layout.verticalScrollPosition += delta;
				
				if (delta == 0)
					break;
			}
			
			return list_;
		}

		/**
		 * Sample:
		 * datagrid_ = gnncScrollPosition.__setEndDataGrid(datagrid_);
		 * 
		 * */
		public static function __setEndDataGrid(dataG_:DataGrid):DataGrid
		{
			//datagrid.ensureCellIsVisible(dgArrayCollection.length - 1,-1);
			
			var delta:Number = 0;
			var count:int = 0;
			
			while (count++ < 10)
			{
				dataG_.validateNow();
				
				delta = dataG_.grid.getVerticalScrollPositionDelta(NavigationUnit.END);
				dataG_.grid.verticalScrollPosition += delta;
				
				if (delta == 0)
					break;
			}
			
			return dataG_
		}

		/**
		 * Sample:
		 * textArea_ = gnncScrollPosition.__setEndDataGrid(textArea_);
		 * 
		 * */
		public function __setEndTextArea(textA_:TextArea):TextArea
		{
			textA_.validateNow();
			textA_.scrollToRange(textA_.text.length-1, textA_.text.length);
			//textA_.scroller.verticalScrollBar.value = textA_.scroller.verticalScrollBar.maximum;
			return textA_;
		}

		public function __getDataGridValues(datagrid_:DataGrid):DataGrid
		{
			datagrid_.validateNow();
			
			_hoverRowIndex									= datagrid_.grid.hoverRowIndex;
			_hoverColumnIndex								= datagrid_.grid.hoverColumnIndex
			_verticalValue									= datagrid_.grid.verticalScrollPosition;
			_horizontalValue								= datagrid_.grid.horizontalScrollPosition;
			_hoverRowIndex									= datagrid_.grid.selectedIndex;

			return datagrid_;
		}
		
		public function __setDataGridValues(datagrid_:DataGrid):DataGrid
		{
			datagrid_.grid.hoverRowIndex					= _hoverRowIndex;
			datagrid_.grid.hoverColumnIndex					= _hoverColumnIndex;
			datagrid_.grid.verticalScrollPosition			= _verticalValue;
			datagrid_.grid.horizontalScrollPosition			= _horizontalValue;
			datagrid_.grid.selectedIndex					= _hoverRowIndex;

			datagrid_.validateNow();
			
			return datagrid_;
		}

		/**
		 * Sample:
		 * gnncScrollPosition.__setTop(list_);
		 * 
		 * */
		public static function __setTop(list_:List):List
		{
			list_.validateNow();
			list_.layout.verticalScrollPosition = 0;
			list_.layout.verticalScrollPosition = 0;
			list_.validateDisplayList();
			list_.validateNow();
			return list_;
		}

	}
}