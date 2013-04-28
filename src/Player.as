package {
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class Player extends FlxSprite {
		[Embed(source = "../res/circle_white.png")] private const CIRCLE_WHITE:Class;
		
		private var stopMoving:Boolean = false;
		
		//TODO: sort out the ugly circle
		
		public function Player(x:Number, y:Number) {
			super(x, y);
			loadGraphic(CIRCLE_WHITE);
			color = 0xff000000;
			width = 86;
			height = 86;
			centerOffsets(true);
			maxVelocity = new FlxPoint(200, 200);
			drag = new FlxPoint(50, 50);
			solid = true;
			elasticity = 1.4;
			alpha = 0.8;
		}
		
		override public function update():void {
			if (!stopMoving) {
				acceleration.x = 0;
				acceleration.y = 0;
				if (FlxG.keys.LEFT || FlxG.keys.A) {
					acceleration.x = -maxVelocity.x * 4;
				} else if (FlxG.keys.RIGHT || FlxG.keys.D) {
					acceleration.x = maxVelocity.x * 4;
				}
				if (FlxG.keys.UP || FlxG.keys.W) {
					acceleration.y = -maxVelocity.y * 4;
				} else if (FlxG.keys.DOWN || FlxG.keys.S) {
					acceleration.y = maxVelocity.y * 4;
				}
			}
			super.update();
		}
		
		public function stop():void {
			stopMoving = true;
		}
	}
}