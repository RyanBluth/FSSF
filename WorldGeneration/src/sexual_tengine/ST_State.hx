package sexual_tengine;
import flash.display.Sprite;
import flash.display.Stage;
import flash.Lib;
import sexual_tengine.camera.ST_Camera;

/**
 * @author ryan
 */
class ST_State extends Sprite
{
	public var camera:ST_Camera;
	public var game:ST_Game;
	
	public function new(_game:ST_Game){
		super();
		camera = new ST_Camera(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, 1, 1);
		game = _game;
	}
	
	public function update(){
		scrollRect = camera.getFrame();
	}
	
	public function draw(){
		
	}
	
	
}