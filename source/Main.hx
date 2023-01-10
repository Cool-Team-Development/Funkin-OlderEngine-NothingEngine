package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(1024, 768, TitleState, 60, 60, true, false));

		#if !mobile
		addChild(new FPS(10, 13, 0xFFFFFF));
		#end
	}
}
