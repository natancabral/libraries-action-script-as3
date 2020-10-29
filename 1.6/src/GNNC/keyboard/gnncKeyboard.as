package GNNC.keyboard
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class gnncKeyboard
	{
		
		public function gnncKeyboard()
		{
		}
		
		public static function __stopPropagation(event:KeyboardEvent):void
		{ 
			event.isDefaultPrevented();
			event.stopImmediatePropagation(); 
			event.stopPropagation();
		}

		public static function selectAll(event:KeyboardEvent):Boolean{
			//event.keyCode == Keyboard.CONTROL
			if ((event.charCode == Keyboard.A || event.charCode == 97  || event.keyCode == 65 ) && event.ctrlKey == true){
				var v:Vector.<int> = new Vector.<int>();
				var len:uint = event.currentTarget.selectedItems;
				for(var i:uint=0;i<len;i++)
					v.push(i);
				event.currentTarget.selectedIndices = v;
				event.currentTarget.setFocus();
				return true;
			} 
			return false; 
		}

		public static function __CONTROL(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.CONTROL) { 		return true; } return false; }
		public static function __ESC(event:KeyboardEvent):Boolean { 				if (event.keyCode == Keyboard.ESCAPE) { 		return true; } return false; }
		public static function __ENTER(event:KeyboardEvent):Boolean { 				if (event.keyCode == Keyboard.ENTER) { 			return true; } return false; }
		public static function __SPACE(event:KeyboardEvent):Boolean { 				if (event.keyCode == Keyboard.SPACE) { 			return true; } return false; }
		public static function __BACKSPACE(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.BACKSPACE) { 		return true; } return false; }
		public static function __DIRECTION_DOWN(event:KeyboardEvent):Boolean { 		if (event.keyCode == Keyboard.DOWN) { 			return true; } return false; }
		public static function __DIRECTION_UP(event:KeyboardEvent):Boolean { 		if (event.keyCode == Keyboard.UP) { 			return true; } return false; }
		public static function __DIRECTION_RIGHT(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.RIGHT) { 			return true; } return false; }
		public static function __DIRECTION_LEFT(event:KeyboardEvent):Boolean { 		if (event.keyCode == Keyboard.LEFT) { 			return true; } return false; }
		public static function __DELETE(event:KeyboardEvent):Boolean { 				if (event.keyCode == Keyboard.DELETE) { 		return true; } return false; }
		public static function __tab(event:KeyboardEvent):Boolean { 				if (event.keyCode == Keyboard.TAB) { 			return true; } return false; }
		
		public static function __alt		(event:KeyboardEvent):Boolean 			{if (event.altKey	== true) { return true; } return false; }
		public static function __control	(event:KeyboardEvent):Boolean 			{if (event.ctrlKey 	== true) { return true; } return false; }
		public static function __shift		(event:KeyboardEvent):Boolean 			{if (event.shiftKey == true) { return true; } return false; }
		
		public static function __controlA(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.A || event.charCode == 97  || event.keyCode == 65 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlB(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.B || event.charCode == 98  || event.keyCode == 66 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlC(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.C || event.charCode == 99  || event.keyCode == 67 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlD(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.D || event.charCode == 100 || event.keyCode == 68 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlI(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.I || event.charCode == 105 || event.keyCode == 73 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlL(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.L || event.charCode == 108 || event.keyCode == 76 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlM(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.M || event.charCode == 109 || event.keyCode == 77 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlO(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.O || event.charCode == 111 || event.keyCode == 79 ) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlV(event:KeyboardEvent):Boolean 				{if ((event.charCode == Keyboard.V || event.charCode == 118 || event.keyCode == 86 ) && event.ctrlKey == true) { return true; } return false; }

		public static function __controlF1(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F1)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF2(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F2)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF3(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F3)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF4(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F4)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF5(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F5)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF6(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F6)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF7(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F7)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF8(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F8)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF9(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F9)  && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF10(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F10) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF11(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F11) && event.ctrlKey == true) { return true; } return false; }
		public static function __controlF12(event:KeyboardEvent):Boolean 			{if ((event.keyCode == Keyboard.F12) && event.ctrlKey == true) { return true; } return false; }

		public static function __CONTROL_AND_N_1(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_1 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_2(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_2 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_3(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_3 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_4(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_4 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_5(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_5 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_6(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_6 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_7(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_7 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_8(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_8 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_9(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_9 && event.ctrlKey == true) { return true; } return false; }
		public static function __CONTROL_AND_N_0(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.NUMBER_0 && event.ctrlKey == true) { return true; } return false; }

		public static function __CONTROL_ENTER	(event:KeyboardEvent):Boolean {		if (event.charCode == Keyboard.ENTER && event.ctrlKey) { return true; } return false; }

		public static function __F1				(event:KeyboardEvent):Boolean { 	if (event.keyCode == 112) { 			return true; } return false; }
		public static function __F2				(event:KeyboardEvent):Boolean { 	if (event.keyCode == 113) { 			return true; } return false; }
		public static function __F3				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F3) { 	return true; } return false; }
		public static function __F4				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F4) { 	return true; } return false; }
		public static function __F5				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F5) { 	return true; } return false; }
		public static function __F6				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F6) { 	return true; } return false; }
		public static function __F7				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F7) { 	return true; } return false; }
		public static function __F8				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F8) { 	return true; } return false; }
		public static function __F9				(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F9) { 	return true; } return false; }
		public static function __F10			(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F10) { 	return true; } return false; }
		public static function __F11			(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F11) { 	return true; } return false; }
		public static function __F12			(event:KeyboardEvent):Boolean { 	if (event.keyCode == Keyboard.F12) { 	return true; } return false; }

		
		
		
	
		public function F1				(event:KeyboardEvent):Boolean { 			if (event.keyCode == 112) { 			return true; } return false; }
		public function F2				(event:KeyboardEvent):Boolean { 			if (event.keyCode == 113) { 			return true; } return false; }
		public function F3				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F3) { 	return true; } return false; }
		public function F4				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F4) { 	return true; } return false; }
		public function F5				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F5) { 	return true; } return false; }
		public function F6				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F6) { 	return true; } return false; }
		public function F7				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F7) { 	return true; } return false; }
		public function F8				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F8) { 	return true; } return false; }
		public function F9				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F9) { 	return true; } return false; }
		public function F10				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F10) { 	return true; } return false; }
		public function F11				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F11) { 	return true; } return false; }
		public function F12				(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.F12) { 	return true; } return false; }
	
		public function _ALT			(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.ALTERNATE) { 		return true; } return false; }
		public function _SHIFT			(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.SHIFT) { 			return true; } return false; }
		public function _CONTROL		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.CONTROL) { 			return true; } return false; }
		public function _CONTROL_ENTER	(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.ENTER && event.ctrlKey) { return true; } return false; }
		public function _ENTER			(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.ENTER) { return true; } return false; }
		public function _ESC			(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.ESCAPE) {return true; } return false; }
		//public function _PRINTSCREEN	(event:KeyboardEvent):Boolean { 			if (event.keyCode == Keyboard.KEYNAME_PRINTSCREEN) {return true; } return false; }
		

		
		public function TOP_DIRECTION	(event:KeyboardEvent):Boolean { 			if (event.charCode == 38) { 			return true; } return false; }
		public function BOTTOM_DIRECTION(event:KeyboardEvent):Boolean { 			if (event.charCode == 40) { 			return true; } return false; }

		public function _CONTROL_AND_N_1(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_1 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_2(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_2 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_3(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_3 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_4(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_4 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_5(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_5 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_6(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_6 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_7(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_7 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_8(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_8 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_9(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_9 && event.ctrlKey == true) { return true; } return false; }
		public function _CONTROL_AND_N_0(event:KeyboardEvent):Boolean {				if (event.charCode == Keyboard.NUMBER_0 && event.ctrlKey == true) { return true; } return false; }

		public function _NUMBER_1		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_1) { 	return true; } return false; }
		public function _NUMBER_2		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_2) { 	return true; } return false; }
		public function _NUMBER_3		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_3) { 	return true; } return false; }
		public function _NUMBER_4		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_4) { 	return true; } return false; }
		public function _NUMBER_5		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_5) { 	return true; } return false; }
		public function _NUMBER_6		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_6) { 	return true; } return false; }
		public function _NUMBER_7		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_7) { 	return true; } return false; }
		public function _NUMBER_8		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_8) { 	return true; } return false; }
		public function _NUMBER_9		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_9) { 	return true; } return false; }
		public function _NUMBER_0		(event:KeyboardEvent):Boolean { 			if (event.charCode == Keyboard.NUMBER_0) { 	return true; } return false; }
	
		/**
		trace("keyDownHandler: " + event.keyCode);
		trace("ctrlKey: " + event.ctrlKey);
		trace("keyLocation: " + event.keyLocation);
		trace("shiftKey: " + event.shiftKey);
		trace("altKey: " + event.altKey);
		**/

		
	}
}