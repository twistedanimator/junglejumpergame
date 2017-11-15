package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import project.MainController;
	
	[SWF(frameRate="31", width="640", height="630", backgroundColor="#093d00")]
	public class Main extends Sprite
	{
		
		protected var app:MainController;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			app = new MainController(this);		

		}

	}
}