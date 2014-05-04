package sexual_tengine.utils;
import flash.geom.Point;
import flash.geom.Rectangle;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_SuperSprite;

import sexual_tengine.animation.ST_SpriteSheetHandler;
import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author Sean
 */
class ST_Collision{

	public function new(){
		
	}
	
	public static function circleCollide(obj1:ST_Sprite, obj2:ST_Sprite, ?obj1P:ST_SuperSprite, ?obj2P:ST_SuperSprite):Bool {
		var t1:Point = new Point(obj1.x, obj1.y);
		var t2:Point = new Point(obj2.x, obj2.y);
		var t3 = obj1.getParentOffset(obj1P);
		t1.x += t3.x;
		t1.y += t3.y;
		var t4 = obj2.getParentOffset(obj2P);
		t2.x += t4.x;
		t2.y += t4.y;
		
		return (t2.x-t1.x)*(t2.x-t1.x) + (t2.y-t1.y)*(t2.y-t1.y) <= (obj1.circleColliderRadius+obj2.circleColliderRadius)*(obj1.circleColliderRadius+obj2.circleColliderRadius);
	}
	
	public static function checkCollision(obj1:ST_Sprite, obj2:ST_Sprite, threshold:Int = 0, ?obj1P:ST_SuperSprite, ?obj2P:ST_SuperSprite):Bool {
		var spriteSheetOffset1:Point = new Point();
		var spriteSheetOffset2:Point = new Point();
		if (obj1.animation.getSpriteSheet() != null) {
			spriteSheetOffset1 = obj1.animation.getXY();
		}if (obj2.animation.getSpriteSheet() != null) {
			spriteSheetOffset2 = obj2.animation.getXY();
		}
		var collision:Bool = false;
		var rect1:Rectangle = new Rectangle(obj1.x + obj1.animation.origin.x, obj1.y + obj1.animation.origin.y, obj1.width, obj1.height);
		var rect2:Rectangle = new Rectangle(obj2.x + obj2.animation.origin.x, obj2.y + obj2.animation.origin.y, obj2.width, obj2.height);
		
		//offsets due to sprite nesting
		if (obj1P != null) {
			if (obj1P.superSprite) {
				rect1.x += obj1P.x;
				rect1.y += obj1P.y;
			}
		}if (obj2P != null) {
			if (obj2P.superSprite) {
				rect2.x += obj2P.x;
				rect2.y += obj2P.y;
			}
		}
		
		var collRect:Rectangle = rect1.intersection(rect2);
		trace(rect1, rect2,collRect);
		if (collRect.width == 0 && collRect.height == 0) {
		}else {
			for (x in 0 ... Math.round(collRect.width)) {
				for (y in 0 ... Math.round(collRect.height)) {
					var bx = Math.round(x + collRect.x - rect1.x+spriteSheetOffset1.x);
					var by = Math.round(y + collRect.y - rect1.y+spriteSheetOffset1.y);
					
					var a1:Int;
					if (obj1.animation.getSpriteSheet() != null) {
						a1 = obj1.animation.getBitmapData().getPixel32(bx, by);
					}else {
						a1 = obj1.getBitmap().bitmapData.getPixel32(bx, by);
					}
					
					bx = Math.round(x + collRect.x - rect2.x+spriteSheetOffset2.x);
					by = Math.round(y + collRect.y - rect2.y+spriteSheetOffset2.y);
					
					var a2:Int;
					if (obj2.animation.getSpriteSheet() != null) {
						a2 = obj2.animation.getBitmapData().getPixel32(bx, by);
					}else {
						a2 = obj2.getBitmap().bitmapData.getPixel32(bx, by);
					}
					if ((a1 >> 24 & 0xFF) > threshold && (a2 >> 24 & 0xFF) > threshold) {
						collision = true;
						break;
					}
				}
				if(collision){
					break;
				}
			}
		}
		return collision;
	}
}