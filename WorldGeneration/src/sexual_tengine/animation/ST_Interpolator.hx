package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;

/**
 * Implement this and define 'interpolate' as a function of elapsedMilliseconds and totalMilliseconds
 * If the interpolation is defined as a percentage of elapsedMilliseconds/totalMilliseconds, no deltaTime correction is required
 * <em>elapsedMilliseconds increases by deltaTime each frame</em>
 * */
interface ST_Interpolator {
	public function interpolate(target:ST_Detachment, totalMilliseconds:Float, elapsedMilliseconds:Float):Void;
}