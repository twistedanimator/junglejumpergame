package project.service
{
	import flash.events.Event;
	
	import lib.common.exec.OpToken;
	
	import vk.APIConnection;
	
	public class VKProxy
	{

		
		public var connection:APIConnection;
		
		public function VKProxy(params:Object)
		{
			connection = new APIConnection(params);
			connection.forceDirectApiAccess();
		}
		
		public function getUsers(uids:Array):OpToken
		{
			var data:Object = 
				{
					uids: uids.join(','),
					fields: 'uid,first_name,last_name,photo,photo_medium'
				};
			
//			var result:Array = [];
//			for(var i:int = 0, l:int = uids.length; i<l; i++)
//			{
//				var uid:String = uids[i];
//				var user:Object = {};
//				user.uid = uid;
//				user.first_name = 'Ирина';//'name'+uid;
//				user.last_name = 'Захарова';//'surname'+uid;
//				user.photo = 'http://junglejumper.local/avatar.jpg';
//				user.photo_medium = 'http://junglejumper.local/avatar.jpg';
//				result[i] = user;
//			}
//			var op:OpToken = new OpToken(arguments);
//			op.complete(result);
//			return op;
			
			return api('users.get', data);
		}
		
		public function showOrderBox(item:String):OpToken
		{
			
			var op:OpToken = new OpToken(arguments);
			
			connection.callMethod('showOrderBox', {type: 'item', item: item});
			connection.addEventListener('onOrderCancel', onCancel);
			connection.addEventListener('onOrderFail', onError);
			connection.addEventListener('onOrderSuccess', onSuccess);
			
			
			function onCancel(e:Event):void
			{
				op.fail('cancelled');
			}
			
			function onError(e:Event):void
			{
				op.fail('error');
			}
			
			function onSuccess(e:Event):void
			{
				op.complete('success');
			}
			
			
			return op;
		}
		
//		public function clientAPI(method:String, ...params):OpToken
//		{
//			var op:OpToken
//		}
		
		public function api(method:String, data:Object):OpToken
		{
			
			var op:OpToken = new OpToken(arguments);
			
			connection.api(method, data, onComplete, onError);
			
			return op;
			
			function onComplete(obj:Object):void
			{
				op.complete(obj);
			}
			
			function onError(obj:Object):void
			{
				trace('VKProxy Error');
				op.fail(obj);
			}
		}
	}
}