package sexual_tengine.sprite;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import openfl.Assets;
import sexual_tengine.animation.ST_AnimationManager;
import sexual_tengine.physics.ST_Physics;

/**
 * ...
 * @author Sean
 */
class ST_Sprite extends Sprite{
	
	private var bitmap:Bitmap;
	public var animation:ST_AnimationManager;
	public var movement:ST_Physics;
	public var active:Bool;
	
	public function new(?_bitmap:String){
		super();
		if(_bitmap != null){
			bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
			addChild(bitmap);
		}else {
			bitmap = new Bitmap();
		}
		animation = new ST_AnimationManager(this.graphics);
		movement = new ST_Physics();
		active = true;
	}
	
	public function update() {
	
		var movementVector:Point = movement.calculatePosition();
		x += movementVector.x;
		y += movementVector.y;
	}
	
	public function setBitmap(_bitmap:String) {
		bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
		addChild(bitmap);
	}
	public function getBitmap():Bitmap {
		return bitmap;
	}
}