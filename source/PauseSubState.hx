package;

import flixel.text.FlxText;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class PauseSubState extends FlxSubState
{
	public function new(x:Float, y:Float)
	{
		super();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);

		// var bf:Boyfriend = new Boyfriend(x, y);
		// bf.scrollFactor.set();
		// add(bf);

		var text:FlxText = new FlxText(0, 0, 0, 
			"!PAUSE!\nSong: " + PlayState.SONG.song + "\nPress Enter to continue\nPress R to reset\nPress Esc to Exit", 20, false);
		text.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.screenCenter();
		add(text);

		// bf.playAnim('firstDeath');

		bg.cameras = [FlxG.cameras.list[1]];
		text.cameras = [FlxG.cameras.list[1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		/*if (FlxG.keys.justPressed.J)
		{
			PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}*/

		if (FlxG.keys.justPressed.R)
		{
			FlxG.sound.music.stop();
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					FlxG.switchState(new PlayState());
				});
			});
		}

		if (FlxG.keys.justPressed.ENTER)
			close();

		if (FlxG.keys.justPressed.ESCAPE){
			if (PlayState.isStoryMode){
				FlxG.switchState(new StoryMenuState());
			}else{
				FlxG.switchState(new FreeplayState());
			}
		}
	}
}
