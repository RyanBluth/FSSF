package sexual_tengine;
import sexual_tengine.animation.ST_Interpolator;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.utils.ST_Logger;

/**
 * ...
 * @author Ryan
 */
class ST_BasicFloatOscillator implements ST_Interpolator{
	private var field:String;
	private var min:Float;
	private var max:Float;
	private var flip:Bool;
	private var first:Bool;
	
	public function new(_field:String, _min:Float, _max:Float){
		field = _field;
		min = _min;
		max = _max; 
		flip = true;
		first = true;
	}
	
	/* INTERFACE sexual_tengine.animation.ST_Interpolator */
	public function interpolate(target:ST_Detachment, totalMilliseconds:Float, elapsedMilliseconds:Float):Void{
		if (first) {
			// verify that the field is a float before starting
			if (!Std.is(Reflect.getProperty(target, field), Float)) {
				ST_Logger.throwAndLog("Field '" + field + "' is not a Float property of '" + target + "'");
			}
			
			Reflect.setProperty(target, field, min);
			first = false;
		}
		
		var step:Float = 
			flip ?
			min + (max - min) * (elapsedMilliseconds / totalMilliseconds)
			:
			max - (max - min) * (elapsedMilliseconds / totalMilliseconds);
		
		
		var steps:Float = ((Math.abs(max) + Math.abs(min)) / totalMilliseconds);
		if (elapsedMilliseconds + STI.deltaTime >= totalMilliseconds) {
			flip = !flip;
		}
		
		Reflect.setProperty(target, field, step);
	}
	
}