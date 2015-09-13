package {

	import flash.display.*;
	import flash.events.*;

	public class ladderTile extends MovieClip {

		public var tileName: int;

		public function ladderTile(xPos, yPos, tileNum) {
			// constructor code

			this.x = xPos;
			this.y = yPos;
			this.tileName = tileNum;
			
		}

		public function getX(): Number {
			return this.x;
		}

		public function getY(): Number {
			return this.y;
		}

	}

}