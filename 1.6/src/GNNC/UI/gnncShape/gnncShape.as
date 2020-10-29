package GNNC.UI.gnncShape
{
	//import necessary classes
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class gnncShape extends Sprite
	{

		private var canvas:Sprite = new Sprite();
		private var gr:Graphics = canvas.graphics;

		public function gnncShape()
		{
			// constructor code
			//trace("drawing a Circle");
			//drawCircle();
			//drawSquare();
			//drawTriangle();
			//addChild(canvas);
		}	
				
		//draw Circle method
		private function drawCircle():void {
			//drawing circle inside the graphics object
			gr.lineStyle(6, 0x0000FF, 0.5);
			gr.beginFill(0xFF0000, 0.5);
			gr.drawCircle(200, 200, 50);
			gr.endFill();
		}
		
		//draw Square method
		private function drawSquare():void {
			//drawing circle inside the graphics object
			gr.lineStyle(6, 0x0000FF, 0.5);
			gr.beginFill(0xFF0000, 0.5);
			gr.drawRect(100, 100, 50, 50);
			gr.endFill();
		}
		
		//draw Triangle method
		private function drawTriangle():void {
			//drawing circle inside the graphics object
			gr.lineStyle(6, 0x0000FF, 0.5);
			gr.beginFill(0xFF0000, 0.5);
			gr.moveTo(0,0);
			gr.lineTo(50,50);
			gr.lineTo(0,50);
			gr.lineTo(0,0);
			gr.endFill();
		}
	}
}