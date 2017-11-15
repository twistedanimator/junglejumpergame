package project.display.scoreboard
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import lib.common.exec.OpToken;

	public class PhotoLoadersPool
	{
		
		protected var freeLoaders:Vector.<Loader>;
		
		protected var pendingTokens:Vector.<OpToken>;
		
		public function PhotoLoadersPool(size:int = 1)
		{
			
			freeLoaders = new Vector.<Loader>;

			
			pendingTokens = new Vector.<OpToken>;
			
			while(size)
			{
				var loader:Loader = new Loader
				freeLoaders.push(loader);
				
				size--;
			}
			
			
		}
		
		public function getPhoto(url:String):OpToken
		{
			var op:OpToken = new OpToken(arguments);
			
			for(var i:int = 0, l:int = freeLoaders.length; i<l; i++)
			{
				var loader:Loader = freeLoaders[i];
				if(loader.contentLoaderInfo.url == url)
				{
					freeLoaders.splice(i, 1);
					op.complete( loader );
					return op;
				}
			}
			
			pendingTokens.push( op );
			
			managePhotos();

			return op;
		}
		
		public function managePhotos():void
		{
			
			for(var k:int = 0, n:int = pendingTokens.length; k<n; k++)
			{
				op = pendingTokens[k];
				url = op.arguments[0];
				
				for(var i:int = 0, l:int = freeLoaders.length; i<l; i++)
				{
					loader = freeLoaders[i];
					if(loader.contentLoaderInfo.url == url)
					{
						freeLoaders.splice(i, 1);						
						
						op.complete( loader );						
						pendingTokens.splice(k, 1);
						k--, n--;
						break;
					}
				}
			}

			
			while(pendingTokens.length)
			{
				var op:OpToken = pendingTokens.shift();
				var url:String = op.arguments[0];
				var loader:Loader = freeLoaders.shift();				
				
				
				loader.load( new URLRequest(url) );		
				
				op.complete(loader);
			}

		}
		
		public function collectPhoto(loader:Loader):void
		{
			if(!loader)
			{
				return;
			}
			
			if(loader.parent)
			{
				loader.parent.removeChild( loader );
			}
			
			freeLoaders.push( loader );
			
			
		}
						
	}
}