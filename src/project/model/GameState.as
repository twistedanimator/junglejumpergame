package project.model
{
	import flash.geom.Rectangle;
	
	import project.utils.SlotNumber;

	public class GameState
	{
		
		public const camera:Rectangle = new Rectangle;
		
		public var time:Number = 0;
		
		public var lastHyperJumpTime:Number = NaN;
		
		public var magicJumpsEnabled:Boolean = true; 
		public var parrotsBonusEnabled:Boolean = true; 
		
		public const score:SlotNumber = new SlotNumber;
		public const numJumps:SlotNumber = new SlotNumber;		
		public const smoothFlowBonus:SlotNumber = new SlotNumber;
		
		public var jumpingStarted:Boolean = false;
		public var fallDown:Boolean = false;
		
		public var lastParrotDistance:Number;
		
		public var prevBaloonX:Number;
		
		
		protected var design:GameDesign;
		
		public function GameState(design:GameDesign)
		{
			this.design = design;
			camera.setTo(0, 0, design.gameWidth, design.gameHeight);
			
			reset();
		}
		
		public function reset():void
		{
			
			camera.y = camera.height;
			
			time = 0;
			
			lastHyperJumpTime = NaN;
			magicJumpsEnabled = true;
			parrotsBonusEnabled = true;
			
			score.value = 0;			
			numJumps.value = 1;
			
			smoothFlowBonus.value = 0;
			
			jumpingStarted = false;
			fallDown = false;
			
			
			lastParrotDistance = design.defaultParrotsDistance; 
			prevBaloonX = design.gameWidth/2;
		}
	}
}