package  {	
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class Bar {
		public var pieces:FlxGroup;
		
		public function Bar(state:FlxState, x:Number, y:Number, long:Boolean, velocity:Number, pieces:Vector.<Vector2D>, colour:uint) {
			this.pieces = new FlxGroup();
			for (var i:String in pieces) {
				var start:Number = pieces[i].a;
				var length:Number = pieces[i].b;
				trace("!! (start: " + start + ", length: " + length + ") !!");
				var piece:BarPiece = new BarPiece(this.pieces, state, x + (long ? start : 0), y + (!long ? start : 0), long, length, velocity, colour);
				state.add(piece);
				this.pieces.add(piece);
			}
			trace("\n" + "----------------------------------------------" + "\n");
			//trace(long ? "horizontal" : "vertical");
			//trace(pieces);
		}
		
		public function update():void {
			pieces.update();
		}
	}
}