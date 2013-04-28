package {	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import org.flixel.FlxObject;
	import org.flixel.FlxU;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Craig Johnston
	 */
	public class PlayState extends FlxState {
		[Embed(source = "../res/part_1_1.mp3")] private const MUSIC_1_1:Class;
		[Embed(source = "../res/part_1_2.mp3")] private const MUSIC_1_2:Class;
		[Embed(source = "../res/part_1_3.mp3")] private const MUSIC_1_3:Class;
		[Embed(source = "../res/part_1_4.mp3")] private const MUSIC_1_4:Class;
		[Embed(source="../res/part_2_1.mp3")] private const MUSIC_2_1:Class;
		
		private const SFX_VOLUME:Number = 0.2;
		
		private const MIN_SPEED:Number = 40;
		private const MAX_SPEED:Number = 100;
		
		private const MAX_BREAKS:uint = 3;
		private const MIN_GAP:Number = 120;
		private const MAX_GAP:Number = 280;
		private const MIN_LENGTH:Number = 100;
		
		private const FADEOUT_TIME:Number = 3.5;
		private const TIME_TO_FADE:Number = 2;
		private const TIME_TO_START:Number = 3;
		
		private const END_TIME:Number = 180;
		
		private var fading:Boolean = true;
		private var started:Boolean = false;
		
		private var player:Player;
		private var bars:Vector.<Bar> = new Vector.<Bar>();
		private var barPieces:FlxGroup = new FlxGroup();
		private var barTimer:FlxTimer = new FlxTimer();
		private var time:Number = 0;
		
		private var boundaries:FlxGroup = new FlxGroup();
		private var stopMoving:Boolean = false;
		
		private var backgroundFading:Boolean = false;
		private var fadeLength:Number;
		private var fadeTimer:Number;
		private var fakeBackground:FlxSprite;
		private var step:Number;
		private var targetColour:uint;
		
		private var wasCollided:Boolean = false;
		
		private var firstBarThisTick:Boolean = true;
		private var lastWasVertical:Boolean = false;
		private var lastWasForward:Boolean = false;		
		
		private var musicTracks:Array = [
			MUSIC_1_1, 
			MUSIC_1_2, 
			MUSIC_1_3, 
			MUSIC_1_4, 
			MUSIC_2_1
		];
		private var trackVolumes:Array = [
			0.4,
			0.4,
			0.4,
			0.4,
			0.5
		];
		private var tracker:Array = [
			[1, 1, 0, 0, 0, 0, 0],
			[0, 0, 1, 1, 0, 0, 0],
			[0, 0, 0, 0, 1, 0, 0],
			[0, 0, 0, 0, 0, 1, 1],
			[0, 1, 0, 0, 0, 0, 1],
		];
		private var fidelity:uint = 32;
		private var tick:Number = -1;
		
		private var backgrounds:Array = [
			0xFFFFFFFF,
			0xFFE0E4CC,
			0xFF542437,
			0xFFF9CDAD,
			0xFF556270,
			0xFFF4EAD5
		];
		
		private var playerColours:Array = [
			0x000000,
			0xFFFFFF,
			0xFFFFFF,
			0x000000,
			0xFFFFFF,
			0x000000
		];
		
		private var colours:Array = [
			[0x000000],
			[0x69D2E7, 0xA7DBD8, 0xF38630, 0xFA6900],
			[0xECD078, 0xD95B43, 0xC02942, 0x53777A],
			[0xFE4365, 0xFC9D9A, 0xC8C8A9, 0x83AF9B],
			[0x4ECDC4, 0xC7F464, 0xFF6B6B, 0xC44D58],
			[0xE94E77, 0xD68189, 0xC6A49A, 0xC6E5D9]
		];
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			//FlxG.visualDebug = true;
			
			fakeBackground = new FlxSprite(0, 0);
			fakeBackground.alpha = 0;
			add(fakeBackground);
			
			var topBoundary:FlxSprite = new FlxSprite(-1, -100);
			topBoundary.width = FlxG.width;
			topBoundary.height = 100;
			var bottomBoundary:FlxSprite = new FlxSprite(-100, FlxG.height);
			bottomBoundary.width = FlxG.width;
			bottomBoundary.height = 100;
			var leftBoundary:FlxSprite = new FlxSprite(-100, -1);
			leftBoundary.width = 100;
			leftBoundary.height = FlxG.height;
			var rightBoundary:FlxSprite = new FlxSprite(FlxG.width, -1);
			rightBoundary.width = 100;
			rightBoundary.height = FlxG.height;
			boundaries.add(topBoundary);
			boundaries.add(bottomBoundary);
			boundaries.add(leftBoundary);
			boundaries.add(rightBoundary);
			boundaries.setAll("solid", true);
			boundaries.setAll("immovable", true);
			add(boundaries);
			
			player = new Player(FlxG.width / 2, FlxG.height / 2);
			add(player);
		}

		override public function update():void {			
			super.update();			
			if (!started) {
				if (fading) {
					player.alpha = time / TIME_TO_FADE;
					if (time >= TIME_TO_FADE) {
						fading = false;
					}
				} else {
					if (time >= TIME_TO_START) {
						started = true;
						startGame();
					}
				}
			}
			if (!stopMoving) {
				time += FlxG.elapsed;
				var collided:Boolean = FlxG.collide(barPieces, player) || FlxG.collide(boundaries, player);
				if ((player.isTouching(FlxObject.LEFT) && player.isTouching(FlxObject.RIGHT)) || (player.isTouching(FlxObject.UP) && player.isTouching(FlxObject.DOWN))) {
					lose();
				} else if (FlxG.overlap(player, barPieces) && FlxG.overlap(player, boundaries)) {
					lose();
				}
				if (backgroundFading) {
					doFadeBackground();
				}
				if (time + 1 >= END_TIME && barPieces.countLiving() == 0) {
					win();
				}
			} else {
				player.x = player.last.x;
				player.y = player.last.y;
			}
		}
		
		private function startGame() {
			time = 0;
			addBar(barTimer);
		}
		
		private function fadeBackground(to:uint, length:Number):void {
			targetColour = to;
			backgroundFading = true;
			step = 1.0 / length;
			fadeLength = length;
			fadeTimer = 0;			
			fakeBackground.makeGraphic(FlxG.width, FlxG.height, to);
			fakeBackground.alpha = 0;
		}
		
		private function doFadeBackground():void {
			fadeTimer += FlxG.elapsed;
			fakeBackground.alpha += step * FlxG.elapsed;
			if (fadeTimer >= fadeLength) {
				FlxG.bgColor = targetColour;
				backgroundFading = false;
				fakeBackground.alpha = 0;
			}
		}
		
		private function fadeSounds():void {
			for (var i:String in FlxG.sounds.members) {
				(FlxG.sounds.members[i] as FlxSound).fadeOut(FADEOUT_TIME);
			}
		}
		
		private function win():void {
			barPieces.setAll("velocity", new FlxPoint(0, 0));
			player.velocity = new FlxPoint(0, 0);
			player.stop();
			stopMoving = true;
			fadeSounds();
			FlxG.fade(0xffffffff, FADEOUT_TIME, onWin);
		}
		
		private function lose():void {
			barPieces.setAll("velocity", new FlxPoint(0, 0));
			player.velocity = new FlxPoint(0, 0);
			player.stop();
			stopMoving = true;
			FlxG.fade(0xffffffff, FADEOUT_TIME, onLose);
		}
		
		private function onWin():void {
			FlxG.switchState(new EndState(true));
		}
		
		private function onLose():void {
			FlxG.switchState(new EndState(false));
		}
		
		private function addBar(timer:FlxTimer):void {
			if (!stopMoving && time + 1 < END_TIME) {
				firstBarThisTick = true;
				var quantity:uint = 1;
				var timeout:uint = 8;
				var colourset:uint = Math.round((time+1) / 64);
				if (time + 1 >= fidelity * (tick + 1)) {
					tick += 1;
					for (var l:uint = 0; l < tracker.length; l++) {
						if (tracker[l][tick] == 1) {
							FlxG.play(musicTracks[l], trackVolumes[l]);
						}
					}
				}
				if (FlxG.bgColor != backgrounds[colourset] && !backgroundFading) {
					fadeBackground(backgrounds[colourset], 2);
					player.color = playerColours[colourset];
				}
				if (time+1 >= 32) {
					quantity = 2;
				}
				if (time+1 > 128) {
					timeout = 4;
				}
				for (var i:uint = 0; i < quantity; i++) {
					var colour:uint = (colours[colourset] as Array)[Math.round(Math.random() * (colours[colourset] as Array).length)] as uint;
					var bar:Bar = generateBar(true, true, colour);
					bars.push(bar);
					barPieces.add(bar.pieces);
				}
				timer.start(timeout, 1, addBar);
			}
		}
		
		private function generateBar(canBeVertical:Boolean, canBeHorizontal:Boolean, colour:uint):Bar {
			// decide if the bar is going to be vertical or not
			var isVertical:Boolean = false;			
			if (canBeVertical && canBeHorizontal) {
				isVertical = (Math.random() > .5) ? true : false;
			} else {
				isVertical = canBeVertical;
			}
			
			var lengths:Vector.<Number> = new Vector.<Number>();
			var breaks:Vector.<Vector2D> = new Vector.<Vector2D>();
			var pieces:Vector.<Vector2D> = new Vector.<Vector2D>();
			
			var forward:Boolean = (Math.random() > .5) ? true : false; // is the bar moving forward or backward?
			
			if (!firstBarThisTick) {
				if (forward == lastWasForward && isVertical == lastWasVertical) {
					forward = !forward;
				}
			} else {
				firstBarThisTick = false;
				lastWasForward = forward;
				lastWasVertical = isVertical;
			}
			
			var barWidth:Number = isVertical ? FlxG.height : FlxG.width; // the total available width for the bar
			var speed:Number = MIN_SPEED + (Math.random() * (MAX_SPEED - MIN_SPEED));
			var numberOfBreaks:Number = 1 + Math.round(Math.random() * (Math.floor(barWidth / (MIN_GAP + MIN_LENGTH)) - 1)); // number of breaks in the bar			
			numberOfBreaks = numberOfBreaks > MAX_BREAKS ? MAX_BREAKS : numberOfBreaks;
			var lastPosition:Number = 0;			
			var cumulativeLength:Number = 0;
			
			trace("maxGap: " + maxGap);
			
			// calculate the lengths of the breaks
			for (var i:uint = 0; i < numberOfBreaks; i++) {
				var maxGap:Number = Math.floor((barWidth - (MIN_GAP*(numberOfBreaks-(i+1))) - cumulativeLength - ((numberOfBreaks + 1) * MIN_LENGTH)));
				maxGap = maxGap > MAX_GAP ? MAX_GAP : maxGap;
				lengths.push(MIN_GAP + Math.round(Math.random() * (maxGap - MIN_GAP)));
				cumulativeLength += lengths[i];
			}
			trace("Lengths: " + lengths);
			
			// calculate the positions of the breaks
			for (i = 0; i < numberOfBreaks; i++) {
				trace("barWidth: " + barWidth + ", lastPosition: " + lastPosition + ", cumulativeLength: " + cumulativeLength + ", numberOfBreaks: " + numberOfBreaks);
				var max:Number = (barWidth - lastPosition) - (cumulativeLength + (MIN_LENGTH * (numberOfBreaks + 1 - i)));
				trace("max: " + max);
				var start:Number = MIN_LENGTH + Math.round(Math.random() * max);
				breaks.push(new Vector2D(lastPosition + start, lengths[i]));
				lastPosition += start + lengths[i];
				cumulativeLength -= lengths[i];
			}
			trace("Breaks: " + breaks);
			
			lastPosition = 0;
			
			// create bar pieces based on the gaps
			for (i = 0; i < numberOfBreaks; i++) {
				pieces.push(new Vector2D(lastPosition, breaks[i].a - lastPosition));
				lastPosition = breaks[i].a + breaks[i].b;
			}
			pieces.push(new Vector2D(lastPosition, barWidth - lastPosition));
			trace("Pieces: " + pieces + "\n");
			
			// create the bar
			if (isVertical) {
				return new Bar(this, forward ? -12 : FlxG.width, 0, false, forward ? speed : -speed, pieces, colour);
				//return new Bar(this, forward ? 0 + 200 : FlxG.width - 200, 0, false, forward ? speed - speed: -speed + speed, pieces, colour);
			} else {
				return new Bar(this, 0, forward ? -12 : FlxG.height, true, forward ? speed : -speed, pieces, colour);
				//return new Bar(this, 0, forward ? 0 + 200 : FlxG.height - 200, true, forward ? speed - speed : -speed + speed, pieces, colour);
			}
		}
	}
}