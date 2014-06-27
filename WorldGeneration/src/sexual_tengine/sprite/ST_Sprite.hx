package sexual_tengine.sprite;

import sexual_tengine.animation.ST_AnimationManager;
import sexual_tengine.physics.ST_Physics;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.STI;

import openfl.display.Graphics;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Assets;



/**
 * ...
 * @author Sean
 */
class ST_Sprite extends ST_Detachment{
	public var circleColliderRadius:Float;
	public var circleColliderX:Float;
	public var circleColliderY:Float;
	
	private var bitmap:Bitmap;
	public var animation:ST_AnimationManager;
	
	public function new(?_bitmap:String) {
		super();
		if(_bitmap != null){
			bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
			addChild(bitmap);
		}else {
			bitmap = new Bitmap();
		}
		animation = new ST_AnimationManager(this.graphics);
		kinetics = new ST_Physics();
		active = true;
		
		circleColliderRadius = 0;
		circleColliderX = 0;
		circleColliderY = 0;
	}
	
	public override function update() {
		super.update();
	}
	
	public function setBitmap(_bitmap:String) {
		if(this.contains(bitmap)){
			removeChild(bitmap);
		}
		bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
		addChild(bitmap);
	}
	public function getBitmap():Bitmap {
		return bitmap;
	}
	
	
	/** Sets the offset for the animation manager */
	public function setOrigin(_x:Float, _y:Float) {
		this.animation.origin.x = _x;
		this.animation.origin.y = _y;
	}
	/** Returns the offset for the animation manager */
	public function getOrigin() {
		return this.animation.origin;
	}
	
	/**
	 * Needs to be called once per frame to update animation manager.
	 */
	public override function draw() {
		if (active) {
			if (!STI.drawCircleColliders) {
				this.animation.draw();
			}else{
				this.graphics.clear();
				this.animation.staticDraw();
				this.animation.draw();
				this.graphics.beginFill(0xFF0000, 0.25);
				this.graphics.drawCircle(0, 0, circleColliderRadius);
				this.graphics.endFill();
			}
		}
	}
	
	override public function deactivate() {
		super.deactivate();
		this.graphics.clear();
	}
}