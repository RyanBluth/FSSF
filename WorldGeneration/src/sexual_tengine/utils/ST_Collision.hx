package sexual_tengine.utils;
import flash.geom.Point;
import flash.geom.Rectangle;
import sexual_tengine.sprite.ST_Detachment;
import sexual_tengine.sprite.ST_SpriteManager;
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
	
	/**
	 * Checks for collisions between one sprite and the members of a sprite manager. Returns an array containing any sprites that it collides with.
	 * @param	obj1	Sprite to check collisions against
	 * @param	obj2	Sprite manager to check collisions in
	 * @param	?obj1P	Parent of sprite to use for calculating offsets
	 * @return	Array containing any sprites that it collides with
	 */
	public static function spriteManagerCollide(obj1:ST_Sprite, obj2:ST_SpriteManager, ?obj1P:ST_SuperSprite):Array < ST_Sprite > {
		// Verify that there are non-zero radii
		if (obj1.circleColliderRadius == 0 || obj2.circleColliderRadius == 0) {
			ST_Logger.throwAndLog("Tried to use grid-based circle-collision without a circleColliderRadius for "+obj1.toString());
		}
		var pos:Point = obj1.getParentOffset(obj1P);
		var res:Array<ST_Sprite> = new Array<ST_Sprite>();
		
		var x = (pos.x - obj1.circleColliderRadius);
		x -= (x % obj2.circleColliderRadius);
		while(x <= (pos.x + obj1.circleColliderRadius)) {
			var y = (pos.y - obj1.circleColliderRadius);
			y -= (y % obj2.circleColliderRadius);
			while(y <= (pos.y + obj1.circleColliderRadius)) {
				var idx = ("x"+((x - (x % obj2.circleColliderRadius))/obj2.circleColliderRadius) + "y"+(((y - (y % obj2.circleColliderRadius))/obj2.circleColliderRadius)));
				if (obj2.collisionGrid.exists(idx)) {
					for (i in obj2.collisionGrid.get(idx)) {
						if (circleCollide(obj1, i, obj1P)) {
							res.push(i);
						}
					}
				}
				y += obj2.circleColliderRadius;
			}
			x += obj2.circleColliderRadius;
		}
		
		/*var idx = ("x"+((t3.x - (t3.x % obj2.circleColliderRadius))/obj2.circleColliderRadius) + "y"+(((t3.y - (t3.y % obj2.circleColliderRadius))/obj2.circleColliderRadius)));
		if (obj2.collisionGrid.exists(idx)) {
			for (i in obj2.collisionGrid.get(idx)) {
				if (circleCollide(obj1, i, obj1P)) {
					res.push(i);
				}
			}
		}*/
		return res;
	}
	
	/**
	 * Checks for collision between two sprites (taking into account their parent offsets up to the supplied parents) based on their circle colliders
	 * @param	obj1	Sprite to check collision against
	 * @param	obj2	Sprite to check collision against
	 * @param	?obj1P	Parent to calculate offsets for obj1
	 * @param	?obj2P	Parent to calculate offsets for obj2
	 * @return	True if sprites' circle colliders are colliding, false otherwise.
	 */
	public static function circleCollide(obj1:ST_Sprite, obj2:ST_Sprite, ?obj1P:ST_SuperSprite, ?obj2P:ST_SuperSprite):Bool {
		//initialize offsets to zero
		var offset1:Point = new Point();
		var offset2:Point = new Point();
		//if a parent was supplied, calculate the offsets
		if (obj1P != null) {
			offset1 = obj1.getParentOffset(obj1P);
		}if (obj2P != null) {
			offset2 = obj2.getParentOffset(obj2P);
		}
		
		//get the sprite positions + offsets
		var pos1:Point = new Point(obj1.x+offset1.x, obj1.y+offset1.y);
		var pos2:Point = new Point(obj2.x+offset2.x, obj2.y+offset2.y);
		
		//check for collision using Euclidean distance
		return (pos2.x-pos1.x)*(pos2.x-pos1.x) + (pos2.y-pos1.y)*(pos2.y-pos1.y) <= (obj1.circleColliderRadius+obj2.circleColliderRadius)*(obj1.circleColliderRadius+obj2.circleColliderRadius);
	}
	
	/**
	 * Checks for collision between two sprites (taking into account their parent offsets up to the supplied parents) based on the alpha of their pixels
	 * @param	obj1		Sprite to check collision against
	 * @param	obj2		Sprite to check collision against
	 * @param	threshold	Alpha threshold for pixels (0-255)
	 * @param	?obj1P		Parent to calculate offsets for obj1
	 * @param	?obj2P		Parent to calculate offsets for obj2
	 * @return	True if sprites' circle colliders are colliding, false otherwise.
	 */
	public static function pixelPerfectCollide(obj1:ST_Sprite, obj2:ST_Sprite, threshold:Int = 0, ?obj1P:ST_SuperSprite, ?obj2P:ST_SuperSprite):Bool {
		//initialize offsets to zero
		var spriteSheetOffset1:Point = new Point();
		var spriteSheetOffset2:Point = new Point();
		var offset1:Point = new Point();
		var offset2:Point = new Point();
		//if graphics are spritesheet based, calculate the offsets
		if (obj1.animation.getSpriteSheet() != null) {
			spriteSheetOffset1 = spriteSheetOffset1 = obj1.animation.getXY();
		}if (obj2.animation.getSpriteSheet() != null) {
			spriteSheetOffset2 = obj2.animation.getXY();
		}
		//if a parent was supplied, calculate the offsets
		if (obj1P != null) {
			offset1 = obj1.getParentOffset(obj1P);
		}if (obj2P != null) {
			offset2 = obj2.getParentOffset(obj2P);
		}
		
		var collision:Bool = false;
		
		//get the rectangles based on sprite positions, spritesheet origins, offsets, and widths/heights
		var rect1:Rectangle = new Rectangle(obj1.x + obj1.animation.origin.x + offset1.x, obj1.y + obj1.animation.origin.y + offset1.y, obj1.width, obj1.height);
		var rect2:Rectangle = new Rectangle(obj2.x + obj2.animation.origin.x + offset2.x, obj2.y + obj2.animation.origin.y + offset2.y, obj2.width, obj2.height);
		
		var collRect:Rectangle = rect1.intersection(rect2);
		
		//no need to check pixels if rectangle has no area
		if (collRect.width != 0 || collRect.height != 0) {
			//loop through pixels of collision rectangle
			for (x in 0 ... Math.round(collRect.width)) {
				for (y in 0 ... Math.round(collRect.height)) {
					var tempX = Math.round(x + collRect.x - rect1.x+spriteSheetOffset1.x);
					var tempY = Math.round(y + collRect.y - rect1.y+spriteSheetOffset1.y);
					
					var a1:Int;
					if(obj1.animation.getSpriteSheet() != null){
						a1 = obj1.animation.getBitmapData().getPixel32(tempX, tempY);
					}else{
						a1 = obj1.getBitmap().bitmapData.getPixel32(tempX, tempY);
					}
					
					tempX = Math.round(x + collRect.x - rect2.x+spriteSheetOffset2.x);
					tempY = Math.round(y + collRect.y - rect2.y+spriteSheetOffset2.y);
					
					var a2:Int;
					if (obj2.animation.getSpriteSheet() != null) {
						a2 = obj2.animation.getBitmapData().getPixel32(tempX, tempY);
					}else {
						a2 = obj2.getBitmap().bitmapData.getPixel32(tempX, tempY);
					}
					if ((a1 >> 24 & 0xFF) > threshold && (a2 >> 24 & 0xFF) > threshold) {
						collision = true;
						break; //only need to know whether there was a collision, so no need to keep looping
					}
				}
				if(collision){
					break; //only need to know whether there was a collision, so no need to keep looping
				}
			}
		}
		return collision;
	}
}