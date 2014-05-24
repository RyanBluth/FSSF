package sexual_tengine.ui;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextFormatAlign;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.text.ST_Text;

/**
 * ...
 * @author ryan
 */
class ST_UiButton extends ST_UiComponent
{	
	private var standardState:String;
	private var mouseDownState:String;
	private var mouseOverState:String;
	private var currentState:ST_ButtonState;

	private var clickCallback:Void->Void;
	private var downCallback:Void->Void;
	private var overCallback:Void->Void;
	
	public var label:ST_Text;
	
	public function new(_width:Float, _height:Float){
		
		super(_width, _height);
		label = new ST_Text();
		addChild(label);
		standardState = ST_UiConstants.BUTTON_UP_SOURCE;
		mouseOverState = ST_UiConstants.BUTTON_FOCUSED_SOURCE;
		mouseDownState = ST_UiConstants.BUTTON_DOWN_SOURCE;
		
		currentState = UP;
		
		setBitmap(standardState);
	}
	
	public function setButtonState(_state:ST_ButtonState, _source:String) {
		switch _state {
			case UP: standardState = _source;
			case FOCUSED: mouseOverState = _source;
			case DOWN: mouseDownState = _source;
		}
	}
	
	public override function update() {
		super.update();
		if (parent.mouseX >= x && parent.mouseX <= x + width && parent.mouseY >= y && parent.mouseY <= y + height) {
			if (ST_Mouse.leftJustReleased) {
				currentState = UP;
				label.format.size = 20.5;
				if(clickCallback!=null){
					clickCallback();
				}
			}else{
				if (ST_Mouse.leftPressed) {
					currentState = DOWN;
					label.format.size = 20;
					if(downCallback!=null){
						downCallback();
					}
				}else {
					currentState = FOCUSED;
					label.format.size = 20.5;
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
	
	private function manageLabel() {
		setChildIndex(label, numChildren - 1);
		label.width = getBitmap().width;
		label.height = getBitmap().height;
		label.format.align = TextFormatAlign.CENTER;
		label.setTextFormat(label.format);
		label.y = label.height * 0.5 - (label.height * 0.25) * label.format.size/12;
	}
	
	public override function draw() {
		super.draw();
		switch currentState {
			case UP: setBitmap(standardState);
			case FOCUSED: setBitmap(mouseOverState);
			case DOWN: setBitmap(mouseDownState);
		}
		manageLabel();
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

enum ST_ButtonState {
	UP;
	FOCUSED;
	DOWN;
}
