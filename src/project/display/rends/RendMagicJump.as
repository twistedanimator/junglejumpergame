package project.display.rends
{
	import flash.geom.Point;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.displayObjects.Star;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.Rotate;
	import org.flintparticles.twoD.actions.ScaleAll;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.RotateVelocity;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.zones.DiscSectorZone;
	import org.flintparticles.twoD.zones.DiscZone;
	
	public class RendMagicJump extends DisplayObjectRenderer
	{
		
		protected var emitter:Emitter2D;
		
		public function RendMagicJump()
		{
			emitter = new Emitter2D;
			emitter.counter = new Blast(25);
			emitter.addInitializer( new ImageClass(Star, [6]) );			
			
			emitter.addInitializer( new Velocity( new DiscSectorZone(new Point(0, 0), 500, 0, 0, -Math.PI) ) );
			emitter.addInitializer( new RotateVelocity(Math.PI) );
			emitter.addInitializer( new Lifetime( 0.7, 1 ) );
			
			emitter.addAction( new Age() );
			emitter.addAction( new Rotate() );
			emitter.addAction( new Accelerate(0, -200) );
			emitter.addAction( new ScaleAll(1, 0) );
			emitter.addAction( new Move );
			
			emitter.start();
			
			addEmitter(emitter);
			
			alpha = 0.7;
		}
	}
}