package sexual_tengine;
import flash.Lib;

class STI {
	//TIME STUFF
	
	/** Artificial FPS for use in target and timeStep (creates slo-mo effect) */
	public static var FPS:Float = 60;
	/** Target framerate in milliseconds-per-frame */
	public static var target:Float = 1000 / FPS;
	/** Target framerate in frames-per-second */
	public static var timeStep:Float = 1 / FPS;
	/** NOT FOR USE OUTSIDE OF ST_GAME: Stores the timeStampe between frames */
	public static var elapsedTime:Float = 0;
	/** Milliseconds between last update and the current update */
	public static var deltaTime:Float = 0;
	/** Pre-multiplied float to correct for variance in deltaTime (deltaTime / (1000 / FPS))*/
	public static var corrector:Float = 1;
	/** Current time in milliseconds (from Lib.getTimer() at the start of the update) */
	public static var timeStamp:Int = 0;
	/** Changes target and timeStamp to match a new artifical FPS
	 * <em>New FPS is clamped between 0 and the actual target FPS</em> */
	public static function setFPS(_t:Float):Void {
		FPS = Math.min(Math.max(_t, 0),Lib.current.stage.frameRate);
		timeStep = 1 / FPS;
		target = 1000 / FPS;
	}
	
	//OTHER
	/** If true, draws circles on each sprite to show their collision boundaries */
	public static var drawCircleColliders:Bool = false;
	
	public function new(){
		
	}
}