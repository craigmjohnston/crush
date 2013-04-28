package {
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class BarPiece extends FlxSprite {
		[Embed(source = "../res/bar_horizontal_middle.png")] private const BAR_HORIZONTAL_MIDDLE:Class;
		[Embed(source = "../res/bar_vertical_middle.png")] private const BAR_VERTICAL_MIDDLE:Class;
		
		private const THICKNESS:uint = 12;
		private const IMAGE_WIDTH:uint = 36;
		
		private var long:Boolean;
		private var forward:Boolean;
		private var group:FlxGroup;
		
		public function BarPiece(group:FlxGroup, state:FlxState, x:Number, y:Number, long:Boolean, length:Number, velocity:Number, colour:uint) {
			super();
			this.x = x;
			this.y = y;
			this.long = long;
			this.loadGraphic(long ? BAR_HORIZONTAL_MIDDLE : BAR_VERTICAL_MIDDLE);
			forward = velocity > 0;
			scale = new FlxPoint(long ? length : 1, long ? 1 : length);
			color = colour;
			solid = true;
			immovable = true;
			width = long ? length : THICKNESS;
			height = long ? THICKNESS : length;
			origin = new FlxPoint(0, 0);
			offset = new FlxPoint(long ? 0 : THICKNESS / 2, long ? THICKNESS / 2 : 0);
			alpha = 0.8;
			this.velocity = new FlxPoint(long ? 0 : velocity, long ? velocity : 0);
			this.group = group;
		}
		
		override public function update():void {
			super.update();
			if (long) {
				if (forward) {
					if (y > FlxG.height) {
						this.kill();
					}
				} else {
					if (y < -THICKNESS) {
						this.kill();
					}
				}
			} else {
				if (forward) {
					if (x > FlxG.width) {
						this.kill();
					}
				} else {
					if (x < -THICKNESS) {
						this.kill();
					}
				}
			}
			if (!this.alive && this.group.alive) {
				this.group.kill();
			}
		}
	}
}