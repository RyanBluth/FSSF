package entities;

/**
 * ...
 * @author ryan
 */
class BulletManager
{
	var bullets:Lambda.Array<Bullet>;
	
	public function new() 
	{
		bullets = new Array();
	}
	
	public function getBullet() {
		if (bullets.length > 0) {
			for (i:Bullet in bullets){
				if (i.alive) {
					
				}
			}
		}
		return new Bullet();
	}
	
}