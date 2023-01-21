package icon;

import flixel.FlxSprite;

class CheckIcon extends FlxSprite
{
	public var options:FlxSprite;

    public function new(char:String = 'disable', isPlayer:Bool = false)
	{
		super();
		loadGraphic('assets/images/icon/icon_check.png', true, 150, 150);

        animation.add('disable', [0, 0], 0, false, isPlayer);
		animation.add('enable', [1, 1], 0, false, isPlayer);

		antialiasing = true;
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (options != null)
			setPosition(options.x + options.width + 10, options.y - 30);
	}
}