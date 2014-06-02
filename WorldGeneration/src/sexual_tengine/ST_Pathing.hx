package sexual_tengine;
import openfl.geom.Point;

/**
 * The interpolation for ST_Pathing is highly instable right now. If possible, use ST_AnimatorCommands instead.
 */
class ST_Pathing{
	public var inputTimes:Array<Int>;
	public var inputForces:Array<Point>;
	public var elapsedFrames:Float;
	private var iterator:Int;
	public function new() {
		iterator = 0;
		elapsedFrames = 0;
		inputTimes = new Array();
		inputForces = new Array();
	}
	
	public function push(_time:Int, _force:Point) {
		inputTimes.push(_time);
		inputForces.push(_force);
	}
	public function pop() {
		var res = { t:inputTimes.pop(), f:inputForces.pop() };
		return res;
	}
	
	/** Needs to be called each frame like an update function. */
	public function getForce():Point {
		var res:Point = new Point();
		var res2:Bool = true;
		elapsedFrames += STI.corrector;
		if (inputForces.length <= 0) {
			return new Point(0, 0);
		}
		while (elapsedFrames > inputTimes[iterator]) {
			iterator += 1;
			if (iterator >= inputTimes.length) {
				iterator = 0;
				elapsedFrames -= inputTimes[inputTimes.length - 1];
				
				/*for (i in 0...inputTimes.length) {
					inputTimes[i] += inputTimes[inputTimes.length - 1];
				}*/
				//var dif = (elapsedFrames - inputTimes[inputTimes.length - 1])*STI.corrector;
				//trace(dif);
				/*while(elapsedFrames > inputTimes[0]){
					elapsedFrames -= inputTimes[inputTimes.length - 1];// inputTimes[inputTimes.length -1];// (STI.timeStamp - (inputTimes[inputTimes.length - 1] + elapsedFrames)) + STI.timeStamp;
				}iterator = 0;
				*/
				
			}//interpolate between the last input force and the first input force by a ratio equivalent to the overlap in the time taken between frames
			var iterator2 = iterator != 0 ? iterator - 1 : inputForces.length - 1;
			var div = iterator != 0 ? (inputTimes[iterator] - inputTimes[iterator2]) : inputTimes[iterator];
			var a = inputForces[iterator2];
			var b = inputForces[iterator];
			var dif = 1-(inputTimes[iterator] - elapsedFrames) / div;// / STI.deltaTime;
			trace(dif);
			res.x = a.x * (dif) + b.x * (1 - dif);
			res.y = a.y * (dif) + b.y * (1 - dif);
			res2 = false;
		}
		if(res2){
			res = inputForces[iterator];
		}
		return res;
	}
}