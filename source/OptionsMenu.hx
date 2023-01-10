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

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = 
		[
			"Ghost tap",
			"Downscroll",
			"Misses Display",
			"Watermark",
			"Hide GF",
			"Back"
		];

	private var grpControls:FlxTypedGroup<Alphabet>;

	var versionShit:FlxText;

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
		}

		versionShit = new FlxText(5, FlxG.height - 48, 0, "", 18);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

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
						versionShit.text = "Disable";
					}else{
						FlxG.save.data.ghost = true;
						versionShit.text = "Enable";						
					}

				case "Downscroll":
					if (FlxG.save.data.down == true){
						FlxG.save.data.down = false;
						versionShit.text = "Disable";
					}else{
						FlxG.save.data.down = true;
						versionShit.text = "Enable";						
					}

				case "Misses Display":
					if (FlxG.save.data.missesDis == true){
						FlxG.save.data.missesDis = false;
						versionShit.text = "Disable";
					}else{
						FlxG.save.data.missesDis = true;
						versionShit.text = "Enable";						
					}

				case "Watermark":
					if (FlxG.save.data.watermark == true){
						FlxG.save.data.watermark = false;
						versionShit.text = "Disable";
					}else{
						FlxG.save.data.watermark = true;
						versionShit.text = "Enable";						
					}
					
				case "Hide GF":
					if (FlxG.save.data.hideGF == true){
						FlxG.save.data.hideGF = false;
						versionShit.text = "Disable";
					}else{
						FlxG.save.data.hideGF = true;
						versionShit.text = "Enable";						
					}

				case "Back":
					FlxG.switchState(new MainMenuState());
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
					versionShit.text = "Enable";
				}else{
					versionShit.text = "Disable";						
				}

			case "Downscroll":
				if (FlxG.save.data.down == true){
					versionShit.text = "Enable";
				}else{
					versionShit.text = "Disable";						
				}

			case "Misses Display":
				if (FlxG.save.data.missesDis == true){
					versionShit.text = "Enable";
				}else{
					versionShit.text = "Disable";						
				}

			case "Watermark":
				if (FlxG.save.data.watermark == true){
					versionShit.text = "Enable";
				}else{
					versionShit.text = "Disable";						
				}
		
			case "Hide GF":
				if (FlxG.save.data.hideGF == true){
					versionShit.text = "Enable";
				}else{
					versionShit.text = "Disable";						
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