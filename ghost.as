package {

	import flash.display.*;
	import flash.sampler.Sample;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class ghost extends actor {

		private var ghostName: String;
		public var ghostChangeDirectionTimer: Timer;
		//public static var ghostSpeed: int = 4;
		public var time:int = 2000;
		public var pacman;
		public var feared:Boolean = false;
		public var fearedTime:int = 7000;
		
		public var distWithPlayer:int;
		public var distCheckTimer:Timer = new Timer(50);



		public function ghost(initX, initY, ghostName, player) {
			// constructor code
			this.x = initX;
			this.y = initY;
			this.ghostName = ghostName;
			this.pacman = player;

			this.setupGhostDirection();

			this.ghostChangeDirectionTimer = new Timer(time);
			this.ghostChangeDirectionTimer.addEventListener(TimerEvent.TIMER, changeDirection);
			this.ghostChangeDirectionTimer.start();
			
			//this.distCheckTimer.addEventListener(TimerEvent.TIMER, distWithPlayer);
			//this.distCheckTimer.start();
		}

		public function setupGhostDirection() {
			//this.x = startX;
			//this.y = startY;

			movingDirectionX = speed;
			movingDirectionY = 0;
		}
		
		public function changeDirection(e: TimerEvent): void {
			if (! feared) {
				var directionX = Math.ceil(Math.random()*2);
				var directionY = Math.ceil(Math.random()*2);
				//trace("mover");
				
			}
			else {
				var deltaX = this.x - this.pacman.x;
				var directionX = Math.ceil(Math.random()*2);
				if (deltaX < 0) {
					var directionY = Math.ceil(Math.abs(Math.random()*2 - 0.75));
				}
				else {
					var directionY = Math.ceil(Math.random()*2 + 0.75);
					if (directionY == 3) {
						directionY = 2;
					}
				}
				
			}
			
			switch (directionX) {
					case 1:
						switch (directionY) {
							case 1:
								//trace("left");
								pushDirection("left")
								//moveY(-speed);
								break;
							case 2:
								//trace("up");
								pushDirection("up")
								break;
						}
					case 2:
						switch (directionY) {
							case 1:
								//trace("down");
								pushDirection("down");
								break;
							case 2:
								//trace("right");
								pushDirection("right");
								break;
						}
				}
			
		}
		
		public function randomChangeTimer() {
			this.time = (Math.ceil(Math.random()*5)+1) * 1000;
		}
		
		public function distanceWithPlayer() {
			this.distWithPlayer = Math.sqrt(Math.pow((this.x - this.pacman.x), 2) + Math.pow((this.y - this.pacman.y),2));
			return this.distWithPlayer;
			
		}

		public function runAway () {
			this.feared = true;
			this.speed *= 2;
			trace("Ghost feared" + this.feared + this.speed);
			var escapeTimer:Timer = new Timer(this.fearedTime, 1);
			escapeTimer.addEventListener(TimerEvent.TIMER, recover);
			escapeTimer.start();
		}
		
		public function recover (e:TimerEvent) {
			this.feared = false;
			this.speed /= 2;
			trace("ghost recover " + this.feared + this.speed);
			
		}
		
	}
		

	}