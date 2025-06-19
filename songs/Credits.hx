import lime.utils.Assets;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;
import haxe.format.JsonParser;
import flixel.util.FlxAxes;

var creditsText:FlxTypedGroup<FlxText>;
var creditoText:FlxText;
var box:FlxSprite;
var texti:String;
var size:String;
var timei:String;
var fuck;

function onSongStart() {
	// Initialize creditsText
	creditsText = new FlxTypedGroup(FlxText);

	// in here, specify your song name and then its credits, then go to the next switch

	box = new FlxSprite(0, -1000).loadGraphic(Paths.image("box"));
	box.cameras = [cunt];
	box.setGraphicSize(Std.int(box.height * 0.8));
    box.screenCenter(FlxAxes.X);
	add(box);
	path = "assets/songs/" + PlayState.instance.curSong + "/credits.json";
	if (Assets.exists(path)) {
        fuck = true;
		texti = Assets.getText(path).split("TIME")[0];
		size = Assets.getText(path).split("SIZE")[1];
		creditoText = new FlxText(0, -1000, 0, texti, 28);
		creditoText.setFormat(Paths.font("PressStart2P.ttf"), Std.parseInt(size), FlxColor.WHITE, null, null, FlxColor.BLACK);
		creditoText.setGraphicSize(Std.int(creditoText.width * 0.8));
		creditoText.updateHitbox();
		creditoText.x = box.x + box.width / 2 - creditoText.width / 2;		
		creditoText.alignment = "center";
		creditsText.add(creditoText);
	} else {
		texti = "CREDITS\nunfinished";
		size = '28';
	}
	add(creditsText);
	creditsText.cameras = [cunt];

	if (Assets.exists(path)) {
		timei = Assets.getText(path).split("TIME")[1];
	} else {
		timei = "2.35";
	}

	FlxG.log.add('BTW THE TIME IS ' + Std.parseFloat(timei));

	new FlxTimer().start(Std.parseFloat(timei), function(tmr:FlxTimer) {
		tweencredits();
	});
}

function tweencredits() {
    if(fuck){
		FlxTween.tween(creditoText, {y: FlxG.height - 625}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(box, {y: 0}, 0.5, {ease: FlxEase.circOut});
		// tween away
		new FlxTimer().start(3, function(tmr:FlxTimer) {
			FlxTween.tween(creditoText, {y: -1000}, 0.5, {ease: FlxEase.circOut});
			FlxTween.tween(box, {y: -1000}, 0.5, {ease: FlxEase.circOut});
		// removal
		new FlxTimer().start(0.5, function(tmr:FlxTimer) {
			remove(creditsText);
			remove(box);
			});
		});
    }
}