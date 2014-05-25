package sexual_tengine.ui;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextFormatAlign;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.text.ST_Text;
import sexual_tengine.ui.ST_UiState;
import sexual_tengine.ui.ST_UiConstants;

/**
 * ...
 * @author ryan
 */
class ST_UiButton extends ST_UiComponent
{	
	private var standardState:String;
	private var mouseDownState:String;
	private var mouseOverState:String;
	
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
		bitmap.width = displayWidth;
		bitmap.height = displayHeight;
	}
	
	public function setButtonState(_state:ST_UiState, _source:String) {
		switch _state {
			case UP: standardState = _source;
			case FOCUSED: mouseOverState = _source;
			case DOWN: mouseDownState = _source;
		}
	}
	
	public override function update() {
		super.update();
	}
	
	private function manageLabel() {
		setChildIndex(label, numChildren - 1);
		label.width = displayWidth;
		label.height = bitmap.height;
		label.format.align = TextFormatAlign.CENTER;
		label.setTextFormat(label.format);
		label.y = label.height * 0.5 - (label.height * 0.25) * label.format.size / 12;
	}
	
	public override function draw() {
		super.draw();
		switch currentState {
			case UP: setBitmap(standardState);
			case FOCUSED: setBitmap(mouseOverState);
			case DOWN: setBitmap(mouseDownState);
		}
		bitmap.width = displayWidth;
		bitmap.height = displayHeight;
		manageLabel();
	}
}
