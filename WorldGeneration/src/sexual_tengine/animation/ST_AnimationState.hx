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

	/**
	 * Creates a new animation state
	 * @param	framePass		Array of frames to use for the state
	 * @param	frameRatePass	Default framerate
	 */
	public function new(_frames:Array<Int>, _frameRate:Int){
		frames = _frames;
		frameRate = _frameRate;
		currentFrame = 0;
		frameCounter = 0;
	}
	
	/** Returns the current frame */
	public function getCurrentFrame():Int{
		return frames[currentFrame];
	}
	/** Increases the current counter by the deltaTime-corrected value and advances the current frame accordingly. */
	public function incrementFrames():Void{
		frameCounter += STI.corrector;
		while (frameCounter >= frameRate){
			frameCounter -= frameRate;
			currentFrame++;
			if (currentFrame >= frames.length ){
				currentFrame = 0;
			}
		}
	}
	
	/** Sets the current frame (also resets the counter for incrementing frames */
	public function setCurrentFrame(_frame:Int):Void{
		currentFrame = _frame;
		frameCounter = 0;
	}
}