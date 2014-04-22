package entities;

import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.sprite.ST_SuperSprite;
import sexual_tengine.sprite.ST_Detachment;
/**
 * ...
 * @author ryan
 */
class Enemy extends ST_SuperSprite
{

	public function new() 
	{
		super();
		
		kinetics.friction = 0.9;
		
		var enemyFire:ST_Sprite = new ST_Sprite();
		enemyFire.animation.addSpriteSheet("img/enemy_01.png", "main", true);
		enemyFire.animation.addAnimationState("main", "main", [1, 2, 3, 4], 5, 550, 550);
		enemyFire.animation.playAnimation(0, "main");
		
		var enemyBody:ST_Sprite = new ST_Sprite();
		enemyBody.animation.addSpriteSheet("img/enemy_01.png", "main", true);
		enemyBody.animation.addAnimationState("main", "main", [0], 5, 550, 550);
		enemyBody.animation.setAnimationState("main");
		enemyBody.animation.staticDraw();
		
		addSpriteChild("enemyFire", enemyFire);
		addSpriteChild("enemyBody", enemyBody);
		
		width = 100;
		height = 100;
		
	}
	
	public override function update() {
		super.update();
	}
	
}