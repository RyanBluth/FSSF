package;

import openfl.geom.Point;
import openfl.Lib;
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
class EnemyType {
	public var width:Int;
	public var height:Int;
	public var frames:Array<Int>;
	public var type:Int;
		
	public function new(_width:Int, _height:Int, _frames:Array<Int>, _type:Int) {
		width = _width;
		height = _height;
		frames = _frames;
		type = _type;
	}
}
class Enemy extends ST_SuperSprite {
	/** The interpolation for ST_Pathing is highly instable right now. If possible, use ST_AnimatorCommands instead. */
	//public var path:ST_Pathing;
	
	public var enemyFire:ST_Sprite;
	public var enemyBody:ST_Sprite;
	
	//width, height, frames, type
	public static var enemyTypes:Array <EnemyType> = [
		new EnemyType(75, 75, [1,2,3,4,5,6], 1),
		new EnemyType(89, 100, [1,2,3,4], 2),
		new EnemyType(49, 76, [1,2,3,4], 3),
		new EnemyType(79, 125, [1,2,3,4], 4),
		new EnemyType(60, 120, [1,2,3,4], 5),
		new EnemyType(180, 133, [1,2,3,4], 6),
		new EnemyType(186, 175, [1,2,3,4], 7),
		new EnemyType(106, 175, [1,2,3,4], 8),
		new EnemyType(175, 200, [1,2,3,4], 9)
	];
	
	public function new() {
		super();
		
		var enemyType:Int = 4;// Std.random(9);
		
		kinetics.friction = 0.9;
		
		enemyFire = new ST_Sprite();
		enemyFire.setOrigin( -enemyTypes[enemyType].width/2, -enemyTypes[enemyType].height/2);
		enemyFire.animation.addSpriteSheet("img/enemy_0"+Std.string(enemyType+1)+".png", "main", true);
		enemyFire.animation.addAnimationState("main", "main", enemyTypes[enemyType].frames, 5, enemyTypes[enemyType].width, enemyTypes[enemyType].height, true);
		enemyFire.animation.playAnimation(0, "main");
		enemyFire.circleColliderRadius = ((enemyTypes[enemyType].width+enemyTypes[enemyType].height)/2) * 0.5;
		
		enemyBody = new ST_Sprite();
		enemyBody.setOrigin( -enemyTypes[enemyType].width/2, -enemyTypes[enemyType].height/2);
		enemyBody.animation.addSpriteSheet("img/enemy_0"+Std.string(enemyType+1)+".png", "main", true);
		enemyBody.animation.addAnimationState("main", "main", [0], 5, enemyTypes[enemyType].width, enemyTypes[enemyType].height, true);
		enemyBody.circleColliderRadius = ((enemyTypes[enemyType].width+enemyTypes[enemyType].height)/2) * 0.5;
		
		addSpriteChild("enemyFire", enemyFire);
		addSpriteChild("enemyBody", enemyBody);
		//path = new ST_Pathing();
		
		animator.addCommand("enemyAlpha", new ST_AnimatorCommand(enemyFire, new ST_BasicFloatOscillator("alpha", 0.1, 1), 15));
		
		
		var pathX = new ST_RelativeLinearInterpolator("x");
		var pathY = new ST_RelativeLinearInterpolator("y");
		
		switch(enemyTypes[enemyType].type) {
			case 1:
				pathX.push(20, 20);
				pathX.push(40, -20);
				pathY.push(40, 5);
			case 2:
			case 3:
				pathX.push(20, 0);
			case 4:
				pathX.push(20, 0);
			case 5:
				var randomFactor:Float = Math.random();
				
				pathX.push(40, 0);
				pathX.push(50, -20*randomFactor,"easeInOutCubic");
				pathX.push(60, 40*randomFactor,"easeInOutCubic");
				pathX.push(70, -40*randomFactor,"easeInOutCubic");
				pathX.push(80, 20*randomFactor,"easeInOutCubic");
				pathY.push(40, 100,"easeOutElastic");
				pathY.push(80, -50, "easeInCubic");
			case 6:
				pathX.push(20, 0);
			case 7:
				pathX.push(20, 0);
			case 8:
				pathX.push(20, 0);
			case 9:
				pathX.push(20, 0);
		}
		
		if(pathX.length == 0){
			pathX.push(10, 0);
		}if(pathY.length == 0){
			pathY.push(10, 0);
		}
		
		animator.addCommand("enemyMovement1", new ST_AnimatorCommand(this, pathX, pathX.totalFrames()));
		animator.addCommand("enemyMovement2", new ST_AnimatorCommand(this, pathY, pathY.totalFrames()));
	}
	
	public override function update() {
		super.update();
		kinetics.resetAcceleration();
		//kinetics.applyForce(path.getForce());
		animator.animate("enemyMovement1");
		animator.animate("enemyMovement2");
	}
	
	public override function draw() {
		super.draw();
		animator.animate("enemyAlpha");
	}
	
}