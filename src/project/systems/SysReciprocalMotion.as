package project.systems
{
	import ash.tools.ListIteratingSystem;

	public class SysReciprocalMotion extends ListIteratingSystem
	{
		public function SysReciprocalMotion()
		{
			super( NodeReciprocalMotion, updateNode );
		}
		
		private function updateNode( node : NodeReciprocalMotion, time : Number ) : void
		{			
			node.movement.x = (320 - 300*Math.sin(node.reciprocal.step/60) - node.position.x)/time;
			node.reciprocal.step++;
		}
	}
}
import ash.core.Node;

import project.components.CompMovement;
import project.components.CompPosition;
import project.components.CompReciprocalMotion;


internal class NodeReciprocalMotion extends Node
{
	public var movement:CompMovement;
	public var position:CompPosition;
	
	public var reciprocal:CompReciprocalMotion;
}