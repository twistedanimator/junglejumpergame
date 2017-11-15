package project.display.rends
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import project.display.TextFactory;
	
	public class RendScoreBubble extends Sprite
	{
		
		
		
		protected var txtScore:TextField;
		
		public function RendScoreBubble()
		{			
			txtScore = TextFactory.createLabel1();
			
			setScore(0);
			addChild(txtScore);			
		}
		
		public function fade():RendScoreBubble
		{
			TweenMax.to(this, 2, {alpha: 0});
			return this;
		}
		
		public function setScore(score:int):RendScoreBubble
		{
			txtScore.text = String(score);
			txtScore.x = -int(txtScore.width/2);
			txtScore.y = -int(txtScore.height/2);
			
			return this;
		}
	}
}