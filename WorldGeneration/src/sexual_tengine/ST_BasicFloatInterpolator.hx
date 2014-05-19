package sexual_tengine;
import sexual_tengine.animation.ST_Interpolator;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.utils.ST_Logger;

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
	
	public function interpolate(target:ST_Sprite, totalMilliseconds:Float, elapsedMilliseconds:Float):Void {
		if (first) {
			// verify that the field is a float before starting
			if (!Std.is(Reflect.getProperty(target, field), Float)) {
				ST_Logger.throwAndLog("Field '" + field + "' is not a Float property of '" + target + "'");
			}
			
			Reflect.setProperty(target, field, min);
			first = false;
		}
		
		var step:Float;
		if (flip) {
			step = min + (max - min) * (elapsedMilliseconds / totalMilliseconds);
		}else {
			step = max - (max - min) * (elapsedMilliseconds / totalMilliseconds);
		}
		
		
		var steps:Float = ((Math.abs(max) + Math.abs(min)) / totalMilliseconds);
		if (elapsedMilliseconds + STI.deltaTime >= totalMilliseconds) {
			flip = !flip;
		}
		
		Reflect.setProperty(target, field, step);
		
		/*if (flip) {
			Reflect.setProperty(target, field, Reflect.getProperty(target, field) + steps);
		}else {
			Reflect.setProperty(target, field, Reflect.getProperty(target, field) - steps);
		}*/
		//trace(flip);
	}
	
}