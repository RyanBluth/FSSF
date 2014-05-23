package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;

/**
 * Implement this and define 'interpolate' as a function of elapsedFrames and totalFrames
 * <em>elapsedFrames increases by corrector each frame</em>
 * */
interface ST_Interpolator {
	public function interpolate(target:Dynamic, totalFrames:Float, elapsedFrames:Float):Void;
}