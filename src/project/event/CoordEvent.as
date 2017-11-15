package project.event
{
	import flash.events.Event;
	
	public class CoordEvent extends Event
	{
		
		public var x:Number;
		public var y:Number;
		
		public function CoordEvent(type:String, x:Number, y:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.x = x;
			this.y = y;
		}
	}
}