package sexual_tengine.ui;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author ryan
 */
class ST_UiComponent extends ST_Sprite
{
	public var backgroundColor:Int;
	public var bgWidth:Float;
	public var bgHeight:Float;
	
	public function new(_width:Float, _height:Float){
		super();
		bgWidth = _width;
		bgHeight = _height;
		animation.play = false;
	}
	
	public function setBackgroundColour(_color:Int, _alpha:Float) {
		graphics.clear();
		graphics.beginFill(_color,_alpha);
		graphics.drawRect(x, y, bgWidth, bgHeight);
		graphics.endFill();
	}
	
	public function setBackgroundImage(_source:String) {
		setBitmap(_source);
	}
	
	public override function update() {
		super.update();	
	}
	
	public override function draw() {
		super.draw();
	}
	
}