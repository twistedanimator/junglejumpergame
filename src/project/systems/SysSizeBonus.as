package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import flash.display.Sprite;
	
	import project.components.CompSizeBonus;
	
	public class SysSizeBonus extends ListIteratingSystem
	{
		public function SysSizeBonus()
		{
			super(MyNode, updateNode);
		}
		
		protected function updateNode(node:MyNode, time:Number):void
		{	
			var sizeBonus:CompSizeBonus = node.sizeBonus;
			
			sizeBonus.time+=time;
			
			var scale:Number;
			
			if(sizeBonus.phase == 0)
			{
				scale = 1 + sizeBonus.phaseTime/sizeBonus.phaseDuration;
			}
			else if(sizeBonus.phase == 2)
			{
				scale = 2 - sizeBonus.phaseTime/sizeBonus.phaseDuration;
			}
			
			if(scale)
			{
//				var sprite:Sprite = node.display.sprite.getChildByName('skinHolder') as Sprite;
//				sprite.scaleX = sprite.scaleY = scale; 
				node.display.scaleSkin( scale );
				
//				node.collision.radius = node.collision.initRadius*scale;
				node.collision.scaleRadius(scale);
			}
			
			if(sizeBonus.time >= CompSizeBonus.DURATION)
			{
				node.entity.remove(CompSizeBonus);
			}
		}
	}
}
import ash.core.Node;

import project.components.CompCollision;
import project.components.CompDisplay;
import project.components.CompSizeBonus;
import project.components.CompSkin;

class MyNode extends Node
{
	public var sizeBonus:CompSizeBonus;
	public var display:CompDisplay;
	public var skin:CompSkin;
	public var collision:CompCollision;
}