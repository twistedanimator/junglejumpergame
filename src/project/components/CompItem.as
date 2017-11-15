package project.components
{
	public class CompItem
	{
		
		public const effects:Vector.<int> = new Vector.<int>;
		public var reaction:int;
		
		public var isVanishing:Boolean;
		public var minY:Number;
		
		
		
		public function CompItem(reaction:uint = 0, isVanishing:Boolean = true, minY:Number = 144)
		{
			this.reaction = reaction;
			this.isVanishing = isVanishing;
			this.minY = minY;
		}
	}
}