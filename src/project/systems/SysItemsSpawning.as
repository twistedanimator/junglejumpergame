package project.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import flash.geom.Rectangle;
	
	import project.EntityManager;
	import project.components.CompPosition;
	import project.model.GameDesign;
	import project.model.GameModel;
	
	public class SysItemsSpawning extends System
	{
		
		protected var model:GameModel;
		protected var design:GameDesign;
		
		protected var em:EntityManager;
		
		protected var items:NodeList;
		protected var heroes:NodeList;
		
		public function SysItemsSpawning(model:GameModel, em:EntityManager)
		{
			this.model = model;
			this.em = em;
			
			design = model.design;
		}
		
		override public function addToEngine(engine:Engine):void
		{
			items = engine.getNodeList( NodeItem );

		}
		
		override public function update( time : Number ) : void
		{
			
			var cameraY:Number = model.state.camera.y;
			
			var maxYInCamera:Number = 0;
			var minYAboveCamera:Number = Number.MAX_VALUE;
			
			for(var node:NodeItem = items.head; node; node = node.next)
			{
				var y:Number = node.position.y;	
				
				if(y < cameraY)
				{
					if(y>maxYInCamera)
					{
						maxYInCamera = y;
					}					
				}
				else
				{
					if(y<minYAboveCamera)
					{
						minYAboveCamera = y;
					}
				}
			}
			
			y = Math.max(cameraY + model.design.itemsSpawnYOffset, maxYInCamera + model.design.itemsDistanceY);

			if( (minYAboveCamera-y) >= model.design.itemsDistanceY)
			{
				var x:Number;
				
				var direction:int = Math.random()<0.5? -1 : 1;
				var distanceX:Number = Math.random()<0.2? model.design.itemsBigDistanceX : model.design.itemsDistanceX;
				
				var prevBaloonX:Number = model.state.prevBaloonX;
				
				x = prevBaloonX + distanceX*direction;
				
				if(x>model.design.gameWidth-distanceX)
				{
					x = prevBaloonX - distanceX;
				}
				else if(x<distanceX)
				{
					x = prevBaloonX + distanceX;
				}
				
				x += model.design.itemsXRandomness*(Math.random() - 0.5);
				y += model.design.itemsYRandomness*(Math.random() - 0.5);
				
				addItem(x, y);
				
				model.state.prevBaloonX = x;
			}
		}
		
		protected function addItem(x:Number, y:Number):void
		{
			
			var parrotDistance:Number = model.getParrotDistance();
			if( y >= model.state.lastParrotDistance + parrotDistance )
			{
				em.addParrot(y);
				model.state.lastParrotDistance += parrotDistance;
			}
			else
			{
				if(Math.random()<=design.sizeBonusChance)
				{
					em.addSizeBonus(x, y);	
				}
				else
				{
					em.addBaloon(x, y, Math.random()<=design.bigBaloonChance);
				}
			}
		}
	}
}
import ash.core.Node;

import project.components.CompItem;
import project.components.CompPosition;

class NodeItem extends Node
{
	public var item:CompItem;
	public var position:CompPosition;
}

