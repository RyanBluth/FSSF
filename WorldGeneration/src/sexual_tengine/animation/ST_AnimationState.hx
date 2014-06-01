package sexual_tengine.animation;

/**
 * ...
 * @author Ryan
 */

import openfl.display.*;
import openfl.events.*;

class ST_AnimationState{
	public var frames:Array<Int>;
	private var currentFrame:Int;
	public var frameRate:Int;
	private var frameCounter:Float;

	/** No docs yet */
	public function new(framePass:Array<Int>, frameRatePass:Int) 
	{
		frames = framePass;
		frameRate = frameRatePass;
		currentFrame = 0;
		frameCounter = 0;
	}
	
	/** No docs yet */
	public function getCurrentFrame(){
		return frames[currentFrame];
	}
	public function incrementFrames(){
		frameCounter+=STI.corrector;
		while (frameCounter >= frameRate){
			frameCounter -= frameRate;
			currentFrame++;
			if (currentFrame >= frames.length ){
				currentFrame = 0;
			}
		}
	}
	
	/** No docs yet */
	public function setCurrentFrame(_frame:Int) {
		currentFrame = _frame;
		frameCounter = 0;
	}
	
}