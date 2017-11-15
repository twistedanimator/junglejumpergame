package project.display.rends
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class RendBaloon extends Sprite
	{
		public function RendBaloon(scale:Number = 1)
		{

			var mc:MovieClip = new $baloon;
			mc.gotoAndPlay( 1+int(Math.random()*(mc.totalFrames-1)) );			
			
			var bal:MovieClip = mc.getChildByName('bal') as MovieClip; 
			bal.gotoAndStop(int( Math.random()*4 )+1);
			
			var graphic:DisplayObject = bal.getChildByName('graphic');
			graphic.scaleX = graphic.scaleY = scale;
			
			addChild(mc);
		}
	}
}