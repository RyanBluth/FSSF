package sexual_tengine.ui;
import flash.geom.Rectangle;

/**
 * ...
 * @author Ryan
 */
class ST_UiLinearLayout extends ST_UiComponent
{
	public var children:Array<ST_UiComponent>;
	private var orientation:ST_UiLinearLayoutOrientation;
	private var updateRequired:Bool;

	public function new(_width:Float, _height:Float, _orientation:ST_UiLinearLayoutOrientation) {
		super(_width, _height);		
		children = new Array();
		updateRequired = true;
		orientation = _orientation;
	}

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
					displayWidth = width + children[children.length-1].marginRight;
				}
			}
			updateRequired = false;
		}
	}
	
	public function addChildren(_children:Array<ST_UiComponent>, ?_startIndex:Int=-1) {
		if(_startIndex==-1){
			for(i in 0..._children.length) {
				children.push(_children[i]);
				addChild(_children[i]);
			}
		}else {
			for(i in 0..._children.length) {
				children.insert(_startIndex + i, _children[i]);
				addChild(_children[i]);
			}
		}
		updateRequired = true;
	}
	
	public function setChildOrderIndex(_child:ST_UiComponent, index:Int) {
		var childTemp = _child;
		children.remove(_child);
		children.insert(index, childTemp);
		updateRequired = true;
	}
	
	public function setOrientation(_orientation:ST_UiLinearLayoutOrientation) {
		orientation = _orientation;
		updateRequired = true;
	}
}

enum ST_UiLinearLayoutOrientation {
	VERTICAL;
	HORIZONTAL;
}