package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.Timer;
import input.ST_TouchManager;

import sexual_tengine.ST_Game;

/**
 * ...
 * @author Sean
 */

class Main extends Sprite 
{
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
		
		addChild(game = new ST_Game(new PlayState()));
		stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		//inputs
		new ST_Keyboard();
		inited = true;
		
	}

	public function gameLoop():Void {
		playState.update();
		playState.draw();
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
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
