package GNNC.data.element
{
	public class gnncElement
	{
		public function gnncElement()
		{
		}
		
		//This function assumes that Element has elements in it.  
		public static function removeAllElements(element:*):Boolean  
		{
			//this.removeChild();
			//this.removeAllElements();
			//this.removeElement();
			return false;
		}  

		public static function removeElementByName(element:*,name:String):Boolean
		{  
			var Element:* = element;
			var len:uint = 0;
			var e:Boolean = false; //element or child
			
			if(Element.hasOwnProperty('numElements'))
			{
				e = true;
				len = Number(Element.numElements);
				if(!len)
					return false;
			}
			else if(Element.hasOwnProperty('numChildren'))
			{
				e = false;
				len = Number(Element.numChildren);
				if(!len)
					return false;
			}
			//child.hasOwnProperty("getElementAt")
			//child.hasOwnProperty("getChildAt");

			for (var i:int =0; i<len; i++)
			{  
				if(e==true)
				{
					if(Object(Element.getElementAt(i))!=null)
						if(Object(Element.getElementAt(i)).hasOwnProperty('name'))
							if(String(Element.getElementAt(i).name) === name){
								Element.removeElementAt(i);
								return true;
							}
				}
				else if(e==false)
				{
					if(Object(Element.getChildAt(i))!=null)
						if(Object(Element.getChildAt(i)).hasOwnProperty('name'))
							if(String(Element.getChildAt(i).name) === name){
								Element.removeChildAt(i);
								return true;
							}
				}
			}  
			return false;  
			
		}

	}
}