package {

	import flash.display.MovieClip;
	import flash.events.*;


	public class main extends MovieClip {
		
		public var PACMAN:player;

		public static var collisionVector: Vector.<tile> = new Vector.<tile> ();
		public static var ladderTileVector: Vector.<ladderTile> = new Vector.<ladderTile> ();
		public static var snakeTileVector:Vector.<ladderTile> = new Vector.<ladderTile>();
		public var ghostVector: Vector .<ghost> = new Vector.<ghost>();
		//public var PacMan:player;
		
		public var directionPointer: pointer;
		
		public var voiceLevel: MovieClip;
		
		public var arduinoConnection: MovieClip;

		public function main() {
			// constructor code

			createPointer();
			
			setupPlayer();

			createLadder();
			createSnake();

			setupGhost();
			

			
			//voiceLevel = new voiceDetector (this) as MovieClip;
			arduinoConnection = new arduino();
			stage.addChild(arduinoConnection);
			
			
			
			
			//stage.addEventListener(MouseEvent.CLICK, tracePoint);

		}
		
		//public function tracePoint(e:MouseEvent) {
			//trace(mouseX, mouseY);
		//}

		
		public function setupPlayer() {
			PACMAN = new player(this, directionPointer);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, PACMAN.changeDirection);
			
			stage.addChild(PACMAN);
			
		}

		public function createLadder(): void {
			var tileWidth: int = 32;
			var tileNum: int = 1;

			for (var i = 0; i < 2; i++) {
				var yPos = 5 * tileWidth + i * 8 * tileWidth;
				var xPos = 10 * tileWidth - i * 6 * tileWidth;
				var aTile: ladderTile = new ladderTile(xPos, yPos, tileNum);
				aTile.gotoAndStop(1);
				stage.addChild(aTile);
				ladderTileVector.push(aTile);
				tileNum++;
			}
		}
		
		public function createSnake(): void {
			var tileWidth: int = 32;
			var tileNum: int = 1;

			for (var i = 0; i < 2; i++) {
				var yPos = 15 * tileWidth - i * 13 * tileWidth;
				var xPos = 22 * tileWidth - i * 4* tileWidth;
				var aTile: ladderTile = new ladderTile(xPos, yPos, tileNum);
				aTile.gotoAndStop(2);
				stage.addChild(aTile);
				snakeTileVector.push(aTile);
				tileNum++;
			}
		}

		public function setupGhost(): void {
			var blink: ghost = new ghost(256, 512, "Blink", PACMAN);
			this.ghostVector.push(blink)
			var pink: ghost = new ghost(288, 544, "pink", PACMAN);
			this.ghostVector.push(pink)
			stage.addChild(blink);
			stage.addChild(pink);
			//pink.distWithPlayer();
		}
		
		public function createPointer(): void {
			directionPointer = new pointer(960, 320);
			directionPointer.gotoAndStop(1);
			stage.addChild(directionPointer);
		}
	}
}