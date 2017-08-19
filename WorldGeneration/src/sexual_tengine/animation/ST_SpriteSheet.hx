package sexual_tengine.animation;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.display.Tile;
import openfl.display.Bitmap;
import openfl.geom.Point;

/**
 * ...
 * @author Ryan
 */
class ST_SpriteSheet extends Tilemap{
	public var animationStates:Map<String, ST_AnimationState>;
	public var currentState:ST_AnimationState;
	private var imageWidth:Int;
	private var imageHeight:Int;
	private var addedTiles:Int;
	public var tileCorners:Array<Point>;
	
	/** No docs yet */
	public function new(_bitmapPath:String){
		var bitmapData = Assets.getBitmapData(_bitmapPath);
		imageHeight = Math.round(bitmapData.height);
		imageWidth = Math.round(bitmapData.width);
		animationStates = new Map();
		tileCorners = new Array<Point>();
		addedTiles = 0;
	    super(imageWidth, imageHeight, new Tileset(bitmapData), false);
	}
	
	/** No docs yet */
	public function addAnimationState(_name:String, _frames:Array<Int>, _frameRate:Int, _frameWidth:Int, _frameHeight:Int):Void{
		var frameRects:Array<Rectangle> = ST_SpriteSheetHandler.getSpriteArray(imageWidth,imageHeight,_frameWidth,_frameHeight,_frames);
		
		for(i in frameRects)
		{
			tileset.addRect(i);
		}
	
		var tileIds:Array<Int> = new Array();
		
		for(i in addedTiles...addedTiles + _frames.length)
		{
			tileIds.push(addedTiles);
			tileCorners.insert(addedTiles, new Point(tileset.getRect(addedTiles).x, tileset.getRect(addedTiles).y));
			addedTiles++;
		}
		
		animationStates.set(_name, new ST_AnimationState(tileIds, _frameRate));
	}
}