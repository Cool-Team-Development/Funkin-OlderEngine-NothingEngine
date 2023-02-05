package;

import flixel.FlxG;
import Controls.Control;
import flixel.FlxSprite;
import flixel.text.FlxText;

class FirstPlay extends MusicBeatState
{
    var text:FlxText;

    override function create() 
    {
        super.create();

		FlxG.save.bind('funkin', 'ninjamuffin99');

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 3)
				StoryMenuState.weekUnlocked.insert(0, true);
		}

		PlayerSettings.init();
		DataFlxG.dataFlxG_save();

        text = new FlxText(0, 0, 0, "Yo, thank for download Nothing Engine\nCurrently, this engine still WIP!\nand this engine is BETA!!\nReport all bugs when you found!\n\nAlso, do you want to disable check version?\nPress ENTER to Disable\nElse, Press ESC to leave it Enable", 12);
        text.screenCenter();
        add(text);
    }    

    override function update(elapsed:Float)
	{
	    super.update(elapsed);
    
        if (controls.ACCEPT)
        {
            FlxG.save.data.checkVer = false;
            FlxG.switchState(new TitleState());
        }

        if (controls.BACK)
        {
            FlxG.save.data.checkVer = true;
            FlxG.switchState(new TitleState());
        }
    }
}