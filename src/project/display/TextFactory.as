package project.display
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import fonts.Calibri;
	import fonts.CalibriBold;
	import fonts.Dalek;
	import fonts.Ritalin;

	public class TextFactory
	{
		private static const tf1:TextFormat = new TextFormat('Ritalin', 20, 0xFFFFFF, true);
		
		private static const tf2:TextFormat = new TextFormat('Calibri', 18, 0x663300, true);
		
		public static function createLabel1(text:String = ''):TextField
		{			
			var txt:TextField = createLabel();
			txt.defaultTextFormat = tf1;
			txt.text = text;
			return txt;
		}
		
		public static function createLabel2(text:String = ''):TextField
		{			
			var txt:TextField = createLabel();
			txt.defaultTextFormat = tf2;
			txt.text = text;
			return txt;
		}
		
		private static function createLabel():TextField
		{
			var txt:TextField = new TextField;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.embedFonts = true;	
			txt.selectable = false;			
			
			return txt;
		}
		
		public static function traceFontNames():void
		{
			var f:Array = Font.enumerateFonts();
			for(var i:int = 0, l:int = f.length; i<l; i++)
			{
				var font:Font = f[i];
				trace(font.fontName);
			}
		}
		
		public function TextFactory()
		{
			fonts.Ritalin;
			fonts.Dalek;
			fonts.Calibri;
			fonts.CalibriBold;
			
			
			
		}
	}
}