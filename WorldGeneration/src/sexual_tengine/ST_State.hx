package sexual_tengine;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.Lib;
import openfl.display.DisplayObject;
import sexual_tengine.camera.ST_Camera;
import openfl.display.DisplayObjectContainer;
import sexual_tengine.sprite.ST_Detachment;

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