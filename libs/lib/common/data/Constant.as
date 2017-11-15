package lib.common.data
{
	public class Constant
	{
		
		protected var _value:*;
		public function get value():*
		{
			return _value;
		}
		
		public function Constant(value:*)
		{
			_value;
		}
		
		public function toString():String
		{
			return String(_value);
		}
	}
}