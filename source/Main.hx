package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		FlxG.fixedTimestep = false;

		addChild(new FlxGame(1280, 720, TitleState, 60, 60, true, false));

		addChild(new FPS(10, 3, 0xFFFFFF));
	}
}
