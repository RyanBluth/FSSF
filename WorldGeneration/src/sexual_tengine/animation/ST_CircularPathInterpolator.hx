package sexual_tengine.animation;
import flash.geom.Point;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Ryan
 */
class ST_CircularPathInterpolator implements ST_Interpolator
{
	
	private var radius:Float;
	
	public function new(_radius:Float) {
		radius = _radius;
	}
	
	public function interpolate(target:ST_Sprite, totalMilliseconds:Float, elapsedMilliseconds:Float):Void
	{
		var currentDegrees = (elapsedMilliseconds / totalMilliseconds)*360;
		currentDegrees = (currentDegrees * Math.PI) / 180;
		var calX = radius * Math.cos(currentDegrees);
		var calY = radius * Math.sin(currentDegrees);
		target.x = calX;
		target.y = calY;
	}
}
