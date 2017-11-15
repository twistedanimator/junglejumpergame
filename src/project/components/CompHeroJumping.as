package project.components
{
	public class CompHeroJumping
	{
		
		protected var jump:Number = 0;
		
		public function getJump():Number
		{
			var result:Number = jump;
			jump = 0;
			return result;
		}
		
		public function setJump(value:Number):void
		{
			if(value>jump)
			{
				jump = value;
			}
		}
		
		public function CompHeroJumping()
		{
		}
	}
}