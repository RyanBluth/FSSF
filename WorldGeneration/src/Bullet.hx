package ;

import flash.geom.Point;
import flash.Lib;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Sean
 */
class Bullet extends ST_Sprite {
	public var timeStamp:Int;
	public function new(?_bitmap:String) {
		super(_bitmap);
		kinetics.friction = 1;
		
		timeStamp = Lib.getTimer();
	}
	public override function update() {
		super.update();
		if (Lib.getTimer() - 5000 > timeStamp) {
			this.active = false;
		}
	}
	
	public override function reset() {
		super.reset();
		timeStamp = Lib.getTimer();
	}
}