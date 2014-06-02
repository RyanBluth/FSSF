package sexual_tengine;

import openfl.Lib;
import openfl.events.Event;
import openfl.display.DirectRenderer;
import sexual_tengine.STI;

import openfl.display.Sprite;
import sexual_tengine.input.ST_Keyboard;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.input.ST_GamepadManager;
import sexual_tengine.input.ST_TouchManager;

/**
 * ...
 * @author ryan
 */
@:access(sexual_tengine.STI)
class ST_Game extends Sprite {
	
	private var ticks:Int = 0;
	private var currentState:ST_State;
	private var pendingState:ST_State;
	public function new(_startState:ST_State) {
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
		
		currentState = _startState;
		currentState.game = this;
		
		addChild(currentState);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		
	}
	private var accumulator:Float = 0;
	private var t:Float = 0;
	public function update(evt:Event) {
		if (pendingState != null) {
			removeChild(currentState);
			currentState = pendingState;
			addChild(currentState);
			pendingState = null;
		}
		STI.timeStamp = Lib.getTimer();
		STI.deltaTime = (STI.timeStamp - STI.elapsedTime);
		STI.corrector = STI.deltaTime / STI.target;
		STI.elapsedTime = STI.timeStamp;
		accumulator += STI.deltaTime;
		
		while (accumulator >= STI.timeStep) {
			//playState.update();
			//playState.draw();
			accumulator -= STI.timeStep;
			t += STI.timeStep;
		}
		currentState.update();
		currentState.draw();
		
		ST_Mouse.clearJust();
		#if !flash
		ST_GamepadManager.clearJust();
		#end
		ST_Keyboard.clearJust();
	}
	
	public function setCurrentState(_state:ST_State) {
		pendingState = _state;
	}
}