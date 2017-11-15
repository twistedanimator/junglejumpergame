package project.display.rends
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class RendJumpsBonusBubble extends Sprite
	{
		
		private static const tf:TextFormat = new TextFormat('Ritalin', 20, 0xFFFFFF, true);
		
		protected var txtBonus:TextField;
		protected var icon:Sprite;
		
		public function RendJumpsBonusBubble()
		{			
			txtBonus = new TextField;
			txtBonus.autoSize = TextFieldAutoSize.LEFT;
			txtBonus.embedFonts = true;			
			txtBonus.defaultTextFormat = tf;
			txtBonus.selectable = false;
			
			icon = new $icon_monkey;
			
			setBonus(0);
			
			addChild(txtBonus);
			addChild(icon);
		}
		
		public function fade():RendJumpsBonusBubble
		{
			TweenMax.to(this, 0.5, {alpha: 0, transformAroundCenter: {scale: 2}, delay: 1.5});
			return this;
		}
		
		public function setBonus(score:int):RendJumpsBonusBubble
		{
			txtBonus.text = '+'+String(score);
			txtBonus.x = -int(txtBonus.width/2);
			txtBonus.y = -int(txtBonus.height/2);
			
			icon.height = txtBonus.height;
			icon.scaleX = icon.scaleY;			
			icon.x = txtBonus.x + txtBonus.width;
			icon.y = txtBonus.y;
			
			return this;
		}
	}
}