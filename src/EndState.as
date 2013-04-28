package {
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class EndState extends FlxState {
		[Embed(source = "../res/Pacifico.ttf", fontFamily = "Pacifico", embedAsCFF = "false")] private const FONT:Class;
		[Embed(source = "../res/Nunito-Regular.ttf", fontFamily = "Nunito", embedAsCFF = "false")] private const FONT2:Class;
		
		private const TIME_TO_FADE:Number = 1;
		
		private var won:Boolean;		
		private var flavourText:FlxText;
		private var tryAgainText:FlxText;	
		private var startText:FlxText;
		private var time:Number = 0;
		
		public function EndState(won:Boolean=false) {
			this.won = won;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			flavourText = new FlxText(0, FlxG.height / 2 - 150, FlxG.width, won ? "Well done." : "Oh well.");
			tryAgainText = new FlxText(0, FlxG.height / 2 + 160, FlxG.width, won ? "Ready for more?" : "Try again?");
			startText = new FlxText(0, FlxG.height / 2 + 60, FlxG.width, "P R E S S   S P A C E");			
			startText.setFormat("Nunito", 40, 0xffcccccc, "center");
			flavourText.setFormat("Pacifico", 100, 0xff000000, "center");
			tryAgainText.setFormat("Nunito", 40, 0xff000000, "center");
			add(flavourText);
			add(tryAgainText);
			add(startText);
		}
		
		override public function update():void {
			time += FlxG.elapsed;
			flavourText.alpha = time / TIME_TO_FADE;
			tryAgainText.alpha = time / TIME_TO_FADE;
			startText.alpha = time / TIME_TO_FADE;
			if (FlxG.keys.SPACE || FlxG.mouse.pressed() || FlxG.keys.ENTER) {
				FlxG.fade(0xffffffff, 2, startGame);
			}
			super.update();
		}
		
		private function startGame():void {
			FlxG.switchState(new PlayState());
		}
	}
}