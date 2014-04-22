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

class PlayState extends ST_State{
	var bulletManager:ST_SpriteManager;
	var scrollBackground:ST_Background;
	var player:ST_SuperSprite;
	
	public function new() {
		super();
		setupPlayer();
		addChild(player);
		ST_GamepadManager.addController(0);
		addChild(new FPS());
		
		bulletManager = new ST_SpriteManager(Bullet);
	}
	
	function setupPlayer(){
		
		player = new ST_SuperSprite();
		player.kinetics.friction = 0.9;
		
		var playerFire:ST_Sprite = new ST_Sprite();
		playerFire.animation.addSpriteSheet("img/player.png", "main", true);
		playerFire.animation.addAnimationState("main", "main", [1, 3, 4], 5, 85, 100);
		playerFire.animation.playAnimation(0, "main");
		
		var playerBody:ST_Sprite = new ST_Sprite();
		playerBody.animation.addSpriteSheet("img/player.png", "main", true);
		playerBody.animation.addAnimationState("main", "main", [0], 5, 85, 100);
		playerBody.animation.setAnimationState("main");
		playerBody.animation.staticDraw();
		
		var playerFire2:ST_Sprite = new ST_Sprite();
		playerFire2.animation.addSpriteSheet("img/player.png", "main", true);
		playerFire2.animation.addAnimationState("main", "main", [3, 2, 4], 5, 85, 100);
		playerFire2.animation.playAnimation(0, "main");
		
		player.addSpriteChild("playerFire", playerFire);
		player.addSpriteChild("playerBody", playerBody);
	}
	
	public override function update(){
		super.update();
		playerMovement();
		player.update();
		for (i in bulletManager.spriteArray) {
			i.update();
			i.animation.draw();
		}
		trace(bulletManager.spriteArray.length);
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
		
		if (ST_GeneralInput.primary(0,false)) {
			var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
			//var bul:Bullet = new Bullet();
			
			bul.x = player.x;
			bul.y = player.y;
			//bul.kinetics.applyForce(player.kinetics.acceleration);
			bul.kinetics.velocity.x = player.kinetics.velocity.x;
			bul.kinetics.velocity.y = player.kinetics.velocity.y - 10;
			
			bul.animation.addSpriteSheet("img/bullet2.png", "main", true);
			bul.animation.addAnimationState("main", "main", [0], 5, 23, 23);
			bul.animation.playAnimation(0, "main", "main");
			
			addChild(bul);
			
			bul = cast(bulletManager.getActiveSprite(),Bullet);
			//var bul:Bullet = new Bullet();
			
			bul.x = player.x + 62;
			bul.y = player.y;
			//bul.kinetics.applyForce(player.kinetics.acceleration);
			bul.kinetics.velocity.x = player.kinetics.velocity.x;
			bul.kinetics.velocity.y = player.kinetics.velocity.y - 10;
			
			bul.animation.addSpriteSheet("img/bullet2.png", "main", true);
			bul.animation.addAnimationState("main", "main", [0], 5, 23, 23);
			bul.animation.playAnimation(0, "main", "main");
			
			addChild(bul);
			//bulletManager.spriteArray.push(bul);
		}
	}
	
	public override function draw() {
		super.draw();
	}
}