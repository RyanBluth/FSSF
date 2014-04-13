package ;
import flash.display.Sprite;
import flash.display.Stage;
import flash.Lib;
import camera.ST_Camera;

/**
 * @author ryan
 */
class ST_State extends Sprite
{
	public var camera:ST_Camera;
	
	public function new(stage:Stage){
		super();
		camera = new camera.ST_Camera(0, 0, stage.stageWidth, stage.stageHeight, 1, 1);
	}
	
	public function update(){
		scrollRect = camera.getFrame();
	}
	
	public function draw(){
		
	}
	
	
}