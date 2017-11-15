package project.components
{
	public class CompSizeBonus
	{
		
		public static const DURATION:int = 10;
		public static const times:Array = [0, 1, 9, DURATION];
		
		protected var _time:Number = 0;
		protected var _phase:int = 0;
		protected var _phaseTime:Number = 0;	
		protected var _phaseDuration:Number = 0;
		
		
		public function set time(value:Number)
		{
			if(value>DURATION)
			{
				value = DURATION;
			}
			
			if(_time == value)
			{
				return;
			}
			
			_time = value;
			
			for(var i:int = 1, l:int = times.length; i<l; i++)
			{
				if(time<=times[i])
				{
					_phase = i-1;
					break;
				}
			}
			
			_phaseTime = time - times[phase];
			
			_phaseDuration = times[phase+1] - times[phase];
		}
		
		public function get time():Number
		{
			return _time;
		}
		
		public function get phase():int
		{
			return _phase;
		}
		
		public function get phaseTime():Number
		{
			return _phaseTime;
		}
		
		public function get phaseDuration():Number
		{
			return _phaseDuration;
		}
		
		public function CompSizeBonus()
		{
		}
		
		public function reset():void
		{
			if(_phase == 1)
			{
				time = times[1];
			}
			else if(_phase == 2)
			{
				time = times[1]*(1 - _phaseTime/(times[3] - times[2]));
			}
		}
	}
}