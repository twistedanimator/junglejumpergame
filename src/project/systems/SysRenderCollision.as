package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class SysRenderCollision extends ListIteratingSystem
	{
		
		public static const SPRITE_NAME:String = 'collisionRend';
		
		public function SysRenderCollision()
		{
			super(NodeRenderCollision, nodeUpdate, nodeAdded, nodeRemoved);
		}
		
		protected function nodeUpdate(node:NodeRenderCollision, time:Number = 0):void
		{
			var sprite:Sprite = node.display.sprite.getChildByName(SPRITE_NAME) as Sprite;
			if( Math.abs(node.collision.radius*2 - sprite.width)>1 )
			{
				updateSprite( sprite, node );
			}
		}
		
		protected function nodeAdded(node:NodeRenderCollision):void
		{
			var sprite:Sprite = new Sprite;
			sprite.name = SPRITE_NAME;
			
			updateSprite( sprite, node );
			
			node.display.sprite.addChild(sprite);
			
		}
		
		protected function updateSprite(sprite:Sprite, node:NodeRenderCollision):void
		{
			var g:Graphics = sprite.graphics;
			g.clear();
			g.lineStyle(1, 0x00FF00);
			g.beginFill(0x00FF00, 0.3);
			g.drawCircle(0, 0, node.collision.radius);
			g.endFill();
			
			sprite.x = node.collision.offset.x;
			sprite.y = node.collision.offset.y;
			
			sprite.cacheAsBitmap = true;
		}
		
		protected function nodeRemoved(node:NodeRenderCollision):void
		{
			node.display.sprite.removeChild( node.display.sprite.getChildByName(SPRITE_NAME) );
		}
	}
}
import ash.core.Node;

import project.components.CompCollision;
import project.components.CompDisplay;

class NodeRenderCollision extends Node
{
	public var display:CompDisplay;
	public var collision:CompCollision;
}