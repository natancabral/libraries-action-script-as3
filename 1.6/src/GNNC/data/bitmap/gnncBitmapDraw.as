/**
 * Copyright tkinjo ( http://wonderfl.net/user/tkinjo )
 * MIT License ( http://www.opensource.org/licenses/mit-license.php )
 * Downloaded from: http://wonderfl.net/c/8DWP
 */

// forked from tkinjo's Paint
package GNNC.data.bitmap
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    
    [SWF(width="465", height="465", backgroundColor="0xffffff", frameRate="60")] 
    /**
     * ...
     * @author tkinjo
     */
    public class gnncBitmapDraw extends  MovieClip
    {
        public function gnncBitmapDraw() 
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP,   mouseUpHandler);
        }
        
        private function mouseDownHandler( event:MouseEvent ):void {
            
            graphics.lineStyle( 10 );
            graphics.moveTo( event.stageX, event.stageY );
        }
        
        private function mouseMoveHandler( event:MouseEvent ):void {
            
            if ( !event.buttonDown )
                return;
            
            graphics.lineTo( event.stageX, event.stageY );
        }
        
        private function mouseUpHandler( event:MouseEvent ):void {
            
            graphics.lineStyle();
        }
    }
}