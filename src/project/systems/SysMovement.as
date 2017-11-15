package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	public class SysMovement extends ListIteratingSystem
	{
		public function SysMovement()
		{
			super(NodeMovement, nodeUpdate);
		}
		
		protected function nodeUpdate(node:NodeMovement, time:Number = 0):void
		{			
			node.position.offset( node.movement.x * time, node.movement.y * time );
			
			if(node.position.y<0)
			{
				node.position.y = 0;
			}
		}
	}
}
import ash.core.Node;

import project.components.CompMovement;
import project.components.CompPosition;

class NodeMovement extends Node
{
	public var position:CompPosition;
	public var movement:CompMovement;
}
