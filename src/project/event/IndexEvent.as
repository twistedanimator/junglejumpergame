package project.event
{
	import flash.events.Event;
	
	public class IndexEvent extends Event
	{
		
		public var index:int;
		
		public function IndexEvent(type:String, index:int = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.index = index;
			super(type, bubbles, cancelable);
		}
	}
}