package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Sprite;
	
	public class Popup extends Sprite
	{
		
		public var onAppeared:Function;
		public var onHidden:Function;
		
		protected var contentHolder:Sprite;
		protected var currentContent:Sprite;
		
		protected var targetContent:Sprite;		

		
		public function Popup(bg:Sprite = null, onHidden:Function = null)
		{
			this.onHidden = onHidden;
			
			if(bg)
			{
				addChild( bg );
			}
			
			addChild( contentHolder = new Sprite );
			
			alpha = 0;
			contentHolder.mouseChildren = false;
		}
		
		public function show(content:Sprite):void
		{
			
			if(content == currentContent)
			{
				return;
			}
			
			if(alpha)
			{
				if(currentContent)
				{
					targetContent = content;
					hideContent();
				}
				else
				{
					showContent(content);
				}				
			}
			else
			{
				contentHolder.addChild( content );
				
				currentContent = content;
				
				TweenMax.to(this, 0.5, {alpha: 1, ease: Sine.easeOut, onComplete: onShowComplete});				

			}
				
		}
		
		public function hide():void
		{
			if(alpha)
			{
				contentHolder.mouseChildren = false;
				TweenMax.to(this, 0.5, {alpha: 0, ease: Sine.easeOut, onComplete: onHideComplete});
			}
		}
		
		protected function onShowComplete():void
		{
			contentHolder.mouseChildren = true;
		}
		
		protected function showContent(content:Sprite):void
		{
			contentHolder.addChild( content );			
			currentContent = content;
			
			TweenMax.to(contentHolder, 0.5, {alpha: 1, ease: Sine.easeOut, onComplete: onShowComplete});
		}
		
		protected function hideContent():void
		{
			contentHolder.mouseChildren = false;
			TweenMax.to(contentHolder, 0.5, {alpha: 0, ease: Sine.easeOut, onComplete: onHideContentComplete});
		}
		
		protected function onHideContentComplete():void
		{
			contentHolder.removeChild(currentContent);
			currentContent = null;
			
			if(targetContent)
			{
				var content:Sprite = targetContent;
				targetContent = null;
				show( content );
			}
		}
		
		protected function onHideComplete():void
		{
			if(currentContent)
			{
				contentHolder.removeChild( currentContent );
				currentContent = null;
			}
			
			if(onHidden != null)
			{
				onHidden();
			}
			
		}
	}
}