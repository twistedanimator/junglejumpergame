package project.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import project.enums.EnumEvents;
	import project.model.Skill;
	
	public class ShopWindow extends Sprite
	{
		
		protected var txtJumps:TextField;
		
		protected var magicJumpsHotArea:Sprite;
		
		protected var items:Array = [];
		
		protected var itemsHolder:Sprite;
		protected var itemsDistanceX:Number = 70;
		protected var itemsDistanceY:Number = 50;
		
		protected const itemsOrder:Vector.<int> = new <int>[0,1,6,7,4,3,9,2,5,10,8];
		
		public function ShopWindow(skills:Vector.<Skill>)
		{
			
//			this.model = model;
			
//			skillHint = new SkillHint(model.player);
			
			icon0, icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, icon9, icon10;
			
			var asset:Sprite = new $shop;
			addChild(asset);
			
			magicJumpsHotArea = asset.getChildByName('magicJumpsHotArea') as Sprite;
			magicJumpsHotArea.addEventListener(MouseEvent.MOUSE_OVER, onMagicJumpsMouseOver);
			magicJumpsHotArea.addEventListener(MouseEvent.MOUSE_OUT, onMagicJumpsMouseOut);

			
			txtJumps = asset.getChildByName('txtJumps') as TextField;
			txtJumps.autoSize = TextFieldAutoSize.LEFT;
			
			var sp:Sprite = new Sprite;
			sp.addChild(txtJumps);
			sp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 2)];
			addChild(sp);
			sp.mouseEnabled = sp.mouseChildren = false;
			
			itemsHolder = new Sprite;
			itemsHolder.x = 55;
			itemsHolder.y = 30;
			addChild(itemsHolder);
			
			var x:int = 0;
			var y:int = 0;
			for(var i:int = 0, l:int = itemsOrder.length; i<l; i++)
			{
				var skill:Skill = skills[ itemsOrder[i] ];
				var skillDisplay:SkillItemRenderer = new SkillItemRenderer(skill);
				
//				skillDisplay.onClick = onSkillIconClick;
				
				skillDisplay.x = x;
				skillDisplay.y = y;
				
				itemsHolder.addChild(skillDisplay);
				items[skill.id] = skillDisplay;
				
				if(skill.numDegrees>3 || y!=0)
				{
					y = 0;
					x += itemsDistanceX;
				}
				else
				{
					y += skillDisplay.height + itemsDistanceY;
				}
			}
			
			var btnJumpsStore:TextButton = new TextButton('купить прыжки', onBtnJumpsStoreClick);
			btnJumpsStore.x = 41;
			btnJumpsStore.y = 416;
			addChild(btnJumpsStore);
			
			var btnClose:TextButton = new TextButton('закрыть', onBtnCloseClick);
			btnClose.x = 530;
			btnClose.y = 416;
			addChild(btnClose);			

		}
		
		public function update(skillLevels:Array, magicJumps:int):void
		{	
//			skillHint.hide();
			
			txtJumps.text = String( magicJumps );
			
			magicJumpsHotArea.width = txtJumps.x+txtJumps.width-magicJumpsHotArea.x;
			
			for(var i:int = 0, l:int = skillLevels.length; i<l; i++)
			{
				(items[i] as SkillItemRenderer).setLevel( skillLevels[i] );
			}
		}
		
		protected function onBtnCloseClick():void
		{
			dispatchEvent( new Event(EnumEvents.CLOSE_POPUP, true) );
		}
		
		protected function onBtnJumpsStoreClick():void
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