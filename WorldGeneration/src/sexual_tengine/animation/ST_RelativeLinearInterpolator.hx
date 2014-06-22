package sexual_tengine.animation;
import sexual_tengine.animation.ST_Interpolator;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.STI;
import sexual_tengine.utils.ST_Logger;

/**
 * ...
 * @author Ryan
 */
class ST_RelativeLinearInterpolator implements ST_Interpolator{
	private var field:String;
	private var min:Float;
	private var max:Float;
	private var first:Bool;
	
	private var iterator:Int;
	private var times:Array<Float>;
	private var positions:Array<Float>;
	private var easings:Array<String>;
	public var length:Int;
	private var dest:Float;
	private var src:Float;
	
	public function new(_field:String){
		field = _field;
		first = true;
		
		iterator = 0;
		times = new Array<Float>();
		positions = new Array<Float>();
		easings = new Array<String>();
		length = 0;
	}
	
	public function push(_t:Float, _v:Float, ?_easing:String):Void {
		times.push(_t);
		positions.push(_v);
		if(_easing != null){
			easings.push(_easing);
		}else {
			easings.push("none");
		}
		length += 1;
	}
	
	public function totalFrames():Float {
		return times.length > 0 ? times[times.length - 1] : 0;
	}
	
	/* INTERFACE sexual_tengine.animation.ST_Interpolator */
	public function interpolate(target:Dynamic, totalFrames:Float, elapsedFrames:Float):Void {
		if (first) {
			// verify that the field is a float before starting
			if (!Std.is(Reflect.getProperty(target, field), Float)) {
				ST_Logger.throwAndLog("Field '" + field + "' is not a Float property of '" + target + "'"+Type.typeof(Reflect.getProperty(target, field)));
			}
			
			src = Reflect.getProperty(target, field);
			dest = src+positions[0];
			//Reflect.setProperty(target, field, min);
			first = false;
		}
		
		var t = false;
		while (elapsedFrames + STI.corrector >= times[iterator]) {
			iterator += 1;
			if (iterator >= positions.length) {
				iterator = 0;
				elapsedFrames = 0;
			}
			src = dest;
			dest = src + positions[iterator];
			t = true;
		}
		
		
		//var step:Float = ST_Easing.easeInOutCirc(elapsedFrames - (iterator == 0 ? 0 : times[iterator - 1]), src, (dest - src), (times[iterator] - (iterator == 0 ? 0 : times[iterator - 1])));
		var step:Float = ST_Easing.call(easings[iterator], elapsedFrames - (iterator == 0 ? 0 : times[iterator - 1]), src, (dest - src), (times[iterator] - (iterator == 0 ? 0 : times[iterator - 1])));
		
		Reflect.setProperty(target, field, step);
	}
}