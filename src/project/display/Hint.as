package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Hint extends Sprite
	{
		public function Hint()
		{

		}
		
		public function hide():void
		{
			alpha = 0;
			visible = false;
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			
		}
		
		protected function appear():void
		{
			visible = true;
			alpha = 0;
			onMouseMove(null);
			
			
			TweenMax.to(this, 0.6, {alpha: 0.9, ease: Sine.easeOut});
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function onMouseMove(e:MouseEvent):void
		{
			x = parent.mouseX + 10;
			y = parent.mouseY + 10;
			
			var p:Point = new Point(x+width, y);
			
			p = parent.localToGlobal(p);
			
			if(p.x>stage.stageWidth)
			{
				x = parent.mouseX - width - 10;
			}
		}
	}
}