package project.display
{
	import flash.display.BlendMode;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import project.enums.EnumEvents;
	
	public class PopupGameOver extends Sprite
	{
		
		protected var yourRecord:Sprite;
		protected var newRecord:Sprite;
		
		protected var txtScore:TextField;
		protected var txtRecord:TextField;
		
		protected var btnPlay:SimpleButton;
		protected var btnMenu:SimpleButton;
		
		
		
		public function PopupGameOver()
		{
			blendMode = BlendMode.LAYER;
			
			var asset:Sprite = new $popupGameOver;

			addChild(asset);
			
			yourRecord = asset.getChildByName('yourRecord') as Sprite;
			newRecord = asset.getChildByName('newRecord') as Sprite;
			newRecord.visible = false;
			
			txtScore = asset.getChildByName('txtScore') as TextField;
			txtRecord = yourRecord.getChildByName('txtRecord') as TextField;
			
			btnPlay = asset.getChildByName('btnPlay') as SimpleButton;
			btnMenu = asset.getChildByName('btnMenu') as SimpleButton;
			
			btnPlay.addEventListener(MouseEvent.CLICK, onBtnPlayClick);
			btnMenu.addEventListener(MouseEvent.CLICK, onBtnMenuClick);
			
			asset.x = int( (640-asset.width)/2 );
			asset.y = int( (480-asset.height)/2 );
		}
		
		protected function onBtnPlayClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.START_GAME, true) );
		}
		
		protected function onBtnMenuClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_MAIN_MENU, true) );
		}
		
		public function update(score:Number, record:Number):void
		{
			txtScore.text = String(score);
			
			if(score<record)
			{
				txtRecord.text = String(record);	
				newRecord.visible = false;
				yourRecord.visible = true;
			}
			else
			{
				newRecord.visible = true;
				yourRecord.visible = false;
			}
			
			
			
		}
		
		
	}
}