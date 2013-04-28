package  {
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class BarPieceEnd extends FlxSprite {
		[Embed(source = "../res/bar_horizontal_start.png")] private const BAR_HORIZONTAL_START:Class; 		// left
		[Embed(source = "../res/bar_vertical_start.png")] private const BAR_VERTICAL_START:Class; 			// top
		[Embed(source = "../res/bar_horizontal_end.png")] private const BAR_HORIZONTAL_END:Class; 			// right
		[Embed(source = "../res/bar_vertical_end.png")] private const BAR_VERTICAL_END:Class; 				// bottom
		
		private const THICKNESS:uint = 12;
		private const ACTUAL_WIDTH:uint = 26;
		private const END_ACTUAL_LENGTH:uint = 10;
		private const END_LENGTH:uint = 3; // length of the white pixels in the end image of a bar piece
		
		private var long:Boolean;
		private var start:Boolean;
		private var middle:BarPieceMiddle;
		
		public function BarPieceEnd(long:Boolean, start:Boolean, x:Number, y:Number, middle:BarPieceMiddle) {
			this.long = long;
			this.start = start;
			this.x = x;
			this.y = y;
			this.middle = middle;
			middle.addEnd(this);
			color = 0x000000;
			
			if (start) {
				this.loadGraphic(long ? BAR_HORIZONTAL_START : BAR_VERTICAL_START);
			} else {
				this.loadGraphic(long ? BAR_HORIZONTAL_END : BAR_VERTICAL_END);
			}
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
			if (long && y != middle.y) {
				y = middle.y;
			} else if (!long && x != middle.x) {
				x = middle.x;
			}
		}
	}
}