package project.display
{
	import ash.signals.Signal0;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import project.enums.EnumEvents;
	import project.event.IndexEvent;
	
	public class PopupJumpsPurchase extends Sprite
	{
		
		protected var container:Sprite;
	
		public function PopupJumpsPurchase(purchases:Array, w:Number = 640, h:Number = 480)
		{
			
//			blendMode = BlendMode.LAYER;
			
			var g:Graphics = graphics;			
			g.beginFill(0, 0);
			g.drawRect(0, 0, w, h);
			g.endFill();
			
			container = new Sprite;

			
			var x:Number = 100;
			var y:Number = 40;
			for(var i:int = 0, l:int = purchases.length; i<l; i++)
			{
				var item:ItemRenderer = new ItemRenderer(purchases[i]);
				item.x = x;
				item.y = y;
				container.addChild( item );
				
				if( (i+1)%3 == 0 )
				{
					y = 50;
					x+= 280;
				}
				else
				{
					y+= 120;
				}
				
				item.addEventListener(MouseEvent.CLICK, onItemClick);
			}			
			
			addChild(container);
			
			var btnSkillStore:TextButton = new TextButton('суперспособности!', onBtnSkillStoreClick);
			btnSkillStore.x = 41;
			btnSkillStore.y = 416;
			addChild(btnSkillStore);
			
			var btnClose:TextButton = new TextButton('закрыть', onBtnCloseClick);
			btnClose.x = 530;
			btnClose.y = 416;
			addChild(btnClose);
			
		}
		
		protected function onItemClick(e:MouseEvent):void
		{
			var item:ItemRenderer = e.target as ItemRenderer;
			
			dispatchEvent(new IndexEvent(EnumEvents.BUY_JUMPS, item.data.id, true)); 
		}
		
		
		protected function onBtnCloseClick():void
		{
			dispatchEvent( new Event(EnumEvents.CLOSE_POPUP, true) );
		}
		
		protected function onBtnSkillStoreClick():void
		{
			dispatchEvent( new Event(EnumEvents.SHOW_MASTERIES_STORE, true) );
		}

	}
}
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import project.model.JumpsPurchaseItem;

import project.utils.StringUtils;

internal class ItemRenderer extends Sprite
{
	
	public var data:JumpsPurchaseItem;
	
	protected var icon:Sprite;
	protected var txtJumps:TextField;
	protected var txtPrice:TextField;
	
	public function ItemRenderer(data:JumpsPurchaseItem)
	{
		
		buttonMode = useHandCursor = true;
		mouseChildren = false;
		
		this.data = data;
		
		var sp:Sprite;
		
		icon = new Sprite;
		sp = new $icon_monkey;
		sp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 5)];
		icon.addChild( sp );
		addChild(icon);
		
		txtPrice = new TextField;
		txtPrice.multiline = false;
		txtPrice.autoSize = TextFieldAutoSize.LEFT;
		txtPrice.selectable = false;		
		txtPrice.defaultTextFormat = new TextFormat('Calibri', 22, 0);
		txtPrice.embedFonts = true;		
		txtPrice.text = '= '+data.price+' '+StringUtils.multiForm(data.price, 'голос', 'голоса', 'голосов');
		txtPrice.x = icon.x + icon.width + 5;
		txtPrice.y = int( (icon.height-txtPrice.height)/2 );
		sp = new Sprite;
		addChild(sp);
		sp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 5)];
		sp.addChild(txtPrice);
		
		
		txtJumps = new TextField;
		txtPrice.multiline = false;
		txtJumps.autoSize = TextFieldAutoSize.LEFT;
		txtJumps.selectable = false;		
		txtJumps.defaultTextFormat = new TextFormat('Calibri', 42, 0);
		txtJumps.embedFonts = true;		
		txtJumps.text = String(data.jumps);		
		txtJumps.x = -int(txtJumps.width/2);
		txtJumps.y = icon.height - txtJumps.height/2;
		sp = new Sprite;
		addChild(sp);
		sp.filters = [new GlowFilter(0xFFFFFF, 1, 5, 5, 5)];
		sp.addChild(txtJumps);
		
		var rect:Rectangle = getBounds(this);
		var g:Graphics = graphics;
		g.beginFill(0, 0);
		g.drawRect(rect.x, rect.y, rect.width, rect.height);
		g.endFill();
		
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	protected function onMouseOver(e:MouseEvent):void
	{
		TweenMax.to(icon, 0.2, {x: -3, y: -3, dropShadowFilter:{blurX:5, blurY:5, distance:2, alpha:1}, ease: Sine.easeOut});
	}
	
	protected function onMouseOut(e:MouseEvent):void
	{
		TweenMax.to(icon, 0.1, {x: 0, y: 0, dropShadowFilter:{blurX:0, blurY:0, distance:0, alpha:0}, ease: Sine.easeOut});
	}
	
	protected function onMouseDown(e:MouseEvent):void
	{
		TweenMax.to(icon, 0.1, {x: 0, y: 0, dropShadowFilter:{blurX:0, blurY:0, distance:0, alpha:0}, ease: Sine.easeOut});
	}
}

