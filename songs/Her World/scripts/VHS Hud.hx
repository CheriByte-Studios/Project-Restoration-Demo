import Date;
import DateTools;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
var irlTxt,timeTxt,scoreTxt1,misses2,rating2,accuracy2:FlxText;
var darkthing:FlxSprite;
var vcrShader = new CustomShader('VVCCRR');
var counterFPS:Bool;

function create(){
    EXEHud = EncoreMode = false;
    VHSHud = true;
    
    vcrShader.data.iTime.value = [0];
    vcrShader.data.vignetteOn.value = [true];
    vcrShader.data.perspectiveOn.value = [true];
    vcrShader.data.distortionOn.value = [true];
    vcrShader.data.glitchModifier.value = [0.1];
    vcrShader.data.vignetteMoving.value = [false];
    vcrShader.data.iResolution.value = [FlxG.width, FlxG.height];
    vcrShader.data.noiseTex.input = Paths.image("bgs/needlemouse/noise2").bitmap;
    FlxG.camera.addShader(vcrShader);
    camHUD.addShader(vcrShader);

    irlTxt = new FlxText(500,625, FlxG.width, "", 40);
    irlTxt.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    irlTxt.scrollFactor.set();
    irlTxt.alpha = 1;
    irlTxt.borderSize = 2;
    add(irlTxt);

    scoreTxt1 = new FlxText(30, 25, FlxG.width, "", 37);
    scoreTxt1.setFormat(Paths.font("vcr.ttf"), 37, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    scoreTxt1.scrollFactor.set();
    scoreTxt1.borderSize = 1.25;
    add(scoreTxt1);

    misses2 = new FlxText(30, 60, FlxG.width, "", 37);
    misses2.setFormat(Paths.font("vcr.ttf"), 37, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    misses2.scrollFactor.set();
    misses2.borderSize = 1.25;
    add(misses2);

    rating2 = new FlxText(30, 100, FlxG.width, "", 37);
    rating2.setFormat(Paths.font("vcr.ttf"), 37, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    rating2.scrollFactor.set();
    rating2.borderSize = 1.25;
    add(rating2);

    accuracy2 = new FlxText(30, 140, FlxG.width, "", 37);
    accuracy2.setFormat(Paths.font("vcr.ttf"), 37, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    accuracy2.scrollFactor.set();
    accuracy2.borderSize = 1.25;
    add(accuracy2);

    irlTxt.cameras = scoreTxt1.cameras = misses2.cameras = rating2.cameras = accuracy2.cameras = [camHUD];

}
function postCreate(){
    for (i in [scoreTxt,missesTxt,accuracyTxt]){
		remove(i);
    }
    healthBarBG.loadGraphic(Paths.image("game/healthover"));
    healthBar.x = 40;
    healthBarBG.x = 10;
    healthBarBG.y = 643;
    var noteStatic = new FlxSprite();
    noteStatic.frames = Paths.getSparrowAtlas("daSTAT");
    noteStatic.setGraphicSize(camHUD.width, camHUD.height);
    noteStatic.cameras = [camHUD];
    noteStatic.screenCenter();
    noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
    noteStatic.alpha = 0.1;
    noteStatic.animation.play("static", true);
    add(noteStatic);
}
function postUpdate(){
    for (i in cpuStrums.members){
        i.x = 9999;
    }
}
var shits = 0;
var ratingStuff:Array<Dynamic> = [
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
var ratingFC:String = "FC";
function update(elapsed){
    var time = DateTools.format(Date.now(), "%r");
    var months = DateTools.format(Date.now(), "%b");
    var dababe:String = '';
    var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
    var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
    var minutes = Std.int(timeRemaining / 60);
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    
    scoreTxt1.text = 'Score: '+ songScore;
    misses2.text = 'Misses: '+ misses;
    rating2.text = 'Rating: ' + rating + ' - ' + ratingFC;
    accuracy2.text = 'Accuracy:  (' + acc + '%)';
    if (inst != null && timeTxt != null) {
        timeTxt.text = minutes + ":" + seconds;
    }
    irlTxt.text =  Std.string(time) + '\n' + Std.string(months) + ' 1998';

    shits += elapsed;
    vcrShader.data.iTime.value = [shits];
}
var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;
function onPlayerHit(event) {
    ratingFC = 'Clear';
    switch (event.rating) {
        case "sick": sicks++;
        case "good": goods++;
        case "bad": bads++;
        case "shit": shits++;
    }
    if(misses < 1) {
		if (bads > 0 || shits > 0) ratingFC = 'FC';
		else if (goods > 0) ratingFC = 'GFC';
		else if (sicks > 0) ratingFC = 'SFC';
	}
	else if (misses < 10) ratingFC = 'SDCB';
}
