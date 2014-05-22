package;

import flash.geom.Point;
import flash.Lib;
import sexual_tengine.animation.ST_AnimationManager;
import sexual_tengine.animation.ST_AnimatorCommand;
import sexual_tengine.animation.ST_CircularPathInterpolator;
import sexual_tengine.animation.ST_BasicFloatOscillator;
import sexual_tengine.animation.ST_RelativeLinearInterpolator;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.sprite.ST_SuperSprite;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.ST_Pathing;
import sexual_tengine.STI;
/**
 * ...
 * @author ryan
 */
class Enemy extends ST_SuperSprite {
	/** The interpolation for ST_Pathing is highly instable right now. If possible, use ST_AnimatorCommands instead. */
	//public var path:ST_Pathing;
	
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
		enemyFire.circleColliderRadius = 100 *0.5;
		
		enemyBody = new ST_Sprite();
		enemyBody.setOrigin( -50, -50);
		enemyBody.animation.addSpriteSheet("img/enemy_01.png", "main", true);
		enemyBody.animation.addAnimationState("main", "main", [0], 5, 100, 100, true);
		enemyBody.circleColliderRadius = 100 *0.5;
		
		addSpriteChild("enemyFire", enemyFire);
		addSpriteChild("enemyBody", enemyBody);
		//path = new ST_Pathing();
		
		animator.addCommand("enemyAlpha", new ST_AnimatorCommand(enemyFire, new ST_BasicFloatOscillator("alpha", 0.1, 1), 15));
		
		var pathX:ST_RelativeLinearInterpolator = new ST_RelativeLinearInterpolator("x");
		pathX.push(20, 20);
		pathX.push(40, -20);
		if (Std.random(10) > 5) {
			pathX.push(60, -20);
		}
		animator.addCommand("enemyMovement", new ST_AnimatorCommand(this, pathX, 60));
		
		/*var style = Std.random(3000);
		if(style >= 2000){
			path.push(10, new Point(0, 0.1));
			path.push(50, new Point(-1, 0));
			path.push(60, new Point(0, 0.1));
			path.push(100, new Point( 1, 0));
		}else if (style >= 1000) {
			path.push(50, new Point(-1, 1));
			path.push(100, new Point(0, -1.414));
			path.push(150, new Point(1, 1));
		}else {
			path.push(10, new Point(0, 0.5));
			path.push(20, new Point(0, -0.5));
			path.push(40, new Point(0, 0.25));
			path.push(60, new Point(0, -0.25));
			path.push(70, new Point(0, 0.5));
			path.push(80, new Point(0, -0.5));
			/*
			path.push(100, new Point(0, 1));
			path.push(200, new Point(-1, 1));
			path.push(300, new Point(-1, 0));
			path.push(400, new Point(-1, -1));
			path.push(500, new Point(0, -1));
			path.push(600, new Point(1, -1));
			path.push(700, new Point(1, 0));
			path.push(800, new Point(1, 1));*/
		//}
	}
	
	public override function update() {
		super.update();
		kinetics.resetAcceleration();
		//kinetics.applyForce(path.getForce());
		animator.animate("enemyMovement");
	}
	
	public override function draw() {
		super.draw();
		animator.animate("enemyAlpha");
	}
	
}