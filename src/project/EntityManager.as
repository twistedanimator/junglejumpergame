package project
{
	import ash.core.Engine;
	import ash.core.Entity;
	
	import flash.display.Sprite;
	
	import project.components.CompCollision;
	import project.components.CompDisplay;
	import project.components.CompHeroJumping;
	import project.components.CompHeroStates;
	import project.components.CompItem;
	import project.components.CompLifespan;
	import project.components.CompMovement;
	import project.components.CompPosition;
	import project.components.CompReciprocalMotion;
	import project.components.CompSkin;
	import project.display.rends.RendBaloon;
	import project.display.rends.RendExplosion;
	import project.display.rends.RendHyperJumpBubble;
	import project.display.rends.RendJumpsBonusBubble;
	import project.display.rends.RendMagicJump;
	import project.display.rends.RendScoreBubble;
	import project.enums.EnumItemEffect;
	import project.enums.EnumItemReaction;
	import project.enums.EnumSkill;
	import project.model.GameDesign;
	import project.model.GameModel;

	public class EntityManager
	{
		
		protected var engine:Engine;
		
		protected var model:GameModel;
		protected var design:GameDesign;
		
		public function EntityManager(model:GameModel, engine:Engine)
		{
			this.model = model;
			design = model.design;
			
			this.engine = engine;
		}
		
		public function remove(entity:Entity):void
		{
			engine.removeEntity(entity);
		}
		
		public function addLand():Entity
		{
			var sprite:Sprite = new $background;
			sprite.cacheAsBitmap = true;
			
			var entity:Entity = new Entity()
				.add( new CompPosition(0, model.design.gameHeight) )
				.add( new CompDisplay )
				.add( new CompSkin( sprite ) )
			;
			
			engine.addEntity(entity);			
			
			return entity;
		}
		
		public function addHero():Entity
		{			
			var entity:Entity = new Entity()				
				.add( new CompCollision(10, 0, -10) )
				
				.add( new CompHeroJumping )
				
				.add( new CompPosition(design.gameWidth/2, 0) )
				.add( new CompMovement(0, 0) )
				
				.add( new CompDisplay )				
			;
			
			entity.add( new CompHeroStates(entity) );
			
			engine.addEntity(entity);
			
			
			return entity;
		}
		
		public function addBaloon(x:Number, y:Number, big:Boolean = false):Entity
		{
			
			var scale:Number = Math.max(design.minBaloonScale, 1 - (y-design.gameHeight) * (1-model.getSkillAmount(EnumSkill.AIR_TOLERANCE)/100) / design.baloonsScaleWithHeightFactor);
			
			if(big)
			{
				scale*=2;
			}
			
			var radius:Number = design.defaultBaloonRadius*scale*(1+model.getSkillAmount(EnumSkill.GREAT_SCRATCHNESS)/100);	
			
			var isVanishing:Boolean = Math.random()>model.getSkillAmount(EnumSkill.BALOON_SYNOPSIS)/100;
			
			var compItem:CompItem = new CompItem(EnumItemReaction.EXPLODE, isVanishing);
			compItem.effects.push( EnumItemEffect.SCORE );
			compItem.effects.push( big? EnumItemEffect.LONG_TOSS : EnumItemEffect.TOSS );
			
			var entity:Entity = new Entity()			
				.add( compItem )
				.add( new CompCollision(radius, -2*scale, 9*scale) )
					
				.add( new CompPosition(x, y) )
				.add( new CompMovement(0, -31) )
				
				.add( new CompDisplay )
				.add( new CompSkin( new RendBaloon(scale) ) )
			;
				
			engine.addEntity(entity);
				
			
			return entity;
		}
		
		public function addSizeBonus(x:Number, y:Number):Entity
		{			
			
			var isVanishing:Boolean = Math.random()>model.getSkillAmount(EnumSkill.BALOON_SYNOPSIS)/100;
			
			var compItem:CompItem = new CompItem(EnumItemReaction.DISAPPEAR, isVanishing);
			compItem.effects.push( EnumItemEffect.SCORE );
			compItem.effects.push( EnumItemEffect.TOSS );
			compItem.effects.push( EnumItemEffect.SIZE_BONUS );
			
			var entity:Entity = new Entity()			
				.add( compItem )
				.add( new CompCollision(15, 0, 16) )
				
				.add( new CompPosition(x, y) )
				.add( new CompMovement(0, -31) )
				
				.add( new CompDisplay )
				.add( new CompSkin( new $baloon_enlarging ) )
			;
			
			engine.addEntity(entity);
			
			
			return entity;
		}
		
		public function addParrot(y:Number):Entity
		{		
			
			var compItem:CompItem = new CompItem(EnumItemReaction.FLYAWAY, true, model.design.gameHeight + 20);
			compItem.effects.push( EnumItemEffect.SCORE_BONUS );
			compItem.effects.push( EnumItemEffect.TOSS );
			
			
			var entity:Entity = new Entity()			
				.add( compItem )
				.add( new CompCollision(12, -2, 3) )
				
				.add( new CompPosition(design.gameWidth/2, y) )
				.add( new CompMovement(0, -31) )
				.add( new CompReciprocalMotion() )
				
				.add( new CompDisplay )
				.add( new CompSkin( new $parrot ) )
			;
			
			engine.addEntity(entity);
			
			
			return entity;
		}
		
		public function addScoreBubble(x:Number, y:Number, score:int):Entity
		{		
			var entity:Entity = new Entity()		
				.add(new CompPosition(x, y))
				.add(new CompMovement(0, 50))
				.add(new CompLifespan(2))
				.add( new CompDisplay )
				.add(new CompSkin( new RendScoreBubble().setScore(score).fade() ))				
			;	
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function addExplosionParticles(x:Number, y:Number):Entity
		{			
			var entity:Entity = new Entity()
				.add( new CompDisplay )
				.add( new CompSkin(new RendExplosion(int(model.getSkillAmount(EnumSkill.ARROGANT_JUMP)/10))) )
				.add( new CompLifespan(1) )
				.add( new CompPosition(x, y) )				
			;
			
			engine.addEntity( entity );
			
			return entity;
		}
		
		public function addMagicJumpParticles(x:Number, y:Number):Entity
		{			
			var entity:Entity = new Entity;
			entity
				.add( new CompDisplay )
				.add( new CompSkin(new RendMagicJump) )
				.add( new CompLifespan(1) )
				.add( new CompPosition(x, y) )				
			;
			
			engine.addEntity( entity );
			
			return entity;
		}
		
		public function addHyperJumpBubble(x:Number, y:Number):Entity
		{		
			var entity:Entity = new Entity()	
				.add( new CompDisplay )
				.add( new CompSkin(new RendHyperJumpBubble().fade()) )
				.add(new CompPosition(x, y))
				.add(new CompMovement(0, -50))
				.add(new CompLifespan(2))
			;	
			
			engine.addEntity(entity);
			return entity;
		}
		
		public function addBonusJumpsBubble(x:Number, y:Number, bonus:int):Entity
		{		
			var entity:Entity = new Entity()	
				.add( new CompDisplay )
				.add( new CompSkin( new RendJumpsBonusBubble().setBonus(bonus).fade()) )
				.add(new CompPosition(x, y + 100))
				.add(new CompMovement(0, 400))
				.add(new CompLifespan(2))			
			;	
			
			engine.addEntity(entity);
			return entity;
		}

	}
}