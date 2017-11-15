package project.display
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import project.enums.EnumEvents;
	
	public class MainMenu extends Sprite
	{
		public function MainMenu()
		{
			var mainMenu:Sprite = new $startMenu;
			addChild(mainMenu);
			
			var btnPlay:SimpleButton = mainMenu.getChildByName('btnPlay') as SimpleButton;
			btnPlay.addEventListener(MouseEvent.CLICK, onBtnPlayClick);
			
			var btnManual:SimpleButton = mainMenu.getChildByName('btnManual') as SimpleButton;
			btnManual.addEventListener(MouseEvent.CLICK, onBtnManualClick);
			
			var btnShop:SimpleButton = mainMenu.getChildByName('btnShop') as SimpleButton;
			btnShop.addEventListener(MouseEvent.CLICK, onBtnShopClick);
		}
		
		protected function onBtnPlayClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.START_GAME, true) );
		}
		
		protected function onBtnManualClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_MANUAL, true) );
		}
		
		protected function onBtnShopClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_MASTERIES_STORE, true) );
		}
	}
}