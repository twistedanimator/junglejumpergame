package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import project.components.CompHeroStates;
	
	public class SysHeroJumping extends ListIteratingSystem
	{
		public function SysHeroJumping()
		{
			super(NodeHeroJumping, nodeUpdate);
		}
		
		protected function nodeUpdate(node:NodeHeroJumping, time:Number):void
		{
			var jump:Number = node.jumping.getJump();
			
			if(jump)
			{
				if(node.heroStates.getState() != CompHeroStates.FLY)
				{
					node.heroStates.changeState( CompHeroStates.FLY );
				}				
				
				node.movement.y = Math.max(node.movement.y, jump);	
				node.skin.replay();
				
				if(jump>1000)
				{				
//					node.display.renderDirection = false;
//					TweenMax.to(mc, 1, {rotation:540, onComplete:onRotationComplete, onCompleteParams:[node.display]});
					node.display.animateSkinRotation();
					
				}
				
			}
		}
	}
}
import ash.core.Node;

import project.components.CompDisplay;
import project.components.CompHeroJumping;
import project.components.CompHeroStates;
import project.components.CompMovement;
import project.components.CompPosition;
import project.components.CompSkin;

class NodeHeroJumping extends Node
{
	public var heroStates:CompHeroStates;
	public var jumping:CompHeroJumping;
	public var movement:CompMovement;
	public var position:CompPosition;
	public var skin:CompSkin;
	public var display:CompDisplay;
}