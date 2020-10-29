////////////////////////////////////////////////////////////////////////////////
//
// NonTransparentPNGEncoder.as
// STEHIL.COM, 2010
// example usage with AlivePDF:
// var p:PDF = new PDF( Orientation.PORTRAIT, Unit.MM, Size.A4 );
// p.addPage();
// var linechartSnap:ImageSnapshot = ImageSnapshot.captureImage(linechart, IMAGE_DPI, new NonTransparentPNGEncoder());
// p.addImageStream(linechartSnap.data, ColorSpace.DEVICE_RGB, null, 0, 150, 180, 80);
//

/**
 * 
 * var image:ImageSnapshot = ImageSnapshot.captureImage(page, 300, new NonTransparentPNGEncoder());
var resize:Resize = new Resize ( Mode.FIT_TO_PAGE, Position.CENTERED );
pdf.addImageStream(image.data, ColorSpace.DEVICE_RGB, resize);
 * 
 * or
 * 
 *     var bytes:ByteArray = pdf.save(Method.LOCAL);
    var file:FileReference = new FileReference();
    file.save(bytes, filename);
	 * 
 * 
 * 
 * 
 * 
 * // Build IHDR chunk
 
var IHDR:ByteArray = new ByteArray();
IHDR.writeInt(w);
IHDR.writeInt(h);
IHDR.writeUnsignedInt(0x08020000); // True colour (no alpha)
IHDR.writeByte(0);
writeChunk(png, 0x49484452, IHDR);
 
// Isolate RGB values
 
for (var j:int = 0; j < w; j++)
{
	p = img.getPixel(j, i);
	IDAT.writeByte(p >> 16 & 0xFF);
	IDAT.writeByte(p >> 8 & 0xFF);
	IDAT.writeByte(p & 0xFF);
}
 * 
 * **/


// based on mx.graphics.codec.PNGEncoder
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package GNNC.data.bitmap
{
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.IImageEncoder;
	
	/**
	 *  The PNGEncoder class converts raw bitmap images into encoded
	 *  images using Portable Network Graphics (PNG) lossless compression.
	 *
	 *  <p>For the PNG specification, see http://www.w3.org/TR/PNG/</p>.
	 */
	public class NonTransparentPNGEncoder implements IImageEncoder
	{
		
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  The MIME type for a PNG image.
		 */
		private static const CONTENT_TYPE:String = "image/png";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function NonTransparentPNGEncoder()
		{
			super();
			
			initializeCRCTable();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Used for computing the cyclic redundancy checksum
		 *  at the end of each chunk.
		 */
		private var crcTable:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  contentType
		//----------------------------------
		
		/**
		 *  The MIME type for the PNG encoded image.
		 *  The value is <code>"image/png"</code>.
		 */
		public function get contentType():String
		{
			return CONTENT_TYPE;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Converts the pixels of a BitmapData object
		 *  to a PNG-encoded ByteArray object.
		 *
		 *  @param bitmapData The input BitmapData object.
		 *
		 *  @return Returns a ByteArray object containing PNG-encoded image data.
		 */
		public function encode(bitmapData:BitmapData):ByteArray
		{
			return internalEncode(bitmapData, bitmapData.width, bitmapData.height,
				bitmapData.transparent);
		}
		
		/**
		 *  Converts a ByteArray object containing raw pixels
		 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
		 *  to a new PNG-encoded ByteArray object.
		 *  The original ByteArray is left unchanged.
		 *
		 *  @param byteArray The input ByteArray object containing raw pixels.
		 *  This ByteArray should contain
		 *  <code>4 * width * height</code> bytes.
		 *  Each pixel is represented by 4 bytes, in the order ARGB.
		 *  The first four bytes represent the top-left pixel of the image.
		 *  The next four bytes represent the pixel to its right, etc.
		 *  Each row follows the previous one without any padding.
		 *
		 *  @param width The width of the input image, in pixels.
		 *
		 *  @param height The height of the input image, in pixels.
		 *
		 *  @param transparent If <code>false</code>, alpha channel information
		 *  is ignored but you still must represent each pixel
		 *  as four bytes in ARGB format.
		 *
		 *  @return Returns a ByteArray object containing PNG-encoded image data.
		 */
		public function encodeByteArray(byteArray:ByteArray, width:int, height:int,
										transparent:Boolean = true):ByteArray
		{
			return internalEncode(byteArray, width, height, transparent);
		}
		
		/**
		 *  @private
		 */
		private function initializeCRCTable():void
		{
			crcTable = [];
			
			for (var n:uint = 0; n < 256; n++)
			{
				var c:uint = n;
				for (var k:uint = 0; k < 8; k++)
				{
					if (c & 1)
						c = uint(uint(0xedb88320) ^ uint(c >>> 1));
					else
						c = uint(c >>> 1);
				}
				crcTable[n] = c;
			}
		}
		
		/**
		 *  @private
		 */
		private function internalEncode(source:Object, width:int, height:int,
										transparent:Boolean = true):ByteArray
		{
			
			// The source is either a BitmapData or a ByteArray.
			var sourceBitmapData:BitmapData = source as BitmapData;
			var sourceByteArray:ByteArray = source as ByteArray;
			if (sourceByteArray)
				sourceByteArray.position = 0;
			// Create output byte array
			var png:ByteArray = new ByteArray();
			// Write PNG signature
			png.writeUnsignedInt(0x89504E47);
			png.writeUnsignedInt(0x0D0A1A0A);
			// Build IHDR chunk
			var IHDR:ByteArray = new ByteArray();
			IHDR.writeInt(width);
			IHDR.writeInt(height);
			IHDR.writeByte(8); // bit depth per channel
			IHDR.writeByte(2); // color type: RGBA
			IHDR.writeByte(0); // compression method
			IHDR.writeByte(0); // filter method
			IHDR.writeByte(0); // interlace method
			writeChunk(png, 0x49484452, IHDR);
			// Build IDAT chunk
			var IDAT:ByteArray = new ByteArray();
			
			var alpha:uint;
			var r:uint;
			var g:uint;
			var b:uint;
			
			for (var y:int = 0; y < height; y++)
			{
				IDAT.writeByte(0); // no filter
				var x:int;
				var pixel:uint;
				for (x = 0; x < width; x++)
				{
					pixel = sourceBitmapData.getPixel32(x, y);
					
					alpha = pixel >> 24 & 0xFF; //alpha=255 if no transparency
					
					r = pixel >> 16 & 0xFF;
					g = pixel >> 8 & 0xFF;
					b = pixel & 0xFF;
					
					alpha = 0xFF - alpha; //invert alpha value
					r+=alpha;
					g+=alpha;
					b+=alpha;
					
					IDAT.writeByte(limit8byte(r));
					IDAT.writeByte(limit8byte(g));
					IDAT.writeByte(limit8byte(b));          
				}
			}
			IDAT.compress();
			writeChunk(png, 0x49444154, IDAT);
			// Build IEND chunk
			writeChunk(png, 0x49454E44, null);
			// return PNG
			png.position = 0;
			return png;
		}
		
		private function limit8byte(n:uint):uint {
			if (n>0xFF)
				return 0xFF;
			else
				return n;
		}
		
		
		/**
		 *  @private
		 */
		private function writeChunk(png:ByteArray, type:uint, data:ByteArray):void
		{
			// Write length of data.
			var len:uint = 0;
			if (data)
				len = data.length;
			png.writeUnsignedInt(len);
			
			// Write chunk type.
			var typePos:uint = png.position;
			png.writeUnsignedInt(type);
			
			// Write data.
			if (data)
				png.writeBytes(data);
			
			// Write CRC of chunk type and data.
			var crcPos:uint = png.position;
			png.position = typePos;
			var crc:uint = 0xFFFFFFFF;
			for (var i:uint = typePos; i < crcPos; i++)
			{
				crc = uint(crcTable[(crc ^ png.readUnsignedByte()) & uint(0xFF)] ^
					uint(crc >>> 8));
			}
			crc = uint(crc ^ uint(0xFFFFFFFF));
			png.position = crcPos;
			png.writeUnsignedInt(crc);
		}
	}
	
}