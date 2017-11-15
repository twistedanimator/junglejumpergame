package project.event
{
	import flash.events.Event;
	
	import lib.common.exec.OpToken;
	
	public class RequestEvent extends Event
	{
		
		protected var op:OpToken;
		
		public function setToken(op:OpToken):void
		{
			this.op = op;
		}
		
		public function getToken():OpToken
		{
			return op;
		}
		
		public function RequestEvent(type:String)
		{
			super(type, true, false);
		}
	}
}