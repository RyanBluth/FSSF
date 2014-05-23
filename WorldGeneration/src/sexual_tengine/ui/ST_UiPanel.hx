package sexual_tengine.ui;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author ryan
 */
class ST_UiPanel extends ST_UiComponent
{
	public var components:Map <String, ST_UiComponent>;
	
	public function new(_width:Float, _height:Float) {
		super(_width, _height);
		components = new Map();
	}
	
	public function addComponent(name:String, component:ST_UiComponent, _componentX:Float, _componentY:Float){
		components.set(name, component);
		addChild(component);
		component.x = _componentX;
		component.y = _componentY;
	}
	
}