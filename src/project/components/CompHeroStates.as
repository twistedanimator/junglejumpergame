package project.components
{
	import ash.core.Entity;
	import ash.fsm.EntityStateMachine;
	
	public class CompHeroStates extends EntityStateMachine
	{
		
		public static const STAY:String = 'STAY';
		public static const WALK:String = 'WALK';
		public static const FLY:String = 'FLY';
		
		protected var stateName:String;
		
		public function CompHeroStates(entity:Entity = null)
		{
			super(entity);
			
			var walking:CompHeroWalking = new CompHeroWalking();
			
			createState(STAY)
				.add( CompHeroWalking ).withInstance(walking)
				.add( CompSkin ).withInstance(new CompSkin( new $hero_stay ));
			
			createState(WALK)
				.add( CompHeroWalking ).withInstance(walking)
				.add( CompSkin ).withInstance(new CompSkin( new $hero_run ));
			
			createState(FLY)
				.add( CompHeroFlying ).withInstance( new CompHeroFlying )
				.add( CompSkin ).withInstance(new CompSkin( new $hero_jump ));
			
			changeState(STAY)
		}
		
		override public function changeState(name:String):void
		{
			super.changeState(name);
			stateName = name;
		}
		
		public function getState():String
		{
			return stateName
		}
	}
}