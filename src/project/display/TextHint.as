package project.display
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextHint extends Hint
	{
		
		protected const defaultText:String = '<u><b>ВОЛШЕБНЫЕ ПРЫЖКИ.</b></u><br/>Кликни левой кнопкой мыши, чтобы Марта смогла <b>оттолкнуться от воздуха</b>.<br/>Прыжки также используются для <b>улучшения способностей</b> мартышки.';
		
		protected var txt:TextField;
		protected var bg:Sprite;
		
		protected var textWidth:Number = 200;
		
		protected var renderedText:String = null;
		
		public function TextHint()
		{
			bg = new Sprite;
			bg.filters = [new DropShadowFilter(4, 45, 0, 0.5, 5, 5, 1, 3)];
			addChild(bg);
			
			var tf:TextFormat = new TextFormat('Calibri', 14, 0x494036);
			tf.align = TextFormatAlign.CENTER;
			
			txt = new TextField;
			txt.selectable = false;
			txt.y = height;
			txt.width = textWidth;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.autoSize = TextFieldAutoSize.LEFT;			
			txt.embedFonts = true;

			txt.defaultTextFormat = tf;			
			addChild(txt);
			
			hide();
		}
		
		public function show(text:String = null):void
		{
			
			if(text == null)
			{
				text = defaultText;
			}
			
			if(text != renderedText)
			{
				txt.htmlText = text;
				
				var g:Graphics = bg.graphics;
				g.clear();
				g.beginFill(0xFFFFFF, 1);
				g.drawRoundRect(0, 0, txt.width, txt.height, 10);
				g.endFill();
				
				renderedText = text;
			}			
			
			appear();
		}
	}
}