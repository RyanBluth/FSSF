package sexual_tengine.input;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;
import Map;

/** Utility class for keyboard input. <strong>Requires that a KeyboardUtil object be initialized before the static members will be of any use.</strong> */
class ST_Keyboard{
	
	/** Currently pressed keys */
	private static var pressedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Keys pressed last frame */
	private static var justPressedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Keys released last frame */
	private static var justReleasedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Last key released */
    private static var lastKeyUp:Int;
	
	/** Access flash key codes using strings <em>(Includes everything but numpad keys and key combinations)</em> */
	public static var keyStrings:Map < String, Int > = [
	"PGUP"	=>	33, "PAGE UP" => 33,
	"PGDN"	=>	34, "PAGE DOWN" => 34,
	"END"	=>	35,
	"HOME"	=>	36,
	"LEFT"	=>	37,
	"RIGHT"	=>	39,
	"UP"	=>	38,
	"DOWN"	=>	40,
	"0"		=>	48,
	"1"		=>	49,
	"2"		=>	50,
	"3"		=>	51,
	"4"		=>	52,
	"5"		=>	53,
	"6"		=>	54,
	"7"		=>	55,
	"8"		=>	56,
	"9"		=>	57,
	"A"		=>	65,
	"B"		=>	66,
	"C"		=>	67,
	"D"		=>	68,
	"E"		=>	69,
	"F"		=>	70,
	"G"		=>	71,
	"H"		=>	72,
	"I"		=>	73,
	"J"		=>	74,
	"K"		=>	75,
	"L"		=>	76,
	"M"		=>	77,
	"N"		=>	78,
	"O"		=>	79,
	"P"		=>	80,
	"Q"		=>	81,
	"R"		=>	82,
	"S"		=>	83,
	"T"		=>	84,
	"U"		=>	85,
	"V"		=>	86,
	"W"		=>	87,
	"X"		=>	88,
	"Y"		=>	89,
	"Z"		=>	90,
	"SPACE"	=>	32, "SPACEBAR" => 32,
	"BACKSPACE"	=>	8,
	"ENTER"	=>	13, "RETURN" => 13,
	"SHIFT"	=>	16,
	"CTRL"	=>	17,
	"WIN"	=>	15,
	"ALT"	=>	18,
	"CAPS"	=>	20, "CAPSLOCK" => 20,
	"NUM"	=>	144, "NUMLOCK" => 144,
	"ESC"	=>	27, "ESCAPE" => 27,
	"PAUSE"	=>	10,
	"PRTSC"	=>	301, "PRINT SCREEN" => 301,
	"DELETE"=>	46,
	"F1"	=>	80,
	"F2"	=>	81,
	"F3"	=>	82,
	"F4"	=>	83,
	"F5"	=>	84,
	"F6"	=>	85,
	"F7"	=>	86,
	"F8"	=>	87,
	"F9"	=>	88,
	"F10"	=>	89,
	"F11"	=>	90,
	"F12"	=>	123,
	"~"	=>	192, "TILDE" => 192,
	"TAB"	=>	9,
	"-"		=>	189, "MINUS" => 189, "DASH" => 189,
	"="		=>	187, "EQUALS" => 187,
	"["		=>	219, "LEFT BRACKET" => 219,
	"]"		=>	221, "RIGHT BRACKET" => 221,
	"\\"	=>	220, "FORWARD SLASH" => 220,
	";"		=>	186, "SEMICOLON" => 186,
	","		=>	188, "COMMA" => 188,
	"."		=>	190, "PERIOD" => 190, "DOT" => 190,
	"/"		=>	191, "BACK SLASH" => 191,
	"RIGHT CLICK" => 302];
	
	/** Attaches event listeners so that the static stuff actually works. */
	public function new(){
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, ST_Keyboard.keyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, ST_Keyboard.keyUp);
	}
	
	/** Adds a pressed key to the map of pressedKeys and justPressedKeys. */
	private static function keyDown(evt:KeyboardEvent) {
		if (!pressedKeys.exists(evt.keyCode)){
			pressedKeys.set(evt.keyCode, evt.keyCode);
			justPressedKeys.set(evt.keyCode, evt.keyCode);
		}
	}
	
	/** Removes and adds a pressed key from the map of pressedKeys and justReleasedKeys, respectively. */
	private static function keyUp(evt:KeyboardEvent){
		pressedKeys.remove(evt.keyCode);
		justReleasedKeys.set(evt.keyCode,evt.keyCode);
		lastKeyUp = evt.keyCode;
	}
	
	/** Clears justPressedKeys and justReleasedKeys on ENTER_FRAME. */
	public static function clearJust(){
		for (key in justPressedKeys.keys()) {
			justPressedKeys.remove(key);
		}
		for (key in justReleasedKeys.keys()) {
			justReleasedKeys.remove(key);
		}
	}
	
	/** Returns all keys currently pressed as a map. */
	public static function getPressedKeys():Map<Int,Int> {
		return pressedKeys;
	}
	
	/** Returns all keys pressed in the last frame as a map. */
	public static function getJustPressedKeys():Map<Int,Int> {
		return justPressedKeys;
	}
	
	/** Returns all keys released in the last frame as a map. */
	public static function getJustReleasedKeys():Map<Int,Int> {
		return justReleasedKeys;
	}

	/**  Returns the last key released. */
    public static function getLastKeyUp():Int{
        return lastKeyUp;
    }
	
	
	
	
	
	/**
	 * If any of the keys in the given array are pressed, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args are currently pressed, false otherwise.
	*/
	public static function isPressed(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (pressedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the keys in the given array was pressed in the last frame, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just pressed, false otherwise.
	*/
	public static function isJustPressed(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (justPressedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the keys in the given array was released in the last frame, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just released, false otherwise.
	*/
	public static function isJustReleased(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (justReleasedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
}