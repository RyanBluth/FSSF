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

	public var enemyFire:ST_Sprite;
	public var enemyBody:ST_Sprite;
	public function new() {
		super();
		
		kinetics.friction = 0.9;
		
		enemyFire = new ST_Sprite();
		enemyFire.setOrigin( -50, -50);
		enemyFire.animation.addSpriteSheet("img/enemy_01.png", "main", true);
		enemyFire.animation.addAnimationState("main", "main", [1, 2, 3, 4], 5, 100, 100, true);
		enemyFire.animation.playAnimation(0, "main");
		
		enemyBody = new ST_Sprite();
		enemyBody.setOrigin( -50, -50);
		enemyBody.animation.addSpriteSheet("img/enemy_01.png", "main", true);
		enemyBody.animation.addAnimationState("main", "main", [0], 5, 100, 100, true);
		
		addSpriteChild("enemyFire", enemyFire);
		addSpriteChild("enemyBody", enemyBody);
	}
	
	public override function update() {
		super.update();
	}
	
}