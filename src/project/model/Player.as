package project.model
{
	import project.utils.SlotNumber;

	public class Player extends UserModel
	{
		
		public const magicJumps:SlotNumber = new SlotNumber;
		
		public var rank:int;
		
		public var skillLevels:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		
		public function Player()
		{
			
		}
	}
}