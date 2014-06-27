package sexual_tengine.ui;
import sexual_tengine.sprite.ST_Sprite;
import openfl.display.DisplayObjectContainer;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextFormatAlign;
import sexual_tengine.input.ST_Mouse;
import sexual_tengine.text.ST_Text;
import sexual_tengine.ui.ST_UiState;

/**
 * ...
 * @author ryan
 */
class ST_UiComponent extends ST_Sprite
{
	private var backgroundColor:Int;
	
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
	
	/**
	 * Creates a new UI component
	 * @param	_width The display width of the component
	 * @param	_height The display height of the component
	 */
	public function new(_width:Float, _height:Float){
		super();
		displayWidth = _width;
		displayHeight = _height;
		animation.play = false;
		marginBottom = 0;
		marginLeft = 0;
		marginRight = 0;
		marginTop = 0;
	}
	
	/**
	 * Sets the background colour of the component
	 * @param	_color The desired colour 
	 * @param	_alpha The desired alpha
	 */
	public function setBackgroundColour(_color:Int, _alpha:Float) {
		graphics.clear();
		graphics.beginFill(_color,_alpha);
		graphics.drawRect(0, 0, displayWidth, displayHeight);
		graphics.endFill();
	}
	
	/**
	 * //TODO add scale modes 
	 * Sets a background image for the component
	 * @param	_source The source of the desired image
	 */
	public function setBackgroundImage(_source:String) {
		var tempSprite:ST_Sprite = new ST_Sprite(_source);
		tempSprite.set_scrollRect(getBounds(this));
		addChildAt(tempSprite, 0);
	}
	
	/**
	 * Does updates for mouse states 
	 */
	public override function update() {
		super.update();
		if (parent.mouseX >= x && parent.mouseX <= x + displayWidth && parent.mouseY >= y && parent.mouseY <= y + displayHeight) {
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
	
	/**
	 * Used to set margins which are used when laying out components
	 * using LinearLayour or the layout utils
	 * @param	_left The left margin
	 * @param	_right The right margin
	 * @param	_top The top margin
	 * @param	_bottom The bottom margin
	 */
	public function setMargins(_left:Float, _right:Float, _top:Float, _bottom:Float) {
		marginLeft = _left;
		marginRight = _right;
		marginTop = _top;
		marginBottom = _bottom;
	}
	
	/**
	 * Sets the callback for a button click event
	 * @param	value Void callback
	 */
	public function setButtonClickCallback(value:Void->Void):Void->Void {
		return clickCallback = value;
	}
	
	/**
	 * Sets the callback for a mouse over event
	 * @param	value Void callback
	 */
	public function setMoueOverCallback(value:Void->Void):Void->Void {
		return overCallback = value;
	}
	
	/**
	 * Sets the callback for a mouse down event
	 * @param	value Void callback
	 */
	public function setButtonDownCallback(value:Void->Void):Void->Void {
		return downCallback = value;
	}
}

