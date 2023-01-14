package cool_data;

import flixel.FlxG;

class DataFlxG 
{
    static public function dataFlxG_save() 
    {
        if (FlxG.save.data.ghost == null){
            FlxG.save.data.ghost = true;
        }

        if (FlxG.save.data.down == null){
            FlxG.save.data.down = false;
        }
    
        if (FlxG.save.data.missesDis == null){
            FlxG.save.data.missesDis = false;
        }

        if (FlxG.save.data.watermark == null){
            FlxG.save.data.watermark = false;
        }
    }
}