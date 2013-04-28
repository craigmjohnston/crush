package {
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class InstructionState extends FlxState {
		[Embed(source = "../res/key_w.png")] private const KEY_W:Class;
		[Embed(source = "../res/key_a.png")] private const KEY_A:Class;
		[Embed(source = "../res/key_s.png")] private const KEY_S:Class;
		[Embed(source = "../res/key_d.png")] private const KEY_D:Class;
		[Embed(source = "../res/key_up_arrow.png")] private const KEY_UP:Class;
		[Embed(source = "../res/key_down_arrow.png")] private const KEY_DOWN:Class;
		[Embed(source = "../res/key_left_arrow.png")] private const KEY_LEFT:Class;
		[Embed(source = "../res/key_right_arrow.png")] private const KEY_RIGHT:Class;
		
		// This would have been much nicer with a spritesheet and not 7834657836583
		// images but screw it, I'm in too deep now!
		
		private const TIME_TO_FADE:Number = 2;
		
		private var time:Number = 0;
		private var instructions:FlxSprite;
		
		private var startText:FlxText;
		
		private var orText:FlxText;
		private var lineText:FlxText;
		private var crushedText:FlxText;
		
		private var wKey:FlxSprite;
		private var aKey:FlxSprite;
		private var sKey:FlxSprite;
		private var dKey:FlxSprite;
		
		private var upKey:FlxSprite;
		private var downKey:FlxSprite;
		private var leftKey:FlxSprite;
		private var rightKey:FlxSprite;
		
		private var wPressed:Boolean = false;
		private var aPressed:Boolean = false;
		private var sPressed:Boolean = false;
		private var dPressed:Boolean = false;
		
		private var upPressed:Boolean = false;
		private var downPressed:Boolean = false;
		private var leftPressed:Boolean = false;
		private var rightPressed:Boolean = false;
		
		public function InstructionState() {
			orText = new FlxText(0, FlxG.height / 2 - 220, FlxG.width, "or");
			orText.setFormat("Nunito", 80, 0xff000000, "center");
			lineText = new FlxText(260, FlxG.height - 84, FlxG.width, "try not to get");			
			lineText.setFormat("Nunito", 60, 0xff7a7a7a, "left");
			crushedText = new FlxText(650, FlxG.height - 100, FlxG.width, "crushed");			
			crushedText.setFormat("Nunito", 80, 0xffed135d, "left");
			startText = new FlxText(0, FlxG.height / 2 + 60, FlxG.width, "P R E S S   S P A C E");			
			startText.setFormat("Nunito", 40, 0xffcccccc, "center");
			add(orText);
			add(lineText);
			add(crushedText);
			add(startText);
			
			wKey = new FlxSprite(134, 30, KEY_W);
			aKey = new FlxSprite(30, 134, KEY_A);
			sKey = new FlxSprite(134, 134, KEY_S);
			dKey = new FlxSprite(238, 134, KEY_D);
			
			upKey = new FlxSprite(724, 30, KEY_UP);
			leftKey = new FlxSprite(620, 134, KEY_LEFT);
			downKey = new FlxSprite(724, 134, KEY_DOWN);
			rightKey = new FlxSprite(828, 134, KEY_RIGHT);
			
			add(wKey);
			add(aKey);
			add(sKey);
			add(dKey);
			
			add(upKey);
			add(downKey);
			add(leftKey);
			add(rightKey);
		}
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
		}
		
		override public function update():void {
			time += FlxG.elapsed;
			wKey.alpha = time / TIME_TO_FADE;
			aKey.alpha = time / TIME_TO_FADE;
			sKey.alpha = time / TIME_TO_FADE;
			dKey.alpha = time / TIME_TO_FADE;
			upKey.alpha = time / TIME_TO_FADE;
			leftKey.alpha = time / TIME_TO_FADE;
			downKey.alpha = time / TIME_TO_FADE;
			rightKey.alpha = time / TIME_TO_FADE;
			orText.alpha = time / TIME_TO_FADE;
			lineText.alpha = time / TIME_TO_FADE;
			crushedText.alpha = time / TIME_TO_FADE;
			startText.alpha = time / TIME_TO_FADE;			
			
			if (FlxG.keys.W) {
				wKey.color = 0xed135d;
				wPressed = true;
			} else if (wPressed) {
				wPressed = false;
				wKey.color = 0xffffff;
			}
			if (FlxG.keys.A) {
				aKey.color = 0xed135d;
				aPressed = true;
			} else if (aPressed) {
				aPressed = false;
				aKey.color = 0xffffff;
			}
			if (FlxG.keys.S) {
				sKey.color = 0xed135d;
				sPressed = true;
			} else if (sPressed) {
				sPressed = false;
				sKey.color = 0xffffff;
			}
			if (FlxG.keys.D) {
				dKey.color = 0xed135d;
				dPressed = true;
			} else if (dPressed) {
				dPressed = false;
				dKey.color = 0xffffff;
			}
			if (FlxG.keys.UP) {
				upKey.color = 0xed135d;
				upPressed = true;
			} else if (upPressed) {
				upPressed = false;
				upKey.color = 0xffffff;
			}
			if (FlxG.keys.DOWN) {
				downKey.color = 0xed135d;
				downPressed = true;
			} else if (downPressed) {
				downPressed = false;
				downKey.color = 0xffffff;
			}
			if (FlxG.keys.LEFT) {
				leftKey.color = 0xed135d;
				leftPressed = true;
			} else if (leftPressed) {
				leftPressed = false;
				leftKey.color = 0xffffff;
			}
			if (FlxG.keys.RIGHT) {
				rightKey.color = 0xed135d;
				rightPressed = true;
			} else if (rightPressed) {
				rightPressed = false;
				rightKey.color = 0xffffff;
			}
			if (FlxG.keys.SPACE || FlxG.mouse.pressed() || FlxG.keys.ENTER) {
				FlxG.music.fadeOut(2);
				FlxG.fade(0xffffffff, 2, startGame);
			}
			super.update();
		}
		
		private function startGame():void {
			FlxG.switchState(new PlayState());
		}
	}
}