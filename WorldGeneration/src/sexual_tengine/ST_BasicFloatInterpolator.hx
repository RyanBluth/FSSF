package sexual_tengine;
import sexual_tengine.animation.ST_Interpolator;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Ryan
 */
class ST_BasicFloatInterpolator implements ST_Interpolator
{
	private var field:String;
	private var min:Float;
	private var max:Float;
	private var flip:Bool;
	private var first:Bool;
	
	public function new(_field:String, _min:Float, _max:Float) 
	{
		field = _field;
		min = _min;
		max = _max; 
		flip = true;
		first = true;
	}
	
	/* INTERFACE sexual_tengine.animation.ST_Interpolator */
	
	public function interpolate(target:ST_Sprite, totalFrames:Int, elapsedFrames:Int):Void 
	{
		if (first) {
			Reflect.setProperty(target, field, min);
			first = false;
		}
		var steps:Float = ((Math.abs(max) + Math.abs(min)) / totalFrames);
		if (elapsedFrames >= totalFrames - 1) {
			flip = !flip;
		}
		if (flip) {
			Reflect.setProperty(target,field, Reflect.getProperty(target,field) + steps );
		}else {
			Reflect.setProperty(target, field, Reflect.getProperty(target,field) - steps);
		}
		trace(flip);
	}
	
}