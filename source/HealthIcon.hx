package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
    public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic('assets/images/icon/icon_grid.png', true, 150, 150);

        animation.add('bf', [0, 1], 0, false, isPlayer);
        animation.add('dad', [2, 2], 0, false, isPlayer);
        animation.add('spooky', [3, 4], 0, false, isPlayer);

		antialiasing = true;
		animation.play(char);
		scrollFactor.set();
	}
}