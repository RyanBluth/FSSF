package sexual_tengine.ui;

/**
 * Helps integrate images into UI panels and layouts
 * @author Ryan
 */
class ST_UiImage extends ST_UiComponent
{
	/**
	 * Creates a new UI image component
	 * @param	_width The display width of the component
	 * @param	_height The display height of the component
	 * @param	_source The image source path
	 */
	public function new(_width:Float, _height:Float, _source:String) {
		super(_width, _height);	
		setImage(_source);
	}
	
	/**
	 * Set the image for 'this' component
	 * @param	_source The source path for the desired image
	 */
	public function setImage(_source:String) {
		setBitmap(_source);
		scaleX = displayWidth / width;
		scaleY = displayHeight / height;
	}
}