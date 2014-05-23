package sexual_tengine.ui;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.TextFormatAlign;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.text.ST_Text;
import sexual_tengine.ui.ST_UiButton.ST_MouseOverButtonListener;

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
	
	private var buttonClickedListener:ST_ButtonClickedListener;
	private var mouseOverListener:ST_MouseOverButtonListener;
	private var buttonDownListener:ST_ButtonDownListener;
	
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
				if(buttonClickedListener!=null){
					buttonClickedListener.buttonClicked();
				}
			}else{
				if (ST_Mouse.leftPressed) {
					currentState = DOWN;
					if(buttonDownListener !=null){
						buttonDownListener.buttonDown();
					}
				}else {
					currentState = FOCUSED;
					if(mouseOverListener != null){
						mouseOverListener.mouseOverButton();
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
}

enum ST_ButtonState {
	UP;
	FOCUSED;
	DOWN;
}

interface ST_ButtonClickedListener {
	public function buttonClicked():Void;
}

interface ST_MouseOverButtonListener {
	public function mouseOverButton():Void;
}

interface ST_ButtonDownListener {
	public function buttonDown():Void; 
}
