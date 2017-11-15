package project.service
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import lib.common.exec.OpToken;
	
	import project.enums.EnumEvents;
	import project.utils.Blowfish;
	
	public class GameService extends EventDispatcher
	{
		
		protected var amfservice:NetConnection;		
		protected var gateway:String;
		
		public function GameService(gateway:String)
		{
			this.gateway = gateway;
			
			amfservice = new NetConnection();
			amfservice.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			amfservice.connect(gateway);
		}
		
		public function signIn(viewer_id:String, auth_key:String):OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.signIn',
				getResponder(op),
				viewer_id, auth_key
			);
			
			return op;
		}
		
		public function signOut():OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.signOut',
				getResponder(op)
			);
			
			return op;
		}
		
		public function submitScore(score:int):OpToken
		{			
			var op:OpToken = new OpToken(arguments);
			
			amfservice.call(
				'User.submitScore',
				getResponder(op),
				Blowfish.encrypt('And the score is: '+score, EnumEvents.SHOW_MAIN_MENU)
			);
			
			return op;
		}
		
		public function getTop(amount:int = 100):OpToken
		{
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.getTop',
				getResponder(op),
				amount
			);
			
			return op;
		}
		
		public function getUsersRanked(topRank:int = 0, amount:int = 100):OpToken
		{
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.getUsersRanked',
				getResponder(op),
				topRank,
				amount
			);
			
			return op;
		}
		
		public function getUsersAmount():OpToken
		{
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.getUsersAmount',
				getResponder(op)
			);
			
			return op;
		}
		
		/*
		public function buyJumps(article:int):OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.buyJumps',
				getResponder(op),
				article
			);
			
			return op;
		}
		*/
		
		public function buySkill(id:int):OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.buySkill',
				getResponder(op),
				id
			);
			
			return op;
		}
		
		public function magicJump(x:Number, y:Number):OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.magicJump',
				getResponder(op),
				Blowfish.encrypt('And the jump number is: '+Math.random(), EnumEvents.SHOW_MAIN_MENU)
			);
			
			return op;
		}
		
		public function hitParrot(x:Number, y:Number):OpToken
		{			
			var op:OpToken = new OpToken(arguments);				
			
			amfservice.call(
				'User.hitParrot',
				getResponder(op),
				Blowfish.encrypt('And the parrot number is: '+Math.random(), EnumEvents.SHOW_MAIN_MENU)
			);
			
			return op;
		}
		
		protected function getResponder(op:OpToken):Responder
		{			
			return new Responder(
				function(data:Object):void{op.complete(data)},
				function(data:Object):void{op.fail(data)}
			);
			
		}
		
		protected function onNetStatus(e:NetStatusEvent):void
		{
			trace('onNetStatus');
			dispatchEvent(e);
		}
	}
}