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
import sexual_tengine.sprite.ST_SuperSprite;
import openfl.display.FPS;
import entities.Player;
import entities.Enemy;

import sexual_tengine.sprite.ST_Detachment;

class PlayState extends ST_State{

	var scrollBackground:ST_Background;
	var player:Player;
	var enemies:Array<Enemy>;
	
	public function new() {
		super();
		player = new Player();
		addChild(player);
		
		enemies = new Array();
		enemies.push(new Enemy());
		
		for (e in enemies) {
			addChild(e);
		}
		
		addChild(new Enemy());
		ST_GamepadManager.addController(0);
		addChild(new FPS());
	}
	
	public override function update() {
		super.update();
		playerMovement();
		player.update();
		for (e in enemies){
			e.update();
		}
	}
	
	private function playerMovement() {
	
		player.kinetics.resetAcceleration();
		if(ST_GeneralInput.left(0)) {
			player.kinetics.applyForce(new Point(-5,0));
		}
		if(ST_GeneralInput.right(0)) {
			player.kinetics.applyForce(new Point(5,0));
		}
		if(ST_GeneralInput.down(0)) {
			player.kinetics.applyForce(new Point(0,5));
		}
		if(ST_GeneralInput.up(0)) {
			player.kinetics.applyForce(new Point(0,-5));
		}
	}
	
	public override function draw() {
		super.draw();
	}
}