package {

	import flash.display.*;
	import flash.events.*;
	import flash.net.drm.VoucherAccessInfo;
	import flash.utils.Timer;


	public class player extends actor {
		
		public var documentClass;
		public var playerTimer:Timer = new Timer(50);

		public function player(docClass) {
			// constructor code
			trace("player");
			
			this.initPlayer()
			this.documentClass = docClass;

			//this.setupPlayerDirection();

			
			this.playerTimer.addEventListener(TimerEvent.TIMER,checkHitGhost);
			this.playerTimer.start();
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
		
		public function changeDirection(e: KeyboardEvent): void {

			//trace("mover");
			switch (e.keyCode) {
				case 38: //up
					trace("up");
					pushDirection("up")
					//moveY(-speed);
					break;
				case 37: //left
					trace("left");
					pushDirection("left")
					//moveX(-speed);
					break;
				case 40: //down
					pushDirection("down")
					//moveY(speed);
					break;
				case 39: //right
					pushDirection("right")
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