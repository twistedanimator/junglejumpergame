package project.systems
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.core.NodeList;
	import ash.core.System;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import project.EntityManager;
	import project.SoundManager;
	import project.components.CompCollision;
	import project.components.CompLifespan;
	import project.components.CompMovement;
	import project.components.CompReciprocalMotion;
	import project.components.CompSizeBonus;
	import project.enums.EnumEvents;
	import project.enums.EnumItemEffect;
	import project.enums.EnumItemReaction;
	import project.enums.EnumSkill;
	import project.enums.Sounds;
	import project.event.CoordEvent;
	import project.model.GameModel;
	import project.model.GameState;
	
	public class SysCollision extends System
	{
		protected var model:GameModel;
		protected var state:GameState;
		
		protected var events:EventDispatcher;
		
		protected var em:EntityManager;
		
		protected var sound:SoundManager;
		
		protected var heroes:NodeList;
		protected var items:NodeList;
		
		public function SysCollision(model:GameModel, em:EntityManager, events:EventDispatcher, sound:SoundManager)
		{
			this.model = model;
			this.em = em;
			
			this.events = events;
			
			this.sound = sound;
			
			state = model.state;
		}
		
		override public function addToEngine(engine:Engine):void
		{
			heroes = engine.getNodeList( NodeHero );
			items = engine.getNodeList( NodeItem );			
		}
		
		override public function update( time : Number ) : void
		{
			var hero:NodeHero = heroes.head;
			if(!hero)
			{
				return;
			}
			
			var yHero:Number = hero.position.y;
			
			if(yHero<=0)
			{
				hero.position.y = 0;
			}
			
			var collisionFound:Boolean = false;
			
			var item:NodeItem;
			for(item = items.head; item; item = item.next)
			{
				var yItem:Number = item.position.y; 
				if( yItem<=item.item.minY || (item.item.isVanishing && (yHero-yItem)>model.design.maxItemDistanceBelowHero) )
				{
					em.remove(item.entity);
					continue;
				}
				
				if(!collisionFound && testCollision(hero, item) )
				{
					collisionFound = true;
					
					state.jumpingStarted = true;
					
					var x:Number = item.position.x;
					var y:Number = item.position.y;
					
					var explodes:Boolean = false;
					
					if(item.item.reaction == EnumItemReaction.EXPLODE)
					{	

						if( Math.random() > model.getSkillAmount(EnumSkill.LIGHT_MOSSINESS)/100 )
						{
							explodes = true;
						}
					}
					
					var effects:Vector.<int> = item.item.effects;
					for(var i:int = 0, l:int = effects.length; i<l; i++)
					{
						var effect:int = effects[i];
						switch(effect)
						{
							case EnumItemEffect.TOSS:
								hero.jumping.setJump( model.getBaloonJump( explodes ) );
								break;								
							case EnumItemEffect.LONG_TOSS:
								hero.jumping.setJump( model.getBigBaloonJump( explodes ) );
								sound.play(Sounds.BIG_JUMP, x/model.design.gameWidth);
								break;
							case EnumItemEffect.SCORE:
								
								var smoothBonus:Number = state.smoothFlowBonus.value;
								addScore( x, y, state.numJumps.value * (10 + (smoothBonus < 3 ? 0 : smoothBonus) * 5) );
								
								effects.splice(i, 1);
								i--; l--;
								break;
							case EnumItemEffect.SCORE_BONUS:								
								
								addScore( x, y, state.score.value * 0.5 );
								events.dispatchEvent( new CoordEvent(EnumEvents.HIT_PARROT, x, y) );
//								sound.play(Sounds.HIT, x/model.design.gameWidth);
								effects.splice(i, 1);
								i--; l--;
								break;
							case EnumItemEffect.SIZE_BONUS:
								var sizeBonus:CompSizeBonus = hero.entity.get(CompSizeBonus);
								if(sizeBonus)
								{
									sizeBonus.reset();
								}
								else
								{
									hero.entity.add( new CompSizeBonus );
									sound.play(Sounds.ENLARGE, x/model.design.gameWidth);
								}
								break;
						}
					}
					
					var reaction:int = item.item.reaction;
					var itemEntity:Entity = item.entity;
					switch(reaction)
					{
						case EnumItemReaction.DISAPPEAR:
							em.remove( itemEntity );
							em.addExplosionParticles(x, y);
							break;
						case EnumItemReaction.EXPLODE:
							if(explodes)
							{
								em.remove( itemEntity );
								em.addExplosionParticles(x, y);
								
								sound.play(Sounds.EXPLODE, x/model.design.gameWidth);
								
							}
							else
							{
								sound.play(Sounds.SOFT_HIT, x/model.design.gameWidth);
							}
							break;
						case EnumItemReaction.FLYAWAY:
							itemEntity.remove( CompReciprocalMotion );
							itemEntity.remove( CompCollision );
							itemEntity.add( new CompLifespan( 3 ) );
							
							sound.play(Sounds.HIT, x/model.design.gameWidth);
							
							var movement:CompMovement = item.entity.get( CompMovement ) as CompMovement;							
							movement.x = movement.x<0? 500 : -500;
							
							break;
					}
					
					
					
				}
			}
		}
		
		private static const pa:Point = new Point;
		private static const pb:Point = new Point;
		
		protected function testCollision(a:NodeCollision, b:NodeCollision):Boolean
		{
			
			pa.setTo(a.position.x + a.collision.offset.x, a.position.y - a.collision.offset.y);
			pb.setTo(b.position.x + b.collision.offset.x, b.position.y - b.collision.offset.y);
			
			if( Math.abs( Point.distance(pa, pb) ) <= (a.collision.radius+b.collision.radius) )
			{
				return true;
			}
			
			return false;
		}
		
		protected function addScore(x:Number, y:Number, score:int):void
		{
			
			
			state.numJumps.value += 1;
			
			state.score.value += score;
			
			em.addScoreBubble( x, y, score );
		}
	}
}

import ash.core.Node;

import project.components.CompCollision;
import project.components.CompHeroJumping;
import project.components.CompHeroStates;
import project.components.CompItem;
import project.components.CompPosition;

class NodeCollision extends Node
{
	public var position:CompPosition;
	public var collision:CompCollision;
}

class NodeHero extends NodeCollision
{	
	public var heroStates:CompHeroStates;
	public var jumping:CompHeroJumping;
}

class NodeItem extends NodeCollision
{
	public var item:CompItem;	
}