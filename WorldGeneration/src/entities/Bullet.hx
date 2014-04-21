package entities;

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