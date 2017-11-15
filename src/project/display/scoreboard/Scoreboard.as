package project.display.scoreboard
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import lib.common.exec.OpToken;
	
	import project.enums.EnumEvents;
	import project.event.ItemsRequestEvent;
	import project.model.UserModel;
	
	public class Scoreboard extends Sprite
	{
		
		protected var data:Vector.<UserModel>;
		
		protected var itemsContainer:Sprite;
		protected var items:Vector.<ScoreboardItem> = new Vector.<ScoreboardItem>;
		
		protected var hotArea:Sprite;
		
		protected var viewportWidth:Number = 640;
		protected var itemWidth:Number = 100;
		protected var gap:Number = 2;
		
		protected var photoPool:PhotoLoadersPool;
		
		protected var btnBackward:SimpleButton;
		protected var btnForward:SimpleButton;
		
		protected const numItems:int = 6;
		
		protected var currentIndex:int = -1;
		
		public var itemsAmount:int;
		
		public function Scoreboard()
		{
			
			itemsAmount = numItems;
			
			hotArea = new Sprite;
			hotArea.y = 29;
			addChild(hotArea);
			var g:Graphics = hotArea.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, viewportWidth, 130 );
			g.endFill();
			
			btnBackward = new button_left as SimpleButton;
			//			btnBackward.y = 29;
			addChild(btnBackward);
			btnBackward.addEventListener(MouseEvent.CLICK, onBtnBackwardClick);
			
			btnForward = new button_right as SimpleButton;
			btnForward.x = 625;
			//			btnForward.y = 29;
			addChild(btnForward);
			btnForward.addEventListener(MouseEvent.CLICK, onBtnForwardClick);
			
			
			itemsContainer = new Sprite;
			itemsContainer.x = 15;
//			itemsContainer.y = 29;
			addChild( itemsContainer );
			
			photoPool = new PhotoLoadersPool(numItems);			
			
			var currentX:int = 0;
			for(var i:int = 0, l:int = numItems; i<l; i++)
			{
				var item:ScoreboardItem = new ScoreboardItem(photoPool);
				item.x = currentX;
				
				itemsContainer.addChild(item);
				items[i] = item;
				
				currentX += itemWidth + gap;
			}
			
			
			

			
		}
		
		protected function onBtnBackwardClick(e:MouseEvent):void
		{
			goTo(currentIndex-numItems);
		}
		
		protected function onBtnForwardClick(e:MouseEvent):void
		{

			goTo(currentIndex+numItems, true);
		}
		
		public function scrollTo(num:int):void
		{
			goTo(int(num/numItems)*numItems);
		}
		
		public function goTo(firstIndex:int, force:Boolean = false):void
		{
		
			
			if(firstIndex>(itemsAmount-numItems))
			{
				firstIndex = itemsAmount - numItems;
			}
			
			if(firstIndex < 0)
			{
				firstIndex = 0;
			}
			
			if(!force && firstIndex == currentIndex)
			{
				return;
			}
			
			var event:ItemsRequestEvent = new ItemsRequestEvent(EnumEvents.REQUEST_USERS, firstIndex, numItems); 
			dispatchEvent( event );
			event.getToken().addResultHandler(onUsersData);

			currentIndex = firstIndex;
		}
		
		protected function onUsersData(op:OpToken):void
		{
			var users:Vector.<UserModel> = op.result;
			
//			users.length = 1;
			
			for(var i:int = 0; i<numItems; i++)
			{
				var item:ScoreboardItem = items[i]; 
				if(i<users.length)
				{
					item.setData(users[i], currentIndex+i);
				}
				else
				{
					item.setData(null);
				}
			}
		}

		


		
//		protected function renderItemsData(itemPos:int):void
//		{
//			if(direction>=0)
//			{
//				for(var i:int = 0, l:int = numItems; i<l; i++)
//				{
//					items[i].setData(data[itemPos+i], itemPos+i+1);
//				}	
//			}
//			else 
//			{
//				for(i = numItems-1; i>=0; i--)
//				{
//					items[i].setData(data[itemPos+i], itemPos+i+1);
//				}	
//			}
//			
//			
//			photoPool.managePhotos();
//			
//			renderedItemPos = itemPos;
//		}
		
		
	}
}