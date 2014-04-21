package ;

import sexual_tengine.camera.ST_Camera;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.Lib;
import sexual_tengine.sprite.ST_SpriteManager;
import sexual_tengine.utils.ST_Logger;

import entities.Bullet;

import sexual_tengine.ST_State;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.input.ST_Keyboard;
import sexual_tengine.input.ST_GamepadManager;
import sexual_tengine.input.ST_GeneralInput;
import sexual_tengine.input.ST_TouchManager;
import sexual_tengine.utils.ST_Collision;
import sexual_tengine.layers.ST_Background;
import openfl.display.FPS;

class PlayState extends ST_State{

	var scrollBackground:ST_Background;
	var player:Array<ST_Sprite>;
	
	public function new() {
		super();
		scrollBackground = new ST_Background("img/stars.jpg", Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, true,20);
		
		addChild(scrollBackground);
		
		player = new Array<ST_Sprite>();
		for (i in 0...1) {
			player[i] = new ST_Sprite("img/SHIP.png");
			addChild(player[i]);
			player[i].movement.friction = 0.80;
		}
		ST_GamepadManager.addController(0);
		addChild(new FPS());
		
		var manager:ST_SpriteManager = new ST_SpriteManager(Bullet,["img/SHIP.png"]);
		addChild(manager.getActiveSprite());
	}
	
	public override function update() {
		super.update();
		scrollBackground.update();
		playerMovement();
		for (i in 0...player.length) {
			player[i].update();
		}
	}
	
	private function playerMovement() {
		for (i in 0...player.length) {
			player[i].movement.resetAcceleration();
			if(ST_GeneralInput.left(0)) {
				player[i].movement.applyForce(new Point(-2,0));
			}
			if(ST_GeneralInput.right(0)) {
				player[i].movement.applyForce(new Point(2,0));
			}
			if(ST_GeneralInput.down(0)) {
				player[i].movement.applyForce(new Point(0,2));
			}
			if(ST_GeneralInput.up(0)) {
				player[i].movement.applyForce(new Point(0,-2));
			}
		}
	}
	
	public override function draw() {
		super.draw();
	}
}