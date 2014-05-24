package sexual_tengine.ui;

/**
 * ...
 * @author Ryan
 */
class ST_UiLabel extends ST_UiComponent
{
	public var text:ST_Text;

	public function new(_width, _height) {
		
		super(_width, _height);
		
		text = new ST_Text();
		text.width = _width;
		text.height = _height;
		addChild(text);
	}
	
}