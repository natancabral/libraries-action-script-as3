package GNNC.data.bitmap
{
	import com.adobe.images.PNGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.core.BitmapAsset;
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.IImageEncoder;
	import mx.graphics.codec.JPEGEncoder;
	import mx.utils.Base64Decoder;
	import mx.utils.GraphicsUtil;
	
	import spark.components.Image;
	
	public class gnncBitmap
	{
		/**
		 * 
		 * B.source 	= gnncBitmap.__captureBitmap(TT); 
		 * 
		 * **/
		
		//private const JPG:JPEGEncoder 			= new JPEGEncoder();
		//private const PNG:PNGEncoder 				= new PNGEncoder();
		
		private static var lineBreak:Boolean;

		private static var _b64Chars:Array = new Array(
			
			'A','B','C','D','E','F','G','H',
			'I','J','K','L','M','N','O','P',
			'Q','R','S','T','U','V','W','X',
			'Y','Z','a','b','c','d','e','f',
			'g','h','i','j','k','l','m','n',
			'o','p','q','r','s','t','u','v',
			'w','x','y','z','0','1','2','3',
			'4','5','6','7','8','9','+','/'
		);

		/*
		takes a byteArray as input and return the base64 string
		*/
		
		private static var lookupObject:Dictionary = buildLookUpObject();
		
		public function gnncBitmap()
		{
		}
		
		static public function __class2Bitmap(classBitmap:*):Bitmap
		{
			return new Bitmap((classBitmap as BitmapAsset).bitmapData);
		}

		static public function __class2BitmapData(classBitmap:*):BitmapData
		{
			return new Bitmap((classBitmap as BitmapAsset).bitmapData).bitmapData;
		}
		
		static public function __captureBitmap(sourceComponentFlexId_:IBitmapDrawable,smooth_:Boolean=false):Bitmap
		{
			var imageBitmapData:BitmapData = ImageSnapshot.captureBitmapData(sourceComponentFlexId_);
			return new Bitmap(imageBitmapData,'auto',smooth_);
		}

		static public function __captureBitmapData(sourceComponentFlexId_:IBitmapDrawable,smooth_:Boolean=false):BitmapData
		{
			var imageBitmapData:BitmapData = ImageSnapshot.captureBitmapData(sourceComponentFlexId_,null,null,null,null,smooth_);
			return imageBitmapData;
		}
		
		static public function __captureBitmap2ByteArray(sourceComponentFlexId_:IBitmapDrawable,DPI:uint=0,pngEncoder_:Boolean=true,jpgQuality_:Number=90):ByteArray
		{
			var encode:Object = pngEncoder_ ? new PNGEncoder() : new JPEGEncoder(jpgQuality_);
			var imageBitmapData:ImageSnapshot = ImageSnapshot.captureImage(sourceComponentFlexId_,DPI,encode as IImageEncoder,true);
			return imageBitmapData.data as ByteArray;
		}

		/** 
		 * #########################################
		 * #########################################
		 * scale
		 * #########################################
		 * ######################################### 
		 * */

		/**
		 * Takes a target DisplayObject, rasterizes it into a Bitmap, and returns it in a container Sprite 
		 * transformed to be identical to the target.
		 */
		public static function __resize2Bitmap(target:DisplayObject, useAlpha:Boolean = true, scaleX:Number = 1, scaleY:Number = 1):Sprite 
		{
			var bounds:Rectangle = target.getBounds(target);
			var bmpd:BitmapData = new BitmapData(target.width * scaleX, target.height * scaleY, useAlpha, 0x00000000);
			var mat:Matrix = new Matrix();
			mat.translate(-bounds.left, -bounds.top);
			mat.scale(scaleX, scaleY);
			bmpd.draw(target, mat);
			
			var bmp:Bitmap = new Bitmap(bmpd, PixelSnapping.ALWAYS, true);
			bmp.x = bounds.left;
			bmp.y = bounds.top;
			var container:Sprite = new Sprite();
			container.cacheAsBitmap = true;
			container.transform.matrix = target.transform.matrix;
			container.addChild(bmp);
			return container;
		}

		/** 
		 * #########################################
		 * #########################################
		 * byteArray to Bitmap is PUBLIC function
		 * #########################################
		 * ######################################### 
		 * */

		public  var _bitmapData:BitmapData;
		
		public function __byteArray2BitmapData(byteArray_:ByteArray,functionComplete_Event_:Function=null):void
		{
			var _loader:Loader = new Loader();
			
			if(functionComplete_Event_!=null)
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, functionComplete_Event_,false,0);
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __getBitmapData,false,1);
			_loader.loadBytes(byteArray_);
		
			function __getBitmapData(e:Event):void 
			{
				var content:* = _loader.content;
				var BMPData:BitmapData = new BitmapData(content.width,content.height,true,0x000000);
				var UIMatrix:Matrix = new Matrix();
				BMPData.draw(content, UIMatrix);
				_bitmapData = BMPData;
			}
		}
		
		/** 
		 * #########################################
		 * #########################################
		 * Decode and Encode Base 64
		 * #########################################
		 * ######################################### 
		 * */
		
		static public function __encodeBase64Image(image_:Image):String 
		{
			var text:String = 'noContent';
			var base64Dec:Base64Decoder;
			var pngEnc:PNGEncoder;
			var imgSnap:ImageSnapshot;
			
			pngEnc = new PNGEncoder();
			
			if(image_.source !=null)
			{
				imgSnap = ImageSnapshot.captureImage(image_ as IBitmapDrawable, 0, pngEnc as IImageEncoder);
				text = ImageSnapshot.encodeImageAsBase64(imgSnap);
			}
			
			return text;
		}
		
		static public function __decodeBase64Image(image_:Image,imageBase64_:String):Object 
		{
			var base64Dec:Base64Decoder;
			var pngEnc:PNGEncoder;
			var byteArr:ByteArray;
			
			base64Dec = new Base64Decoder();
			base64Dec.decode(imageBase64_);
			
			byteArr = base64Dec.toByteArray();
			image_.source = byteArr;
			
			return image_;
		}
		
		public static function __encode64(pByteArray:ByteArray, pLineBreak:Boolean=true ):String
		{	
			lineBreak = pLineBreak;
			
			return __encode64Bytes ( pByteArray );	
		}

		public static function __decode64 ( pString:String ):ByteArray
		{	
			return __decodeString ( pString ); 	
		}

		private static function __encode64Bytes ( pByteArray:ByteArray ):String
		{
			var output:String = '';
			var bufferSize:int;
			pByteArray.position = 0;
			var col:int = 0;
			
			while ( bufferSize = pByteArray.bytesAvailable ) {
				
				bufferSize = Math.min ( 3, bufferSize );
				
				var bytePacket:ByteArray = new ByteArray();
				
				pByteArray.readBytes ( bytePacket, 0, bufferSize );
				
				output += __encodeBytePacket ( bytePacket );
				
				col += 4;
				
				if ( lineBreak &&  ( col % 76 ) == 0 )
				{
					output += '\n';
					col = 0;			
				}
			}
			return output;
		}

		private static function __encodeBytePacket ( pByteArrayPacket:ByteArray ):String 
		{
			var encodedString:String = '';
			var packetLength:uint = pByteArrayPacket.length;
			
			encodedString += _b64Chars[pByteArrayPacket[0] >> 2];
			
			if ( packetLength == 1 ) {
				
				encodedString +=( _b64Chars[((pByteArrayPacket[0] << 4) & 0x3F)] );
				encodedString += ("=="); 
				
			} else if ( packetLength == 2 ) {
				
				encodedString += ( _b64Chars[(pByteArrayPacket[0] << 4) & 0x3F | pByteArrayPacket[1] >> 4 ] );
				encodedString += ( _b64Chars[(pByteArrayPacket[1] << 2) & 0x3F ] );
				encodedString += ("=");		
				
			} else
			{	
				encodedString +=( _b64Chars[(pByteArrayPacket[0] << 4) & 0x3F | pByteArrayPacket[1] >> 4 ] );
				encodedString +=( _b64Chars[(pByteArrayPacket[1] << 2) & 0x3F | pByteArrayPacket[2] >> 6 ] );
				encodedString +=( _b64Chars[pByteArrayPacket[2] & 0x3F] );	
			}
			return encodedString;
		}
		
		private static function buildLookUpObject ():Dictionary
		{
			var obj:Dictionary = new Dictionary();
			
			for (var i:int = 0; i< _b64Chars.length; i++ ) obj[_b64Chars[i]] = i;
			
			return obj;	
		}

		private static function __decodeString ( pString:String ):ByteArray 
		{
			var sourceString:String = pString;
			var base64Bytes:ByteArray = new ByteArray();
			var stringPacket:String = ""; 
			var lng:int = sourceString.length;
			
			for (var i:int = 0; i< lng; i++ )
			{	
				stringPacket += sourceString.charAt ( i );
				
				if ( stringPacket.length == 4 )
				{	
					base64Bytes.writeBytes ( __decodeStringPacket ( stringPacket ) );
					
					stringPacket = "";	
				}
			}
			return base64Bytes;
		}
		
		private static function __decodeStringPacket ( stringBuffer:String ):ByteArray
		{		
			var byteStringPacket:ByteArray = new ByteArray();
			
			var charValue1:uint = lookupObject[stringBuffer.charAt ( 0 )];
			var charValue2:uint = lookupObject[stringBuffer.charAt ( 1 )];
			var charValue3:uint = lookupObject[stringBuffer.charAt ( 2 )];
			var charValue4:uint = lookupObject[stringBuffer.charAt ( 3 )];
			
			byteStringPacket.writeByte(charValue1 << 2 | charValue2 >> 4);
			if (stringBuffer.charAt(2) != "=") byteStringPacket.writeByte(charValue2 << 4 | charValue3 >> 2);
			if (stringBuffer.charAt(3) != "=") byteStringPacket.writeByte(charValue3 << 6 | charValue4);
			
			return byteStringPacket;	
		}


		/** 
		 * #########################################
		 * #########################################
		 * Converter Sprite and Graphics
		 * #########################################
		 * ######################################### 
		 * */

		// **********************************************************************************
		
		
		/**
		 * Converts a Bitmap to a Sprite.
		 *
		 * @param   bitmap      The Bitmap that should be converted.
		 * @param   smoothing   Whether or not the bitmap is smoothed when scaled.
		 * @return              The converted Sprite object.
		 * 
		 * @see                 http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#smoothing
		 */
		public static function __bitmap2Sprite(bitmap:Bitmap, smoothing:Boolean = false):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.addChild( new Bitmap(bitmap.bitmapData.clone(), "auto", smoothing) );
			return sprite;
			
		} // END FUNCTION bitmapToSprite
		
		
		/**
		 * Converts BitmapData to a Sprite.
		 *
		 * @param   bitmap      The Bitmap that should be converted.
		 * @param   smoothing   Whether or not the bitmap is smoothed when scaled.
		 * @return              The converted Sprite object.
		 * 
		 * @see                 http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Bitmap.html#smoothing
		 */
		public static function __bitmapData2Sprite(bitmapData:BitmapData, smoothing:Boolean = false):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.addChild( new Bitmap(bitmapData.clone(), "auto", smoothing) );
			return sprite;
			
		} // END FUNCTION bitmapToSprite

		
		// **********************************************************************************

		/**
		 * Converts a Sprite to a Bitmap.
		 *
		 * @param   sprite      The Sprite that should be converted.
		 * @param   smoothing   Whether or not the bitmap is smoothed when scaled.
		 * @return              The converted Bitmap object.
		 * 
		 * @see                 http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/BitmapData.html#draw()
		 */
		public static function __sprite2Bitmap(sprite:Sprite, smoothing:Boolean = false):Bitmap
		{
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
			bitmapData.draw(sprite);
			
			return new Bitmap(bitmapData, "auto", smoothing);
			
		} // END FUNCTION spriteToBitmap
		
		
		
		/**
		 * JH DotComIT added 11/19/2011
		 * Converts a Sprite to a BitmapData.
		 *
		 * @param   sprite      The Sprite that should be converted.
		 * @return              The converted Bitmap object.
		 * 
		 * @see                 http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/BitmapData.html#draw()
		 */
		public static function __sprite2BitmapData(sprite:Sprite):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
			bitmapData.draw(sprite);
			
			return bitmapData;
			
		} // END FUNCTION spriteToBitmapData
		
		// **********************************************************************************
		
		public static function __graphics2Bitmap(graphics:Graphics, width:Number, height:Number, smoothing:Boolean = false):Bitmap
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.copyFrom(graphics);
			sprite.graphics.endFill();
			
			return __sprite2Bitmap(sprite);
		}
		
		public static function __graphics2BitmapData(graphics:Graphics, width:Number, height:Number):BitmapData
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.copyFrom(graphics);
			sprite.graphics.endFill();
			
			return __sprite2BitmapData(sprite);
		} 

	}
}