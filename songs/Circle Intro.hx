
public var noCount:Bool = false;
var blackFuck:FlxSprite;
var startCircle:FlxSprite;
var startText:FlxSprite;

public var cunt = new HudCamera();
function postCreate() {
	FlxG.cameras.add(cunt, false);
	cunt.bgColor = 0;

	if (noCount) return;

	blackFuck = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackFuck.screenCenter();
	blackFuck.scrollFactor.set();
	blackFuck.cameras = [cunt];
	add(blackFuck);

	startCircle = new FlxSprite();
	startCircle.loadGraphic(Paths.image('intro/' + PlayState.SONG.meta.displayName + '/act'));
	startCircle.x = FlxG.width + startCircle.width + 15;
	add(startCircle);
	startCircle.cameras = [cunt];
	startText = new FlxSprite();
	startText.loadGraphic(Paths.image('intro/'+ PlayState.SONG.meta.displayName + '/text'));
	startText.x = -startText.width - 15;
	startText.cameras = [cunt];
	add(startText);
}


function onSongStart() {
	if (noCount) return;

	new FlxTimer().start(0.6, function(tmr:FlxTimer) {
		FlxTween.tween(startCircle, {x: 0}, 0.5);
		FlxTween.tween(startText, {x: 0}, 0.5);
	});

	new FlxTimer().start(1.9, function(tmr:FlxTimer) {
		FlxTween.tween(startCircle, {alpha: 0}, 1);
		FlxTween.tween(startText, {alpha: 0}, 1);
		FlxTween.tween(blackFuck, {alpha: 0}, 1);
	});
}