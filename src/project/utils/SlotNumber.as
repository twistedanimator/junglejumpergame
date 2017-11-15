package project.utils
{
	import ash.signals.Signal1;
	
	public class SlotNumber extends Signal1
	{
		
		private var _value : Number;
		private var shift : int;	
		
		public function SlotNumber(value:Number = 0)
		{
			super(Number);
			this.value = value;
		}
		
		public function get value():Number
		{
			return _value - shift;
		}
		
		public function set value(newValue:Number):void
		{
			var needDispatch:Boolean = (newValue == (_value-shift))? false : true;
			
			generateShift();
			_value = newValue + shift;
			
			if(needDispatch)
			{
				dispatch(newValue);
			}			
		}
		
		override public function add(listener:Function):void
		{			
			super.add(listener);
			listener(_value - shift);
		}
		
		private function generateShift():void
		{
			shift = 10 + int(Math.random() * 990);
		}
	}
}