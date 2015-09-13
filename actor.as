package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class actor extends MovieClip{
		
		public var movingDirectionX: int;
		public var movingDirectionY: int;
		public var tempX:int;
		public var tempY:int;
		private var nextDirection:String = "NULL";
		
		public var speed: int = 4;
		
		public var actorTimer:Timer;


		public function actor() {
			// constructor code
			
			actorTimer = new Timer(50);
			actorTimer.addEventListener(TimerEvent.TIMER, moveToDirection);
			actorTimer.start()
			tempX = this.x;
			tempY = this.y;
			//this.addEventListener(Event.ENTER_FRAME, checkMotionStop);
		}
		
		
		public function moveToDirection(e:TimerEvent):void {
			if (this.getNextDirection() != "NULL") {
				switch(this.getNextDirection()) {
					case "up":
						this.y--;
						if (checkCollisions()) {
							this.y++;
						}
						else{
							movingDirectionX = 0;
							movingDirectionY = -speed;
							this.setNextDirection("NULL");
							break;
						}
						break;
					case "left":
						this.x--;
						if (checkCollisions()) {
							this.x++;
						}
						else{
							movingDirectionX = -speed;
							movingDirectionY = 0;
							this.setNextDirection("NULL");
							break;
						}
						break;
					case "down":
						this.y++;
						if (checkCollisions()) {
							this.y--;
						}
						else{
							movingDirectionX = 0;
							movingDirectionY = speed;
							this.setNextDirection("NULL");
							break;
						}
						break;
					case "right":
						this.x++;
						if (checkCollisions()) {
							this.x--;
						}
						else{
							movingDirectionX = speed;
							movingDirectionY = 0;
							this.setNextDirection("NULL");
							break;
						}
						break;
				}
			}
			//trace(movingDirectionX, movingDirectionY)
			moveActor();
			checkMotionStop();
		}
		
		
		public function moveActor(): void {
			//trace("move player");
			if (! this.checkCollisions()) {
				if (movingDirectionX == 0) {
					moveY(movingDirectionY);
				}
				else{
					moveX(movingDirectionX);
				}
			}
			var motionTimer:Timer = new Timer(50);
			motionTimer.addEventListener(TimerEvent.TIMER, checkMotion);
			motionTimer.start();
		}
		
		public function checkMotion(e:TimerEvent) {
			if (this.movingDirectionX > 0 && this.nextDirection == "right") {
				this.setNextDirection("NULL");
			}
			if (this.movingDirectionX < 0 && this.nextDirection == "left") {
				this.setNextDirection("NULL");
			}
			if (this.movingDirectionY > 0 && this.nextDirection == "down") {
				this.setNextDirection("NULL");
			}
			if (this.movingDirectionY < 0 && this.nextDirection == "up") {
				this.setNextDirection("NULL");
			}
		}
		
		public function checkMotionStop() {
			if (tempX == this.x && tempY == this.y) {
				//trace("reset direction");
				this.setNextDirection("NULL");
			}
			tempX = this.x;
			tempY = this.y;
		}
		
		private function moveX(speedX: int): void {
			//trace("moveX")
			if (speedX > 0) {
				for (var i: int = 1; i < speedX; i++) {
					this.x++;
					if (checkCollisions() == true) {
						this.x--;
						break;
					}
				}
			} else if (speedX < 0) {
				for (var j: int = -1; j >= speedX; j--) {
					this.x--;
					if (checkCollisions() == true) {
						this.x++;
						break;
					}
				}
			}
		}

		private function moveY(speedY: int): void {
			if (speedY > 0) {
				for (var i: int = 1; i < speedY; i++) {
					this.y++;
					if (checkCollisions() == true) {
						this.y--;
						break;
					}
				}
			} else if (speedY < 0) {
				for (var j: int = -1; j >= speedY; j--) {
					this.y--;
					if (checkCollisions() == true) {
						this.y++;
						break;
					}
				}
			}
			
		}
		

		private function getNextDirection():String {
			return this.nextDirection;
		}
		
		private function setNextDirection(direction:String):void {
			this.nextDirection = direction;
			//trace(this.nextDirection);
		}
		
		public function pushDirection(direction:String) {
			if (this.getNextDirection() == "NULL" ) {
				this.setNextDirection(direction);
				//trace("push direction");
				//trace(this.nextDirection)
				
			}
		}
		
		private function checkCollisions(): Boolean {
			for each(var g: tile in main.collisionVector) {
				if (hitTestObject(g)) {
					return true;
				}
			}
			for each(var h: ladderTile in main.ladderTileVector) {
				if (h.tileName == 1) {
					if (hitTestObject(h)) {
						return true;
					}
				} else {
					if (hitTestObject(h)) {
						jumpUp();
						return false;
					}
				}
			}
			for each(var q: ladderTile in main.snakeTileVector) {
				if (q.tileName == 1) {
					if (hitTestObject(q)) {
						return true;
					}
				} else {
					if (hitTestObject(q)) {
						jumpDown();
						return false;
					}
				}
			}
			return false;
		}

		public function jumpUp() {
			for each(var ladderTop: ladderTile in main.ladderTileVector) {
				if (ladderTop.tileName == 1) {
					break
				}
			}
			var jumpX = ladderTop.getX();
			var jumpY = ladderTop.getY() - 32;

			this.x = jumpX;
			this.y = jumpY;
		}
		
		public function jumpDown() {
			for each (var snakeTail: ladderTile in main.snakeTileVector) {
				if (snakeTail.tileName == 1) {
					break;
				}
			}
			var jumpX = snakeTail.getX();
			var jumpY = snakeTail.getY() + 32;
			
			this.x = jumpX;
			this.y = jumpY;
		}
		
		
	}
	
}
