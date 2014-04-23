package ;

import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.STI;

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
		
		var style = Lib.getTimer()%3000;
		if(style >= 2000){
			this.setOrigin( -23 / 2, -23 / 2);
		}else if(style >= 1000){
			this.setOrigin( -53 / 2, -23 / 2);
		}else{
			this.setOrigin( -123 / 2, -23 / 2);
		}
		this.rotation = Std.random(180);
	}
	public override function update() {
		if(active){
			super.update();
			
			//kill bullets outside screen
			if (this.x < -50 || this.y < -50 || this.x > Lib.current.stage.stageWidth+50 || this.y > Lib.current.stage.stageHeight+50) {
				this.active = false;
				this.graphics.clear();
			}
			//kill bullets that have been onstage for too long
			if (Lib.getTimer() - 60000 > timeStamp) {
				this.active = false;
				this.graphics.clear();
			}
			//rotate!
			this.rotation += 10 * STI.deltaTime / (1000 / 60);
		}
	}
	
	public override function reset() {
		super.reset();
		timeStamp = Lib.getTimer();
		this.rotation = Std.random(180);
	}
}