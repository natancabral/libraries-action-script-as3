package GNNC.data.zip
{
	public class gnncZip
	{
		public function gnncZip()
		{
		}
	}
}

/**
 
 // create the Zip file, first param : compression method
 var myZip:ASZip = new ASZip (CompressionMethod.GZIP);
 // create a flash.display.BitmapData
 var myStevie:Stevie = new Stevie (0, 0);
 // encode it as a PNG
 var bytes:ByteArray = PNGEnc.encode (myStevie);
 // create a text stream
 var txt:ByteArray = new ByteArray();
 // write some text into it
 txt.writeUTFBytes("Hello there !!");
 // add a pics folder
 myZip.addDirectory ("pics/");
 // then a text folder
 myZip.addDirectory ("text/");
 // pass the PNG stream and specify a file name and location
 myZip.addFile (bytes, "pics/stevie.png");
 // pass the text stream and specify a file name and location
 myZip.addFile (txt, "text/story.txt");
 // add a comment
 myZip.addComment ("A comment !");
 // generate final Zip file
 var myZipFile:ByteArray = myZip.saveZIP ( Method.LOCAL );
 
 */