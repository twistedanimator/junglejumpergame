package project
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import sounds.Ambient;
	import sounds.Explode;
	import sounds.Hit;
	import sounds.Magic;
	import sounds.Size;
	import sounds.Wind;

	public class SoundManager
	{
		
		public var explode:Sound = new Explode;
		
		public var wind:Sound = new Wind;
		
		public var magic:Sound = new Magic;
		
		public var hit:Sound = new Hit;
		
		public var size:Sound = new Size;
		
		protected var ambient:Sound = new Ambient;
		protected var ambientChannel:SoundChannel;
		
		protected var sounds:Array = [explode, explode, hit, wind, magic, size, wind];
		protected var volumes:Array = [0.3, 0.015, 1, 1, 0.1, 0.5, 0.5];
		
		protected var _status:uint = 1;
		
		public function get enabled():Boolean
		{
			return _status == 1;
		}
		
		public function SoundManager()
		{
			ambientChannel = ambient.play(0, 999999);
		}
		
		public function play(id:int, pan:Number = 0.5):void
		{
			if(_status == 1)
			{
				var sound:Sound  = sounds[id];
				
				sound.play(0, 0, new SoundTransform(volumes[id], -1 + 2*pan));
			}
			
		}
		
		public function toggle():void
		{
			if(_status == 0)
			{
				ambientChannel = ambient.play(0, 999999);
				_status = 1;
			}
			else
			{				
				SoundMixer.stopAll();	
				_status = 0;
			}
		}

	}
}