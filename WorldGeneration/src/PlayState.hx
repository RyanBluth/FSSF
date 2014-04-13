package ;

import camera.ST_Camera;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.Lib;
import utils.ST_Logger;

import input.ST_Mouse;
import input.ST_Keyboard;
import input.ST_GamepadManager;
import input.ST_GeneralInput;
import input.ST_TouchManager;
import utils.ST_Collision;
import layers.ST_Background;
import openfl.display.FPS;

class PlayState extends ST_State{

	var scrollBackground:ST_Background;
	var player:ST_Sprite;
	
	public function new(stage:Stage) {
		super(stage);
		scrollBackground = new ST_Background("img/stars.jpg", stage.stageWidth, stage.stageHeight, true, 5);
		player = new ST_Sprite("img/SHIP.png");
		addChild(scrollBackground);
		addChild(player);
		player.movement.friction = 0.80;
		ST_GamepadManager.addController(0);
		addChild(new FPS());
	}
	
	public override function update() {
		super.update();
		scrollBackground.update();
		playerMovement();
		player.update();
	}
	
	private function playerMovement() {
		player.movement.resetAcceleration();
		if(ST_GeneralInput.left(0)) {
			player.movement.applyForce(new Point( -3, 0));
		}
		if(ST_GeneralInput.right(0)) {
			player.movement.applyForce(new Point(3,0));
		}
		if(ST_GeneralInput.down(0)) {
			player.movement.applyForce(new Point(0,3));
		}
		if(ST_GeneralInput.up(0)) {
			player.movement.applyForce(new Point(0,-3));
		}
		
		if (ST_GeneralInput.primary(0, true)) {
			for (i in 0...10000000) {
				var t = 5;
				var s = t;
				s = t + s * t;
			}
		}
	}
	
	public override function draw() {
		super.draw();
	}
}