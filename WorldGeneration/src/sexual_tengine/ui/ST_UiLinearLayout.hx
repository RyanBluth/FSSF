package sexual_tengine.ui;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Ryan
 * A Linear layout which can be used horizontally or vertically
 */
class ST_UiLinearLayout extends ST_UiComponent
{
	public var children:Array<ST_UiComponent>;
	private var orientation:ST_UiLinearLayoutOrientation;
	private var updateRequired:Bool;

	/**
	 * Creates a new linear layout with the specified oritentaion
	 * Created with a width and height of 0 and will expand as children are added
	 * @param	_orientation The orientation of the layout - VERTICAL or HORIZONTAL
	 */
	public function new(_orientation:ST_UiLinearLayoutOrientation) {
		super(0,0);		
		children = new Array();
		updateRequired = true;
		orientation = _orientation;
	}

	/**
	 * Draws the all of the layouts children into their appropriate positions
	 * This only happens if an update is required. A required update is trigged 
	 * when children are added or rearragned 
	 */
	public override function draw() {
		super.draw();
		if (updateRequired) {
			if(orientation == VERTICAL){
				for (i in 0...children.length) {
					if (i == 0) {
						children[i].y = children[i].marginTop;
					}else {
						children[i].y = children[i - 1].y + children[i - 1].displayHeight + children[i - 1].marginBottom + children[i].marginTop;
					}
				}
				if(children.length > 0){
					displayHeight = height + children[children.length-1].marginBottom;
					displayWidth = width;
				}
			}else {
				for (i in 0...children.length) {
					if (i == 0) {
						children[i].x = children[i].marginLeft;
					}else {
						children[i].x = children[i - 1].x + children[i - 1].displayWidth + children[i - 1].marginRight + children[i].marginLeft;
					}
				}
				if(children.length > 0){
					displayHeight = height;
					displayWidth  = width + children[children.length-1].marginRight;
				}
			}
			updateRequired = false;
		}
	}
	
	/**
	 * Adds a child to the layout at the specified index and calls draw
	 * @param	_children The UI components to add
	 * @param	_startIndex Where to insert the children into the array
	 */
	public function addChildren(_children:Array<ST_UiComponent>, ?_startIndex:Int=0) {
		for(i in 0..._children.length) {
			children.insert(_startIndex + i, _children[i]);
			addChild(_children[i]);
		}
		updateRequired = true;
		draw();
	}
	
	/**
	 * Sets the index of a child component
	 * @param	_child The child to change
	 * @param	index The desired destination index
	 */
	public function setChildOrderIndex(_child:ST_UiComponent, index:Int) {
		var childTemp = _child;
		children.remove(_child);
		children.insert(index, childTemp);
		updateRequired = true;
		draw();
	}
	
	/**
	 * Sets the orientation of 'this' layout
	 * @param	_orientation VERTICAL or HORIZONTAL
	 */
	public function setOrientation(_orientation:ST_UiLinearLayoutOrientation) {
		orientation = _orientation;
		updateRequired = true;
		draw();
	}
}

enum ST_UiLinearLayoutOrientation {
	VERTICAL;
	HORIZONTAL;
}