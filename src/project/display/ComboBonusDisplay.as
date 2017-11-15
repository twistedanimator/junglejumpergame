package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Sine;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ComboBonusDisplay extends Sprite
	{
		
		protected var valueContainer:Sprite;
		protected var txtValue:TextField;
		
		protected var _value:int = 0;
		
		protected var valueX:Number;
		protected var valueY:Number = -18;;
		
		public function ComboBonusDisplay()
		{
			
			var txt:TextField;
			var tf:TextFormat = new TextFormat('Ritalin', 30, 0xFFFFFF, true);
			
			txt = new TextField;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.embedFonts = true;			
			txt.defaultTextFormat = tf;
			txt.text = 'Бонус: ';	
			valueX = txt.width;
			
			tf.size = 51;
			txtValue = new TextField;
			txtValue.autoSize = TextFieldAutoSize.LEFT;
			txtValue.embedFonts = true;			
			txtValue.defaultTextFormat = tf;
			txtValue.text = 'x3';			
			
			valueContainer = new Sprite;
			valueContainer.addChild(txtValue);
			
			valueContainer.x = valueX;
			valueContainer.y = valueY;
			
			addChild(txt);
			addChild(valueContainer);
			
			alpha = 0;
			
			mouseChildren = mouseEnabled = false;
		}
		
		public function setValue(value:int):void
		{
			if(_value!=value)
			{
				
				if(value>2)
				{
					alpha = 1;
					
					txtValue.text = 'x'+value;	
					valueContainer.scaleX = valueContainer.scaleY = 1;
					valueContainer.x = valueX;
					valueContainer.y = valueY;
					
					TweenMax.from(valueContainer, .5, {transformAroundCenter: {scale: 0.2}, ease: Back.easeOut});
				}
				else
				{
					if(alpha)
					{
						TweenMax.to(this, 1, {alpha: 0, ease: Sine.easeOut});
					}
				}
				
				
				
				_value = value;
				
			}
		}
	}
}