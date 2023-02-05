package;

import flixel.FlxState;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import flixel.FlxG;
import cool_data.DataFlxG;

class Main extends Sprite
{
	var state:Class<FlxState> = FirstPlay; //first state
	public static var fps:Int = 60;
	
	public function new()
	{
		super();

		FlxG.fixedTimestep = false;

		if (DataFlxG.firstPlay == true){
			state = FirstPlay;
		}else{
			state = TitleState;
		}

		addChild(new FlxGame(1280, 720, state, fps, fps, true, false));

		addChild(new FPS(10, 3, 0xFFFFFF));
	}
}
