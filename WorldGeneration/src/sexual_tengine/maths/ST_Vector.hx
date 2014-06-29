package sexual_tengine.maths;

/**
 * ...
 * @author Ryan
 */
class ST_Vector
{
	public var x:Float;
	public var y:Float;
	
	/**
	 * Creates a new ST_Vector instance
	 * @param	_x The x value of the vector - Defaults to 0
	 * @param	_y The y value of the vector - Defaults to 0
	 */
	public function new(_x:Float = 0, _y:Float = 0){
		x = _x;
		y = _y;
	}
	
	/**
	 * Calculates the magnitude of the vector
	 * @return The magnitude of the vector
	 */
	public function magnitude():Float {
		return Math.sqrt(x * x + y * y);
	}
	
	/**
	 * Normalizes the vector instance.
	 * Normalization is the process of setting the vector's magnitude 
	 * to 1 by scaling the x and y components to the proper size
	 */
	public function normalize():Void {
		var tolerance:Float = 0.0001;
		var magnitude = magnitude();
		if (magnitude <= tolerance) {
			magnitude = 1;
		}
		x /= magnitude;
		y /= magnitude;
		if (Math.abs(x) < tolerance) {
			x = 0.0;
		}
		if (Math.abs(y) < tolerance) {
			y = 0.0;
		}
	}
	
	/**
	 * Simply flips the vectors x and y values
	 */
	public function reverse() {
		x = -x;
		y = -y;
	}
	
	/**
	 * Adds v1 to v2
	 * @param	_v1 Vector 1
	 * @param	_v2 Vector 2
	 * @return A new vector created from adding v1 and v2 together
	 */
	public static function add(_v1:ST_Vector, _v2:ST_Vector):ST_Vector{
		return new ST_Vector(_v1.x + _v2.x, _v1.y + _v2.y);
	}
	
	/**
	 * Subtracts v1 from v2
	 * @param	_v1 Vector 1
	 * @param	_v2 Vector 2
	 * @return A new Vector created from subtracting v1 from v2
	 */
	public static function subtract(_v1:ST_Vector, _v2:ST_Vector):ST_Vector{
		return new ST_Vector(_v1.x - _v2.x, _v1.y - _v2.y);
	}
	
	/**
	 * Multiplies v1 and v2
	 * @param	_v1 Vector 1
	 * @param	_v2 Vector 2
	 * @return A new Vector created from multiplying v1 and v2 together
	 */
	public static function multiply(_v1:ST_Vector, _v2:ST_Vector):ST_Vector{
		return new ST_Vector(_v1.x * _v2.x, _v1.y * _v2.y);
	}
	
	/**
	 * Divides v1 by v2
	 * @param	_v1 Vector1 
	 * @param	_v2 Vector 2
	 * @return A new vector created by dividing v1 by v2
	 */
	public static function divide(_v1:ST_Vector, _v2:ST_Vector):ST_Vector{
		return new ST_Vector(_v1.x/_v2.x, _v1.y/_v2.y);
	}
	
	/**
	 * Calculates a sudo cross product. A cross product is not meant to be
	 * used in 2D space. Using this method you can determine if v1 is left 
	 * or right of v2 by the retrun values sign
	 * @param	_v1 Vector1 
	 * @param	_v2 Vector 2
	 * @return A sudo corss product value. Calculated in 3D space with a Z value of 0
	 */
	public static function crossProduct(_v1:ST_Vector, _v2:ST_Vector):Float{
		return _v1.x * _v2.y - _v1.y *_v1.x;
	}
	
	/**
	 * Calculates the dot product of v1 and v2
	 * @param	_v1 Vector1 
	 * @param	_v2 Vector 2
	 * @return The dot product of v1 and v2
	 */
	public static function dotProduct(_v1:ST_Vector, _v2:ST_Vector):Float{
		return _v1.x * _v2.x + _v1.y *_v1.y;
	}
	
	/**
	 * Multiples vector v by scalar value s
	 * @param	_v The Vector
	 * @param	_s The Scalar
	 * @return A new vector created by multiplying v by s
	 */
	public static function scalarMultiply(_v:ST_Vector, _s:Float):ST_Vector {
		return new ST_Vector(_v.x * _s, _v.y * _s);
	}
	
	/**
	 * Dividess vector v by scalar value s
	 * @param	_v The Vector
	 * @param	_s The Scalar
	 * @return A new vector created by dividing v by s
	 */
	public static function scalarDivide(_v:ST_Vector, _s:Float):ST_Vector {
		return new ST_Vector(_v.x / _s, _v.y / _s);
	}
	
}
