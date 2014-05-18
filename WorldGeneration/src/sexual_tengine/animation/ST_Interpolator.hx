package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Ryan
 */
interface ST_Interpolator
{
	public function interpolate(target:ST_Sprite, totalFrames:Int, elapsedFrames:Int):Void;
}