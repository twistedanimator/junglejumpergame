package project.event
{
	import flash.events.Event;
	
	import project.model.Skill;
	
	public class SkillEvent extends Event
	{
		
		public var skill:Skill;
		
		public var level:int;
		
		public function SkillEvent(type:String, skill:Skill, level:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
			this.skill = skill;
			this.level = level;
		}
	}
}