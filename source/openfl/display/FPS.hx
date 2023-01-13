package openfl.display;

import flixel.FlxG;
import openfl.system.System;
import flixel.math.FlxMath;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the OG current frame rate of an OpenFL project

	with some custom by Huy1234TH
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	var secondFPS(default, null):Int;

	var secondCache:Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		secondFPS = 0;
		selectable = false;
		mouseEnabled = true;
		defaultTextFormat = new TextFormat("_sans", 16, color, true);
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end

		width = 1280;
		height = 720;
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		secondFPS = Math.round((currentCount + secondCache) / 2);

		var memoryMegas:Float = 0;
		memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
		
		if (currentCount != cacheCount /*&& visible*/)
		{
			text = "FPS: " + currentFPS + "." + secondFPS;
			text += "\nMemory: " + memoryMegas + " MB";

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end
		}

		cacheCount = currentCount;

		if (secondCache == 60){
			secondCache = 0;
		}else{
			secondCache = 4 + times.length;
		}
	}
}
