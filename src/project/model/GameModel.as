package project.model
{
	import project.enums.EnumAppScreens;
	import project.enums.EnumSkill;

	public class GameModel
	{

		public const design:GameDesign = new GameDesign;
		public const state:GameState = new GameState(design);
		
		public var currentScreen:String = EnumAppScreens.MAIN_MENU;	
		
//		public var jumpsPurchaseAvailable:Boolean = true;
		
		public const users:Users = new Users();
		
		public const player:Player = new Player;
		
		public function GameModel()
		{
			
		}
		
		
		public function getBaloonJump(explodes:Boolean = false):Number
		{
			return design.baloonJump + (explodes? getSkillAmount( EnumSkill.ARROGANT_JUMP ) : 0);
		}
		
		public function getBigBaloonJump(explodes:Boolean = false):Number
		{
			return design.bigBaloonJump + (explodes? getSkillAmount( EnumSkill.ARROGANT_JUMP ) : 0);
		}
		
		public function getMagicJump():Number
		{
			return design.defaultMagicJump*(1+getSkillAmount( EnumSkill.JUMPINESS )/100);
		}
		
		public function getParrotDistance():Number
		{
//			return 1000;
			return design.defaultParrotsDistance*(1 - getSkillAmount(EnumSkill.FERTILE_PARROT)/100);
		}
		
		public function getSkillAmount(skill:int):Number
		{
			var level:int = player.skillLevels[ skill ];
			return level == 0? 0 : design.getSkill(skill).getAmount( level );			
		}
	}
}
