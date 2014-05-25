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
import sexual_tengine.ui.ST_UiButton;
import sexual_tengine.ui.ST_UiImage;
import sexual_tengine.ui.ST_UiInputText;
import sexual_tengine.ui.ST_UiLabel;
import sexual_tengine.ui.ST_UiLayoutUtil;
import sexual_tengine.ui.ST_UiLinearLayout;
import sexual_tengine.ui.ST_UiPanel;
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
	
	var panel:ST_UiPanel;
	var button:ST_UiButton;
	
	var linLay:ST_UiLinearLayout;
	
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
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		enemies.push(new Enemy());
		
		for (e in enemies) {
			addChild(e);
			e.x = Std.random(Lib.current.stage.stageWidth);
			e.y = Std.random(Lib.current.stage.stageHeight);
		}
		
		addChild(new FPS());
		panel = new ST_UiPanel(200, 200);
		panel.setBackgroundColour(0xFF0033, 1);
		addChild(panel);
		
		button = new ST_UiButton(128, 32);
		//panel.addComponent("button", button, 30, 30);
		
		button.label.text = "Button";
		button.label.format.size = 20.5;
		//panel.addComponent("text", new ST_UiInputText(100, 30), 50, 50);
		var text =  new ST_UiInputText(100, 30);
		var text2 =  new ST_UiInputText(100, 30);
		var text3 =  new ST_UiInputText(100, 30);
		var text4 =  new ST_UiInputText(100, 30);
		var img = new ST_UiImage(100, 100, "img/bullet.png");
		var label:ST_UiLabel = new ST_UiLabel(100, 100);
		label.text.text = "Label";
		label.text.format.size = 30;
		panel.x = 100;
		panel.y = 100;
		linLay = new ST_UiLinearLayout(0, 0, VERTICAL);
		linLay.addChildren([button,text,text2,img,text3,label,text4]);
		panel.addComponent("lin", linLay, 50, 50);
		text2.marginLeft = 10;
		text2.marginRight = 10;
		linLay.setChildOrderIndex(button, 3);
		button.marginBottom = 20;
		label.text.setFont("font/PTC55F.ttf");
		
		
		var text5 = new ST_UiInputText(100, 30);
		var text6 = new ST_UiInputText(100, 30);
		
		panel.addComponent("text5", text5, 0, 0);
		panel.addComponent("text6", text6, 0, 0);
		ST_UiLayoutUtil.centerVerical(linLay, [text5], 10);
		trace(linLay.displayHeight);
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
		linLay.update();
		panel.update();
		button.update();
//		trace(bulletManager.spriteArray.length,ST_Collision.spriteManagerCollide(player.playerBody, bulletManager, player).length);
		
		if(ST_GeneralInput.primary(0,false)){
			//trace(ST_Collision.circleCollide(collisionTest, player.playerBody, null, player));
			//trace(ST_Collision.checkCollision(collisionTest, player.playerBody, 0, null, player));
			//trace(ST_Collision.checkCollision(enemies[0].enemyBody, player.playerBody, 0, enemies[0], player));
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
		linLay.draw();
		player.draw();
		button.draw();
		for (e in enemies) {
			e.draw();
		}for (i in bulletManager.spriteArray) {
			i.draw();
		}
	}
}