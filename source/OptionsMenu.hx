package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import icon.CheckIcon;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = 
		[
			"Ghost tap",
			"Downscroll",
			"Misses Display",
			"Watermark"
		];

	private var grpControls:FlxTypedGroup<Alphabet>;

	private var iconArray:Array<CheckIcon> = [];

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.menuBG__png);
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!

			var icon:CheckIcon = new CheckIcon(controlsStrings[i]);
			icon.options = controlLabel;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);
		}

		super.create();	

		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);

			switch(controlsStrings[curSelected])
			{
				case "Ghost tap":
					if (FlxG.save.data.ghost == true){
						FlxG.save.data.ghost = false;
						iconArray[curSelected].animation.play("disable");
					}else{
						FlxG.save.data.ghost = true;
						iconArray[curSelected].animation.play("enable");						
					}

				case "Downscroll":
					if (FlxG.save.data.down == true){
						FlxG.save.data.down = false;
						iconArray[curSelected].animation.play("disable");
					}else{
						FlxG.save.data.down = true;
						iconArray[curSelected].animation.play("enable");						
					}

				case "Misses Display":
					if (FlxG.save.data.missesDis == true){
						FlxG.save.data.missesDis = false;
						iconArray[curSelected].animation.play("disable");
					}else{
						FlxG.save.data.missesDis = true;
						iconArray[curSelected].animation.play("enable");						
					}

				case "Watermark":
					if (FlxG.save.data.watermark == true){
						FlxG.save.data.watermark = false;
						iconArray[curSelected].animation.play("disable");
					}else{
						FlxG.save.data.watermark = true;
						iconArray[curSelected].animation.play("enable");						
					}
			}
		
			FlxG.save.flush();
		}

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		switch(controlsStrings[curSelected])
		{
			case "Ghost tap":
				if (FlxG.save.data.ghost == true){
					iconArray[curSelected].animation.play("enable");
				}else{
					iconArray[curSelected].animation.play("disable");					
				}

			case "Downscroll":
				if (FlxG.save.data.down == true){
					iconArray[curSelected].animation.play("enable");
				}else{
					iconArray[curSelected].animation.play("disable");					
				}

			case "Misses Display":
				if (FlxG.save.data.missesDis == true){
					iconArray[curSelected].animation.play("enable");
				}else{
					iconArray[curSelected].animation.play("disable");					
				}

			case "Watermark":
				if (FlxG.save.data.watermark == true){
					iconArray[curSelected].animation.play("enable");
				}else{
					iconArray[curSelected].animation.play("disable");					
				}
		}

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}