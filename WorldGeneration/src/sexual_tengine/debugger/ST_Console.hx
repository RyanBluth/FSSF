package sexual_tengine.debugger;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldType;
import sexual_tengine.text.ST_Text;
import flash.events.KeyboardEvent;
import sexual_tengine.input.ST_Mouse;

/**
 * ...
 * @author Ryan
 */
class ST_Console extends Sprite
{

	private var enterField:ST_Text;
	private var propertiesTable:PropertiesTable;
	private var currentPropertiesObject:Dynamic;
	
	public function new() 
	{
		super();
		enterField = new ST_Text();
		enterField.selectable = true;
		enterField.wordWrap = true;
		enterField.addEventListener(KeyboardEvent.KEY_UP, keyup);
		width = 1280;
		enterField.width = 1280;
		enterField.background = true;
		enterField.backgroundColor = 0xAAAAAA;
		enterField.text = " ";
		enterField.type = TextFieldType.INPUT;
		addChild(enterField);
		enterField.y = Lib.current.stage.stageHeight - height;
		propertiesTable = new PropertiesTable();
		addChild(propertiesTable);
	}
	
	public function update() {
		if (currentPropertiesObject != null) {
			var fields =  Reflect.fields(currentPropertiesObject);
			for (i in fields) {
				propertiesTable.update(i, Reflect.getProperty(currentPropertiesObject, i) + "  -  (" + Std.string(Type.typeof(Reflect.getProperty(currentPropertiesObject, i))).substring(1) +")");
			}
		}
		//propertiesTable.scrollRect = new Rectangle(propertiesTable.scrollRect.x + 0.1, 200, 500, 300);
		//trace(propertiesTable.scrollRect);
	}
	
	private function keyup(evt:KeyboardEvent) {
		enterField.y = Lib.current.stage.stageHeight - height;
	}
	
	public function analyze(object:Dynamic) {
		if (object != null && object != currentPropertiesObject && object!= propertiesTable) {
			currentPropertiesObject = object;
			var fields =  Reflect.fields(object);
			propertiesTable.clear();
			for (i in fields) {
				propertiesTable.addRow(i, Reflect.getProperty(object, i) + "  -  (" + Std.string(Type.typeof(Reflect.getProperty(object, i))).substring(1) +")");
			}
			propertiesTable.initScrollBar();
		}
	}
	
	public function clear() {
		enterField.text = "";
	}
}

private class PropertiesTable extends Sprite {
	
	private var fields:Array<ST_Text>;
	private var values:Array<ST_Text>;
	private var scrollBar:ScrollBar;
	private var propertiesContainer:Sprite;
	
	public function new() {
		super();	
		fields = new Array();
		values = new Array();
		//addEventListener(MouseEvent.MOUSE_WHEEL, scroll, true);
		propertiesContainer = new Sprite();
		scrollRect = new Rectangle(0, 0, width, 400);
	}
	
	public function addRow(_field:String, _value:String) {
		if (_value == null) {
			_value = "";
		}
		fields.push(new ST_Text(_field,"font/arial.ttf",12,0xEEEEEE));
		values.push(new ST_Text(_value,"font/arial",12,0xEEEEEE));
		fields[fields.length - 1].backgroundColor = 0x33222222;
		fields[fields.length - 1].borderColor = 0x000000;
		fields[fields.length - 1].border = true;
		fields[fields.length - 1].background = true;
		fields[fields.length - 1].height = 20;
		fields[fields.length - 1].type = TextFieldType.INPUT;
		fields[values.length - 1].selectable = true;
		values[values.length - 1].backgroundColor = 0x222222;
		values[values.length - 1].borderColor = 0x000000;
		values[values.length - 1].height = 20;
		values[values.length - 1].border = true;
		values[values.length - 1].background = true;
		values[values.length - 1].type = TextFieldType.INPUT;
		values[values.length - 1].selectable = true;
		if (fields.length == 1) {
			fields[fields.length-1].x = x;
			fields[fields.length-1].y = y;
			values[values.length-1].x = fields[fields.length-1].x + fields[fields.length-1].width;
			values[values.length-1].y = y;
		}else {
			fields[fields.length-1].x = x;
			fields[fields.length-1].y = fields[fields.length - 2].y + fields[fields.length - 2].height;
			values[values.length-1].x = fields[fields.length - 2].width + fields[fields.length - 2].x;
			values[values.length-1].y = fields[fields.length - 2].y + fields[fields.length - 2].height;
		}
		addChild(values[values.length - 1]);
		addChild(fields[fields.length - 1]);
		
		adjustWidth();
	}
	
	public function update(_field:String, _value:String) {
		for (i in 0...fields.length) {
			if (_field == fields[i].text) {
				values[i].text = _value;
				values[i].textColor = 0xEEEEEE;
			}
		}
		scroll();
	}
	
	public function initScrollBar() {
		scrollBar = new ScrollBar();
		scrollBar.createScroll(400, height);
		scrollBar.height = 400;
		scrollBar.x = width + x - 20;
		addChild(scrollBar);
	}
	
	/**
	 * We call this the first time to size things properly
	 * However it is very expensive so we don't call it on updates
	 * 
	 */
	private function adjustWidth() {
		var maxFieldWidth:Int = 0;
		var maxValueWidth:Int = 0;
		for (i in fields) {
			if (i.width > maxFieldWidth) {
				i.enableAutoSize();
				maxFieldWidth = Math.round(i.width);
			}
		}
		for (i in fields) {
			i.disableAutoSize();
			i.width = maxFieldWidth;
		}
		if (maxFieldWidth + maxValueWidth > Lib.current.stage.stageWidth) {
			maxValueWidth = Lib.current.stage.stageWidth - maxFieldWidth;
		}
		for (i in values) {
			i.enableAutoSize();
			if (i.width > maxValueWidth) {
				maxValueWidth = Math.round(i.width);
			}
		}
		var j:Int = 0;
		for (i in values) {
			i.disableAutoSize();
			i.width = maxValueWidth;
			i.x = fields[j].x + fields[j].width;
			j++;
		}
		
		scrollRect = new Rectangle(scrollRect.x, scrollRect.y, maxFieldWidth + maxValueWidth, 400);
	}
	
	private function scroll() {
		if (Lib.current.stage.mouseY > height*0.1 && ST_Mouse.rightPressed) {
			if (scrollRect.y > 0) {
				if (scrollRect.y - 0.1 > 0) {
					scrollRect=  new Rectangle(0,scrollRect.y-0.1,scrollRect.width,scrollRect.height);
				}else {
					scrollRect =  new Rectangle(0,0,scrollRect.width,scrollRect.height);
				}
			}
		}else if(Lib.current.stage.mouseY < height * 0.9 && ST_Mouse.rightPressed){
			if (scrollRect.y + scrollRect.height < parent.x + parent.height) {
				if (scrollRect.y + 0.1 <  parent.x + parent.height) {
					scrollRect=  new Rectangle(0,scrollRect.y+0.1,scrollRect.width,scrollRect.height);
				}else {
					scrollRect=  new Rectangle(0,(parent.y + parent.height) -scrollRect.height,scrollRect.width,scrollRect.height);
				}
			}
		}
	}
	
	public function clear() {
		fields = new Array();
		values = new Array();
		graphics.clear();
		removeChildren();
	}
}

private class ScrollBar extends Sprite{
	
	private var scrollHandle:Sprite;
	
	public function new() {
		super();
	}
	
	public function createScroll(_scrollHeight, _viewHeight) {
		
		scrollHandle = new Sprite();
		graphics.beginFill(0x334544);
		graphics.drawRect(0, 0, 20, _viewHeight);
		graphics.endFill();
		scrollHandle.graphics.beginFill(0xAAAAAA);
		scrollHandle.graphics.drawRect(0, 0, 20, _scrollHeight);
		scrollHandle.graphics.endFill();
		addChild(scrollHandle);
		
	}
}