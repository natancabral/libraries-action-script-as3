/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package GNNC.data.encrypt
{
	import GNNC.data.encrypt.gnncIntUtil;
	import flash.utils.ByteArray;
	import mx.utils.Base64Encoder;
	
	/**
	 * The SHA-256 algorithm
	 * 
	 * @see http://csrc.nist.gov/publications/fips/fips180-2/fips180-2withchangenotice.pdf
	 */
	public class gnncSHA256
	{
		public static const TYPE_ID:String = "SHA-256";
		
		private static var k:Array = 
			[0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
				0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
				0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
				0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
				0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
				0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
				0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
				0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2];

		public static var digest:ByteArray;
		/**
		 *  Performs the SHA256 hash algorithm on a string.
		 *
		 *  @param s		The string to hash
		 *  @return			A string containing the hash value of s
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 *  @tiptext
		 */
		public static function hash( s:String ):String {
			var blocks:Array = createBlocksFromString( s );
			var byteArray:ByteArray = hashBlocks( blocks );
			
			return gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true );
		}
		
		/**
		 *  Performs the SHA256 hash algorithm on a ByteArray.
		 *
		 *  @param data		The ByteArray data to hash
		 *  @return			A string containing the hash value of data
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 */
		public static function hashBytes( data:ByteArray ):String
		{
			var blocks:Array = createBlocksFromByteArray( data );
			var byteArray:ByteArray = hashBlocks(blocks);
			
			return gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true )
					+ gnncIntUtil.toHex( byteArray.readInt(), true );
		}
		
		/**
		 *  Performs the SHA256 hash algorithm on a string, then does
		 *  Base64 encoding on the result.
		 *
		 *  @param s		The string to hash
		 *  @return			The base64 encoded hash value of s
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 *  @tiptext
		 */
		public static function hashToBase64( s:String ):String
		{
			var blocks:Array = createBlocksFromString( s );
			var byteArray:ByteArray = hashBlocks(blocks);

			// ByteArray.toString() returns the contents as a UTF-8 string,
			// which we can't use because certain byte sequences might trigger
			// a UTF-8 conversion.  Instead, we convert the bytes to characters
			// one by one.
			var charsInByteArray:String = "";
			byteArray.position = 0;
			for (var j:int = 0; j < byteArray.length; j++)
			{
				var byte:uint = byteArray.readUnsignedByte();
				charsInByteArray += String.fromCharCode(byte);
			}

			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode(charsInByteArray);
			return encoder.flush();
		}
		
		private static function hashBlocks( blocks:Array ):ByteArray {
			var h0:int = 0x6a09e667;
			var h1:int = 0xbb67ae85;
			var h2:int = 0x3c6ef372;
			var h3:int = 0xa54ff53a;
			var h4:int = 0x510e527f;
			var h5:int = 0x9b05688c;
			var h6:int = 0x1f83d9ab;
			var h7:int = 0x5be0cd19;
			
			var k:Array = new Array(0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2);
			
			var len:int = blocks.length;
			var w:Array = new Array( 64 );
			
			// loop over all of the blocks
			for ( var i:int = 0; i < len; i += 16 ) {
				
				var a:int = h0;
				var b:int = h1;
				var c:int = h2;
				var d:int = h3;
				var e:int = h4;
				var f:int = h5;
				var g:int = h6;
				var h:int = h7;
				
				for(var t:int = 0; t < 64; t++) {
					
					if ( t < 16 ) {
						w[t] = blocks[ i + t ];
						if(isNaN(w[t])) { w[t] = 0; }
					} else {
						var ws0:int = gnncIntUtil.ror(w[t-15], 7) ^ gnncIntUtil.ror(w[t-15], 18) ^ (w[t-15] >>> 3);
						var ws1:int = gnncIntUtil.ror(w[t-2], 17) ^ gnncIntUtil.ror(w[t-2], 19) ^ (w[t-2] >>> 10);
						w[t] = w[t-16] + ws0 + w[t-7] + ws1;
					}
					
					var s0:int = gnncIntUtil.ror(a, 2) ^ gnncIntUtil.ror(a, 13) ^ gnncIntUtil.ror(a, 22);
					var maj:int = (a & b) ^ (a & c) ^ (b & c);
					var t2:int = s0 + maj;
					var s1:int = gnncIntUtil.ror(e, 6) ^ gnncIntUtil.ror(e, 11) ^ gnncIntUtil.ror(e, 25);
					var ch:int = (e & f) ^ ((~e) & g);
					var t1:int = h + s1 + ch + k[t] + w[t];
					
					h = g;
					g = f;
					f = e;
					e = d + t1;
					d = c;
					c = b;
					b = a;
					a = t1 + t2;
				}
					
				//Add this chunk's hash to result so far:
				h0 += a;
				h1 += b;
				h2 += c;
				h3 += d;
				h4 += e;
				h5 += f;
				h6 += g;
				h7 += h;
			}
			
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeInt(h0);
			byteArray.writeInt(h1);
			byteArray.writeInt(h2);
			byteArray.writeInt(h3);
			byteArray.writeInt(h4);
			byteArray.writeInt(h5);
			byteArray.writeInt(h6);
			byteArray.writeInt(h7);
			byteArray.position = 0;
			
			digest = new ByteArray();
			digest.writeBytes(byteArray);
			digest.position = 0;
			return byteArray;
		}
		
		/**
		 *  Converts a ByteArray to a sequence of 16-word blocks
		 *  that we'll do the processing on.  Appends padding
		 *  and length in the process.
		 *
		 *  @param data		The data to split into blocks
		 *  @return			An array containing the blocks into which data was split
		 */
		private static function createBlocksFromByteArray( data:ByteArray ):Array
		{
			var oldPosition:int = data.position;
			data.position = 0;
			
			var blocks:Array = new Array();
			var len:int = data.length * 8;
			var mask:int = 0xFF; // ignore hi byte of characters > 0xFF
			for( var i:int = 0; i < len; i += 8 )
			{
				blocks[ i >> 5 ] |= ( data.readByte() & mask ) << ( 24 - i % 32 );
			}
			
			// append padding and length
			blocks[ len >> 5 ] |= 0x80 << ( 24 - len % 32 );
			blocks[ ( ( ( len + 64 ) >> 9 ) << 4 ) + 15 ] = len;
			
			data.position = oldPosition;
			
			return blocks;
		}
					
		/**
		 *  Converts a string to a sequence of 16-word blocks
		 *  that we'll do the processing on.  Appends padding
		 *  and length in the process.
		 *
		 *  @param s	The string to split into blocks
		 *  @return		An array containing the blocks that s was split into.
		 */
		private static function createBlocksFromString( s:String ):Array
		{
			var blocks:Array = new Array();
			var len:int = s.length * 8;
			var mask:int = 0xFF; // ignore hi byte of characters > 0xFF
			for( var i:int = 0; i < len; i += 8 ) {
				blocks[ i >> 5 ] |= ( s.charCodeAt( i / 8 ) & mask ) << ( 24 - i % 32 );
			}
			
			// append padding and length
			blocks[ len >> 5 ] |= 0x80 << ( 24 - len % 32 );
			blocks[ ( ( ( len + 64 ) >> 9 ) << 4 ) + 15 ] = len;
			return blocks;
		}
		
		public static function computeDigest(byteArray:ByteArray):String
		{
			// Preprocessing
			
			// 0. Set the ByteArray's position to zero
			var originalPosition:uint = byteArray.position;
			byteArray.position = 0;
			
			// 1. Pad the message
			var paddingLength:int = byteArray.length % 64;
			
			paddingLength = 64 - paddingLength;
			
			if (paddingLength < (1 + 8))
			{
				paddingLength += 64;   //  need to pad a partial block plus a full block
			}
			
			var messagePadding:Array = new Array(paddingLength);
			var n:int = (byteArray.length + paddingLength) / 64;        // number of message blocks
			
			var messageLengthBits:uint = byteArray.length * 8;
			messagePadding[0] = 128;
			
			// put message size in last 32 bits of the message padding
			var i:int;
			
			for (i = 1; i < paddingLength - 8; i++)
			{
				messagePadding[i] = 0;
			}
			
			var lastIndex:int = messagePadding.length - 1;        // last index of messagePadding
			for (i = 0; i < 4; i++)
			{
				messagePadding[lastIndex - i] = (messageLengthBits >> (i << 3)) & 0xff;
			}    
			
			
			// 2. Set initial hash H(0)
			var h0:int = 0x6a09e667;
			var h1:int = 0xbb67ae85;
			var h2:int = 0x3c6ef372;
			var h3:int = 0xa54ff53a;
			var h4:int = 0x510e527f;
			var h5:int = 0x9b05688c;
			var h6:int = 0x1f83d9ab;
			var h7:int = 0x5be0cd19;
			
			var a:int;
			var b:int;
			var c:int;
			var d:int;
			var e:int;
			var f:int;
			var g:int;
			var h:int;        
			
			// Hash computation
			// for all message blocks
			var m:ByteArray = new ByteArray();    // message block; 16 32-bit words or 64 bytes
			var w:Array = new Array(64);    // message schedule, 64 32-bit words
			var paddingStart:uint = 0;           // index to start padding message
			var paddingSize:uint = 0;            // amount of padding to copy to message
			var j:uint;
			var t1:int;                    // temporary storage in hash loop
			var t2:int;                    // temporary storage in hash loop
			var t:uint;
			var msgIndex:uint;
			var wt2:int;                   // w[t - 2]
			var wt15:int;                  // w[t -15]
			
			//var messageSchTime:int = 0;
			//var hashTime:int = 0;
			//var startTime:int;
			//var endTime:int;
			
			for (i = 0; i < n; i++)
			{
				// get the next message block of 512 bits or 64 bytes.
				getMessageBlock(byteArray, m);
				
				// append pass to end of last message block
				if (i == (n - 2) && messagePadding.length > 64)
				{
					// pad end of message before last block
					paddingStart = 64 - (messagePadding.length % 64);
					paddingSize = 64 - paddingStart;
					for (j = 0; j < paddingSize; j++)
					{
						m[j + paddingStart] = messagePadding[j];
					}
					
				}
				else if (i == n - 1)
				{
					var prevPaddingSize:int = paddingSize;
					if (messagePadding.length > 64)
					{
						paddingStart = 0;
						paddingSize = 64;
					}
					else
					{
						paddingStart = 64 - messagePadding.length;
						paddingSize = messagePadding.length;
					}
					
					for (j = 0; j < paddingSize; j++)
					{
						m[j + paddingStart] = messagePadding[j + prevPaddingSize];
					}
				}
				
				// prepare the message schedule, w
				//startTime= getTimer();    
				for (t = 0; t < 64; t++)
				{
					if (t < 16)
					{
						msgIndex = t << 2;
						w[t] = int((m[msgIndex] << 24) | 
							(m[msgIndex + 1] << 16) | 
							(m[msgIndex + 2] << 8) | 
							m[msgIndex + 3]);
					}
					else 
					{
						// inline functions to boost performance. keep orginal code for reference.
						// w[t] = divisor1(w[t - 2]) + uint(w[t - 7]) + divisor0(w[t - 15]) + uint(w[t - 16]);
						wt2 = w[t -2];
						wt15 = w[t-15];   
						w[t] = int(int((((wt2 >>> 17) | (wt2 << 15)) ^ ((wt2 >>> 19) | (wt2 << 13)) ^ (wt2 >>> 10))) + // divisor1(w[t - 2])
							int(w[t - 7]) + 
							int((((wt15 >>> 7) | (wt15 << 25)) ^ ((wt15 >>> 18) | (wt15 << 14)) ^ (wt15 >>> 3))) + // divisor0(w[t - 15])
							int(w[t - 16]));
					}
				}
				
				//endTime= getTimer();    
				//messageSchTime += endTime - startTime;
				
				//startTime= getTimer();    
				
				a = h0;
				b = h1;
				c = h2;
				d = h3;
				e = h4;
				f = h5;
				g = h6;
				h = h7;
				
				for (t = 0; t < 64; t++)
				{
					// inline functions to boost performance. keep orginal code for reference.
					//t1 = h + sum1(e) + Ch(e, f, g) + uint(k[t]) + uint(w[t]);
					//t2 = sum0(a) + Maj(a, b, c);
					t1 = h + 
						int((((e >>> 6) | (e << 26)) ^ ((e >>> 11) | (e << 21)) ^ ((e >>> 25) | (e << 7)))) + //  sum1(e)
						int(((e & f) ^ (~e & g))) + // Ch(e, f, g)
						int(k[t]) + 
						int(w[t]);
					t2 = int((((a >>> 2) | (a << 30)) ^ ((a >>> 13) | (a << 19)) ^ ((a >>> 22) | (a << 10)))) + // sum0(a)
						int(((a & b) ^ (a & c) ^ (b & c))); // Maj(a, b, c)
					
					h = g;
					g = f;
					f = e;
					e = d + t1;
					d = c;
					c = b;
					b = a;
					a = t1 + t2;    
					
					//trace("t = " + t + " a = " + uint(a).toString(16) + " b = " + uint(b).toString(16) + 
					//      " c = " + uint(c).toString(16) + " d = " + uint(d).toString(16) + "\n");
					//trace("t = " + t + " e = " + uint(e).toString(16) + " f = " + uint(f).toString(16) + 
					//      " g = " + uint(g).toString(16) + " h = " + uint(h).toString(16) + "\n");
					
				}
				
				h0 += a;
				h1 += b;
				h2 += c;
				h3 += d;
				h4 += e;
				h5 += f;
				h6 += g;
				h7 += h;
				
				//endTime= getTimer();    
				//hashTime += endTime - startTime;
				
			}
			
			// Reset the ByteArray's position to where it was previously
			byteArray.position = originalPosition;
			
			//trace("messageSchTime = " + messageSchTime);
			//trace("hashTime = " + hashTime);
			
			// final digest is h1 | h2 | h3 | h4 | h5 | h6 | h7
			// convert H(i) variables to hex strings and concatinate
			return toHex(h0) + toHex(h1) +
				toHex(h2) + toHex(h3) +
				toHex(h4) + toHex(h5) +
				toHex(h6) + toHex(h7);
		}
		
		private static function toHex(n:uint):String
		{
			var s:String = n.toString(16);
			
			if (s.length < 8)
			{
				// add leading zeros
				var zeros:String = "0";
				var count:int = 8 - s.length;
				for (var i:int = 1; i < count; i++)
				{
					zeros = zeros.concat("0");
				}
				
				return zeros + s;
			}
			
			return s;
		}

		private static function getMessageBlock(byteArray:ByteArray, m:ByteArray):void
		{
			byteArray.readBytes(m, 0, Math.min(byteArray.bytesAvailable, 64));
			
			//            for (var i:int; i < length && (i + startingIndex) < byteArray.length; i++)
			//            {
			//                m[i] = byteArray[i + startingIndex];
			//            }
		}


	}
}
