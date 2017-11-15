package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import project.enums.EnumEvents;
	import project.event.SkillEvent;
	import project.model.Skill;
	
	public class SkillItemRenderer extends Sprite
	{

		public var skill:Skill;
		protected var currentLevel:int = -1;
		
		protected var degreeItems:Array = [];		
		protected var activeIcon:Sprite;	
		
		public function SkillItemRenderer(skill:Skill)
		{
			
			this.skill = skill;
			
			var iconClass:Class = getDefinitionByName('icon'+skill.id) as Class;
			
			
			
			var y:Number = 0;
			var distance:Number = 43;
			
			var itemsHolder:Sprite = new Sprite;
			addChild(itemsHolder);

			
			for(var i:int = 0, l:int = skill.numDegrees; i<l; i++)
			{				
				var icon:DegreeItem = new DegreeItem(iconClass, i, skill.getDegreeLevels(i));
				icon.y = y;
				
				itemsHolder.addChild(icon);					
				degreeItems[i] = icon;
				
				icon.addEventListener(MouseEvent.MOUSE_OVER, onIconMouseOver);				
				
				y+=distance;
			}
			
			var g:Graphics = itemsHolder.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, itemsHolder.width, itemsHolder.height);
			g.endFill();
			
			itemsHolder.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
		}
		
		protected function onMouseOut(e:MouseEvent):void
		{
			dispatchEvent( new Event(EnumEvents.HIDE_HINT, true) );
			
		}
		
		protected function onIconMouseOver(e:MouseEvent):void
		{
			var icon:DegreeItem = e.currentTarget as DegreeItem;
			var level:int = skill.getDegreeLevelsTotal( icon.degree );
			
			dispatchEvent( new SkillEvent(EnumEvents.SHOW_SKILL_HINT, skill, level, true) );			

		}
		
		protected function onActiveIconMouseOver(e:MouseEvent):void
		{
			TweenMax.to(activeIcon, 0.5, {glowFilter:{color:0xFFFFFF, blurX:10, blurY:10, strength:5, alpha:1, ease: Sine.easeOut}});
			
		}
		
		protected function onActiveIconMouseOut(e:MouseEvent):void
		{
			TweenMax.to(activeIcon, 0.5, {glowFilter:{color:0xFFFFFF, blurX:0, blurY:0, strength:1, alpha:0, ease: Sine.easeOut}});
			
		}
		
		protected function onActiveIconClick(e:MouseEvent):void
		{
//			if(onClick != null)
//			{
//				var icon:Sprite = e.target as Sprite;
//				var level:int = int(icon.name.substr(5));				
//				onClick(this, level);
//			}
			
			var item:DegreeItem = e.currentTarget as DegreeItem;
			dispatchEvent( new SkillEvent(EnumEvents.UPGRADE_SKILL, skill, skill.getDegreeLevelsTotal(item.degree), true) );
				
		}
		
		public function setLevel(level:int):void
		{
//			trace('setLevel: skill = '+skill.id+', currentLevel = '+currentLevel+', level = '+level);
			
			if(level == currentLevel)
			{
				return;
			}
			
			dispatchEvent( new Event(EnumEvents.HIDE_HINT, true) );
			if(activeIcon)
			{
				onActiveIconMouseOut(null);
				activeIcon.removeEventListener(MouseEvent.CLICK, onActiveIconClick);	
				activeIcon.removeEventListener(MouseEvent.MOUSE_OVER, onActiveIconMouseOver);
				activeIcon.removeEventListener(MouseEvent.MOUSE_OUT, onActiveIconMouseOut);
				activeIcon = null;
			}
			
			var targetDegree:int = skill.getDegree(level+1);
			
//			trace('degree = '+degree);

			for(var i:int = 0, l:int = skill.numDegrees; i<l; i++)
			{
				var icon:DegreeItem = degreeItems[i];
	
				if(i<targetDegree)
				{
					icon.setComplete();
				}
				else if(i == targetDegree)
				{
					icon.setCurrent( skill.getDegreeLevelsTotal(targetDegree)-level );
					
					activeIcon = icon;
					activeIcon.addEventListener(MouseEvent.CLICK, onActiveIconClick);
					activeIcon.addEventListener(MouseEvent.MOUSE_OVER, onActiveIconMouseOver);
					activeIcon.addEventListener(MouseEvent.MOUSE_OUT, onActiveIconMouseOut);
				}
				else
				{
					icon.setUnavailable();
				}
			}
			
			currentLevel = level;
			
			mouseEnabled = mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		protected var counter:int = 0;
		protected function onEnterFrame(e:Event):void
		{
			if(++counter == 2)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				mouseEnabled = mouseChildren = true;
				counter = 0;

			}		
		}
	}
}

import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

internal class DegreeItem extends Sprite
{
	
	protected static const grayscale:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0]);
	protected static const iconGlow:GlowFilter = new GlowFilter(0xFFFFFF, 1, 5, 5, 3);
	
	protected static const tfPrice:TextFormat = new TextFormat('Calibri', 14, 0x494036, true);
	protected static const priceGlow:GlowFilter = new GlowFilter(0xFFFFFF, 1, 7, 7, 5);
	
	protected var icon:Sprite;
	protected var txtLevel:TextField;
	protected var levelCounterHolder:Sprite;
	
	public var degree:int;
	public var degreeLevels:int;
	
	public function DegreeItem(iconClass:Class, degree:int, degreeLevels:int)
	{
		icon = new iconClass;		
		this.degree = degree;
		this.degreeLevels = degreeLevels;
		
		addChild(icon);
		icon.mouseChildren = false;
		icon.filters = [grayscale];		
		
		levelCounterHolder = new Sprite;		
		levelCounterHolder.filters = [priceGlow];
		addChild(levelCounterHolder);		
		levelCounterHolder.mouseChildren = levelCounterHolder.mouseEnabled = false;
		
		txtLevel = new TextField;		
		txtLevel.autoSize = TextFieldAutoSize.LEFT;
		txtLevel.selectable = false;
		txtLevel.defaultTextFormat = tfPrice;
		txtLevel.text = '0/0';
		levelCounterHolder.addChild(txtLevel);
		
		levelCounterHolder.x = icon.width - 12;
		levelCounterHolder.y = icon.y + icon.height - levelCounterHolder.height;

	}
	
	public function setComplete():void
	{
		icon.filters = [iconGlow];
		icon.buttonMode = icon.useHandCursor = false;					
		txtLevel.text = degreeLevels+'/'+degreeLevels; 
	}
	
	public function setCurrent(remainingLevels:int):void
	{
		icon.filters = [];
		icon.buttonMode = icon.useHandCursor = true;	
		
		txtLevel.text = (degreeLevels - remainingLevels)+'/'+degreeLevels; 
	}
	
	public function setUnavailable():void
	{
		icon.filters = [grayscale];
		icon.buttonMode = icon.useHandCursor = false;
		txtLevel.text = '0/'+degreeLevels; 
	}
}