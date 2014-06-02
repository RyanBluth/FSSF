package sexual_tengine.layers;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.Lib;
import sexual_tengine.STI;
/**
 * ...
 * @author ryan
 */
class ST_Background extends Sprite
{
	var bitmapOne:Bitmap;
	var bitmapTwo:Bitmap;
	public var speed:Int;
	
	public function new(_resource:String, _width:Float, _height:Float, ?_scrollable:Bool, ?_speed:Int){
		super();
		bitmapOne = new Bitmap(Assets.getBitmapData(_resource));
		//ST_Logger.log(_width,_height);
		/*if (bitmapOne.width < bitmapOne.height){
			bitmapOne.scaleX = _width / _height;
			bitmapOne.scaleY = bitmapOne.scaleX;
		}else {
			bitmapOne.scaleY = _height / _width;
			bitmapOne.scaleX = bitmapOne.scaleY;
		}*/
		
		if (_scrollable){
			bitmapTwo = new Bitmap(Assets.getBitmapData(_resource));
			//bitmapTwo.scaleX = bitmapTwo.scaleY = bitmapOne.scaleX;
			bitmapTwo.scaleY = bitmapOne.scaleY;
			bitmapTwo.scaleX = bitmapTwo.scaleY;
			bitmapTwo.y = -bitmapOne.height;
		}
		if(_speed != null && _speed!= 0){
			speed = _speed;
		}else{
			speed = 1;
		}
		bitmapOne.y = 0;
		addChild(bitmapOne);
		addChild(bitmapTwo);
	}
	
	public function update() {
		bitmapOne.y += speed * STI.corrector;
		bitmapTwo.y += speed * STI.corrector;
		if (bitmapOne.y >= bitmapOne.height) {
			bitmapOne.y = bitmapTwo.y-bitmapOne.height;
		}
		if (bitmapTwo.y >= bitmapTwo.height) {
			bitmapTwo.y = bitmapOne.y-bitmapTwo.height;
		}
	}
}