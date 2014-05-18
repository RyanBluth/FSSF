package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author Ryan
 */
class ST_SuperSpriteAnimator
{
	
	public var commands:Map<String, ST_AnimatorCommand>;
	
	public function new() { 
		commands = new Map();
	}
	
	public function addCommand(commandName:String, command:ST_AnimatorCommand) {
		commands.set(commandName, command);
	}
	
	public function animate(commandName:String) {
		commands.get(commandName).animate();
	}
	
}