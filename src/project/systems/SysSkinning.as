package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import flash.display.Sprite;
	
	public class SysSkinning extends ListIteratingSystem
	{
		public function SysSkinning()
		{
			super(SkinningNode, nodeUpdate, nodeAdded, nodeRemoved);
		}
		
		protected function nodeUpdate(node:SkinningNode, time:Number = 0):void
		{
			
		}
		
		protected function nodeAdded(node:SkinningNode):void
		{
			node.display.setSkin( node.skin.sprite );
			
//			nodeUpdate( node );
		}
		
		protected function nodeRemoved(node:SkinningNode):void
		{
			node.display.unsetSkin( node.skin.sprite );			
		}
	}
}
import ash.core.Node;

import project.components.CompDisplay;
import project.components.CompSkin;

class SkinningNode extends Node
{
	public var display:CompDisplay;
	public var skin:CompSkin;
}