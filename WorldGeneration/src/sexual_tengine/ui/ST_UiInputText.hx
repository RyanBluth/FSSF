package sexual_tengine.ui;
import sexual_tengine.text.ST_Text;
import flash.text.TextFieldType;

/**
 * ...
 * @author Ryan
 */
class ST_UiInputText extends ST_UiComponent
{
	public var text:ST_Text;
	public var hintText:String;
	
	public function new(_width:Float, _height:Float) {
		super(_width, _height);
		
		text = new ST_Text();
		text.width = _width;
		text.height = _height;
		text.backgroundColor = 0xFFFFFF;
		text.background = true;
		text.selectable = true;
		text.border = true;
		text.type = TextFieldType.INPUT;
		
		addChild(text);
	}
	
	
}