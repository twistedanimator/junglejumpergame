package project.display
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import project.enums.EnumEvents;
	
	public class GameHUD extends Sprite
	{
		
		protected var score:ScoreDisplay;
		
		protected var comboBonus:ComboBonusDisplay;
		
		protected var magicJumps:Sprite;
		protected var txtJumps:TextField;
		protected var magicJumpsHotArea:Sprite;
		
		
		public function GameHUD()
		{			
			
			score = new ScoreDisplay;
			score.x = score.y = 15;
			addChild(score);
			
			comboBonus = new ComboBonusDisplay;
			comboBonus.x = int( (640 - comboBonus.width)/2 );
			comboBonus.y = 340;
			addChild(comboBonus);				
			
			magicJumps = new $magic_jumps;
			
			magicJumps.x = 5;
			magicJumps.y = 390;
			addChild( magicJumps );
			
			magicJumpsHotArea = magicJumps.getChildByName('magicJumpsHotArea') as Sprite;
			magicJumpsHotArea.addEventListener(MouseEvent.MOUSE_OVER, onMagicJumpsMouseOver);
			magicJumpsHotArea.addEventListener(MouseEvent.MOUSE_OUT, onMagicJumpsMouseOut);
			
			txtJumps = magicJumps.getChildByName('txtJumps') as TextField;
			txtJumps.autoSize = TextFieldAutoSize.LEFT;
			
			var sp:Sprite = new Sprite;
			sp.mouseEnabled = sp.mouseChildren = false;
			sp.addChild(txtJumps);
			sp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 2)];
			magicJumps.addChild(sp);
			
			var btnPlus:SimpleButton = magicJumps.getChildByName('btnPlus') as SimpleButton;
			btnPlus.addEventListener(MouseEvent.CLICK, onBtnPlusClick);			

			mouseEnabled = false;
			
			hideGameUI();
			
		}		
		
		public function showGameUI():void
		{
			magicJumps.visible = true;
			score.visible = true;
		}
		
		public function hideGameUI():void
		{
			magicJumps.visible = false;
			score.visible = false;
		}
		
		public function setMagicJumps(value:int):void
		{
			txtJumps.text = String(value);
			magicJumpsHotArea.width = txtJumps.x+txtJumps.width-magicJumpsHotArea.x;
		}
		
		public function setScore(value:int):void
		{
			score.setValue(value);
		}
		
		public function setComboBonus(value:int):void
		{
			comboBonus.setValue(value);
		}
		
		protected function onBtnPlusClick(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_JUMPS_STORE, true) );
		}
		
		protected function onMagicJumpsMouseOver(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_TEXT_HINT, true) );
		}
		
		protected function onMagicJumpsMouseOut(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.HIDE_HINT, true) );
		}
	}
}