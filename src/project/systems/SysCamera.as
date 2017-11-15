package project.systems
{
	import ash.core.Engine;
	import ash.core.NodeList;
	import ash.core.System;
	
	import flash.geom.Rectangle;
	
	import project.model.GameModel;
	
	public class SysCamera extends System
	{
		
		protected var camera:Rectangle;
		
		protected var heroes:NodeList;
		
		public function SysCamera(model:GameModel)
		{
			camera = model.state.camera;
		}
		
		override public function addToEngine(engine:Engine):void
		{
			heroes = engine.getNodeList(NodeHero);
		}
		
		override public function update(time:Number):void
		{
			var hero:NodeHero = heroes.head;
			if(!hero)
			{
				return;
			}
			
			camera.y = Math.max(camera.height, hero.position.y + camera.height/2);
		}
	}
}
import ash.core.Node;

import project.components.CompHeroStates;
import project.components.CompPosition;

class NodeHero extends Node
{
	public var heroStates:CompHeroStates;
	public var position:CompPosition;
}