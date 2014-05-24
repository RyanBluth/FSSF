package sexual_tengine.ui;

/**
 * ...
 * @author Ryan
 */
class ST_UiImage extends ST_UiComponent
{
	
	public function new(_width:Float, _height:Float, _source:String) {
		super(_width, _height);	
		setImage(_source);
	}
	
	public function setImage(_source:String) {
		setBitmap(_source);
		scaleX = displayWidth / width;
		scaleY = displayHeight / height;
	}
}