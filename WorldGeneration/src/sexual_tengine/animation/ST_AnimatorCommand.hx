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
	
	private var totalFrames:Float;
	private var elapsedFrames:Float;
	
	/**
	 * Creates a new animator command.
	 * @param	_target				Sprite affected by interpolator
	 * @param	_interpolator		Interpolator to affect sprite
	 * @param	_totalFrames	Total Frames for interpolation
	 */
	public function new(_target:ST_Detachment, _interpolator:ST_Interpolator, _totalFrames:Float){
		target = _target;
		interpolator = _interpolator;
		totalFrames = _totalFrames;
		elapsedFrames = 0;
	}
	
	/**
	 * Interpolates the interpolator and updates the timer. <strong>Usually needs to be called every frame like an update function.</strong>
	 */
	public function animate():Void{
		interpolator.interpolate(target, totalFrames, elapsedFrames);
		elapsedFrames += STI.corrector;
		while (elapsedFrames >= totalFrames) {
			elapsedFrames -= totalFrames;
		}
	}
	
}