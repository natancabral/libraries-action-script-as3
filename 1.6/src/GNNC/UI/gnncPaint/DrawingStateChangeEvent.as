/*
 *  Copyright 2010 Chet Haase
 *	
 *	Licensed under the Apache License, Version 2.0 (the "License");
 *	you may not use this file except in compliance with the License.
 *	You may obtain a copy of the License at
 *	
 *	http://www.apache.org/licenses/LICENSE-2.0
 *	
 *	Unless required by applicable law or agreed to in writing, software
 *	distributed under the License is distributed on an "AS IS" BASIS,
 *	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *	See the License for the specific language governing permissions and
 *	limitations under the License.
 */
package GNNC.UI.gnncPaint
{
import flash.events.Event;

import mx.graphics.IFill;
import mx.graphics.IStroke;

public class DrawingStateChangeEvent extends Event
{
    public var stroke:IStroke;
    public var fill:IFill;
    
    public function DrawingStateChangeEvent(type:String, stroke:IStroke, fill:IFill)
    {
        super(type);
        this.fill = fill;
        this.stroke = stroke;
    }
    
    public static const DRAWING_STATE_CHANGE:String = "drawingStateChange";
    
    override public function clone():Event
    {
        return new DrawingStateChangeEvent(type, stroke, fill   );
    }
}
}