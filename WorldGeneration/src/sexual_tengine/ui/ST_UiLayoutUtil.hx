package sexual_tengine.ui;

/**
 * ...
 * @author Ryan
 */
class ST_UiLayoutUtil
{

	public static function layoutAbove(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, margin:Float) {
		for (i in _targets) {
			i.y = _anchor.y - i.displayHeight - margin;
		}
	}
	
	public static function layoutBelow(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, margin:Float) {
		for (i in _targets) {
			i.y = _anchor.y + _anchor.displayHeight + margin;
		}
	}
	
	public static function layoutLeft(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, margin:Float) {
		for (i in _targets) {
			i.x = _anchor.x - i.width - margin;
		}
	}
	
	public static function layoutRight(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, margin:Float) {
		for (i in _targets) {
			i.x = _anchor.x + i.width + margin;
		}
	}
	
	public static function alignTop(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, _alignHorizontal:Bool) {
		for (i in _targets) {
			i.y = _anchor.y;
		}
		if (_alignHorizontal) {
			centerHorizontal(_anchor, _targets);
		}
	}
	
	public static function alignBottom(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, _alignHorizontal:Bool) {
		for (i in _targets) {
			i.y = _anchor.y + _anchor.displayHeight - i.displayHeight;
		}
		if (_alignHorizontal) {
			centerHorizontal(_anchor, _targets);
		}
	}
	
	public static function alignLeft(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, _alignVertical:Bool){
		for (i in _targets) {
			i.x = _anchor.x;
		}
		if (_alignVertical) {
			centerVertical(_anchor, _targets);
		}
	}
	
	public static function alignRight(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>, _alignVertical:Bool) {
		for (i in _targets) {
			i.x = _anchor.x + _anchor.displayWidth - i.displayWidth;
		}	
		if (_alignVertical) {
			centerVertical(_anchor, _targets);
		}
	}
	
	public static function centerVertical(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>) {
		for (i in _targets) {
			i.y = _anchor.y + _anchor.displayHeight * 0.5 - i.displayHeight * 0.5;
		}
	}
	
	public static function centerHorizontal(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>) {
		for (i in _targets) {
			i.x = _anchor.x + _anchor.displayWidth * 0.5 - i.displayWidth * 0.5;
		}
	}
	
	public static function center(_anchor:ST_UiComponent, _targets:Array<ST_UiComponent>) {
		centerHorizontal(_anchor, _targets);
		centerVertical(_anchor, _targets);
	}

}