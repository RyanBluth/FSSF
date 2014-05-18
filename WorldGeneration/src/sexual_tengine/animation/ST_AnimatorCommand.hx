package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Ryan
 */
class ST_AnimatorCommand
{
	public  var target:ST_Sprite;
	private var interpolator:ST_Interpolator;
	private var totalFrames:Int;
	private var elapsedFrames:Int;
	
	public function new(_target:ST_Sprite, _interpolator:ST_Interpolator, _totalFrames:Int) 
	{
		target = _target;
		interpolator = _interpolator;
		totalFrames = _totalFrames;
		elapsedFrames = 0;
	}
	
	public function animate() {
		interpolator.interpolate(target,  totalFrames, elapsedFrames);
		elapsedFrames++;
		if (elapsedFrames >= totalFrames) {
			elapsedFrames = 0;
		}
	}
	
}