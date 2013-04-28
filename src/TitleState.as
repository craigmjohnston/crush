package {
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class TitleState extends FlxState {
		[Embed(source = "../res/Pacifico.ttf", fontFamily = "Pacifico", embedAsCFF = "false")] private const FONT:Class;
		[Embed(source = "../res/Nunito-Regular.ttf", fontFamily = "Nunito", embedAsCFF = "false")] private const FONT2:Class;
		
		[Embed(source="../res/part_2_1.mp3")] private const MUSIC:Class;
		
		private const TIME_TO_FADE:Number = 2;
		
		private var won:Boolean;		
		private var titleText:FlxText;
		private var descriptionText:FlxText;
		private var startText:FlxText;
		private var time:Number = 0;
		
		public function TitleState(won:Boolean=false) {
			this.won = won;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			FlxG.playMusic(MUSIC);
			titleText = new FlxText(0, FlxG.height / 2 - 120, FlxG.width, "crush.");
			titleText.setFormat("Pacifico", 100, 0xff000000, "center");
			startText = new FlxText(0, FlxG.height / 2 + 60, FlxG.width, "P R E S S   S P A C E");			
			startText.setFormat("Nunito", 40, 0xffcccccc, "center");
			descriptionText = new FlxText(0, FlxG.height / 2 + 240, FlxG.width, "by Craig Johnston (@oatsbarley) for Ludum Dare 26");			
			descriptionText.setFormat("Nunito", 24, 0xffcccccc, "center");
			add(titleText);
			add(startText);
			add(descriptionText);
		}
		
		override public function update():void {
			time += FlxG.elapsed;
			titleText.alpha = time / TIME_TO_FADE;
			startText.alpha = time / TIME_TO_FADE;
			descriptionText.alpha = time / TIME_TO_FADE;
			if (FlxG.keys.SPACE || FlxG.mouse.pressed() || FlxG.keys.ENTER) {
				FlxG.fade(0xffffffff, 2, startGame);
			}
			super.update();
		}
		
		private function startGame():void {
			FlxG.switchState(new InstructionState());
		}
	}
}