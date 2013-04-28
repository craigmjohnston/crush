package  {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class BarPieceMiddle extends FlxSprite {
		[Embed(source = "../res/bar_horizontal_middle.png")] private const BAR_HORIZONTAL_MIDDLE:Class;
		[Embed(source = "../res/bar_vertical_middle.png")] private const BAR_VERTICAL_MIDDLE:Class;
		
		private const THICKNESS:uint = 12;
		private const ACTUAL_WIDTH:uint = 26;
		private const END_ACTUAL_LENGTH:uint = 10;
		private const END_LENGTH:uint = 3; // length of the white pixels in the end image of a bar piece
		
		private var long:Boolean;
		private var ends:Vector.<BarPieceEnd> = new Vector.<BarPieceEnd>();
		
		public function BarPieceMiddle(long:Boolean, length:Number, x:Number, y:Number, velocity:Number) {
			this.long = long;
			this.x = x;
			this.y = y;
			this.velocity = new FlxPoint(long ? 0 : velocity, long ? velocity : 0);
			this.loadGraphic(long ? BAR_HORIZONTAL_MIDDLE : BAR_VERTICAL_MIDDLE);
			scale = new FlxPoint(long ? length : 1, long ? 1 : length);
			color = 0x000000;
		}
		
		public function addEnd(end:BarPieceEnd):void {
			ends.push(end);
		}
		
		override public function draw():void {
			adjustPosition();
			super.draw();
			adjustPosition();
		}
		
		override public function update():void {
			adjustPosition();
			super.update();
			adjustPosition();
		}
		
		private function adjustPosition():void {
			for (var i:String in ends) {
				if (long) {
					if (ends[i].y != y) {
						ends[i].y = y;
					}
				} else {
					if (ends[i].x != x) {
						ends[i].x = x;
					}
				}
			}
		}
	}
}

/*if (long) {
				start.origin = new FlxPoint(END_ACTUAL_LENGTH - END_LENGTH, ACTUAL_WIDTH - THICKNESS);
				start.width = END_LENGTH;
				middle.origin = new FlxPoint(0, ACTUAL_WIDTH - THICKNESS);
				middle.width = length;
				end.origin = new FlxPoint(0, ACTUAL_WIDTH - THICKNESS);
				end.width = END_LENGTH;
				setAll("height", THICKNESS);
			} else {
				start.origin = new FlxPoint(ACTUAL_WIDTH - THICKNESS, END_ACTUAL_LENGTH - END_LENGTH);
				start.height = END_LENGTH;
				middle.origin = new FlxPoint(ACTUAL_WIDTH - THICKNESS, 0);
				middle.height = length;
				end.origin = new FlxPoint(ACTUAL_WIDTH - THICKNESS, 0);
				end.height = END_LENGTH;
				setAll("width", THICKNESS);
			}
			setAll("offset", new FlxPoint(long ? 0 : THICKNESS / 2, long ? THICKNESS / 2 : 0));
			setAll("color", colour);
			setAll("velocity", new FlxPoint(long ? 0 : velocity, long ? velocity : 0));
			setAll("solid", true);
			setAll("immovable", true);
			setAll("alpha", 0.7);*/
			
/*start = new FlxSprite(
				long ? x - (END_ACTUAL_LENGTH - END_LENGTH) : x - (ACTUAL_WIDTH - THICKNESS) / 2, 
				long ? y - (ACTUAL_WIDTH - THICKNESS) / 2 : y - (END_ACTUAL_LENGTH - END_LENGTH), 
				long ? BAR_HORIZONTAL_START : BAR_VERTICAL_START
			);
			middle = new FlxSprite(
				long ? x + END_LENGTH : x - (ACTUAL_WIDTH - THICKNESS) / 2, 
				long ? y - (ACTUAL_WIDTH - THICKNESS) / 2 : y + END_LENGTH, 
				long ? BAR_HORIZONTAL_MIDDLE : BAR_VERTICAL_MIDDLE
			);
			middle.scale = new FlxPoint(long ? length : 1, long ? 1 : length);
			end = new FlxSprite(
				long ? x + END_LENGTH + length : x - (ACTUAL_WIDTH - THICKNESS) / 2, 
				long ? y - (ACTUAL_WIDTH - THICKNESS) / 2 : y + END_LENGTH + length,
				long ? BAR_HORIZONTAL_END : BAR_VERTICAL_END
			);*/