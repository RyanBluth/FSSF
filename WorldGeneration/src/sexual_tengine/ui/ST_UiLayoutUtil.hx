package sexual_tengine.ui;

/**
 * ...
 * @author Ryan
 */
class ST_UiLayoutUtil
{

	public static function layoutAbove(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, margin:Float) {
		for (i in targets) {
			i.y = anchor.y - i.displayHeight - margin;
		}
	}
	
	public static function layoutBelow(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, margin:Float) {
		for (i in targets) {
			i.y = anchor.y + anchor.displayHeight + margin;
		}
	}
	
	public static function layoutLeft(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, margin:Float) {
		for (i in targets) {
			i.x = anchor.x - i.width - margin;
		}
	}
	
	public static function layoutRight(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, margin:Float) {
		for (i in targets) {
			i.x = anchor.x + i.width + margin;
		}
	}
	
	public static function alignTop(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, alignHorizontal:Bool) {
		for (i in targets) {
			i.y = anchor.y;
		}
		if (alignHorizontal) {
			alignHorizontal(anchor, targets);
		}
	}
	
	public static function alignBottom(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, alignHorizontal:Bool) {
		for (i in targets) {
			i.y = anchor.y + anchor.displayHeight - i.displayHeight;
		}
		if (alignHorizontal) {
			alignHorizontal(anchor, targets);
		}
	}
	
	public static function alignLeft(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, alignVertical:Bool){
		for (i in targets) {
			i.x = anchor.x;
		}
		if (alignVertical) {
			alignVertical(anchor, targets);
		}
	}
	
	public static function alignRight(anchor:ST_UiComponent, targets:Array<ST_UiComponent>, alignVertical:Bool) {
		for (i in targets) {
			i.x = anchor.x + anchor.displayWidth - i.displayWidth;
		}	
		if (alignVertical) {
			alignVertical(anchor, targets);
		}
	}
	
	public static function centerVerical(anchor:ST_UiComponent, targets:Array<ST_UiComponent>) {
		for (i in targets) {
			i.y = anchor.y + anchor.displayHeight * 0.5 - i.displayHeight * 0.5;
		}
	}
	
	public static function centerHorizontal(anchor:ST_UiComponent, targets:Array<ST_UiComponent>) {
		for (i in targets) {
			i.x = anchor.x + anchor.displayWidth * 0.5 - i.displayWidth * 0.5;
		}
	}
	
	public static function center(anchor:ST_UiComponent, targets:Array<ST_UiComponent>) {
		centerHorizontal(anchor, targets);
		centerVerical(anchor, targets);
	}

}