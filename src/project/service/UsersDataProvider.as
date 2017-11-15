package project.service
{
	import flash.utils.Dictionary;
	
	import lib.common.exec.OpToken;
	
	import project.model.UserModel;

	public class UsersDataProvider
	{
		
		protected var game:GameService;
		protected var vkontakte:VKProxy;
		
		protected var ops:Dictionary = new Dictionary;
		
		public function UsersDataProvider(game:GameService, vk:VKProxy)
		{
			this.game = game;
			this.vkontakte = vk;
		}
		
		public function getUsers(from:int, amount:int):OpToken
		{
			var op:OpToken = new OpToken(arguments);
			
			ops[op] = null;
			
			game.getUsersRanked(from, amount)
				.setParent(op)
				.addHandlers(onGameUsers, onFault);
			
			
			return op;
		}
		
		protected function onGameUsers(op:OpToken):void
		{
			
			var arr:Array = op.result as Array;
			var l:int = arr.length;
			
			var users:Vector.<UserModel> = new Vector.<UserModel>(l); 					
			
			var uids:Array = [];
			
			for(var i:int = 0; i<l; i++)
			{
				var obj:Object = arr[i];
				var uid:String = obj['uid'];
				
				uids[i] = uid;
				
				var user:UserModel = new UserModel();
				user.uid = uid;
				user.record = obj['score'];
				users[i] = user;
								
			}
			
			var opMain:OpToken = op.parent;
			
			ops[opMain] = users;			
			
			vkontakte.getUsers(uids)
				.setParent(opMain)
				.addHandlers(onVKontakteUsers, onFault);
		}
		
		protected function onVKontakteUsers(op:OpToken):void
		{
			var usersVK:Array = op.result as Array;
			
			var opMain:OpToken = op.parent;
			var users:Vector.<UserModel> = ops[opMain];	
			
			var k:int = users.length;
			for(var i:int = 0, l:int = usersVK.length; i<l; i++)
			{
				var userVK:Object = usersVK[i];				
				var uid:String = userVK['uid'];
				
				for(var j:int = 0; j<k; j++)
				{
					var user:UserModel = users[ j ];
					
					if(user.uid == uid)
					{
						user.firstName = userVK['first_name'];
						user.lastName = userVK['last_name'];
						user.photo = userVK['photo_medium'];
						break;
					}
				}				
			}
			
			delete ops[opMain];
			opMain.complete( users );
		}
		
		protected function onFault(op:OpToken):void
		{
			var opMain:OpToken = op.parent;
			delete ops[opMain];
			opMain.fail( op.fault );
		}
	}
}