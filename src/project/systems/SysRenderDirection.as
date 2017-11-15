package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	public class SysRenderDirection extends ListIteratingSystem
	{
		public function SysRenderDirection()
		{
			super(NodeRenderDirection, updateNode);
		}
		
		protected function updateNode(node:NodeRenderDirection, time:Number):void
		{
			
//			if(!node.display.renderDirection)
//			{
//				return;
//			}
			
			var vx:Number = node.motion.x;
			
			if(vx>0)
			{
				node.display.setDirection(1);
			}
			else if(vx<0)
			{
				node.display.setDirection(-1);
			}
		}
	}
}

import ash.core.Node;

import project.components.CompDisplay;
import project.components.CompMovement;


internal class NodeRenderDirection extends Node
{
	public var motion : CompMovement;
	public var display : CompDisplay;
}