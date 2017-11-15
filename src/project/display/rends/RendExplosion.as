package project.display.rends
{
	import flash.geom.Point;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.displayObjects.RadialDot;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.ScaleAll;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.zones.DiscZone;
	
	public class RendExplosion extends DisplayObjectRenderer
	{
		protected var emitter:Emitter2D;
		
		public function RendExplosion(additional:int = 0)
		{
		
			emitter = new Emitter2D;
			emitter.counter = new Blast(10+additional);
			emitter.addInitializer( new ImageClass(RadialDot, [9]) );			
			emitter.addInitializer( new Velocity( new DiscZone(new Point(0, -50), 150+additional*10, 100) ) );			
			emitter.addInitializer( new Lifetime( 0.5, 1+additional/10 ) );
			
			emitter.addAction( new Age() );
			emitter.addAction( new Accelerate(0, 200+additional*30) );
			emitter.addAction( new ScaleAll(1+additional/100, 0) );
			emitter.addAction( new Move );
			
			emitter.start();
			
			addEmitter(emitter);
		}
	}
}