package {

	import flash.display.*;
	import flash.events.*;
	import flash.net.drm.VoucherAccessInfo;
	import flash.utils.Timer;


	public class player extends actor {
		
		public var documentClass;
		public var playerTimer:Timer = new Timer(50);
		public var pointerTimer:Timer = new Timer(5000);
		public var directionOrientation: int = 1;
		public var directionPointer;

		public function player(docClass, pointer) {
			// constructor code
			trace("player");
			
			this.initPlayer()
			this.documentClass = docClass;
			this.directionPointer = pointer

			//this.setupPlayerDirection();

			
			this.playerTimer.addEventListener(TimerEvent.TIMER,checkHitGhost);
			this.playerTimer.start();
			
			this.pointerTimer.addEventListener(TimerEvent.TIMER, changeDirectionOrientation);
			this.pointerTimer.start();
		}
		
		public function initPlayer() {
			this.x = 32*10;
			this.y = 32*10;
			this.setupPlayerDirection();
		}

		public function setupPlayerDirection() {
			//this.x = startX;
			//this.y = startY;
			trace("start")
			movingDirectionX = speed;
			movingDirectionY = 0;
		}
		
		public function changeDirectionOrientation(e:TimerEvent) {
			directionOrientation = Math.ceil(Math.random()*4);
			switch (directionOrientation) {
				case 1:
					this.directionPointer.gotoAndStop(1);
					break;
				case 2:
					this.directionPointer.gotoAndStop(2);
					break;
				case 3:
					this.directionPointer.gotoAndStop(3);
				    break;
				case 4:
					this.directionPointer.gotoAndStop(4);
					break;
			}
		}
		
		public function changeDirection(e: KeyboardEvent): void {

			//trace("mover");
			switch (e.keyCode) {
				case 38: //up
					switch (directionOrientation) {
						case 1:
							trace("1-up"); 
							pushDirection("up");
							break;
						case 2:
							trace("2-left");
							pushDirection("left");
							break;
						case 3:
							trace("3-down");				
							pushDirection("down");
							break;
						case 4:
							trace("4-up-right");
							pushDirection("right");
							break;
					}
					
					break;
					//moveY(-speed);
				case 37: //left
					
					switch (directionOrientation) {
						case 1:
							trace("1-left-left"); 
							pushDirection("left");
							break;
						case 2:
							trace("2-left-down");
							pushDirection("down");
							break;
						case 3:
							trace("3-left-right");				
							pushDirection("right");
							break;
						case 4:
							trace("4-left-up");
							pushDirection("up");
							break;
					}
					//moveX(-speed);
					break;
				case 40: //down
					switch (directionOrientation) {
						case 1:
							trace("1-down-down"); 
							pushDirection("down");
							break;
						case 2:
							trace("2-down-right");
							pushDirection("right");
							break;
						case 3:
							trace("3-down-up");				
							pushDirection("up");
							break;
						case 4:
							trace("4-down-left");
							pushDirection("left");
							break;
					}
					//moveY(speed);
					break;
				case 39: //right
					switch (directionOrientation) {
						case 1:
							trace("1-right-right"); 
							pushDirection("right");
							break;
						case 2:
							trace("2-right-up");
							pushDirection("up");
							break;
						case 3:
							trace("3-right-left");				
							pushDirection("left");
							break;
						case 4:
							trace("4-right-down");
							pushDirection("down");
							break;
					}
					//moveX(speed);
					break;
				default:
					trace("invalid key");
					break;
			}
		}
		
		public function checkHitGhost(e:TimerEvent) {
			for each(var g:ghost in this.documentClass.ghostVector) {
				if (hitTestObject(g)) {
					this.playerDie();
					break;
				}
			}
		}
		
		public function playerDie() {
			trace("player die!")
		}
	}

}