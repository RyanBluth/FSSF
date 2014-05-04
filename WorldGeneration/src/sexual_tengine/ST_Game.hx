package sexual_tengine;

import flash.Lib;
import flash.events.Event;
import openfl.display.DirectRenderer;
import sexual_tengine.STI;

import flash.display.Sprite;
import sexual_tengine.input.ST_Keyboard;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.input.ST_GamepadManager;
import sexual_tengine.input.ST_TouchManager;

/**
 * ...
 * @author ryan
 */
class ST_Game extends Sprite {
	private var ticks:Int = 0;
	private var playState:ST_State;
	public function new(_playState:ST_State) {
		super();
		//inputs
		new ST_Keyboard();
		
		#if mobile
			new ST_TouchManager();
		#else
			new ST_Mouse();
		#end
		
		#if !flash
			new ST_GamepadManager();
		#end
		
		playState = _playState;
		addChild(playState);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		
	}
	private var accumulator:Float = 0;
	private var t:Float = 0;
	public function update(evt:Event) {
		ticks = Lib.getTimer();
		STI.deltaTime = (ticks - STI.elapsedTime);
		STI.corrector = STI.deltaTime / STI.target;
		STI.elapsedTime = ticks;
		accumulator += STI.deltaTime;
		
		while (accumulator >= STI.timeStep) {
			//playState.update();
			//playState.draw();
			accumulator -= STI.timeStep;
			t += STI.timeStep;
		}
		playState.update();
		playState.draw();
		
		ST_Mouse.clearJust();
		#if !flash
		ST_GamepadManager.clearJust();
		#end
		ST_Keyboard.clearJust();
	}
}