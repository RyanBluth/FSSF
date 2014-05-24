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
	
	public function addComponent(_name:String, _component:ST_UiComponent, _componentX:Float, _componentY:Float){
		components.set(_name, _component);
		addChild(_component);
		_component.x = _componentX;
		_component.y = _componentY;
	}
	
	public function getComponentByName(_name:String):ST_UiComponent {
		return components.get(_name);
	}
	
}