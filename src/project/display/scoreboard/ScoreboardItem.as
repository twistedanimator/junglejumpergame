package project.display.scoreboard
{
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flashx.textLayout.formats.TextAlign;
	
	import lib.common.exec.OpToken;
	
	import project.model.UserModel;

	public class ScoreboardItem extends Sprite
	{
		
		
		protected var txtName:TextField;
		protected var txtScore:TextField;
		
		protected var txtIndex:TextField;
		
		protected var photoContainer:Sprite;
		protected var photoLoader:Loader;
		protected var frame:Sprite;
		protected var bg:Sprite;
		
		protected var photoPool:PhotoLoadersPool;
		
		protected var layoutWidth:int = 100;
		protected var layoutHeight:int = 148;
		protected var photoHeight:int = 118;
		
		public var data:UserModel;
		
		public function ScoreboardItem(photoPool:PhotoLoadersPool)
		{
			
			this.photoPool = photoPool;
			
			var g:Graphics;
			
			bg = new Sprite;
			addChild(bg);
			g = bg.graphics;
			g.beginFill(0x6c9f25);
			g.drawRect(0, 0, 100, layoutHeight);
			g.endFill();
			
			
			
			photoContainer = new Sprite;
			photoContainer.y = 30;
			photoContainer.scrollRect = new Rectangle(0, 0, 100, photoHeight);
			addChild(photoContainer);
			
			var panel:Sprite = new panel_small as Sprite;
			panel.y = layoutHeight - panel.height;
			addChild(panel);
			
			panel = new panel_small as Sprite;
			panel.height = 30;
			addChild(panel);
			
			var txt:TextField;
			var tf:TextFormat;
			
			txt = txtName = new TextField;
			txt.selectable = false;
			addChild(txt);
			txt.width = 100;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.multiline = true;
			txt.wordWrap = true;			
			tf = new TextFormat('Calibri', 10, 0xFFFFFF, false);
			tf.align = TextAlign.CENTER;
			txt.defaultTextFormat = tf;
			txt.filters = [new DropShadowFilter(1, 45, 0, 1, 2, 2, 1, 3, false)];
			
			txt = txtScore = new TextField;
			txt.selectable = false;
			addChild(txt);
			
//			txt.background = true;
//			txt.backgroundColor = 0x6c9f25;
			txt.width = 100;
			
			txt.autoSize = TextFieldAutoSize.LEFT;
//			txt.multiline = true;
//			txt.wordWrap = true;
			tf = new TextFormat('Calibri', 12, 0xFFFFFF, true);
			tf.align = TextAlign.CENTER;
			txt.defaultTextFormat = tf;
			txt.text = String(0);
			txt.y = layoutHeight - txt.height - 2;
			txt.filters = [new DropShadowFilter(1, 45, 0, 1, 2, 2, 1, 3, false)];
			
			
			txt = txtIndex = new TextField;
			txt.selectable = false;
			addChild(txt);			
			txt.autoSize = TextFieldAutoSize.LEFT;			
			tf = new TextFormat('Calibri', 12, 0xFFFFFF, true);			
			txt.defaultTextFormat = tf;
			txt.text = '0';
			txt.x = 2;
			txt.y = 33;
			txt.background = true;
			txt.backgroundColor = 0x43ac28;//0x6c9f25;
			txt.filters = [new DropShadowFilter(1, 45, 0, 1, 2, 2, 1, 3)];
			
			frame = new Sprite;
			addChild(frame);
			g = frame.graphics;
			g.lineStyle(1, 0x002e00);
			g.drawRect(0, 0, 100, layoutHeight);
			
			buttonMode = useHandCursor = true;
		}
		
		public function setData(data:UserModel, index:int = 0):void
		{
			
			this.data = data;
			
			if(photoLoader)
			{				
				photoPool.collectPhoto( photoLoader );				
			}
			
			if(!data)
			{
				visible = false;
				return;
			}
			
			visible = true;
			
			txtName.text = data.firstName+'\n'+data.lastName;			

			txtScore.text = String(data.record);
			
			
			
			if(txtScore.width>layoutWidth)
			{
				
			}
			
			txtScore.x = int( (width-txtScore.width)/2 );
			
			txtIndex.text = ' '+String(index+1)+' ';
			
			
			
			photoPool.getPhoto( data.photo ).addResultHandler( onPhoto );
			
			
			addEventListener(MouseEvent.CLICK, onClick);

		}
		
		protected function onClick(e:MouseEvent):void
		{
//			trace(data.uid);
			navigateToURL( new URLRequest('http://vk.com/id'+data.uid), '_blank' );
		}
		
		protected function onPhoto(op:OpToken):void
		{			
			photoLoader = op.result as Loader;
			photoContainer.addChild( photoLoader );
		}
		
	}
}