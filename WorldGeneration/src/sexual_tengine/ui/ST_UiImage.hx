package sexual_tengine.ui;

/**
 * ...
 * @author Ryan
 */
class ST_UiImage extends ST_UiComponent
{
	
	public function new(_width:Float, _height:Float) {
		super(_width, _height);	
	}
	
	public function setImage(_source:ST_UiImage) {
		setBitmap(_source);
		scaleX = displayWidth / width;
		scaleY = displayHeight / height;
	}
}