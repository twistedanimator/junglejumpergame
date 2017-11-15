package project
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import lib.common.exec.OpToken;
	
	import project.display.MainDisplay;
	import project.enums.EnumAppScreens;
	import project.enums.EnumEvents;
	import project.event.IndexEvent;
	import project.event.ItemsRequestEvent;
	import project.event.SkillEvent;
	import project.model.GameModel;
	import project.model.JumpsPurchaseItem;
	import project.model.Skill;
	import project.service.GameService;
	import project.service.UsersDataProvider;
	import project.service.VKProxy;

	public class MainController
	{
		
		protected var model:GameModel;
		
		protected var display:MainDisplay;
		
		protected var sound:SoundManager;
		
		protected var game:GameController;
		
		protected var events:EventDispatcher;
		
		protected var gameService:GameService;
		protected var vkService:VKProxy;
		protected var usersProvider:UsersDataProvider;
		
		public function MainController(container:Sprite)
		{
			model = new GameModel;
			
			events = new EventDispatcher;
			
			sound = new SoundManager;
//			sound.toggle();
			
			initServices(container);			
			
			display = new MainDisplay(model.design);
			display.toggleSpeaker(sound.enabled);
			container.addChild(display);			
			
			game = new GameController(model, events, gameService, display.gameDisplay, display.hud, sound);			
			
//			display.showMasteriesStore();
			display.showMainMenu();
			
			initEvents();

			
		}
		
		protected function initEvents():void
		{			
			display.addEventListener( EnumEvents.SHOW_MAIN_MENU, onShowMainMenuRequest );
			
			display.addEventListener( EnumEvents.START_GAME, onStartGameRequest );
			
			display.addEventListener( EnumEvents.SHOW_MASTERIES_STORE, onShowMasteriesStoreRequest );
			display.addEventListener( EnumEvents.SHOW_JUMPS_STORE, onShowJumpsStoreRequest );
			display.addEventListener( EnumEvents.SHOW_MANUAL, onShowManualRequest );
			display.addEventListener( EnumEvents.CLOSE_POPUP, onClosePopupRequest );			
			
			display.addEventListener( EnumEvents.TOGGLE_SOUND, onToggleSoundRequest );
			
			display.addEventListener( EnumEvents.SHOW_TEXT_HINT, onShowTextHintRequest );
			
			display.addEventListener( EnumEvents.SHOW_SKILL_HINT, onShowSkillHintRequest );
			display.addEventListener( EnumEvents.HIDE_HINT, onHideSkillHintRequest );
			
			display.addEventListener( EnumEvents.UPGRADE_SKILL, onUpgradeSkillRequest );
			display.addEventListener( EnumEvents.BUY_JUMPS, onBuyJumpsRequest );
			
			display.addEventListener( EnumEvents.REQUEST_USERS, onRequestUsers);
			
			events.addEventListener( EnumEvents.GAME_ENDED, onGameEnded );
		}
		
		protected function initServices(container:Sprite):void
		{
			
			var loaderInfo:LoaderInfo = container.stage.loaderInfo;			
			var params:Object = loaderInfo.parameters;			
			
			var urlAPI:String = '../api/index.php';
						
			if(loaderInfo.url.indexOf('file') == 0)
			{
				params = JSON.parse
				(
					'{"api_url":"http:\/\/api.vk.com\/api.php","api_id":5180235,"api_settings":1,"viewer_id":44535316,"viewer_type":0,"sid":"3e9ec6f8d59e57e519fe68398097ce503d4841be90d474dc45f9d257e3122d1bd9182d808531cce6465ec","secret":"19eee18ba3","access_token":"35d1bbe5f732ac1f96bd26fbcf89598fe5332ce5400266bfe010b135cc96f48a7751b852f3b49c273f33b","user_id":0,"group_id":0,"is_app_user":1,"auth_key":"3c99db230ebc718b773025bbe8675c84","language":0,"parent_language":0,"ad_info":"ElsdCQVYRFZhBgVdAwJSXHt6A1ZzBx5pU1BXIgZUJlIEAWcgAUoLQg==","is_secure":0,"ads_app_id":"5180235_9615e4d0f687222adf","referrer":"unknown","lc_name":"bfb91591"}'
				);
				urlAPI = 'http://junglejumper.loc/api/index.php';	
			}
			
			model.player.uid = params.viewer_id;
			model.users.addUser( model.player );			
			
			gameService = new GameService(urlAPI);			
			vkService = new VKProxy(params);
			
			usersProvider = new UsersDataProvider(gameService, vkService);
			
			gameService.signIn(params.viewer_id, params.auth_key)
				.addResultHandler(onSignedIn)
				.addFaultHandler(handleServiceFault);
		}
		
		protected function onSignedIn(op:OpToken):void
		{			
			trace('=== onSignedIn ===');
			model.player.record = op.result.score;
			model.player.magicJumps.value = op.result.jumps;
			model.player.rank = op.result.rank;			
			
			trace('skills = '+op.result.skills);
			trace('rank = '+op.result.rank);
			trace('record = '+op.result.score);
			
			trace('usersAmount = '+op.result.usersAmount);

			
			for(var i:int = 0, l:int = model.player.skillLevels.length; i<l; i++)
			{
				model.player.skillLevels[i] = parseInt( String(op.result.skills).substr(i*2, 2), 10 );
//				trace(i, ': ', model.player.skillLevels[i]);
			}
			
			display.scrollScoreboard(model.player.rank, op.result.usersAmount);	
			
			display.enable();			
			
//			display.showMasteriesStore(model.player.skillLevels, model.player.magicJumps.value);
			
//			for(i = 0; i<11; i++)
//			{
//				var skill:Skill = model.design.getSkill(i);
//				trace('-----------------------------------');
//				trace(skill.id);
//				trace(skill.amounts);
//				trace(skill.prices);
//				trace(skill.upgrades);
//				trace(skill.maxLevel);
//				trace('[ \'amounts\'=>['+skill.amounts+'], \'prices\'=>['+skill.prices+'] ],');
				
//			}
			
//			gameService.submitScore(50).addFaultHandler(handleServiceFault);
			
		}
		
		protected function onShowTextHintRequest(e:Event):void
		{
			display.showTextHint();
		}
		
		protected function onShowSkillHintRequest(e:SkillEvent):void
		{
			display.showSkillHint(e.skill, e.level, model.player.skillLevels[ e.skill.id ], model.player.magicJumps.value);
		}
		
		protected function onHideSkillHintRequest(e:Event):void
		{
			display.hideHint();			 
		}
		
		protected function onUpgradeSkillRequest(e:SkillEvent):void
		{
			var skill:Skill = e.skill;
			var level:int = model.player.skillLevels[skill.id];
			
			var price:int = skill.getPrice(level+1);
			
			if(model.player.magicJumps.value>=price)
			{				
				gameService.buySkill(skill.id).addHandlers(handleBuySkillComplete, handleServiceFault);
			}
			
			
		}
		
		protected function handleBuySkillComplete(op:OpToken):void
		{
			var id:int = op.arguments[0];
			
			trace('op.result.skills = '+op.result.skills);
			
			model.player.skillLevels[id] = parseInt( String(op.result.skills).substr( id*2, 2), 10 );
			model.player.magicJumps.value = op.result['jumps'];
			
			display.showMasteriesStore( model.player.skillLevels, model.player.magicJumps.value );
		}
		
		protected function onBuyJumpsRequest(e:IndexEvent):void
		{
			display.disable();
			vkService.showOrderBox('item'+e.index).addHandlers(onOrderSuccess, onOrderFail);
		}
		
		protected function onOrderSuccess(op:OpToken):void
		{
			display.enable();
			
			var item:String = op.arguments[0];
			
			var index:int = int( item.substr(4) );
			
			model.player.magicJumps.value += JumpsPurchaseItem(model.design.jumpsPurchases[index]).jumps;
		}
		
		protected function onOrderFail(op:OpToken):void
		{
			display.enable();
		}
		

		
		protected function onShowMainMenuRequest(e:Event):void
		{
			game.pause();
			display.showStartScreen();
			display.showMainMenu();
			
			model.currentScreen = EnumAppScreens.MAIN_MENU;
		}
		
		protected function onStartGameRequest(e:Event):void
		{			
			display.hideStartScreen();
			display.hidePopup();
			
			model.currentScreen = EnumAppScreens.GAME;
			
			model.state.reset();
			game.run();
		}
		
		protected function onGameEnded(e:Event):void
		{
			
			var score:Number = model.state.score.value;
			var record:Number = model.player.record;

			display.showGameOver(score, record);
			display.hud.hideGameUI();
			
			if(score>record)
			{
				model.player.record = score;
				gameService.submitScore(score).addHandlers(onScoreSubmitted, handleServiceFault);
			}
		}
		
		protected function onScoreSubmitted(op:OpToken):void
		{
			model.player.rank = op.result.rank;
			display.scrollScoreboard(model.player.rank, op.result.usersAmount);
		}
		
		protected function onClosePopupRequest(e:Event):void
		{
			display.hideHint();
			if(model.currentScreen == EnumAppScreens.GAME)
			{
				display.hidePopup();
				game.run();
			}
			else
			{
				display.showMainMenu();				
			}			
		}
		
		protected function onShowMasteriesStoreRequest(e:Event = null):void
		{		
			if(model.currentScreen == EnumAppScreens.GAME)
			{
				game.pause();
			}
			
			display.showMasteriesStore(model.player.skillLevels, model.player.magicJumps.value);
		}
		
		protected function onShowJumpsStoreRequest(e:Event = null):void
		{			
			if(model.currentScreen == EnumAppScreens.GAME)
			{
				game.pause();
			}
			display.showJumpsStore();
		}
		
		protected function onShowManualRequest(e:Event = null):void
		{			
			display.showManual();
		}		
		
		protected function onRequestUsers(e:ItemsRequestEvent):void
		{
//			trace('e.firstIndex = '+e.firstIndex);
			e.setToken( usersProvider.getUsers(e.firstIndex, e.amount) );
		}
		
		protected function handleServiceFault(op:OpToken):void
		{
			var str:String = Object(op.fault).hasOwnProperty('faultString')?
				op.fault.faultString : 
				Object(op.fault).hasOwnProperty('error_msg')?
				op.fault.error_msg : op.fault;			
			
			trace('GAME SERVICE FAULT: '+str);
		}
		
		protected function onToggleSoundRequest(e:Event):void
		{
			sound.toggle();
			display.toggleSpeaker(sound.enabled);
		}
	}
}