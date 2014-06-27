package sexual_tengine.ui;
import openfl.display.DisplayObjectContainer;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextFormatAlign;
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
	
	/**
	 * Creates a new UI button with the desired width and height 
	 * @param	_width The display width
	 * @param	_height The display height
	 */
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
	
	/**
	 * Used to set the image for a specific button state
	 * @param	_state The button state
	 * @param	_source The path for the desired image
	 */
	public function setButtonState(_state:ST_UiState, _source:String) {
		switch _state {
			case UP: standardState = _source;
			case FOCUSED: mouseOverState = _source;
			case DOWN: mouseDownState = _source;
		}
	}
	
	/**
	 * Calls super.update()
	 */
	public override function update() {
		super.update();
	}
	
	/**
	 * Updates label formatting and positioning 
	 */
	private function manageLabel() {
		setChildIndex(label, numChildren - 1);
		label.width = displayWidth;
		label.height = bitmap.height;
		label.format.align = TextFormatAlign.CENTER;
		label.setTextFormat(label.format);
		//I have no idea why this equation works but it does
		label.y = label.height * 0.5 - (label.height * 0.25) * label.format.size /((12)*(displayHeight/32));
	}
	
	/**
	 * Draws the correct image for the current mouse state and also
	 * updates the buttons label
	 */
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
