package sexual_tengine.sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
/**
 * ...
 * @author Ryan
 */
class ST_SoundManager
{

	public var sounds:Map<String, ST_Sound>;
	
	public function new() {
		sounds = new Map<String,ST_Sound>();
	}
	
	public function addSound(_source:String, _name:String) {
		sounds.set(_name, new ST_Sound(_source));
	}
	
	public function stopSound(_name:String) {
		sounds.get(_name).stop();
	}
	
	public function playSound(_name:String, _position:Int, _loops:Int,_soundTransform:SoundTransform = null) {
		sounds.get(_name).play(_position,_loops, _soundTransform);
	}
	
	public function fadeOutSound(_name:String, _durationMillis:Int) {
		sounds.get(_name).fadeOut(_durationMillis);
	}
	
	public function fadeInSound(_name:String, _durationMillis:Int, _position:Int, _loops:Int, _soundTransform:SoundTransform = null) {
		sounds.get(_name).fadeIn(_durationMillis, _position, _loops,_soundTransform);
	}
}