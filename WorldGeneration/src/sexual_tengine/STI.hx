package sexual_tengine;

class STI {
	//TIME STUFF
	
	/** Target framerate in milliseconds-per-frame */
	public static var target:Float = 1000 / 60;
	/** NOT FOR USE OUTSIDE OF ST_GAME: Stores the timeStampe between frames */
	public static var elapsedTime:Float = 0;
	/** Milliseconds between last update and the current update */
	public static var deltaTime:Float = 0;
	/** Pre-multiplied float to correct for variance in deltaTime */
	public static var corrector:Float = 1;
	/** Target framerate in frames-per-second */
	public static var timeStep:Float = 1 / 60;
	/** Current time in milliseconds (from Lib.getTimer() at the start of the update) */
	public static var timeStamp:Int = 0;
	/** Changes target and timeStamp to match a new timestep */
	public static function setTimestep(_t:Float):Void {
		timeStep = 1 / _t;
		target = 1000 / _t;
	}
	
	//OTHER
	/** If true, draws circles on each sprite to show their collision boundaries */
	public static var drawCircleColliders:Bool = false;
	
	public function new(){
		
	}
}