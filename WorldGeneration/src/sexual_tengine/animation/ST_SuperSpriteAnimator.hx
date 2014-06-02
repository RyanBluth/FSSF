package sexual_tengine.animation;
import sexual_tengine.sprite.ST_Sprite;
import sexual_tengine.utils.ST_Logger;

/**
 * ...
 * @author Ryan
 */
class ST_SuperSpriteAnimator{
	public var commands:Map<String, ST_AnimatorCommand>;
	public function new() { 
		commands = new Map();
	}
	
	public function addCommand(commandName:String, command:ST_AnimatorCommand) {
		commands.set(commandName, command);
	}
	
	public function animate(commandName:String) {
		if(commands.exists(commandName)){
			commands.get(commandName).animate();
		}else {
			ST_Logger.throwAndLog("Called 'animate' using non-existent command '" + commandName + "'");
		}
	}
}