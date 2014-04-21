package sexual_tengine.sprite;

import flash.display.Sprite;
import sexual_tengine.physics.ST_Physics;
import flash.geom.Point;

/**
 * ...
 * @author ryan
 */
class ST_Detachment extends Sprite
{
	public var kinetics:ST_Physics;
	public var active:Bool;
	
	
	public function new() {
		super();
		kinetics = new ST_Physics();
		active = true;
	}
	
	public function update() {
		var movementVector:Point = kinetics.calculatePosition();
		x += movementVector.x;
		y += movementVector.y;
	}
}