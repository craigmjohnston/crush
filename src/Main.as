package {	
	import org.flixel.FlxGame;
	
	[SWF(width="960", height="600", backgroundColor="0x000000")]
	[Frame(factoryClass="Preloader")]
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class Main extends FlxGame {
		public function Main():void {
			super(960, 600, EndState, 1, 60, 60);
		}
	}
}