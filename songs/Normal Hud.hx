import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.math.FlxPoint;
import openfl.events.KeyboardEvent;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.ui.Keyboard;
import openfl.system.System;
import openfl.text.TextFormat;
import openfl.Lib;
import flixel.FlxG;
import funkin.options.Options;

var cacheCount:Int;
var currentTime:Float;
var times:Array<Float>;

public var colouredBar = (dad != null && dad.xml != null && dad.xml.exists("color")) ? CoolUtil.getColorFromDynamic(dad.xml.get("color")) : 0xFFFFFFFF;
public var sicks:Int = 0;
public var goods:Int = 0;
public var bads:Int = 0;
public var shits:Int = 0;
public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeover:FlxSprite;
public var healthover:FlxSprite;
public var timeTxt:FlxText; // I forgot why I made these public variables.......
public var hudTxt:FlxText;
public var hudTxtTween:FlxTween;
public var ratingFC:String = "FC";
public var botplayTxt:FlxText;
public var botplaySine:Float = 0;
public var Overwrite:Bool = false;
public var ratingStuff:Array<Dynamic> = [
    ['JUST DIE!!!', 0.2],
    ['You Suck!', 0.4],
    ['Come on...', 0.5],
    ['Do Better', 0.6],
    ['Too Slow', 0.69],
    ['Not bad', 0.7],
    ['Pretty Good', 0.8],
    ['AWESOME!', 0.9],
    ['OUTSTANDING!!', 1],
    ['!!!AMAZING!!!', 1]
];

function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function create() {
  //  if (isEncoreMode) return;
  if (VHSHud) return;
    timeTxt = new FlxText(0, 19, 400, "X:XX", 32);
    timeTxt.setFormat(Paths.font("Modern Sonic Font.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Misses: 0 | Rating: ?");
    hudTxt.setFormat(Paths.font("Modern Sonic Font.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    hudTxt.borderSize = 1.25;
    hudTxt.antialiasing = true;
    hudTxt.scrollFactor.set();
    hudTxt.screenCenter(FlxAxes.X);

    botplayTxt = new FlxText(400, 83, FlxG.width - 800, "BOTPLAY", 32);
    botplayTxt.setFormat(Paths.font("Modern Sonic Font.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    botplayTxt.scrollFactor.set();
    botplayTxt.borderSize = 1.25;
    botplayTxt.alpha = 0;
    botplayTxt.cameras = [camHUD];
    add(botplayTxt);

    timeover = new FlxSprite();
    timeover.x = timeTxt.x;
    timeover.y = timeTxt.y + (timeTxt.height / 4);
    timeover.alpha = 0;
    timeover.loadGraphic(Paths.image("game/timeover"));

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("game/timebarbg"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,0xFFFF0000);
    if (FlxG.save.data.colouredBar) {
        timeBar.createFilledBar(0xFF000000, colouredBar);
    }
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeover);
    add(timeTxt);

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;
    timeover.x = 422;
    hudTxt.cameras = [camHUD];
    timeover.cameras = [camHUD];
    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];

    cacheCount = 0;
    currentTime = 0;
    times = [];
}

function onSongStart() {
    if (VHSHud) return;
 //   if (isEncoreMode) return;
    for (i in [timeBar, timeBarBG, timeTxt,timeover]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
}

function update(elapsed:Float) {
    if (VHSHud) return;
 //   if (isEncoreMode) return;
    if (inst != null && timeBar != null && timeBar.max != inst.length) {
        timeBar.setRange(0, Math.max(1, inst.length));
    }
    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    if (songScore > 0 || acc > 0 || misses > 0) {
        hudTxt.text = "Score: " + songScore + " | Misses: " + misses +  " | Rating: " + rating + " (" + acc + "%)" + " - " + ratingFC;
    }
    timeover.alpha = timeBarBG.alpha;
}

function onPlayerHit(event) {
    if (VHSHud) return;
   // if (isEncoreMode) return;
    if (Overwrite) return;
    if (event.note.isSustainNote) return;

    if(hudTxtTween != null) {
        hudTxtTween.cancel();
    }
    hudTxt.scale.x = 1.075;
    hudTxt.scale.y = 1.075;
    hudTxtTween = FlxTween.tween(hudTxt.scale, {x: 1, y: 1}, 0.2, {onComplete: function(twn:FlxTween) {hudTxtTween = null;}});

    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }
    ratingFC = 'Clear';
    if(misses < 1) {
		if (bads > 0 || shits > 0) ratingFC = 'FC';
		else if (goods > 0) ratingFC = 'GFC';
		else if (sicks > 0) ratingFC = 'SFC';
	}
	else if (misses < 10) ratingFC = 'SDCB';
}

function postCreate() {
    if (VHSHud) return;
   // if (isEncoreMode) return;
    for (i in [missesTxt, accuracyTxt, scoreTxt]) {
        i.visible = false;
    }
    if (downscroll) {
        hudTxt.y = healthBarBG.y - 58;
    } 
    
    healthBarBG.loadGraphic(Paths.image("game/healthover"));
    remove(healthBarBG);
    insert(members.indexOf(iconP1), healthBarBG);
    healthBarBG.x = healthBar.x - 28;

    add(hudTxt);
    healthBar.y = FlxG.height * 0.89;
    healthBarBG.y = healthBar.y - 7;
    iconP1.y = healthBar.y - 75;
    iconP2.y = iconP1.y;
    if (!downscroll) {
        hudTxt.y = healthBarBG.y + 38;
    }
    if (FlxG.save.data.showBar) {
        for (i in [timeTxt, timeBar, timeBarBG, timeover]) {
            i.visible = false;
        }
    }
    if (FlxG.save.data.showTxt) {
        hudTxt.visible = false;
    }
}