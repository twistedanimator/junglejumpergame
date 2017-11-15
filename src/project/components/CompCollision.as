package project.components
{
	import flash.geom.Point;

	public class CompCollision
	{
		
		public const offset:Point = new Point;
		
		protected var initRadius:Number;
		protected var scale:Number = 1;
		
		public function get radius():Number
		{
			return initRadius*scale;
		}
		
		
		public function CompCollision(radius:Number, offsetX:Number = 0, offsetY:Number = 0)
		{
			initRadius = radius;
			offset.setTo(offsetX, offsetY);
		}
		
		public function scaleRadius(scale:Number = 1):void
		{
			this.scale = scale;
		}
			
	}
}