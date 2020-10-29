package GNNC.audio
{
	import flash.display.Sprite;
	import flash.media.Sound;

	public class gnncAudio extends Sprite
	{
		public function gnncAudio()
		{
		}

		public static function play(sound:Class):void
		{
			if( sound == null )
				return;

			var p:Sound = sound as Sound;
			p.play();
		}

	}
}