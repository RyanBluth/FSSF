package sexual_tengine.sprite;

import sexual_tengine.animation.ST_AnimationManager;
import sexual_tengine.physics.ST_Physics;
import sexual_tengine.sprite.ST_Detachment;

import flash.display.Graphics;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import openfl.Assets;



/**
 * ...
 * @author Sean
 */
class ST_Sprite extends ST_Detachment{
	
	
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
		
	}
	
	public override function update() {
		super.update();
	}
	
	public function setBitmap(_bitmap:String) {
		bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
		addChild(bitmap);
	}
	public function getBitmap():Bitmap {
		return bitmap;
	}
	
	
	public function setOrigin(_x:Float, _y:Float) {
		this.animation.origin.x = _x;
		this.animation.origin.y = _y;
	}
	
	/**
	 * Needs to be called once per frame to update animation manager.
	 */
	public function draw() {
		if(active){
			this.animation.draw();
		}
	}
	
	override public function deactivate() {
		super.deactivate();
		this.graphics.clear();
	}
}