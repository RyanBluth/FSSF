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
import sexual_tengine.STI;
import sexual_tengine.utils.ST_Logger;

import Bullet;

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

import sexual_tengine.animation.ST_SpriteSheet;

import openfl.display.FPS;
import entities.Player;
import entities.Enemy;

import sexual_tengine.sprite.ST_Detachment;

class PlayState extends ST_State{
	var bulletManager:ST_SpriteManager;
	var scrollBackground:ST_Background;
	var player:Player;
	var enemies:Array<Enemy>;
	
	var collisionTest:ST_Sprite;
	
	public function new() {
		super();
		player = new Player();
		setupPlayer();
		addChild(player);
		addChild(new FPS());
		
		bulletManager = new ST_SpriteManager(Bullet);
		
		collisionTest = new ST_Sprite();
		collisionTest.animation.addSpriteSheet("img/terrain.png", "main");
		collisionTest.animation.addAnimationState("main", "main", [0], 0, 432, 216, true);
		collisionTest.x = 700;
		addChild(collisionTest);
		
		
		#if !flash
		ST_GamepadManager.addController(0);
		#end
	}
	
	function setupPlayer(){
		player.kinetics.friction = 0.9;
		
		enemies = new Array();
		enemies.push(new Enemy());
		
		for (e in enemies) {
			addChild(e);
			e.x = 500;
			e.y = 500;
		}
		
		addChild(new Enemy());
		addChild(new FPS());
	}
	
	public override function update(){
		super.update();
		playerMovement();
		player.update();
		for (i in bulletManager.spriteArray) {
			i.update();
		}
		for (e in enemies){
			e.update();
		}
		
		if(ST_GeneralInput.primary(0,true)){
			trace(ST_Collision.checkCollision(collisionTest, player.playerBody, 0, null, player));
			trace(ST_Collision.checkCollision(enemies[0].enemyBody, player.playerBody, 0, enemies[0], player));
		}
	}
	
	private function playerMovement() {
	
		player.kinetics.resetAcceleration();
		if(ST_GeneralInput.left(0)) {
			player.kinetics.applyForce(new Point(-1,0));
		}
		if(ST_GeneralInput.right(0)) {
			player.kinetics.applyForce(new Point(1,0));
		}
		if(ST_GeneralInput.down(0)) {
			player.kinetics.applyForce(new Point(0,1));
		}
		if(ST_GeneralInput.up(0)) {
			player.kinetics.applyForce(new Point(0,-1));
		}
		
		if (ST_GeneralInput.primary(0, false)) {
			var pos:Point = new Point(player.x - 23*1.5, player.y - 23*2);
			var vel:Point = new Point(player.kinetics.velocity.x*0.5, Math.min(player.kinetics.velocity.y*0.5 - 5,-1));
			var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
			
			bul.x = pos.x;
			bul.y = pos.y;
			bul.kinetics.velocity = vel;
			
			addChild(bul);
		}if (ST_GeneralInput.secondary(0, false)) {
			var pos:Point = new Point(player.x + 23*1.5, player.y - 23*2);
			var vel:Point = new Point(player.kinetics.velocity.x*0.5*STI.corrector, Math.min(player.kinetics.velocity.y*0.5*STI.corrector - 5,-1));
			var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
			
			bul.x = pos.x;
			bul.y = pos.y;
			bul.kinetics.velocity = vel;
			
			addChild(bul);
		}
	}
	
	public override function draw() {
		super.draw();
		player.draw();
		for (e in enemies) {
			e.draw();
		}for (i in bulletManager.spriteArray) {
			i.draw();
		}
	}
}