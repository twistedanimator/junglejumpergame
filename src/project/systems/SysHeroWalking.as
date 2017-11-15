package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import project.components.CompHeroStates;
	import project.components.CompMovement;
	import project.components.CompPosition;
	import project.input.MouseInput;
	import project.model.GameModel;
	
	public class SysHeroWalking extends ListIteratingSystem
	{
		
		protected var model:GameModel;
		protected var input:MouseInput;
		
		public function SysHeroWalking(model:GameModel, input:MouseInput)
		{
			super(NodeHeroWalking, nodeUpdate);
			
			this.model = model;
			this.input = input;
		}
		
		protected function nodeUpdate(node:NodeHeroWalking, time:Number):void
		{
			var position : CompPosition = node.position;
			var movement : CompMovement = node.movement;
			
			var states:CompHeroStates = node.heroStates;
			
			if(input.getClicked())
			{
				if(!model.state.fallDown)
				{
					node.jumping.setJump( model.design.landJump ); 					
					return;
				}
				
			}
			
			var speed:Number = node.walking.speed;
			
			var direction:int = 0;
			
			if(input.mouseIsOver)
			{
				var mouseX:Number = input.mouseX;
				
				var hr:Number = 5;
				
				var x:Number = position.x; 				
				
				if(mouseX<x-hr)
				{
					direction = -1;
				}
				else if(mouseX>x+hr)
				{
					direction = 1;
				}	
			}			
			
			if(direction)
			{
				movement.x = speed * direction;
				states.changeState(CompHeroStates.WALK);
			}
			else
			{
				movement.x = 0;
				states.changeState(CompHeroStates.STAY);
				
			}
		}
	}
}
import ash.core.Node;

import project.components.CompHeroStates;
import project.components.CompHeroWalking;
import project.components.CompHeroJumping;
import project.components.CompMovement;
import project.components.CompPosition;

class NodeHeroWalking extends Node
{
	public var heroStates:CompHeroStates;
	public var jumping:CompHeroJumping;
	public var walking:CompHeroWalking;
	
	public var position:CompPosition;
	public var movement:CompMovement;
}