package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import project.components.CompHeroStates;
	import project.components.CompMovement;
	import project.components.CompPosition;
	import project.enums.EnumEvents;
	import project.event.CoordEvent;
	import project.input.MouseInput;
	import project.model.GameModel;
	
	public class SysHeroFlying extends ListIteratingSystem
	{
		protected var model:GameModel;
		protected var events:EventDispatcher;		
		protected var input:MouseInput;
		
		public function SysHeroFlying(model:GameModel, events:EventDispatcher, input:MouseInput)
		{
			super(NodeHeroFlying, nodeUpdate);
			
			this.model = model;
			this.events = events;
			this.input = input;
			
			
		}
		
		protected function nodeUpdate(node:NodeHeroFlying, time:Number):void
		{
			var position : CompPosition = node.position;
			var movement : CompMovement = node.movement;
			
			var states:CompHeroStates = node.heroStates;
			
			if(position.y == 0 && movement.y<=0)
			{
				movement.y = 0;
				states.changeState( CompHeroStates.STAY );
				
				if(model.state.jumpingStarted)
				{
					model.state.fallDown = true;
					events.dispatchEvent( new Event(EnumEvents.GAME_ENDED) );
				}
				
				return;
			}
			
			movement.x = (input.mouseX - node.position.x)*9;	
			movement.y += node.flying.gravity * time;
			
			if(input.getClicked())
			{
//				events.magicJump.dispatch(position.x, position.y);
				events.dispatchEvent( new CoordEvent(EnumEvents.JUMP, position.x, position.y) );
			}
			
//			var speed:Number = node.flying.speed;
//			
//			var direction:int = 0;
//			
//			if(input.mouseIsOver)
//			{
//				var mouseX:Number = input.mouseX;
//				
//				var hr:Number = 5;
//				
//				var x:Number = position.x; 				
//				
//				if(mouseX<x-hr)
//				{
//					direction = -1;
//				}
//				else if(mouseX>x+hr)
//				{
//					direction = 1;
//				}	
//			}			
//			
//			if(direction)
//			{
//				movement.x = speed * direction;
//				states.changeState(CompHeroStates.WALK);
//			}
//			else
//			{
//				movement.x = 0;
//				states.changeState(CompHeroStates.STAY);
//				
//			}
		}
	}
}
import ash.core.Node;

import project.components.CompHeroFlying;
import project.components.CompHeroStates;
import project.components.CompMovement;
import project.components.CompPosition;

class NodeHeroFlying extends Node
{
	public var heroStates:CompHeroStates;
	public var flying:CompHeroFlying;
	
	public var position:CompPosition;
	public var movement:CompMovement;
}