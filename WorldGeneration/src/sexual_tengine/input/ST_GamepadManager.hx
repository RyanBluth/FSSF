package sexual_tengine.input;

import lime.ui.Gamepad;
import lime.ui.GamepadAxis;
import lime.ui.GamepadButton;
import sexual_tengine.utils.ST_Logger;

/** Class for instantiating individual gamepad objects */
class ST_Gamepad {
	/** Currently pressed buttons */
	public var pressedButtons:Map<Int,Int>;
	/** Buttons pressed last frame */
	public var justPressedButtons:Map<Int,Int>;
	/** Buttons released last frame */
	public var justReleasedButtons:Map<Int,Int>;
	/** Last button released */
    public var lastButtonUp:Int;
	/** Array of axis positions */
	public var axes:Array<Float>;
	/** Controller */
	public var gamepad:Gamepad;

	
	public function new(gamepad:Gamepad){
		pressedButtons = new Map<Int,Int>();
		justPressedButtons = new Map<Int,Int>();
		justReleasedButtons = new Map<Int,Int>();
		axes = new Array<Float>();
		this.gamepad = gamepad;
	}
}

/** Class for handling gamepads. <strong>Requires that a GamepadManager object be initialized before the static members will be of any use.</strong> */
class ST_GamepadManager{
	public static var numPads:Int = 0;
	/** Array of gamepads */
	public static var pads:Map<Int,ST_Gamepad> = new Map<Int,ST_Gamepad>();
	
	/** Currently pressed Buttons */
	private static var pressedButtons:Map<Int,String> = new Map<Int,String>();
	/** Buttons pressed last frame */
	private static var justpressedButtons:Map<Int,String> = new Map<Int,String>();
	/** Buttons released last frame */
	private static var justReleasedButtons:Map<Int,String> = new Map<Int,String>();
	
		public function new() {
			// add existing gamepads
			for (g in Gamepad.devices){
				onGamepadConnect(g);
			}
			// listen for new gamepads
			Gamepad.onConnect.add(onGamepadConnect);
		}

		private function onGamepadConnect(gamepad:Gamepad):Void{
			var g:ST_Gamepad = addController(gamepad);
			trace("GAMEPAD CONNECTED:" + gamepad.id + " " + gamepad.name);
			gamepad.onAxisMove.add(onAxisMove.bind(g));
			gamepad.onButtonDown.add(onButtonDown.bind(g));
			gamepad.onButtonUp.add(onButtonUp.bind(g));
			gamepad.onDisconnect.add(onGamepadDisconnect.bind(g));
		}

		private function onGamepadDisconnect (g:ST_Gamepad):Void {
				trace('gamepad ' + g.gamepad.id + ' disconnected');
		}
		
		private static function onButtonDown(g:ST_Gamepad, button:GamepadButton) {
			if (!g.pressedButtons.exists(button)){
				g.pressedButtons.set(button, button);
				g.justPressedButtons.set(button, button);
			}
		}
		private static function onButtonUp(g:ST_Gamepad, button:GamepadButton) {
			g.pressedButtons.remove(button);
			g.justReleasedButtons.set(button,button);
			g.lastButtonUp = button;
		}
		private static function onAxisMove(g:ST_Gamepad, axis:GamepadAxis, value:Float) {
			g.axes[axis] = value;
		}
	
	/** Clears justPressedButtons and justReleasedButtons on ENTER_FRAME. */
	public static function clearJust() {
		for(pad in pads){
			for (button in pad.justPressedButtons) {
				pad.justPressedButtons.remove(button);
			}
			for (button in pad.justReleasedButtons) {
				pad.justReleasedButtons.remove(button);
			}
		}
	}
	
	
	
	/** Adds a gamepad to the pads array 
	 * @param	device	Controller id, <em>Defaults to ST_GamepadManager.numPads</em>*/
	public static function addController(gamepad:Gamepad):ST_Gamepad {
		var g:ST_Gamepad = null;
		if (!pads.exists(gamepad.id)) {
			g = new ST_Gamepad(gamepad);
			pads.set(gamepad.id, g);
			numPads += 1;
		}else {
			g = pads.get(gamepad.id);
			ST_Logger.log("ERROR: Gamepad device '" + gamepad + "' already exists");
		}
		return g;
	}
	
	/**
	 * If any of the buttons in the given array are pressed, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args	An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args are currently pressed, false otherwise.
	*/
	public static function isPressed(device:Int, args:Array<String>):Bool {
		var res:Bool = false;
		var i:String;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).pressedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the buttons in the given array was pressed in the last frame, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just pressed, false otherwise.
	*/
	public static function isJustPressed(device:Int, args:Array<String>):Bool {
		var res:Bool = false;
		var i:String;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).justPressedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the buttons in the given array was released in the last frame, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just released, false otherwise.
	*/
	public static function isJustReleased(device:Int, args:Array<String>):Bool {
		var res:Bool = false;
		var i:String;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).justReleasedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * Compares a given axis on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for axis array. <em>Use the shortcuts in the XboxAxes for this.</em>
	 * @param	threshold	Threshold to check axis against. Values 0 to 1.
	 * @return	True if axis is below the given thershold for the device, false otherwise
	 */
	public static function axisIsBelow(device:Int, axis:String, threshold:Float):Bool {
		var res:Bool = false;
		res = pads.get(device).axes[XboxAxes[axis]] < threshold;
		return res;
	}
	/**
	 * Compares a given axis on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for axis array. <em>Use the shortcuts in the XboxAxes for this.</em>
	 * @param	threshold	Threshold to check axis against. Values 0 to 1.
	 * @return	True if axis is above the given thershold for the device, false otherwise
	 */
	public static function axisIsAbove(device:Int, axis:String, threshold:Float):Bool {
		var res:Bool = false;
		res = pads.get(device).axes[XboxAxes[axis]] > threshold;
		return res;
	}
	
	
	/** Contains A, B, X, Y, L1, R1, SELECT, START, L3, R3. <em>L3 and R3 are when you press on the sticks.</em>*/
	public static var XboxButtons:Map<String, Int> = [
		"A"			=>	0,
		"B"			=>	1,
		"X"			=>	2,
		"Y"			=>	3,
		"L1"		=>	4,
		"R1"		=>	5,
		"SELECT"	=>	6,
		"START"		=>	7,
		"L3"		=>	8,
		"R3"		=>	9];
	/** Contains LX, LY, RX, RY, TRIGGERS. */
	public static var XboxAxes:Map<String, Int> = [
		"LX"		=>	0,
		"LY"		=>	1,
		"RX"		=>	4,
		"RY"		=>	3,
		"TRIGGERS"	=>	2];
	/** Contains X, Y. <em>The hat is the d-pad.</em> */
	public static var XboxHat:Map<String, Int> = [
		"X"		=>	0,
		"Y"		=>	1];
}