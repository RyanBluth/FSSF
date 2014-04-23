package sexual_tengine.sprite;

import flash.display.Sprite;
import sexual_tengine.physics.ST_Physics;
import flash.geom.Point;
import sexual_tengine.STI;

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
		if(active){
			var movementVector:Point = kinetics.calculatePosition();
			x += movementVector.x * STI.corrector;
			y += movementVector.y * STI.corrector;
		}
	}
	
	public function deactivate() {
		this.active = false;
	}
	
	public function reactivate() {
		active = true;
	}
}