package {

	import flash.display.MovieClip;


	public class tile extends MovieClip {


		public function tile() {
			// constructor code

			main.collisionVector.push(this);
		}
	}

}