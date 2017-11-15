package project.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import project.enums.EnumEvents;
	
	public class Manual extends Sprite
	{
		public function Manual()
		{
			var asset:Sprite = new $instruction as Sprite;; 
			addChild( asset );
			
			var btnClose:TextButton = new TextButton('закрыть', onBtnCloseClick);
			btnClose.x = 530;
			btnClose.y = 416;
			addChild(btnClose);
			
			var btnJumps:Sprite = asset.getChildByName('btnJumps') as Sprite;
			btnJumps.buttonMode = btnJumps.useHandCursor = true;
			btnJumps.addEventListener(MouseEvent.CLICK, onBtnJumpsClick);
			
			var btnSkills:Sprite = asset.getChildByName('btnSkills') as Sprite;
			btnSkills.buttonMode = btnJumps.useHandCursor = true;
			btnSkills.addEventListener(MouseEvent.CLICK, onBtnSkillsClick);
		}
		
		protected function onBtnCloseClick():void
		{
			dispatchEvent( new Event(EnumEvents.CLOSE_POPUP, true) );
		}
		
		protected function onBtnJumpsClick(e:Event):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_JUMPS_STORE, true) );
		}
		
		protected function onBtnSkillsClick(e:Event):void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_MASTERIES_STORE, true) );
		}
	}
}