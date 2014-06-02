package sexual_tengine.utils;

import haxe.PosInfos;

/**
 * ...
 * @author ryan
 */
class ST_Logger
{
	/**
	 * Used to log a string and crash the application.
	 * Logs the string using trace and throw to cover multiple platforms.
	 * 
	 * @param	str The string to be logged
	 */
	public static function throwAndLog(log:Dynamic) {
		trace(log);
		throw log;
	}
	
	
	/**
	 * Used to log a single variable. Better to use this than
	 * trace becasue it will only trace out the log if you are compiling 
	 * in debug mode
	 * 
	 * @param	log The variable to be logged 
	 */
	public static function log(log:Dynamic, ?pos:PosInfos) {
		#if debug
			trace( '${pos.fileName}:${pos.lineNumber}:${pos.className}.${pos.methodName}():\t'+log);
		#end
	}
	
	/**
	 * Used to log multiple variables. Better to use this than 
	 * trace because it will only trace out the log if you are compiling in 
	 * debug mode. <strong>Tip -- You can declare an array like so [1, "string", sprite]</strong>
	 * 
	 * @param	logs			A dynamic array of type dynamic. Holds the items to be logged 
	 * @param	?commaSeperated	Whether the values should be comma seperated or not
	 */
	public static function logMultiple(logs:Array<Dynamic>, ?commaSeperated:Bool = false, ?pos:PosInfos) {
		#if debug
			var logString:String = '${pos.fileName}:${pos.lineNumber}:${pos.className}.${pos.methodName}():\t';
			var firstRun:Bool = true;
			for (log in logs) {
				if(commaSeperated)
					logString += firstRun ? Std.string(log) : (", " + Std.string(log));
				else
					logString += firstRun ? Std.string(log) : (" " + Std.string(log));
				firstRun = false;
			}
			trace(logString);
		#end
	}
}