package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.STI;

/**
 * ...
 * @author Ryan
 */
class ST_AnimatorCommand {
	/** Sprite affected by interpolator */
	public  var target:ST_Detachment;
	/** Interpolator to affect sprite */
	private var interpolator:ST_Interpolator;
	
	private var totalMilliseconds:Float;
	private var elapsedMilliseconds:Float;
	
	/**
	 * Creates a new animator command.
	 * @param	_target				Sprite affected by interpolator
	 * @param	_interpolator		Interpolator to affect sprite
	 * @param	_totalMilliseconds	Total milliseconds for interpolation
	 */
	public function new(_target:ST_Detachment, _interpolator:ST_Interpolator, _totalMilliseconds:Float){
		target = _target;
		interpolator = _interpolator;
		totalMilliseconds = _totalMilliseconds;
		elapsedMilliseconds = 0;
	}
	
	/**
	 * Interpolates the interpolator and updates the timer. <strong>Usually needs to be called every frame like an update function.</strong>
	 */
	public function animate():Void{
		interpolator.interpolate(target, totalMilliseconds, elapsedMilliseconds);
		elapsedMilliseconds += STI.deltaTime;
		while (elapsedMilliseconds >= totalMilliseconds) {
			elapsedMilliseconds -= totalMilliseconds;
		}
	}
	
}