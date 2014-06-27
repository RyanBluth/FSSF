package sexual_tengine.ui;
import sexual_tengine.text.ST_Text;
/**
 * ...
 * @author Ryan
 */
class ST_UiLabel extends ST_UiComponent
{
	public var text:ST_Text;

	/**
	 * Creates a new UI label
	 * Use text.text to access the text
	 * Use text.format to access formatting options
	 * @param	_width The display width of the component
	 * @param	_height The display height of the component
	 */
	public function new(_width, _height) {
		super(_width, _height);
		
		text = new ST_Text();
		text.width = _width;
		text.height = _height;
		addChild(text);
	}
	
	/**
	 * Draws updates to text formatting
	 */
	public override function draw() {
		super.draw();
		text.setTextFormat(text.format);
	}
}