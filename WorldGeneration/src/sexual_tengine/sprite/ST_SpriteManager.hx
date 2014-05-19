package sexual_tengine.sprite;
import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author ryan
 */
class ST_SpriteManager{
	public var spriteArray:Array<ST_Sprite>;
	public var collisionGrid:Map<String,Array<ST_Sprite>>;
	public var circleColliderRadius:Float;
	
	var spriteClass:Dynamic;	
	var constructorParams:Array<Dynamic>;
	public function new(_spriteClass:Dynamic, ?_constructorParams:Array<Dynamic>){
		spriteArray = new Array();
		spriteClass = _spriteClass;
		if(_constructorParams != null){
			constructorParams = _constructorParams;
		}else{
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
	
	public function updateGrid() {
		collisionGrid = new Map<String,Array<ST_Sprite>>();
		/*for (i in collisionGrid.keys()) {
			collisionGrid.set(i,new Array());
		}*/
		for (i in spriteArray) {
			if(i.active){
				var idx = ("x"+((i.x - (i.x % circleColliderRadius))/circleColliderRadius) + "y"+(((i.y - (i.y % circleColliderRadius))/circleColliderRadius)));
				if (!collisionGrid.exists(idx)) {
					collisionGrid.set(idx, new Array<ST_Sprite>());
				}
				collisionGrid.get(idx).push(i);
			}//Math.fmo
			//i.x
		}
	}
	
	public function toString():String {
		return "ST_SpriteManager of type '" + spriteClass.toString()+"'";
	}
}