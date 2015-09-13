package  {
	import flash.display.*;
	import flash.events.*;
	import flash.media.Microphone;
	
	public class voiceDetector extends MovieClip{
		public var mic:Microphone;
		
		public var deviceArray:Array;
		
		public var documentClass;
		
		public var g:ghost;
		
		public var screamingLevel:int = 1;
		
		public function voiceDetector(docClass) {
			// constructor code
			
			deviceArray = Microphone.names;
			
			this.documentClass = docClass;
			
			//buzz1 = new buzz() as MovieClip;
			
			trace("Availiable sound input devices: ");
			for (var i:int = 0; i < deviceArray.length; i ++) {
				trace("" + deviceArray[i]);
			}
			
			mic = Microphone.getMicrophone();
			setMicSettings();
			
			mic.addEventListener(ActivityEvent.ACTIVITY, onMicActivity);
			mic.addEventListener(StatusEvent.STATUS, onMicStatus);
			
			
		}
		
		public function setMicSettings() {
			mic.gain = 50;
			mic.rate = 11;
			mic.setUseEchoSuppression(true);
			mic.setLoopBack(true);
			mic.setSilenceLevel(10, 500);
		}
		
		public function onMicActivity(e) {
			trace("activating" + e.activating + ", activityLevel=" + mic.activityLevel);
			if (mic.activityLevel > 20 * this.screamingLevel) {
				for each ( g in documentClass.ghostVector) {
					if (g.distanceWithPlayer() < 50 ) {
						g.runAway();
						this.screamingLevel++;
						trace("next volumn should over: " + 20*this.screamingLevel);
					};
				}
			}
		}
		
		public function onMicStatus(e) {
			trace("status: level=" + e.level + ", code=" + e.code);
		}

	}
	
}
