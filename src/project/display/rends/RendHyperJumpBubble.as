package project.display.rends
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class RendHyperJumpBubble extends Sprite
	{
		
		private static const tf:TextFormat = new TextFormat('Ritalin', 20, 0xFFFFFF, true);
		
		protected var txt:TextField;
		
		public function RendHyperJumpBubble()
		{			
			txt = new TextField;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.embedFonts = true;			
			txt.defaultTextFormat = tf;
			
			txt.text = 'КиййЯ!';
			txt.x = -int(txt.width/2);
			txt.y = -int(txt.height/2);
			
			txt.selectable = false;

			addChild(txt);			
		}
		
		public function fade():RendHyperJumpBubble
		{
			TweenMax.to(this, 1, {alpha: 0, scaleX: 1.2, scaleY: 1.2});
			return this;
		}

	}
}