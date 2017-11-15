package project.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import project.model.Player;
	import project.model.Skill;
	import project.utils.StringUtils;

	
	public class SkillHint extends Hint
	{
		
		protected static const roman_numerals:Array = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
		
		protected var bg:Sprite;
		
		protected var container:Sprite;
		protected var txtName:TextField;
		protected var txtDegree:TextField;
		protected var txtLevel:TextField;
		protected var txtDescription:TextField;
		protected var txtPrice:TextField;
		protected var txtStatus:TextField;
		
		protected var textWidth:Number = 150;
		
		public function SkillHint()
		{

			
			mouseEnabled = mouseChildren = false;
			
			blendMode = BlendMode.LAYER;
			
			bg = new Sprite;
			addChild( bg );
			bg.filters = [new DropShadowFilter(4, 45, 0, 0.5, 5, 5, 1, 3)];
			
			container = new Sprite;
			container.x = container.y = 5;
			addChild(container);
			
			var tf:TextFormat = new TextFormat('Calibri', 12, 0x494036);
			tf.align = TextFormatAlign.CENTER;
			
			txtName = new TextField;
			txtName.selectable = false;			
			txtName.multiline = false;
			txtName.autoSize = TextFieldAutoSize.LEFT;
			txtName.embedFonts = true;
			tf.bold = true;
			tf.size = 14;
			txtName.defaultTextFormat = tf;
			txtName.text = 'name';
			container.addChild(txtName);
			
			txtDegree = new TextField;
			txtDegree.selectable = false;
			txtDegree.y = height - 6;
			txtDegree.multiline = false;
			txtDegree.autoSize = TextFieldAutoSize.LEFT;
			txtDegree.embedFonts = true;
			tf.bold = true;
			tf.size = 15;
			txtDegree.defaultTextFormat = tf;
			txtDegree.text = 'degree';
			container.addChild(txtDegree);	
			
			txtLevel = new TextField;
			txtLevel.selectable = false;
			txtLevel.y = height;
			txtLevel.multiline = false;
			txtLevel.autoSize = TextFieldAutoSize.LEFT;
			txtLevel.embedFonts = true;
			tf.bold = true;
			tf.size = 12;
			txtLevel.defaultTextFormat = tf;
			txtLevel.text = 'level';
			container.addChild(txtLevel);
			
			txtDescription = new TextField;
			txtDescription.selectable = false;
			txtDescription.y = height;
			txtDescription.width = textWidth;
			txtDescription.multiline = true;
			txtDescription.wordWrap = true;
			txtDescription.autoSize = TextFieldAutoSize.LEFT;			
			txtDescription.embedFonts = true;
			tf.size = 12;
			tf.bold = false;
			txtDescription.defaultTextFormat = tf;			
			container.addChild(txtDescription);
			
			txtPrice = new TextField;
			txtPrice.selectable = false;
			txtPrice.y = height;
			txtPrice.multiline = false;
			txtPrice.autoSize = TextFieldAutoSize.LEFT;
			txtPrice.embedFonts = true;
			tf.bold = true;
			tf.size = 12;
			txtPrice.defaultTextFormat = tf;
			txtPrice.text = 'price';
			container.addChild(txtPrice);
			
			txtStatus = new TextField;
			txtStatus.selectable = false;
			txtStatus.y = height;
			txtStatus.multiline = false;
			txtStatus.autoSize = TextFieldAutoSize.LEFT;
			txtStatus.embedFonts = true;
			tf.bold = true;
			tf.size = 13;
			txtStatus.defaultTextFormat = tf;
			txtStatus.text = 'status';
			container.addChild(txtStatus);	
			
			hide();
		}
		
		public function show(skill:Skill, level:int, playerLevel:int, magicJumps:int):void
		{			

			
			var degree:int = skill.getDegree(level);
			var targetDegree:int = skill.getDegree(playerLevel+1);
			
			txtName.text = skill.name;
			txtName.x = int( (textWidth - txtName.width)/2 );
			
			if(skill.numDegrees <= 1)
			{
				txtDegree.text = '';
			}
			else
			{
				txtDegree.text = ((degree == skill.numDegrees-1)? 'высшей' : roman_numerals[degree]) + ' степени';
			}
			
			txtDegree.x = int( (textWidth - txtDegree.width)/2 );
			
			
			
			var price:int = skill.getPrice(level);
			
			
			
			var tf:TextFormat = txtStatus.defaultTextFormat;
			if(degree < targetDegree)
			{			
				tf.color = 0x3DA222;
				txtStatus.defaultTextFormat = tf;
				txtStatus.text = 'Полностью освоена';
				
//				txtPrice.alpha = 0.5;
				txtPrice.visible = false;
				txtLevel.visible = false;
				
				txtDescription.htmlText = skill.getDescription(level);
				txtDescription.y = txtDegree.y + txtDegree.height;
				
			}
			else if(degree == targetDegree)
			{
				if(magicJumps>=price)
				{
					tf.color = 0x126DA8;
					txtStatus.defaultTextFormat = tf;
					txtStatus.text = 'Клик, чтобы купить!';
				}
				else
				{
					tf.color = 0x8A270F;
					txtStatus.defaultTextFormat = tf;
					txtStatus.text = 'Не хватает прыжков';
				}				
				
				txtPrice.visible = true;
				txtLevel.visible = true;
				
//				trace(level, playerLevel, skill.getDegreeLevels(degree));
				txtLevel.text = (1 + skill.getDegreeLevels(degree) - (level-playerLevel)) + ' уровень';
				txtLevel.x = int( (textWidth - txtLevel.width)/2 );
				
				txtPrice.text = 'Цена: '+price+' '+StringUtils.multiForm(price, 'прыжок', 'прыжка', 'прыжков');
				
				txtDescription.htmlText = skill.getDescription(playerLevel+1);
				txtDescription.y = txtLevel.y + txtLevel.height;
			}
			else
			{
				tf.color = 0x8A270F;
				txtStatus.defaultTextFormat = tf;
				txtStatus.text = 'Необходимa '+roman_numerals[degree-1]+' степень';
				
				txtPrice.visible = true;
				txtLevel.visible = false;
				
				txtPrice.text = 'Цена за уровень: '+price+' '+StringUtils.multiForm(price, 'прыжок', 'прыжка', 'прыжков');
				
				txtDescription.htmlText = skill.getDescription(level);
				txtDescription.y = txtDegree.y + txtDegree.height;
			}
			
			txtPrice.x = int( (textWidth - txtPrice.width)/2 );
			txtPrice.y = txtDescription.y + txtDescription.height;			
			
			txtStatus.x = int( (textWidth - txtStatus.width)/2 );
			txtStatus.y = txtPrice.y + txtPrice.height;
			
			var g:Graphics = bg.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRoundRect(0, 0, container.width+container.x*2, container.height+container.y*2, 10);
			g.endFill();
			
			appear();
		}
		
		
	}
}