package project.systems
{
	import ash.tools.ListIteratingSystem;
	
	import project.EntityManager;

	public class SysLifespan extends ListIteratingSystem
	{
		
		protected var em:EntityManager;
		
		public function SysLifespan(em:EntityManager)
		{
			this.em = em;
			super(MyNode, updateNode);
		}

		
		protected function updateNode(node:MyNode, time:Number):void
		{			
			node.life.time -= time;
			if(node.life.time <= 0)
			{
				em.remove( node.entity );
			}
		}
	}
}
import ash.core.Node;

import project.components.CompLifespan;

internal class MyNode extends Node
{
	public var life:CompLifespan;
}