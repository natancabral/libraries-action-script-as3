package GNNC.UI.gnncView
{
	/*
	
	Example: Zooming in Flash
	
	Author:
	Daniel Gasienica
	daniel@gasienica.ch
	http://gasi.ch/
	
	
	Originally published on
	http://gasi.ch/blog/2008/02/05/zooming-in-flash-flex/
	
	Released under the
	Creative Commons Attribution-Share Alike License
	http://creativecommons.org/licenses/by-sa/3.0/
	
	*/
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.UI.gnncImage.gnncImageProgress;
	import GNNC.mouse.gnncMousePoint;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	import mx.effects.Fade;
	import mx.effects.easing.Elastic;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	
	import spark.primitives.Ellipse;
	
	
	public class gnncViewImage extends Canvas
	{
		public var _IMAGE:gnncImageProgress = new gnncImageProgress();
		private var affineTransform : Matrix;
		
		// Constructor
		public function gnncViewImage(imageLocation_:String)
		{ 
			//this.width 			= parentApplication.parent.width;
			//this.height 		= parentApplication.parent.height;
			
			addEventListener	( Event.ADDED_TO_STAGE, registerListeners )
			createGrid			(imageLocation_)
		}
		
		// Transformations
		public function scaleAt( scale : Number, originX : Number, originY : Number ) : void
		{
			// get the transformation matrix of this object
			affineTransform = transform.matrix
			
			// move the object to (0/0) relative to the origin
			affineTransform.translate( -originX, -originY )
			
			// scale
			affineTransform.scale( scale, scale )
			
			// move the object back to its original position
			affineTransform.translate( originX, originY )
			
			
			// apply the new transformation to the object
			transform.matrix = affineTransform
		}
		
		public function rotateAt( angle : Number, originX : Number, originY : Number ) : void
		{
			// get the transformation matrix of this object
			affineTransform = transform.matrix
			
			
			// move the object to (0/0) relative to the origin
			affineTransform.translate( -originX, -originY )
			
			// rotate
			affineTransform.rotate( angle )
			
			// move the object back to its original position
			affineTransform.translate( originX, originY )
			
			
			// apply the new transformation to the object
			transform.matrix = affineTransform
		}
		
		
		// Helpers
		private function registerListeners( event : Event ) : void
		{
			// Panning
			this.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown )
			this.addEventListener( MouseEvent.MOUSE_UP, onMouseUp )
			
			// Mouse wheel support for zooming
			this.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel )
			
			// Keyboard support for zooming
			this.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown )            
		}
		
		private function createGrid(imageLocation_:String) : void
		{
			/*var spacing : Number = 10
			
			for( var row : uint = 0; row < 5; row++ )
			{
			for( var column : uint = 0; column < 5; column++ )
			{
			var circle:Ellipse = new Ellipse();
			circle.fill = new SolidColor(0xFFFFFF,.5);
			
			circle.x = column * ( circle.width + spacing )
			circle.y = row * ( circle.height + spacing )
			
			addChild( circle as DisplayObject )
			}
			}   */
			
			//_IMAGE.smoothBitmapContent 	= true;
			_IMAGE.smoothBitmapContent	= true;
			_IMAGE.scaleContent			= true;
			_IMAGE.progressWidth 		= 100;
			_IMAGE.progressHeight		= 20;
			_IMAGE.width				= 660;//FlexGlobals.topLevelApplication.parent.width;
			_IMAGE.height				= 460;//FlexGlobals.topLevelApplication.parent.height;
			_IMAGE.source 				= imageLocation_;
			_IMAGE.horizontalCenter		= 0;
			_IMAGE.verticalCenter		= 0;
			_IMAGE.setStyle				('horizontalAlign','center');
			_IMAGE.setStyle				('verticalAlign','middle');
			_IMAGE.addEventListener		(FlexEvent.DATA_CHANGE,		centerImage);
			_IMAGE.addEventListener		(FlexEvent.UPDATE_COMPLETE,	centerImage);
			
			addChild					(_IMAGE);
			
			stopDrag();
			callLater(stopDrag);
			
		}
		
		private function centerImage(e:*=null) : void
		{
			//this.x = (parentApplication.parent.width/2)-(_IMAGE.width/2);
			//this.y = (parentApplication.parent.height/2)-(_IMAGE.height/2);
			
			//_IMAGE.width				= _IMAGE.contentWidth;
			//_IMAGE.height				= _IMAGE.contentHeight;
			
			//new gnncAlert().__alert('imgW.H.X.Y.scale:'+_IMAGE.width+'.'+_IMAGE.height+'.'+_IMAGE.x+'.'+_IMAGE.y+'.'+_IMAGE.scaleX+'.');
			//new gnncAlert().__alert('thisW.H.X.Y.scale:'+this.width+'.'+this.height+'.'+this.x+'.'+this.y+'.'+this.scaleX+'.');
			
			//_IMAGE.x = (FlexGlobals.topLevelApplication.parent.width/2)-(_IMAGE.width/2);
			//_IMAGE.y = (FlexGlobals.topLevelApplication.parent.height/2)-(_IMAGE.height/2);
			_IMAGE.x = (660/2)-(_IMAGE.width/2);
			_IMAGE.y = (460/2)-(_IMAGE.height/2);

			
			//var originX : Number = parentApplication.parent.width/2;
			//var originY : Number = parentApplication.parent.height/2;
			
			//scaleAt( 1, originX, originY );
		}
		
		// Event Handlers
		private function onMouseWheel( event : MouseEvent ) : void
		{
			// set the origin of the transformation
			// to the current position of the mouse
			
			//var originX : Number = this.mouseX
			//var originY : Number = this.mouseY
			
			var point:Point			= gnncMousePoint.__local2Global(event);
			var originX : Number 	= point.x;
			var originY : Number 	= point.y;
			
			// zoom
			if( !event.altKey )
			{
				if( event.delta > 0 )
				{                    
					// zoom in
					scaleAt( 6/5, originX, originY ) 
				}
				else
				{
					// zoom out                    
					scaleAt( 5/6, originX, originY )
				}
			}
			else
			{
				// rotate
				rotateAt( event.delta / 20, originX, originY )
			}
		}
		
		private function onMouseDown( event : MouseEvent ) : void
		{
			startDrag()
		}
		
		private function onMouseUp( event : MouseEvent ) : void
		{
			stopDrag()
		}
		
		/**
		 * Keyboard support for zooming due to
		 * missing mouse wheel support on Mac OS
		 */
		private function onKeyDown( event : KeyboardEvent ) : void
		{
			// set the origin of the transformation
			// to the current position of the mouse
			
			//var originX : Number = this.mouseX
			//var originY : Number = this.mouseY
			
			var originX : Number = parentApplication.parent.mouseX;
			var originY : Number = parentApplication.parent.mouseY;
			
			
			// zoom
			if( event.keyCode == Keyboard.UP )
			{
				// zoom in
				scaleAt( 6/5, originX, originY )                            
			}
			else if( event.keyCode == Keyboard.DOWN )
			{
				// zoom out
				scaleAt( 5/6, originX, originY )                    
			}
				// rotate
			else if( event.keyCode == Keyboard.LEFT )
			{
				// rotate left    
				rotateAt( -Math.PI / 60, originX, originY )                
			}
			else if( event.keyCode == Keyboard.RIGHT )
			{
				// rotate right
				rotateAt( Math.PI / 60, originX, originY )                
			}
		}
		
		public function zoomIn() : void
		{
			centerImage();

			//var originX : Number = parentApplication.parent.width/2;
			//var originY : Number = parentApplication.parent.height/2;
			var originX : Number = 660/2;
			var originY : Number = 460/2;
			
			scaleAt( 6/5, originX, originY )                            
		}
		
		public function zoomOut() : void
		{
			centerImage();
			
			//var originX : Number = parentApplication.parent.width/2;
			//var originY : Number = parentApplication.parent.height/2;
			var originX : Number = 660/2;
			var originY : Number = 460/2;
			
			scaleAt( 5/6, originX, originY )                    
		}
		
	}    
}