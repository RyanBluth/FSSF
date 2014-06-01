package sexual_tengine.text;
import openfl.text.Font;
import openfl.text.GridFitType;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.Assets;
/**
 * Helper class used to create text fields
 * 
 * @author ryan
 */
class ST_Text extends TextField { 

	public var format:TextFormat;
	public var autoSizeField:TextFieldAutoSize;
	
	public function new(?_text:String,?_font:String,?_size:Float, ?_color:Int, ?_bold:Bool, ?_italic:Bool, ?_underline:Bool) {
		super();
		format = new TextFormat(_font, _size, _color, _bold, _italic, _underline);
		embedFonts = true;
		if (_text != null) {
			text = _text;
		}
		selectable = false;
		format.size = 12;
		setTextFormat(format);
		if(_font != null){
			setFont(_font);
		}
	}
	
	public function enableAutoSize() {
		autoSizeField = TextFieldAutoSize.LEFT;
		autoSize = autoSizeField;
	}
	
	public function disableAutoSize() {
		autoSize = TextFieldAutoSize.NONE;
	}
	
	public function setFont(fontPath:String) {
		format.font = Assets.getFont(fontPath).fontName;
		setTextFormat(format);
	}
}
