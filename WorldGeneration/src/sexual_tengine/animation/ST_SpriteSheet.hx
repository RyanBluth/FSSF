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
class ST_SpriteSheet {
	public var animationStates:Map<String, ST_AnimationState>;
	public var currentState:ST_AnimationState;
	public var rects:Array<Rectangle>;
	private var imageWidth:Int;
	private var imageHeight:Int;
	private var addedTiles:Int;
	public var bitmapData:BitmapData;
	public var tileCorners:Array<Point>;
	private var bitmapCache:Map<Int, BitmapData>;
	
	/** No docs yet */
	public function new(_bitmapPath:String){
		bitmapData = Assets.getBitmapData(_bitmapPath);
		imageHeight = Math.round(bitmapData.height);
		imageWidth = Math.round(bitmapData.width);
		animationStates = new Map();
		tileCorners = new Array<Point>();
		addedTiles = 0;
		rects = new Array();
		bitmapCache = new Map();
	}
	
	/** No docs yet */
	public function addAnimationState(_name:String, _frames:Array<Int>, _frameRate:Int, _frameWidth:Int, _frameHeight:Int):Void{
		var frameRects:Array<Rectangle> = ST_SpriteSheetHandler.getSpriteArray(imageWidth,imageHeight,_frameWidth,_frameHeight,_frames);
		
		for(i in frameRects)
		{
			//var id = tileset.addRect(i);
			rects.push(i);
		}
	
		var tileIds:Array<Int> = new Array();
		
		for(i in addedTiles...addedTiles + _frames.length)
		{
			tileIds.push(addedTiles);

		//	tileCorners.insert(addedTiles, new Point(tileset.getRect(addedTiles).x, tileset.getRect(addedTiles).y));
			addedTiles++;
		}//
		
		animationStates.set(_name, new ST_AnimationState(tileIds, _frameRate));
	}

	public function getRect(index:Int):Rectangle{
		return rects[index];
	}

	public function getBimapForCurrentFrame():BitmapData{
		var currentFrame:Int = currentState.getCurrentFrame();
		if(bitmapCache.exists(currentFrame)){
			return bitmapCache.get(currentFrame);
		}else{
			var currentRect:Rectangle = rects[currentFrame];
			var bit:BitmapData = new BitmapData(cast(currentRect.width, Int), cast(currentRect.height, Int), false, 0xFF0000 );
			bit.copyPixels(bitmapData, currentRect, new Point()); 
			bitmapCache.set(currentFrame, bit);
			return bit;
		}
	}

	public function getCurrentFrameRect():Rectangle{
		return rects[currentState.getCurrentFrame()];
	}
}