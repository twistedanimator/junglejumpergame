package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;

	public class TextButton extends Sprite
	{
		protected var holder:Sprite;
		protected var txtLabel:TextField;
		
		protected var callback:Function;
		
		public function TextButton(text:String, callback:Function = null)
		{
			
			this.callback = callback;
			
			holder = new Sprite;
			addChild(holder);
			
			var sp1:Sprite = new Sprite;
			holder.addChild(sp1);
			sp1.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 5)];
			
			txtLabel = TextFactory.createLabel2(text);
			sp1.addChild(txtLabel);
			
			var g:Graphics = graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			mouseChildren = false;
			buttonMode = useHandCursor = true;
		}
		
		protected function onMouseOver(e:MouseEvent):void
		{
			TweenMax.to(holder, 0.1, {x: -1, y: -1, dropShadowFilter:{blurX:2, blurY:2, distance:1, alpha:1}, ease: Sine.easeOut});
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			TweenMax.to(holder, 0.1, {x: 0, y: 0, dropShadowFilter:{blurX:0, blurY:0, distance:0, alpha:0}, ease: Sine.easeOut});
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			TweenMax.to(holder, 0.1, {x: 0, y: 0, dropShadowFilter:{blurX:0, blurY:0, distance:0, alpha:0}, ease: Sine.easeOut});
			if(callback != null)
			{
				callback();
			}
		}
	}
}