package sexual_tengine.ui;
import sexual_tengine.sprite.ST_Sprite;

/**
 * ...
 * @author ryan
 */
class ST_UiPanel extends ST_UiComponent
{
	public var components:Map <String, ST_UiComponent>;
	
	/**
	 * Creates a new UI panel - A ui panel is intended to be used as a window style containe
	 * @param	_width The display width of the panel
	 * @param	_height The display height of the panel
	 */
	public function new(_width:Float, _height:Float) {
		super(_width, _height);
		components = new Map();
	}
	
	/**
	 * Used to add a UI component to the panels local corodinate space
	 * @param	_name The name of the child object
	 * @param	_component The UI component
	 * @param	_componentX The component's x position in this's corodinate space
	 * @param	_componentY The component's y position in this's corodinate space
	 */
	public function addComponent(_name:String, _component:ST_UiComponent, _componentX:Float, _componentY:Float){
		components.set(_name, _component);
		addChild(_component);
		_component.x = _componentX;
		_component.y = _componentY;
	}
	
	/**
	 * Returns a component from the compoents map
	 * @param	_name The name of the compoent -> See addComponents
	 * @return
	 */
	public function getComponentByName(_name:String):ST_UiComponent {
		return components.get(_name);
	}
	
}