package project.model
{
	

	public class Skill
	{
		
		public var id:int;
		public var name:String;
		
		public var numDegrees:int = 1;
		public var maxLevel:int = 1;
		
		public var upgrades:Array;
		public var levelsTotal:Array;
		
		public var additions:Array;		
		public var amounts:Array;
		
		public var prices:Array;		
		
		protected var descriptions:Array;
		protected var description:String;
		
		public function Skill(id:int, additions:Array, prices:Array, name:String, description:*, upgrades:Array = null)
		{
			this.id = id;
			
			this.amounts = amounts;
			this.prices = prices;
			
			this.upgrades = upgrades;
			this.additions = additions;
				
			this.name = name;			
			
			
			if(description is Array)
			{
				this.descriptions = description;
			}
			else
			{
				this.description = String(description);
			}
			
			this.upgrades = upgrades;
			
			numDegrees = prices.length;
			maxLevel = additions.length;
			
			var i:int;
			var amount:Number = 0;

//			var degree:int = 0;
			
			if(upgrades == null)
			{
				upgrades = [];
				for(i = 0; i<numDegrees; i++)
				{
					upgrades[i] = i+1;
				}
			}
			
			this.upgrades = upgrades;
			
			amount = 0;
			levelsTotal = [];
			for(i = 0; i<numDegrees; i++)
			{
				amount+=upgrades[i];
				levelsTotal[i] = amount;
			}
			
			amount = 0;
			amounts = [];
			for(i = 0; i<maxLevel; i++)
			{				
				amount+=additions[i];
				amounts[i] = amount;
			}
		}
		
		public function getDegreeLevels(degree:int):int
		{
			return upgrades[degree];
		}
		
		public function getDegreeLevelsTotal(degree:int):int
		{
			return levelsTotal[degree];
		}
		
		public function getDegree(level:int):int
		{
			for(var i:int = 0; i<numDegrees; i++)
			{
				if(level<=levelsTotal[i])
				{
					return i;
				}				
			}
			
//			throw new Error('Incorrect level.');
			return numDegrees;
		}
		
		
		public function getAmount(level:int):Number
		{
			return level>0? amounts[level-1] : 0;
		}
		
		public function getDescription(level:int):String
		{
			if(level>0)
			{
				var degree:int = getDegree(level);
				
				var desc:String = descriptions? descriptions[degree] : description;
				desc = desc.replace('amount', getAmount(level));
				return desc;
			}
			
			return '';
		}
		
		public function getPrice(level:int):Number
		{
			return level>0? prices[getDegree(level)] : 0;
		}
	}
}