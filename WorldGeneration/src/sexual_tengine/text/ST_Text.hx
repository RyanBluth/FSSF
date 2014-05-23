package sexual_tengine.text;
import flash.text.GridFitType;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import openfl.Assets;
/**
 * Helper class used to create text fields
 * 
 * @author ryan
 */
class ST_Text extends TextField
{
	public var format:TextFormat;
	public var autoSizeField:TextFieldAutoSize;
	
	public function new(?_text:String,?_font:String,?_size:Float, ?_color:Int, ?_bold:Bool, ?_italic:Bool, ?_underline:Bool) 
	{
		super();
		format = new TextFormat(_font, _size, _color, _bold, _italic, _underline);
		
		if (_text != null) {
			text = _text;
		}
		selectable = false;
		setTextFormat(format);
	}
	
	public function enableAutoSize() {
		autoSizeField = TextFieldAutoSize.LEFT;
		autoSize = autoSizeField;
	}
	
	public function disableAutoSize() {
		autoSize = TextFieldAutoSize.NONE;
	}
}
