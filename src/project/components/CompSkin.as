package project.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class CompSkin
	{
		
		public var sprite:Sprite;
		
		protected var animation:MovieClip;
		
		public function CompSkin(sprite:Sprite)
		{
			this.sprite = sprite;
			
			animation = sprite.getChildByName('animation') as MovieClip;
			if(animation)
			{
				sprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				sprite.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}
		}
		
		public function replay():void
		{
			if(animation)
			{
				animation.gotoAndPlay(1);
			}
			
		}
		
		protected function onAddedToStage(e:Event):void
		{
			animation.gotoAndPlay(1);
		}
		
		protected function onRemovedFromStage(e:Event):void
		{
			animation.gotoAndStop(1);
		}
		
		
		

	}
}