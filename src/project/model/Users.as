package project.model
{
	public class Users
	{
		
		protected var users:Object = {};
		
		public function Users()
		{
		}
		
		public function getUser(uid:String):UserModel
		{
			var user:UserModel = users[uid]; 
			if(!user)
			{
				user = new UserModel;
				user.uid = uid;
				users[uid] = user;
			}			
			
			return user;
		}
		
		public function addUser(user:UserModel):void
		{
			users[user.uid] = user;
		}
	}
}