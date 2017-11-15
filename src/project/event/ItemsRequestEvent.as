package project.event
{
	public class ItemsRequestEvent extends RequestEvent
	{
		
		public var firstIndex:int = 0;
		public var amount:int = 1;
		
		public function ItemsRequestEvent(type:String, firstIndex:int = 0, amount:int = 1)
		{
			super(type);
			this.firstIndex = firstIndex;
			this.amount = amount;
		}
	}
}