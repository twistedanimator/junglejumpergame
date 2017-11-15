package project.display
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ScoreDisplay extends Sprite
	{
		protected var txtScore:TextField;
		
		public function ScoreDisplay()
		{
			var label:Sprite = new $labelScore;
			addChild(label);
			
			var tf:TextFormat;
			
			txtScore = new TextField;
			txtScore.autoSize = TextFieldAutoSize.LEFT;
			txtScore.embedFonts = true;
			
			tf = new TextFormat('Dalek', 20, 0xFFFFFF, true);			
			txtScore.defaultTextFormat = tf;
			
			txtScore.x = label.width + 5;
			txtScore.y = int( (txtScore.height - label.height)/2 );
//			txtScore.border = true;
			
			addChild(txtScore);
			
			mouseChildren = mouseEnabled = false;
		}
		
		public function setValue(value:int):void
		{
			txtScore.text = String(value);
		}
	}
}