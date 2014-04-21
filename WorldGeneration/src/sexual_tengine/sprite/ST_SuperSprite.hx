package sexual_tengine.sprite;

import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.animation.ST_SpriteSheet;
/**
 * ...
 * @author ryan
 */
class ST_SuperSprite extends ST_Detachment
{
	public var spriteChildren:Map<ST_Sprite>;
	
	public function new() {
		super();
		spriteChildren = new Map();
	}
	
	public function addSpriteChild(_name:String, _sprite:ST_Sprite) {
		spriteChildren.set(_name, _sprite);
	}
	
	public function getSpriteChild(_name:String):ST_Sprite{
		return spriteChildren.get(_name);
	}
}