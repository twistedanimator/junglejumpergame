package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.DropShadowFilterPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import project.display.scoreboard.Scoreboard;
	import project.enums.EnumEvents;
	import project.model.GameDesign;
	import project.model.Skill;
	import project.model.UserModel;
	
	public class MainDisplay extends Sprite
	{
		
		protected var design:GameDesign;
		
		protected const startScreen:StartScreen = new StartScreen;
		public const gameDisplay:Sprite = new Sprite;
		
		protected var speaker:MovieClip;
		
		public const hud:GameHUD = new GameHUD;		
		protected const popupsLayer:Sprite = new Sprite;
		protected const hintsLayer:Sprite = new Sprite;
		
		protected var bigPopup:Popup;
		protected var transparentPopup:Popup;
		
		protected var mainMenu:MainMenu;
		protected var jumpsStore:PopupJumpsPurchase;
		protected var masteriesStore:ShopWindow;
		protected var manual:Manual;
		protected var gameOver:PopupGameOver;
		
		protected var currentPopup:Popup;
		protected var targetPopup:Popup;
		protected var targetContent:Sprite;
		
		public var scoreboard:Scoreboard;
		
		
		protected var hint:Hint;
		protected var textHint:TextHint;
		protected var skillHint:SkillHint;
		
		
		public function MainDisplay(design:GameDesign)
		{			
			this.design = design;
			
			TweenPlugin.activate([TransformAroundCenterPlugin, GlowFilterPlugin, DropShadowFilterPlugin ]);
			
			scoreboard = new Scoreboard;
			scoreboard.y = 481;
			addChild(scoreboard);
			
			addChild(gameDisplay);
			addChild(startScreen);
			addChild( hud );
			
			speaker = new $speaker;
			speaker.transform.colorTransform = new ColorTransform(0.55859375, 0.55859375, 0.55859375, 1, 112, 112, 22);
			speaker.buttonMode = speaker.useHandCursor = true;
			speaker.x = 600;
			speaker.y = 20;
			addChild(speaker);speaker.gotoAndStop('on');			
			speaker.addEventListener(MouseEvent.CLICK, onSpeakerClick);
			
			addChild( popupsLayer );
			addChild( hintsLayer );
			
			bigPopup = new Popup(new $bgPopup, onCurrentPopupHidden);
			transparentPopup = new Popup(null, onCurrentPopupHidden);
			
			mainMenu = new MainMenu;
			
			manual = new Manual;
			
			gameOver = new PopupGameOver;
			
			skillHint = new SkillHint;
			hintsLayer.addChild(skillHint);
			
			textHint = new TextHint;
			hintsLayer.addChild(textHint);
			
			mouseChildren = false;
		}
		
		public function enable():void
		{
			mouseChildren = true;
		}
		
		public function disable():void
		{
			mouseChildren = false;
		}
		
		public function showTextHint(text:String = null):void
		{
			hideHint();
			hint = textHint;
			textHint.show(text);
		}
		
		public function showSkillHint(skill:Skill, level:int, playerLevel:int, magicJumps:int):void
		{
			hideHint();
			hint = skillHint;
			skillHint.show(skill, level, playerLevel, magicJumps);
		}
		
		public function hideHint():void
		{
			if(hint)
			{
				hint.hide();
				hint = null;
			}
			
		}

		
		public function scrollScoreboard(index:int, totalAmount:int):void
		{
			
			scoreboard.itemsAmount = totalAmount;
			scoreboard.scrollTo(index);
		}
		
		public function hidePopup():void
		{
			hideHint();
			if(currentPopup)
			{
				currentPopup.hide();				
			}
			
		}
		
		public function showStartScreen():void
		{
			startScreen.show();
		}
		
		public function hideStartScreen():void
		{
			startScreen.hide();
		}
		
		public function showMainMenu():void
		{
			showPopup(transparentPopup, mainMenu);
		}
		
		public function showManual():void
		{
			showPopup(bigPopup, manual);
		}
		
		public function showJumpsStore():void
		{
			showPopup(bigPopup, getJumpsStore());
		}
		
		public function showMasteriesStore(skillLevels:Array, magicJumps:int):void
		{			
			var popup:ShopWindow = getMasteriesStore();
			popup.update(skillLevels, magicJumps);
			showPopup(bigPopup, popup);
		}
		
		public function toggleSpeaker(on:Boolean = true):void
		{
			if(on)
			{
				speaker.gotoAndStop('on');
			}
			else
			{
				speaker.gotoAndStop('off');
			}
		}
		
		protected function showPopup(popup:Popup, content:Sprite):void
		{
			hideHint();
			
			if(!currentPopup)
			{
				currentPopup = popup;
				popupsLayer.addChild( currentPopup );
			}
			
			if(popup == currentPopup)
			{				
				currentPopup.show(content);
			}
			else
			{
				targetPopup = popup;
				targetContent = content;

				currentPopup.hide();
			}			
		}
		
		protected function onCurrentPopupHidden():void
		{
			popupsLayer.removeChild( currentPopup );
			currentPopup = null;
			
			if(targetPopup)
			{
				showPopup(targetPopup, targetContent);
				targetPopup = null;
				targetContent = null;
			}
		}		
		
		public function showGameOver(score:Number, record:Number):void
		{
			gameOver.update(score, record);
			showPopup(transparentPopup, gameOver);
		}		
		
		protected function getJumpsStore():PopupJumpsPurchase
		{
			if(!jumpsStore)
			{
				jumpsStore = new PopupJumpsPurchase(design.jumpsPurchases);
			}
			
			return jumpsStore;
		}
		
		protected function getMasteriesStore():ShopWindow
		{
			if(!masteriesStore)
			{
				masteriesStore = new ShopWindow(design.getSkills());
			}
			
			return masteriesStore;
		}
		
		protected function onSpeakerClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.TOGGLE_SOUND, true) );
		}
	}
}