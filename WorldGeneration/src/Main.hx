package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import haxe.Timer;
import sexual_tengine.input.ST_TouchManager;
import sexual_tengine.ST_Game;

/**
 * ...
 * @author Sean
 */

class Main extends Sprite{
	var inited:Bool;
	var game:ST_Game;
	
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
		
	function init(){
		if (inited) {
			return;
		}
		// (initialization code here)
		
		addChild(game = new ST_Game(new MenuState(game)));
		//inputs
		
		inited = true;
		
	}
	
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = openfl.display.StageScaleMode.SHOW_ALL;
		Lib.current.addChild(new Main());
	}
}
