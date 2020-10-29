package com.vstyran.transform.managers.raster
{
	/**
	 * Default bitmap cursors.
	 * 
	 * @author Volodymyr Styranivskyi
	 */
	public class Cursors
	{
		[Embed(source="images/move.png")]
		/**
		 * Move cursor. 
		 */		
		public static const MoveCursor:Class;
		
		[Embed(source="images/resize1.png")]
		/**
		 * Horizontal resize cursor. 
		 */		
		public static const HResizeCursor:Class;
		
		[Embed(source="images/resize2.png")]
		/**
		 * Vertical resize cursor. 
		 */		
		public static const VResizeCursor:Class;
		
		[Embed(source="images/resize3.png")]
		/**
		 * Resize cursor to top-left direction. 
		 */		
		public static const TLResizeCursor:Class;
		
		[Embed(source="images/resize4.png")]
		/**
		 * Resize cursor to top-right direction. 
		 */	
		public static const TRResizeCursor:Class;
		
		[Embed(source="images/rotate.png")]
		/**
		 * Rotate cursor. 
		 */		
		public static const RotateCursor:Class;
	}
}