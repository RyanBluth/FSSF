package;

import sexual_tengine.camera.ST_Camera;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.Lib;
import sexual_tengine.debugger.ST_Console;
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
import Player;
import Enemy;

import sexual_tengine.sprite.ST_Detachment;

class PlayState extends ST_State{
	var bulletManager:ST_SpriteManager;
	var scrollBackground:ST_Background;
	var player:Player;
	var enemies:Array<Enemy>;
	
	var collisionTest:ST_Sprite;
	var debugger:ST_Console;
	
	public function new() {
		super();
		player = new Player();
		setupPlayer();
		addChild(player);
		addChild(new FPS());
		
		bulletManager = new ST_SpriteManager(Bullet);
		bulletManager.circleColliderRadius = 11.5;
		
		collisionTest = new ST_Sprite();
		collisionTest.animation.addSpriteSheet("img/terrain.png", "main");
		collisionTest.animation.addAnimationState("main", "main", [0], 0, 432, 216, true);
		collisionTest.x = 700;
		addChild(collisionTest);
		
		collisionTest.circleColliderRadius = 5;
		//player.playerBody.circleColliderRadius = 5;
		
		//debugger = new ST_Console();
		//addChild(debugger);
		
		ST_GamepadManager.addController(0);
	}
	
	function setupPlayer(){
		player.kinetics.friction = 0.9;
		
		enemies = new Array();
		for(i in 0...10){
			enemies.push(new Enemy());
		}
		
		for (e in enemies) {
			addChild(e);
			e.x = Std.random(Lib.current.stage.stageWidth);
			e.y = Std.random(Lib.current.stage.stageHeight);
		}
		
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
		
		
		bulletManager.updateGrid();
		for (e in enemies) {
			if(e.active){
				for (b in ST_Collision.spriteManagerCollide(e.enemyBody, bulletManager, e)) {
					e.deactivate();
					b.deactivate();
					break;
				}
			}
		}
		
		
//		ST_Logger.log(bulletManager.spriteArray.length,ST_Collision.spriteManagerCollide(player.playerBody, bulletManager, player).length);
		
		if(ST_GeneralInput.primary(0,false)){
			//ST_Logger.log(ST_Collision.circleCollide(collisionTest, player.playerBody, null, player));
			ST_Logger.log(ST_Collision.pixelPerfectCollide(collisionTest, player.playerBody, 0, null, player));
			//ST_Logger.log(ST_Collision.checkCollision(enemies[0].enemyBody, player.playerBody, 0, enemies[0], player));
		}
		//if (ST_GeneralInput.primary(0,true)) {
		//	debugger.analyze(getObjectsUnderPoint(new Point(mouseX, mouseY))[0]);
		//}
		//debugger.update();
		
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
		
		if (ST_Keyboard.isPressed(["MINUS"])) {
			STI.setFPS(STI.getFPS() + 1);
		}if (ST_Keyboard.isPressed(["EQUALS"])) {
			STI.setFPS(STI.getFPS()-1);
		}
		
		//STI.setFPS(5*Math.sqrt(player.kinetics.velocity.x * player.kinetics.velocity.x + player.kinetics.velocity.y * player.kinetics.velocity.y));
		
		
		//if (player.shotTimerElapsed >= player.shotTimerTotal) {
			for(i in 0...100){
			if (ST_GeneralInput.primary(0, false)) {
				var pos:Point = new Point(player.x - 23*1.5, player.y - 23*2);
				var vel:Point = new Point(player.kinetics.velocity.x*0.5, Math.min(player.kinetics.velocity.y - 5,-1));
				var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
				
				bul.x = pos.x;
				bul.y = pos.y;
				bul.kinetics.velocity = vel;
				
				addChild(bul);
			}if (ST_GeneralInput.secondary(0, false)) {
				var pos:Point = new Point(player.x + 23*1.5, player.y - 23*2);
				var vel:Point = new Point(player.kinetics.velocity.x*0.5, Math.min(player.kinetics.velocity.y - 5,-1));
				var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
				
				bul.x = pos.x;
				bul.y = pos.y;
				bul.kinetics.velocity = vel;
				
				addChild(bul);
			}
			player.shotTimerElapsed = 0;
			}
		//}
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