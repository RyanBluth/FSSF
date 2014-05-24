package sexual_tengine.ui;
import sexual_tengine.sprite.ST_Sprite;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextFormatAlign;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.text.ST_Text;
import sexual_tengine.ui.ST_UiState;

/**
 * ...
 * @author ryan
 */
class ST_UiComponent extends ST_Sprite
{
	public var backgroundColor:Int;
	
	public var displayWidth:Float;
	public var displayHeight:Float;
	
	public var marginLeft:Float;
	public var marginRight:Float;
	public var marginTop:Float;
	public var marginBottom:Float;
	
	private var currentState:ST_UiState;
	
	private var clickCallback:Void->Void;
	private var downCallback:Void->Void;
	private var overCallback:Void->Void;
	
	
	public function new(_width:Float, _height:Float){
		super();
		displayWidth = _width;
		displayHeight = _height;
		animation.play = false;
	}
	
	public function setBackgroundColour(_color:Int, _alpha:Float) {
		graphics.clear();
		graphics.beginFill(_color,_alpha);
		graphics.drawRect(x, y, displayWidth, displayHeight);
		graphics.endFill();
	}
	
	public function setBackgroundImage(_source:String) {
		graphics.clear();	
		setBitmap(_source);
	}
	
	public override function update() {
		super.update();
		if (parent.mouseX >= x && parent.mouseX <= x + width && parent.mouseY >= y && parent.mouseY <= y + height) {
			if (ST_Mouse.leftJustReleased) {
				currentState = UP;
				if(clickCallback!=null){
					clickCallback();
				}
			}else{
				if (ST_Mouse.leftPressed) {
					currentState = DOWN;
					if(downCallback!=null){
						downCallback();
					}
				}else {
					currentState = FOCUSED;
					if(overCallback != null){
						overCallback();
					}
				}
			}
		}else {
			currentState = UP;
		}
		draw();
	}
	
	public override function draw() {
		super.draw();
	}
	
	public function setMargins(_left:Float, _right:Float, _top:Float, _bottom:Float) {
		marginLeft = _left;
		marginRight = _right;
		marginTop = _top;
		marginBottom = _bottom;
	}
	
		function setButtonClickCallback(value:Void->Void):Void->Void {
		return clickCallback = value;
	}
	
	function setMoueOverCallback(value:Void->Void):Void->Void {
		return overCallback = value;
	
	}
	function setButtonDownCallback(value:Void->Void):Void->Void {
		return downCallback = value;
	}
}

