package project.components
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;

	public class CompDisplay
	{
		
		public var sprite:Sprite;
		
		protected var container:Sprite;
		protected var skinContainer:Sprite;
		
		protected var renderDirection:Boolean = true;
		
		public function CompDisplay()
		{
			sprite = new Sprite;
			sprite.addChild( container = new Sprite);
			container.addChild( skinContainer = new Sprite );
			
		}
		
		public function setSkin(skin:Sprite):void
		{
			skinContainer.addChild( skin );
		}
		
		public function unsetSkin(skin:Sprite):void
		{
			if(skin.parent == skinContainer)
			{
				skinContainer.removeChild( skin );
			}			
		}
		
		public function scaleSkin(scale:Number):void
		{
			skinContainer.scaleX = skinContainer.scaleY = scale;
		}
		
		public function setDirection(direction:int):void
		{
			if(renderDirection)
			{
				container.scaleX = direction;
			}
			
		}
		
		public function animateSkinRotation():void
		{
			
			if(renderDirection)
			{
				renderDirection = false;
				TweenMax.to(container, 0.8, {rotation: 720, ease: Circ.easeOut, onComplete:onRotationComplete});
			}						
			
		}
		
		protected function onRotationComplete():void
		{
			renderDirection = true;
		}
	}
}