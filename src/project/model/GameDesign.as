package project.model
{
	import project.enums.EnumSkill;

	public class GameDesign
	{
		
		public var gameWidth : Number = 640;
		public var gameHeight : Number = 480;
		
		public var itemsSpawnYOffset : int = 120; 		
		
		public var itemsDistanceX : int = 70;
		public var itemsBigDistanceX : int = 200;		
		public var itemsDistanceY : int = 60;		
		
		public var itemsXRandomness : int = 10;
		public var itemsYRandomness : int = 10;
		
		public var bigBaloonChance:Number = 0.04;
		public var sizeBonusChance:Number = 0.01;		
		
		public var minBaloonScale:Number = 0.3;
		public var baloonsScaleWithHeightFactor:Number = 80000;
		
		public var defaultBaloonRadius:Number = 11;
		
		public var maxItemDistanceBelowHero:Number = 1000;
		
		public var defaultParrotsDistance:Number = 5000;
		
		public var baloonJump:Number = 620;
		public var bigBaloonJump:Number = 1100;
		
		public var landJump:Number = 800;
		
		public var defaultMagicJump:Number = 600;
		public var hyperJump:Number = 500;
		
		public var minHyperJumpInterval:Number = 3;
		
		protected const skills:Vector.<Skill> = new Vector.<Skill>;
		
		public var jumpsPurchases:Array;
		
		public function GameDesign()
		{
			jumpsPurchases = [
				
				new JumpsPurchaseItem(0,	5,		3),
				new JumpsPurchaseItem(1, 	17,		8),
				new JumpsPurchaseItem(2,	29,		15),
				
				new JumpsPurchaseItem(3,	42,		20),
				new JumpsPurchaseItem(4,	65,		30),
				new JumpsPurchaseItem(5,	175,	60),
			];
			
			
			addSkill(new Skill(
				EnumSkill.GREAT_SCRATCHNESS,	
				[7], 
				[15],
				'Великая скрипучесть', 
				'Измененная поверхность лапок Марты улучшает сцепление с резиной, <b>облегчая попадание</b> по шарикам.'
			));
			
			addSkill(new Skill(
				EnumSkill.FERTILE_PARROT,
				[3, 1, 2, 1, 1, 1],
				[3, 7, 13],
				'Плодовитая попугаиха',
				'Закормленные попугаи! Теперь попадаются в небе чаще на <b>amount%</b>.'
			));
			
			addSkill(new Skill(
				EnumSkill.PERFECTED_SOLEMNITY,				
				[1, 2], 
				[20, 40],
				'Улучшенная вальяжность',
				[
					'Вальяжный прыжок, при срабатывании приносит не один, а <b>два волшебных прыжка</b>!!', 
					'Вальяжный прыжок, при срабатывании приносит не один, и даже не два, а <b>целых три волшебных прыжка</b>!!!'
				],
				[1, 1]
			));
			
			addSkill(new Skill(
				EnumSkill.BALOON_SYNOPSIS,
				[15, 5, 10, 4, 6, 10],
				[1, 3, 7],
				'Сочувствие шариков',
				'<b>amount%</b> нелопнувших шариков не исчезают. Они продолжают спускаться к земле и могут помочь при падениях.'			
			));
			
			addSkill(new Skill(
				EnumSkill.ARROGANT_JUMP,
				[25, 12, 13, 10, 15, 25],
				[1, 3, 7],
				'Надменный прыжок',
				'Марта настолько раздражает шарики, что они разрываются с гневом, отбрасывая нахалку с дополнительной силой в <b>amount Ньютонов</b>'		
			));
			
			addSkill(new Skill(
				EnumSkill.LIGHT_MOSSINESS,
				[5, 2, 3, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1],
				[1, 3, 7, 13, 21],
				
				'Легкая пушистость', 
				'Марта так нежно касается шариков, что <b>amount%</b> не лопаются под её весом'
			));
			
			addSkill(new Skill(
				EnumSkill.BIRD_KINSHIP,
				[10, 2, 3, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2],
				[1, 3, 7, 13, 21, 50],				
				'Птичий альянс', 
				'С вероятностью <b>amount%</b> попадание по попугаю приносит вам один волшебный прыжок!'
			));
			
			addSkill(new Skill(
				EnumSkill.AIR_TOLERANCE,
				[20, 4, 6, 2, 3, 5, 1, 2, 3, 4, 1, 2, 2, 2, 3, 1, 1, 2, 2, 2, 2],
				[1, 3, 7, 13, 21, 50],
				'Клаустрофилия', 
				'С набором высоты шарики уменьшаются в размере на <b>amount%</b> медленнее'
			));
			
			addSkill(new Skill(
				EnumSkill.HYPERACTIVITY,
				[5, 2, 3, 1, 2, 2, 1, 1, 1, 2, 1, 2, 2, 2, 3, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 3, 4],
				[1, 3, 7, 13, 21, 30, 35, 50],
				'Гиперактивность', 
				'С вероятностью <b>amount%</b> можно без всякой магии совершить прыжок прямо в воздухе! (Можно повторить через 3 секунды)'
			));
			
			addSkill(new Skill(
				EnumSkill.IMPOSING_JUMPS,
				[3, 1, 1, 0.5, 0.5, 1, 
					0.2, 0.3, 0.5, 1, 
					0.1, 0.2, 0.3, 0.4, 1, 
					0.1, 0.2, 0.3, 0.4, 0.5, 0.5, 
					0.1, 0.2, 0.2, 0.3, 0.3, 0.4, 0.5, 
					0.2, 0.3, 0.5, 0.5, 0.5, 0.5, 1, 1.5],
				[1, 3, 7, 13, 21, 30, 40, 50],
				'Вальяжные прыжки', 
				'При применении волшебного прыжка, вальяжность Марты дает вам <b>amount%</b> шанс совершенно бесплатно получить сей прыжок обратно!'
			));
			
			addSkill(new Skill(
				EnumSkill.JUMPINESS,
				[10, 2, 3, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 1, 1, 2, 2, 2, 2, 2, 3],
				[1, 3, 7, 13, 21, 30, 35, 50],
				'Прыжковитость', 
				'Волшебные прыжки становятся выше на <b>amount%</b>'
			));
		}
		
		public function getSkill(id:int):Skill
		{
			return skills[id];
		}
		
		protected function addSkill(skill:Skill):void
		{
			skills[skill.id] = skill;
		}
		
		public function getSkills():Vector.<Skill>
		{
			return skills;
		}
		
		public function get numSkills():int
		{
			return skills.length;
		}
			
	}
}
