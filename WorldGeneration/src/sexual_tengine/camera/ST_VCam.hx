package sexual_tengine.camera;
import openfl.display.Sprite;

/**
 * ...
 * @author ryan
 */
class ST_VCam extends Sprite
{
	/**
	 * VCam AS3 v1.01
	 *
	 * VCam based on original code by Sham Bhangal and Dave Dixon
	 *
	 * Dynamic Registration AS3 code based on work by Oscar Trelles, AS2
	 * work by Darron Schall (www.darronschall.com)
	 * and AS1 work by Robert Penner (www.robertpenner.com)
	 *
	 * Special Thanks to Josh Steele and Jeff Brenner
	 *
	 * @author Bryan Heisey
	 * @version 1.01
	 * @created 27-May-2008
	 *
	  * Requirements: Flash CS3+ & Actionscript 3
	 */

	

	////////////////////////////////////////////////////////////////////////////
	// Get stage width and height //////////////////////////////////////////////

	var oldScaleMode:String=stage.scaleMode;
	

	var sW:Float=stage.stageWidth;
	var sH:Float=stage.stageHeight;

	
	////////////////////////////////////////////////////////////////////////////
	// Get Vcam width and height ///////////////////////////////////////////////

	var bounds_obj:Object=this.getBounds(this);

	var camH:Float=bounds_obj.height;
	var camW:Float=bounds_obj.width;

	////////////////////////////////////////////////////////////////////////////
	// Creat Point for dynamic registration point //////////////////////////////

	var rp:Point=new Point(x,y);

	////////////////////////////////////////////////////////////////////////////
	// Add Event Listeners /////////////////////////////////////////////////////


	////////////////////////////////////////////////////////////////////////////
	// Create BitmapData ///////////////////////////////////////////////////////

	var bmp:Bitmap;
	var myBitmapData:BitmapData=new BitmapData(sW,sH,true,0);


	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	
	function new () {
		super();
		visible=false;
		parent.cacheAsBitmap = true;
		stage.scaleMode = "exactFit";
		stage.scaleMode = oldScaleMode;
		addEventListener(Event.ENTER_FRAME,camControl);
		addEventListener(Event.REMOVED_FROM_STAGE, reset);
		bmp=new Bitmap(myBitmapData);
		camControl();
		stage.addChild(bmp);
	}

	function camControl(?event):Void {

		parent.visible=true;

		////////////////////////////////////////////////////////////////////////////
		// Move the registration point to the vCams current position ///////////////

		rp.x=x;
		rp.y=y;

		////////////////////////////////////////////////////////////////////////////
		// Gets the current scale of the vCam //////////////////////////////////////

		var h:Float=camH * scaleY;
		var w:Float=camW * scaleX;

		////////////////////////////////////////////////////////////////////////////
		// Gets the stage to vCam scale ratio //////////////////////////////////////

		var _scaleY:Float=sH / h;
		var _scaleX:Float=sW / w;

		////////////////////////////////////////////////////////////////////////////
		// Positions the parent ////////////////////////////////////////////////////

		x2=w *0.5 * _scaleX;
		y2=h *0.5 * _scaleY;

		scaleX2=_scaleX;
		scaleY2=_scaleY;

		rotation2=- rotation;

		////////////////////////////////////////////////////////////////////////////
		// Draw bitmap of parent////////////////////////////////////////////////////

		myBitmapData.lock();
		myBitmapData.fillRect(myBitmapData.rect,0x00);
		myBitmapData.unlock();

		myBitmapData.draw(stage);

		////////////////////////////////////////////////////////////////////////////
		// Apply vCam filters to bitmap ////////////////////////////////////////////
		bmp.filters=this.filters;
		bmp.transform.colorTransform=this.transform.colorTransform;

		parent.visible=false;

	}

	function reset(e:Event):Void {

		////////////////////////////////////////////////////////////////////////////
		// Cleans up data for garbage collection ///////////////////////////////////

		removeEventListener(Event.ENTER_FRAME,camControl);
		removeEventListener(Event.REMOVED_FROM_STAGE,reset);

		stage.removeChild(bmp);
		myBitmapData.dispose();
		bmp=null;

		////////////////////////////////////////////////////////////////////////////
		// Resets parent properties ////////////////////////////////////////////////

		parent.scaleX=1;
		parent.scaleY=1;
		parent.x=0;
		parent.y=0;
		parent.rotation=0;

		parent.visible=true;

	}
	function setX2(value:Float):Void {
		var p:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));
		parent.x+= value - p.x;
	}
	function getX2():Float {
		var p:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));
		return p.x;
	}
	function setY2(value:Float):Void {
		var p:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));
		parent.y+= value - p.y;
	}
	function getY2():Float {
		var p:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));
		return p.y;
	}
	function getScaleX2():Float {
		return parent.scaleX;
	}
	function setScaleX2(value:Float):Void {
		setProperty2("scaleX",value);
	}

	function getScaleY2():Float {
		return parent.scaleY;
	}

	function setScaleY2(value:Float):Void {
		setProperty2("scaleY",value);
	}

	function get rotation2():Float {
		return parent.rotation;
	}
	function set rotation2(value:Float):Void {
		setProperty2("rotation",value);
	}

	function setProperty2(prop:String,n:Float):Void {
		var a:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));

		parent[prop]=n;

		var b:Point=parent.parent.globalToLocal(parent.localToGlobal(rp));

		parent.x-= b.x - a.x;
		parent.y-= b.y - a.y;
	}
	
}