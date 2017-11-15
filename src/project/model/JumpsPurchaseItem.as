package project.model
{
	public class JumpsPurchaseItem
	{
		public var id:int;
		public var jumps:int;
		public var price:int;
		
		public function JumpsPurchaseItem(id:int, jumps:int, price:int)
		{
			this.id = id;
			this.jumps = jumps;
			this.price = price;
		}
	}
}