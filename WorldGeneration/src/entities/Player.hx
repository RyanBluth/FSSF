package entities;
import flash.Lib;
import sexual_tengine.sprite.ST_SuperSprite;
import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author ryan
 */
class Player extends ST_SuperSprite{
	public function new() {
		super();
		
		kinetics.friction = 0.9;
		this.x = (Lib.current.stage.stageWidth - 85)*0.5;
		this.y = Lib.current.stage.stageHeight - 100*2;
		var playerFire:ST_Sprite = new ST_Sprite();
		playerFire.animation.addSpriteSheet("img/player.png", "main", true);
		playerFire.animation.addAnimationState("main", "main", [1, 2, 3, 4], 5, 85, 100);
		playerFire.animation.playAnimation(0, "main");
		
		var playerBody:ST_Sprite = new ST_Sprite();
		playerBody.animation.addSpriteSheet("img/player.png", "main", true);
		playerBody.animation.addAnimationState("main", "main", [0], 5, 85, 100);
		playerBody.animation.setAnimationState("main");
		playerBody.animation.staticDraw();
		
		addSpriteChild("playerFire", playerFire);
		addSpriteChild("playerBody", playerBody);
	}	
}