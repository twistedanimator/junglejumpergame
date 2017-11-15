package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import project.model.GameModel;
	
	public class SysDisplay extends ListIteratingSystem
	{
		
		protected var container:Sprite;
		
		protected var camera:Rectangle;
		
		public function SysDisplay(model:GameModel, container:Sprite)
		{
			super(NodeDisplay, nodeUpdate, nodeAdded, nodeRemoved);
			
			this.container = container;
			
			camera = model.state.camera;
		}
		
		protected function nodeUpdate(node:NodeDisplay, time:Number = 0):void
		{
			var sprite:Sprite = node.display.sprite;
			
			sprite.x = node.position.x - camera.x;
			sprite.y = camera.y - node.position.y;
		}
		
		protected function nodeAdded(node:NodeDisplay):void
		{
			container.addChild( node.display.sprite );
			nodeUpdate( node );
		}
		
		protected function nodeRemoved(node:NodeDisplay):void
		{
			var sprite:Sprite = node.display.sprite; 
			if(sprite.parent == container)
			{
				container.removeChild( sprite );
			}
			
		}
		
		
	}
}
import ash.core.Node;

import project.components.CompDisplay;
import project.components.CompPosition;

class NodeDisplay extends Node
{
	public var display:CompDisplay;
	public var position:CompPosition;
}