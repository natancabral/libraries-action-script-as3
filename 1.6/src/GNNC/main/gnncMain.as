package GNNC.main
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;

	[SWF(frameRate=60, width=500, height=500)]
	public class gnncMain extends MovieClip 
	{
		public function gnncMain()
		{
			super();
			
			stage.scaleMode 		= StageScaleMode.NO_SCALE;
			stage.align 			= StageAlign.TOP_LEFT;
			stage.quality 			= StageQuality.BEST;
			stage.stageFocusRect 	= false;
		}
	}
}
