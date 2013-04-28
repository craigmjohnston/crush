package {
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class Vector2D {
		public var a:Number;
		public var b:Number;
		
		public function Vector2D(a:Number, b:Number) {
			this.a = a;
			this.b = b;
		}
		
		public function toString():String {
			return "[" + this.a + ", " + this.b + "]";
		}
	}
}