package sexual_tengine.sprite;
import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author ryan
 */
class ST_SpriteManager
{
	var spriteArray:Array<ST_Sprite>;
	var spriteClass:Dynamic;	
	var constructorParams:Array<Dynamic>;
	
	public function new(_spriteClass:Dynamic, ?_constructorParams:Array<Dynamic>) 
	{
		spriteArray = new Array();
		spriteClass = _spriteClass;
		if(_constructorParams != null){
			constructorParams = _constructorParams;
		}else {
			constructorParams = new Array<Dynamic>();
		}
	}
	
	public function getActiveSprite():ST_Sprite {
		
		if (spriteArray.length > 0) {
			for (i in spriteArray) {
				if (!i.active) {
					return i;
					break;
				}
			}
			return Type.createInstance(spriteClass,constructorParams);
			
		}else {
			return Type.createInstance(spriteClass,constructorParams);
		}
	}
	
	public function reset() {
		spriteArray = new Array();
	}
}