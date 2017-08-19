package;

import openfl.media.Sound;
import sexual_tengine.camera.ST_Camera;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import openfl.Lib;
import sexual_tengine.debugger.ST_Console;
import sexual_tengine.sound.ST_SoundManager;
import sexual_tengine.sprite.ST_SpriteManager;
import sexual_tengine.ST_Game;
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
	var soundManager:ST_SoundManager;
	var container:ST_Sprite;
	
	public function new(_game:ST_Game) {
		super(_game);
		container = new ST_Sprite();
		container.graphics.beginFill(0xFFFFFF);
		container.graphics.drawRect(15, 15, 1250, 650);
		container.graphics.endFill();
		addChild(container);
		player = new Player();
		setupPlayer();
		addChild(player);
		addChild(new FPS());
		
		bulletManager = new ST_SpriteManager(Bullet);
		bulletManager.circleColliderRadius = 11.5;
		
		soundManager = new ST_SoundManager();
	}
	
	function setupPlayer() {
		
		player.kinetics.friction = 0.9;
		
		enemies = new Array();
		for(i in 0...50){
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
	}
	
	private function playerMovement() {
	
		player.kinetics.resetAcceleration();
		if(ST_GeneralInput.left(0)) {
			player.kinetics.applyForce(new Point(-1,0));
		}
		if(ST_GeneralInput.right(0)) {
			player.kinetics.applyForce(new Point(1, 0));
		}
		if(ST_GeneralInput.down(0)) {
			player.kinetics.applyForce(new Point(0, 1));
		}
		if(ST_GeneralInput.up(0)) {
			player.kinetics.applyForce(new Point(0, -1));
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
			var vel:Point = new Point(player.kinetics.velocity.x*0.5, Math.min(player.kinetics.velocity.y*0.5 - 5,-1));
			var bul:Bullet = cast(bulletManager.getActiveSprite(),Bullet);
			
			bul.x = pos.x;
			bul.y = pos.y;
			bul.kinetics.velocity = vel;
			addChild(bul);
		}
		if (player.y < 20 + player.height*0.5) {
				player.y = 20 + player.height*0.5;
		}
		if (player.y > 660 - player.height*0.5) {
				player.y = 660 - player.height*0.5;
		}
		if (player.x < 20 + player.width*0.5) {
				player.x = 20 + player.width*0.5;
		}
		if (player.x > 1260 - player.width*0.5) {
				player.x = 1260 - player.width*0.5;
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