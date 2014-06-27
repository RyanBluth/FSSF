package sexual_tengine.sprite;

import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import sexual_tengine.physics.ST_Physics;
import openfl.geom.Point;
import sexual_tengine.STI;

/**
 * ...
 * @author ryan
 */
class ST_Detachment extends Sprite{
	public var kinetics:ST_Physics;
	public var active:Bool;
	/** Whether this class extends ST_SuperSprite */
	public var superSprite:Bool;
	
	
	public function new() {
		super();
		kinetics = new ST_Physics();
		active = true;
		superSprite = false;
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
	
	public function draw(){};
	
	public function getParentOffset(_parent:ST_Detachment):Point{
		var t:DisplayObjectContainer = cast(this,DisplayObjectContainer);
		var offset:Point = new Point(0, 0);
		while (t != _parent) {
			t = t.parent;
			if (t != null) {
				offset.x += t.x;
				offset.y += t.y;
			}else {
				break;
			}
		}
		return offset;
	}
}