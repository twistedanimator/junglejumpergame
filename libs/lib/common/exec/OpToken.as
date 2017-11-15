package lib.common.exec
{	
	import lib.common.data.Constant;

	public class OpToken
	{
		public static const PENDING:* = new Constant('PENDING');
		public static const COMPLETE:* = new Constant('COMPLETE');
		public static const FAILED:* = new Constant('FAILED');
		public static const CANCELLED:* = new Constant('CANCELLED');
		
		protected var resultHandlers:Vector.<Function>;
		protected var faultHandlers:Vector.<Function>;	
		protected var cancelHandler:Function;
		
		protected var _status:* = PENDING;
		public function get status():*
		{
			return _status;
		}
		
		protected var _result:*;
		public function get result():*
		{
			return _result;
		}
		
		protected var _fault:*;
		public function get fault():*
		{
			return _fault;
		}
		
		protected var parentToken:OpToken;
		public function get parent():OpToken
		{
			return parentToken;
		}
		public function setParent(op:OpToken):OpToken
		{
			parentToken = op;
			return this;
		}
		
		public var arguments:Object;
		
		public function OpToken(arguments:Array = null, cancelHandler:Function = null)
		{
			this.arguments = arguments; 
			this.cancelHandler = cancelHandler;
		}
		
		public function addHandlers(result:Function, fault:Function):OpToken
		{
			addResultHandler(result);
			addFaultHandler(fault);
			return this;
		}
		
		public function addResultHandler(handler:Function):OpToken
		{
			if (status == COMPLETE)
			{
				handler(this);
			}
			else if (status == PENDING)
			{
				if(!resultHandlers)
				{
					resultHandlers = new Vector.<Function>;
					resultHandlers[0] = handler;
				}
				else if( resultHandlers.indexOf(handler) == -1 )
				{
					resultHandlers[resultHandlers.length] = handler;
				}
			}
			return this;
		}
		
		public function addFaultHandler(handler:Function):OpToken
		{
			if (status == FAILED || status == CANCELLED)
			{
				handler(this);
			}
			else if (status == PENDING)
			{
				if(!faultHandlers)
				{
					faultHandlers = new Vector.<Function>;
					faultHandlers[0] = handler;
				}
				else if( faultHandlers.indexOf(handler) == -1 )
				{
					faultHandlers[faultHandlers.length] = handler;
				}
				
			}
			return this;
		}
		
		public function complete(obj:Object = null):void
		{
			_status = COMPLETE;
			_result = obj;
			if(resultHandlers)
			{
				for each(var handler:Function in resultHandlers)
				{
					handler(this);
				}
			}
						
			disposeHandlers();
		}
		
		public function fail(obj:Object):void
		{
			_status = FAILED;
			_fault = obj;
			if(faultHandlers)
			{
				for each(var handler:Function in faultHandlers)
				{
					handler(this);
				}
			}
			
			disposeHandlers();
		}
		
		public function cancel():void
		{
			_status = CANCELLED;
			if(cancelHandler != null)
			{
				cancelHandler(this);
			}
			
			if(faultHandlers)
			{
				for each(var handler:Function in faultHandlers)
				{
					handler(this);
				}
			}
			
			disposeHandlers();
		}
		
		protected function disposeHandlers():void
		{
			resultHandlers = null;
			faultHandlers = null;
		}
	}
}