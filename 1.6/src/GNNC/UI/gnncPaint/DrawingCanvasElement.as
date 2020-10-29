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
import flash.events.MouseEvent;
import flash.geom.Point;

import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.graphics.SolidColor;
import mx.graphics.SolidColorStroke;

import spark.components.Group;
import spark.primitives.Ellipse;
import spark.primitives.Line;
import spark.primitives.Path;
import spark.primitives.Rect;
import spark.primitives.supportClasses.FilledElement;
import spark.primitives.supportClasses.StrokedElement;

public class DrawingCanvasElement extends Group
{
    public static const LINE:int = 0;
    public static const RECT:int = 1;
    public static const ELLIPSE:int = 2;
    public static const PATH:int = 3;

    public var drawingMode:int = LINE;

    public var stroke:IStroke = new SolidColorStroke(0);
    public var fill:IFill = new SolidColor(0);
    
    private var shape:StrokedElement;
    private var pathPoints:Vector.<Point>;
    
    public function DrawingCanvasElement()
    {
        super();
        var border:Rect = new Rect();
        //border.stroke = new SolidColorStroke(0);
		border.fill = new SolidColor(0xffffff);
		border.left = 0;
        border.right = 0;
        border.top = 0;
        border.bottom = 0;
        addElement(border);
        addEventListener("mouseDown", mouseDownHandler);
    }
    
    private function mouseDownHandler(event:MouseEvent):void
    {
        if (drawingMode == LINE)
        {
            shape = new Line();
            var line:Line = Line(shape);
            line.xFrom = event.localX;
            line.yFrom = event.localY;
            line.xTo = event.localX;
            line.yTo = event.localY;
        }
        else
        {
            switch (drawingMode)
            {
                case RECT:
                    shape = new Rect();
                    shape.x = event.localX;
                    shape.y = event.localY;
                    break;
                case ELLIPSE:
                    shape = new Ellipse();
                    shape.x = event.localX;
                    shape.y = event.localY;
                    break;
                case PATH:
                    shape = new Path();
                    pathPoints = new <Point>[new Point(event.localX, event.localY)];
                    break;
            }
            FilledElement(shape).fill = fill;
        }
        shape.stroke = stroke;
        addElement(shape);
        addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }

    private function mouseMoveHandler(event:MouseEvent):void
    {
        dragTo(event.localX, event.localY);
    }
    
    private function mouseUpHandler(event:MouseEvent):void
    {
        dragTo(event.localX, event.localY);
        removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    
    private function dragTo(dragX:Number, dragY:Number):void
    {
        switch (drawingMode)
        {
            case LINE:
                Line(shape).xTo = dragX;
                Line(shape).yTo = dragY;
                break;
            case RECT:
                shape.width = dragX - shape.x;
                shape.height = dragY - shape.y;
                break;
            case ELLIPSE:
                shape.width = dragX - shape.x;
                shape.height = dragY - shape.y;
                break;
            case PATH:
                pathPoints[pathPoints.length] = new Point(dragX, dragY);
                constructPath();
                break;
        }
    }    

    private function constructPath():void
    {
        var dataString:String = "M " + pathPoints[0].x + " " + pathPoints[1].y;
        for (var i:int = 1; i < pathPoints.length; ++i)
        {
            var pt:Point = pathPoints[i];
            dataString += " L " + pt.x + " " + pt.y;
        }
        Path(shape).data = dataString;
    }
}
}