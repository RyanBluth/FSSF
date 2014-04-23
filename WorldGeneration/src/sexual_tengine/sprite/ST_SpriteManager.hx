package sexual_tengine.sprite;
import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author ryan
 */
class ST_SpriteManager
{
	public var spriteArray:Array<ST_Sprite>;
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
		for (i in spriteArray) {
			if (!i.active) {
				i.reactivate();
				return i;
				break;
			}
		}
		var temp = Type.createInstance(spriteClass, constructorParams);
		spriteArray.push(temp);
		return temp;
	}
	
	public function reset() {
		spriteArray = new Array();
	}
}