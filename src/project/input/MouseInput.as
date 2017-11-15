package project.input
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MouseInput
	{
		
		protected var container:Sprite;
		
		protected var clicked:Boolean = false;
		
		public var mouseIsOver:Boolean = false;
		public var mouseX:Number = NaN;
		public var mouseY:Number = NaN;
		
		public function MouseInput(container:Sprite)
		{
			this.container = container;		
			
			container.mouseChildren = false;
			
			container.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			container.addEventListener(Event.MOUSE_LEAVE, mouseLeft);
			
			container.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function getClicked():Boolean
		{
			var result:Boolean = clicked;
			
			clicked = false;
			
			return result;
		}
		
		protected function mouseMoved(e:MouseEvent):void
		{
			mouseIsOver = true;
			mouseX = container.mouseX;
			mouseY = container.mouseY;
		}
		
		protected function mouseLeft(e:MouseEvent):void
		{
			mouseIsOver = false;
			mouseX = NaN;
			mouseY = NaN;
		}
		
		protected function onMouseClick(e:MouseEvent):void
		{
			clicked = true;
		}
	}
}
