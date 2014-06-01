package sexual_tengine;
import openfl.geom.Point;

/**
 * ...
 * @author Sean
 */
class ST_Pathing{
	public var inputTimes:Array<Int>;
	public var inputForces:Array<Point>;
	public var timeStamp:Int;
	private var iterator:Int;
	public function new() {
		iterator = 0;
		timeStamp = STI.timeStamp;
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
	
	public function getForce():Point {
		while ((STI.timeStamp - timeStamp) > inputTimes[iterator]) {
			iterator += 1;
			if (iterator >= inputTimes.length) {
				timeStamp = (STI.timeStamp - (inputTimes[inputTimes.length - 1] + timeStamp)) + STI.timeStamp;
				iterator = 0;
				
				//interpolate between the last input force and the first input force by a ratio equivalent to the overlap in the time taken between frames
				var a = inputForces[inputForces.length - 1];
				var b = inputForces[0];
				var dif = (timeStamp-STI.timeStamp)/STI.target;
				var res:Point = new Point(a.x*(dif) + b.x*(1-dif), a.y * (dif) + b.y * (1-dif));
				return res;
			}
		}
		return inputForces[iterator];
	}
}