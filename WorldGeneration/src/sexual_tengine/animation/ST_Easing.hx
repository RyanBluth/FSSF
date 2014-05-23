package sexual_tengine.animation;

/**
 * Contains the standard Robert Penner easing equations
 * @author Sean
 */
class ST_Easing{
	public function new(){}
	
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function none(t:Float, b:Float, c:Float, d:Float):Float{
		return c * t / d + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInQuad(t:Float, b:Float, c:Float, d:Float):Float {
		return c*(t/=d)*t + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutQuad(t:Float, b:Float, c:Float, d:Float):Float {
		return -c *(t/=d)*(t-2) + b;
	}
	
	/**
	 * This one might not be right
	 * Currently:	return -c/2 * (((t-2)*(--t)) - 1) + b;
	 * Could be:	return -c/2 * (((--t)*(t-2)) - 1) + b;
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutQuad(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t /= d / 2) < 1) {
			return ((c/2)*(t*t)) + b;
		}
		return -c/2 * (((t-2)*(--t)) - 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInCubic(t:Float, b:Float, c:Float, d:Float):Float {
		return c*(t/=d)*t*t + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutCubic(t:Float, b:Float, c:Float, d:Float):Float {
		return c*((t=t/d-1)*t*t + 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutCubic(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t /= d / 2) < 1) {
			return c/2*t*t*t + b;
		}
		return c/2*((t-=2)*t*t + 2) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInQuart(t:Float, b:Float, c:Float, d:Float):Float {
		return c*(t/=d)*t*t*t + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutQuart(t:Float, b:Float, c:Float, d:Float):Float {
		return -c * ((t=t/d-1)*t*t*t - 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutQuart(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t /= d / 2) < 1) {
			return c/2*t*t*t*t + b;
		}
		return -c/2 * ((t-=2)*t*t*t - 2) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInQuint(t:Float, b:Float, c:Float, d:Float):Float {
		return c*(t/=d)*t*t*t*t + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutQuint(t:Float, b:Float, c:Float, d:Float):Float {
		return c*((t=t/d-1)*t*t*t*t + 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutQuint(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t /= d / 2) < 1) {
			return c/2*t*t*t*t*t + b;
		}
		return c/2*((t-=2)*t*t*t*t + 2) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInSine(t:Float, b:Float, c:Float, d:Float):Float {
		return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutSine(t:Float, b:Float, c:Float, d:Float):Float {
		return c * Math.sin(t/d * (Math.PI/2)) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutSine(t:Float, b:Float, c:Float, d:Float):Float {
		return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInExpo(t:Float, b:Float, c:Float, d:Float):Float {
		return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutExpo(t:Float, b:Float, c:Float, d:Float):Float {
		return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutExpo(t:Float, b:Float, c:Float, d:Float):Float {
		if (t == 0) {
			return b;
		}
		if (t == d) {
			return b+c;
		}
		if ((t /= d / 2) < 1) {
			return c/2 * Math.pow(2, 10 * (t - 1)) + b;
		}
		return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInCirc(t:Float, b:Float, c:Float, d:Float):Float {
		return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutCirc(t:Float, b:Float, c:Float, d:Float):Float {
		return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutCirc(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t /= d / 2) < 1) {
			return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
		}
		return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	p	Period
	 * @param	a	Amplitude
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeInElastic(t:Float, b:Float, c:Float, d:Float, ?p:Float, ?a:Float, ?s:Float):Float {
		if (t == 0) {
			return b;
		}
		if ((t /= d) == 1) {
			return b+c;  
		}
		if (p == null) {
			p = d * 0.3;
		}
		if (a == null) {
			a = c;
		}else if (a < Math.abs(c)) {
			a = c;
		}
		if (s == null) {
			s = p / 4;
		}
		var postFix:Float = a*Math.pow(2, 10*(t-=1));
		return -(postFix * Math.sin((t*d-s)*(2*Math.PI) / p )) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	p	Period
	 * @param	a	Amplitude
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeOutElastic(t:Float, b:Float, c:Float, d:Float, ?p:Float, ?a:Float, ?s:Float):Float {
		if (t == 0) {
			return b;
		}
		if ((t /= d) == 1) {
			return b+c;  
		}
		if (p == null) {
			p = d * 0.3;
		}
		if (a == null) {
			a = c;
		}else if (a < Math.abs(c)) {
			a = c;
		}
		if (s == null) {
			s = p / 4;
		}
		return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b);	
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	p	Period
	 * @param	a	Amplitude
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeInOutElastic(t:Float, b:Float, c:Float, d:Float, ?p:Float, ?a:Float, ?s:Float):Float {
		if (t == 0) {
			return b;
		}
		if ((t/=d/2)==2) {
			return b+c;  
		}
		if (p == null) {
			p = d*(0.3*1.5);
		}
		if (a == null) {
			a = c;
		}else if (a < Math.abs(c)) {
			a = c;
		}
		if (s == null) {
			s = p / 4;
		}
		
		if (t < 1) {
			var postFix:Float =a*Math.pow(2,10*(t-=1));
			return -0.5*(postFix* Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		} 
		var postFix:Float =  a*Math.pow(2,-10*(t-=1));
		return postFix * Math.sin( (t*d-s)*(2*Math.PI)/p )*0.5 + c + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeInBack(t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float {
		var postFix:Float = t/=d;
		return c*(postFix)*t*((s+1)*t - s) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeOutBack(t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float {
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @param	s	Tweak parameter
	 * @return	Eased value
	 */
	public static function easeInOutBack(t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float {
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		var postFix:Float = t-=2;
		return c/2*((postFix)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	}
	
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInBounce(t:Float, b:Float, c:Float, d:Float):Float {
		return c - easeOutBounce (d-t, 0, c, d) + b;
	}
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeOutBounce(t:Float, b:Float, c:Float, d:Float):Float {
		if ((t/=d) < (1/2.75)) {
			return c*(7.5625*t*t) + b;
		} else if (t < (2/2.75)) {
			var postFix:Float = t-=(1.5/2.75);
			return c*(7.5625*(postFix)*t + 0.75) + b;
		} else if (t < (2.5/2.75)) {
			var postFix:Float = t-=(2.25/2.75);
			return c*(7.5625*(postFix)*t + 0.9375) + b;
		} else {
			var postFix:Float = t-=(2.625/2.75);
			return c*(7.5625*(postFix)*t + 0.984375) + b;
		}
	}
	/**
	 * @param	t	Current time
	 * @param	b	Start value
	 * @param	c	Change in value (target - start value)
	 * @param	d	Duration
	 * @return	Eased value
	 */
	public static function easeInOutBounce(t:Float, b:Float, c:Float, d:Float):Float {
		if (t < d/2) return easeInBounce(t*2, 0, c, d) * .5 + b;
		return easeOutBounce(t*2-d, 0, c, d) * .5 + c*.5 + b;
	}
}

/*
 *
 * TERMS OF USE - EASING EQUATIONS
 * 
 * Open source under the BSD License. 
 * 
 * Copyright Â© 2001 Robert Penner
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * Redistributions of source code must retain the above copyright notice, this list of 
 * conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list 
 * of conditions and the following disclaimer in the documentation and/or other materials 
 * provided with the distribution.
 * 
 * Neither the name of the author nor the names of contributors may be used to endorse 
 * or promote products derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 *  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
 */