package sexual_tengine.sound;

import haxe.Timer;
import openfl.Assets;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.net.URLRequest;

/**
 * ...
 * @author Ryan
 */
class ST_Sound extends Sound
{
	private var channel:SoundChannel;
	private var fadeTimer:Timer;
	private var fadeFactor:Float;
	
	public function new(_source:String) {	
		super();
		load(new URLRequest(_source));
	}
	
	public function stop() {
		channel.stop();
		channel = null;
	}
	
	public override function play(_startTime:Float = 0, _loops:Int = 0, _soundTransform:SoundTransform = null):SoundChannel{
		if (_soundTransform == null) {
			_soundTransform = new SoundTransform();
		}
		channel = super.play(_startTime,_loops, _soundTransform);
		return channel;
	}
	
	public function fadeOut(_durationMillis:Int) {
		if(fadeTimer == null){
			fadeFactor = (5 / _durationMillis) * -1;
			fadeTimer = new Timer(5);
			fadeTimer.run = fade;
		}
	}
	
	public function fadeIn(_durationMillis:Int,_startTime:Float = 0, _loops:Int = 0, _soundTransform:SoundTransform = null) {
		if(fadeTimer == null){
			if (channel != null) {
				channel.stop();
			}
			if (_soundTransform == null) {
				_soundTransform = new SoundTransform(0,0);
			}
			play(_startTime,_loops,_soundTransform);
			fadeFactor = (5 / _durationMillis);
			fadeTimer = new Timer(5);
			fadeTimer.run = fade;
		}
	}
	
	private function fade() {
		var transform:SoundTransform = channel.soundTransform;
		transform.volume += fadeFactor;
		channel.soundTransform = transform;
		if (channel.soundTransform.volume > 1) {
			channel.soundTransform.volume = 1;
			fadeInComplete();
		}
		if (channel.soundTransform.volume <= 0) {
			fadeOutComplete();
		}
	}
	
	private function fadeInComplete() {
		fadeTimer.stop();
		fadeTimer = null;
	}
	
	private function fadeOutComplete() {
		fadeTimer.stop();
		fadeTimer = null;
		channel.stop();
	}
}