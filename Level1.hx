package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import states.dialogue.Level1Dialogue;

/**
 * ...
 * @author ByteCode
 */
class Level1 extends FlxState
{
	
	var levelStage:FlxSprite;
	var levelText:FlxText;
	//var leverCollision:FlxSprite;
	var doorCollision:FlxSprite;
	
	public function new() 
	{
		super();
		
		var timer:FlxTimer = new FlxTimer();
		
		levelStage = new FlxSprite().loadGraphic('assets/images/levels/one.png', false);
		levelStage.scale.set(1.2, 1.2);
		add(levelStage);
		
		levelText = new FlxText(640, 520, 550, "D-donde estoy?... algo esta mal..", 20);
		levelText.screenCenter(X);
		add(levelText);
		
		doorCollision = new FlxSprite().makeGraphic(198, 456, FlxColor.WHITE);
		doorCollision.x = 300;
		doorCollision.y = 150;
		add(doorCollision);
		
		timer.start(3, function(t:FlxTimer)
		{
			FlxTween.tween(levelText, {alpha: 0}, 1);
		}, 1);
		
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		var mouse:FlxPoint = new FlxPoint(FlxG.mouse.viewX, FlxG.mouse.viewY);
		
		if (doorCollision.overlapsPoint(mouse))
		{
			if (FlxG.mouse.justPressed)
			{
				FlxG.switchState(new Level1Dialogue());
			}
		}
		
		final lerpValue = elapsed * 10; // 3.5 * elapsed;
		FlxG.camera.scroll.set(FlxMath.lerp(FlxG.camera.scroll.x, FlxMath.remapToRange(FlxG.mouse.viewX, 0, FlxG.width, -10, 3), lerpValue),
		FlxMath.lerp(FlxG.camera.scroll.y, FlxMath.remapToRange(FlxG.mouse.viewY, 0, FlxG.height, -1, 1), lerpValue));
		
	}
	
}