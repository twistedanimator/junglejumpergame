package project
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.tick.FrameTickProvider;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	import lib.common.exec.OpToken;
	
	import project.components.CompHeroFlying;
	import project.components.CompHeroJumping;
	import project.display.GameHUD;
	import project.enums.EnumEvents;
	import project.enums.EnumSkill;
	import project.enums.Sounds;
	import project.enums.SystemPriorities;
	import project.event.CoordEvent;
	import project.event.RequestEvent;
	import project.event.SkillEvent;
	import project.input.MouseInput;
	import project.model.GameModel;
	import project.model.GameState;
	import project.service.GameService;
	import project.systems.SysCamera;
	import project.systems.SysCollision;
	import project.systems.SysDisplay;
	import project.systems.SysHeroFlying;
	import project.systems.SysHeroJumping;
	import project.systems.SysHeroWalking;
	import project.systems.SysItemsSpawning;
	import project.systems.SysLifespan;
	import project.systems.SysMovement;
	import project.systems.SysReciprocalMotion;
	import project.systems.SysRenderDirection;
	import project.systems.SysSizeBonus;
	import project.systems.SysSkinning;

	public class GameController
	{
		
		protected var container:Sprite;
		protected var hud:GameHUD;
		
		protected var sound:SoundManager;
		
		protected var model:GameModel;
		protected var state:GameState;
		
		protected var events:EventDispatcher;
		
		protected var engine:Engine;
		
		protected var gameService:GameService;
		
		protected var tickProvider:FrameTickProvider;
		
		protected var em:EntityManager;
		
		protected var input:MouseInput;
		
		protected var hero:Entity;

		
		public function GameController(model:GameModel, events:EventDispatcher, gameService:GameService, container:Sprite, hud:GameHUD, sound:SoundManager)
		{
			this.container = container;
			this.hud = hud;
			
			this.sound = sound;
			
			this.events = events;
			
			this.gameService = gameService;			
			
			this.model = model;
			this.state = model.state;
			this.events = events;
			
			initEvents();
			
			drawBack();
			
			input = new MouseInput(container);
			
			engine = new Engine;
			
			em = new EntityManager(model, engine);
			
			em.addLand();
			hero = em.addHero();
			
			addSystems();
			
			tickProvider = new FrameTickProvider( container );
			tickProvider.add( engine.update );
			
			tickProvider.proceed(7);
			
			initHUD();

		}
		
		public function run():void
		{			
			tickProvider.start();
			
			hud.showGameUI();
			
		}
		
		public function pause():void
		{
			tickProvider.stop();
			hud.hideGameUI();
		}
		
		protected function initHUD():void
		{
			
			model.state.score.add( hud.setScore );
			model.player.magicJumps.add( hud.setMagicJumps );
			
		}
		
		protected function initEvents():void
		{
			events.addEventListener(EnumEvents.JUMP, onJump);
			events.addEventListener(EnumEvents.HIT_PARROT, onParrotHit);
			
//			events.magicJump.add( onMagicJump);
		}
		
		protected function onJump(e:CoordEvent):void
		{
			var jumping:CompHeroJumping = hero.get( CompHeroJumping ) as CompHeroJumping;
			
			if(state.jumpingStarted)
			{
				var jumped:Boolean = false;
				if( isNaN(state.lastHyperJumpTime) || (state.time - state.lastHyperJumpTime)>=model.design.minHyperJumpInterval )
				{
					var hyperProbability:Number = model.getSkillAmount(EnumSkill.HYPERACTIVITY)/100;
					if(Math.random()<hyperProbability)
					{
						jumping.setJump( model.design.hyperJump );
						em.addHyperJumpBubble(e.x, e.y);
						trace('HYPER!');						
						sound.play(Sounds.HYPER_JUMP, e.x/model.design.gameWidth);
						
						jumped = true;
					}
					
					state.lastHyperJumpTime = state.time;
				}
				
				
				
				
				if(!jumped)
				{
					if(state.magicJumpsEnabled && model.player.magicJumps.value > 0)
					{						
						state.magicJumpsEnabled = false;
						
						jumping.setJump( model.getMagicJump() );						
						em.addMagicJumpParticles(e.x, e.y);	
						
						model.player.magicJumps.value = model.player.magicJumps.value - 1;
						
						sound.play(Sounds.MAGIC_JUMP, e.x/model.design.gameWidth);
						
						gameService.magicJump(e.x, e.y).addHandlers(onMagicJumpRegistered, onGameServiceFault);
					}
				}
			}
		}		
		
		protected function onMagicJumpRegistered(op:OpToken):void
		{
			if(op.result.bonus>0)
			{
				trace('BONUS! +'+op.result.bonus);
				em.addBonusJumpsBubble( op.arguments[0], op.arguments[1], op.result.bonus );
			}			
			
			model.player.magicJumps.value = op.result.jumps;
			state.magicJumpsEnabled = true;
		}
		
		protected function onParrotHit(e:CoordEvent):void
		{
			if(state.parrotsBonusEnabled)
			{
				gameService.hitParrot(e.x, e.y).addHandlers(onParrotHitRegistered, onGameServiceFault);
				state.parrotsBonusEnabled = false;
			}
			
		}
		
		protected function onParrotHitRegistered(op:OpToken):void
		{
			if(op.result && op.result.bonus>0)
			{
				model.player.magicJumps.value = op.result.jumps;
				
				if(op.result.bonus > 0)
				{
					em.addBonusJumpsBubble( op.arguments[0], op.arguments[1], op.result.bonus );
					trace('PARROT BONUS! +'+op.result.bonus);
				}				
			}
			
			state.parrotsBonusEnabled = true;
		}
		
		protected function onGameServiceFault(op:OpToken):void
		{
			trace('onGameServiceFault: '+op.fault);
		}
		
		protected function addSystems():void
		{
			
			engine.addSystem( new SysItemsSpawning(model, em), SystemPriorities.update );
			engine.addSystem( new SysLifespan(em), SystemPriorities.update );	
			engine.addSystem( new SysReciprocalMotion(), SystemPriorities.update );
			
			engine.addSystem( new SysSizeBonus(), SystemPriorities.update );	
			
			engine.addSystem( new SysMovement(), SystemPriorities.move );
			
			engine.addSystem( new SysCollision(model, em, events, sound), SystemPriorities.resolveCollisions );
			
			engine.addSystem( new SysHeroWalking(model, input), SystemPriorities.stateMachines );
			engine.addSystem( new SysHeroFlying(model, events, input), SystemPriorities.stateMachines );			
			engine.addSystem( new SysHeroJumping(), SystemPriorities.stateMachines );
			
			engine.addSystem( new SysCamera(model), SystemPriorities.move );
			
//			engine.addSystem( new SysRenderCollision(), SystemPriorities.render );
			engine.addSystem( new SysSkinning, SystemPriorities.render );
			engine.addSystem( new SysDisplay(model, container), SystemPriorities.render );
			engine.addSystem( new SysRenderDirection, SystemPriorities.render );
		}
		
		protected function drawBack():void
		{
			var g:Graphics = container.graphics;
			g.beginFill(0x55AED8, 1);
			g.drawRect(0, 0, model.design.gameWidth, model.design.gameHeight);
			g.endFill();
			
			container.scrollRect = new Rectangle(0, 0, model.design.gameWidth, model.design.gameHeight);
		}
	}
}