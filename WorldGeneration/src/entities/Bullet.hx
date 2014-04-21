package entities;

import sexual_tengine.sprite.ST_Sprite;
/**
 * ...
 * @author ryan
 */
class Bullet extends ST_Sprite
{
	public var alive:Bool;
	public var damage:Int;
	
	public function new(_resource:String) 
	{
		super(_resource);
	}
}