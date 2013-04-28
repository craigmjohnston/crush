package {
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class BarPiece extends FlxGroup {
		private var long:Boolean;
		private var start:BarPieceEnd;
		private var middle:BarPieceMiddle;
		private var end:BarPieceEnd;
		
		public function BarPiece(state:FlxState, x:Number, y:Number, long:Boolean, length:Number, velocity:Number, colour:uint) {
			super();
			this.long = long;
			
			/*middle = new BarPieceMiddle(long, length, x, y, velocity);
			start = new BarPieceEnd(long, true, x, y, middle);
			end = new BarPieceEnd(long, false, x, y, middle);
			
			add(start);
			add(middle);
			add(end);*/
		}
		
		/*override public function update():void {
			adjustPositions();
			super.update();
			adjustPositions();
		}
		
		override public function postUpdate():void {
			adjustPositions();
			super.postUpdate();
			adjustPositions();
		}
		
		override public function preUpdate():void {
			adjustPositions();
			super.preUpdate();
			adjustPositions();
		}
		
		override public function draw():void {
			adjustPositions();
			super.draw();
			adjustPositions();
		}*/
		
		public function adjustPositions():void {			
			/*if (long) {				
				if (start.y != middle.y) {
					start.y = middle.y;
					trace("mismatch");
				}
				if (end.y != middle.y) {
					end.y = middle.y;
					trace("mismatch");
				}
			} else {				
				if (start.x != middle.x) {
					start.x = middle.x;
					trace("mismatch");
				}
				if (end.x != middle.x) {
					end.x = middle.x;
					trace("mismatch");
				}
			}
			setAll("x", middle.x);
			start.drawFrame();
			middle.drawFrame();
			end.drawFrame();
			
			start.dirty = true;
			middle.dirty = true;
			end.dirty = true;*/
		}
	}
}