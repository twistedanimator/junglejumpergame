package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class StartScreen extends Sprite
	{
		
		protected var bg:Sprite;
		protected var parrot:MovieClip;

		public var onHidden:Function;
		public var onAppeared:Function;

		
		public function StartScreen()
		{
			blendMode = BlendMode.LAYER;
			
			bg = new $startScreenBackground;
			addChild(bg);
			
			parrot = new $parrot;		
			parrot.width = 70;
			parrot.scaleY = parrot.scaleX;			
			runParrot();
		}
		
		public function hide():void
		{
			TweenMax.killDelayedCallsTo(runParrot);
			TweenMax.to(this, 0.5, {alpha: 0, ease: Sine.easeOut, onComplete: onHideComplete});
		}
		
		public function show():void
		{
			visible = true;
			TweenMax.to(this, 0.5, {alpha: 1, ease: Sine.easeOut, onComplete: onShowComplete});
		}
		
		protected function onShowComplete():void
		{
			mouseChildren = true;
			runParrot();
			if(onAppeared != null)
			{
				onAppeared();
			}			
		}
		
		protected function onHideComplete():void
		{
			visible = false;
			if(onHidden != null)
			{
				onHidden();
			}
		}
		
		protected function runParrot():void
		{
			if(Math.random()>0.4)
			{
				parrot.scaleX = -parrot.scaleX;
			}
			
			var targetX:Number;
			if(parrot.scaleX>0)
			{
				parrot.x = -parrot.width;
				targetX = bg.width + parrot.width;
			}
			else
			{
				parrot.x = bg.width + parrot.width;
				targetX = -parrot.width;
			}
			
			parrot.y = int(Math.random()*30) + 50;
			bg.addChildAt( parrot, 1 );
			
			var targetHeight:String = String( -30+int(Math.random()*70) );
			TweenMax.to(parrot, 5, {x: targetX, y: targetHeight, onComplete: onParrotComplete, ease: Linear.easeIn});
		}
		
		protected function onParrotComplete():void
		{
			TweenMax.delayedCall(3+Math.random()*5, runParrot);
		}
	}
}