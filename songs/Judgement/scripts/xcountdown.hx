//a

var _songBPM = Conductor.bpm;
function create() {
    skipcountdownlol = true;
    Conductor.changeBPM(80);
}
function postCreate() {
    Conductor.changeBPM(80);
}
function onCountdown(event) {

    if (event.soundPath != null) event.soundPath = 'xcount/' + event.soundPath;
    event.antialiasing = true;
    event.spritePath = switch(event.swagCounter) {
        case 0: 'game/Count/x/three';
        case 1: 'game/Count/x/two';
        case 2: 'game/Count/x/one';
        case 3: 'game/Count/x/fun';
    }
}
var _cachedSprites:Array<FlxSprite> = [];
function onPostCountdown(event) {
    if (event.sprite == null) return;
    if (cunt != null) event.sprite.cameras = [cunt];
    event.spriteTween.cancel();
    
    var scaleIncrease = (event.swagCounter == 3) ? 0.15 : 0;
    event.sprite.scale.set((event.scale + 0.15) + scaleIncrease, (event.scale + 0.15) + scaleIncrease);

    if (event.swagCounter < 3) {
        event.sprite.y = event.sprite.height/4;
        _cachedSprites.push(event.sprite);
    
        event.sprite.alpha = 0.0001;
        FlxTween.tween(event.sprite, {alpha: 1}, Conductor.crochet / 1000);
        FlxTween.tween(event.sprite, {x: (FlxG.width/3)*(event.swagCounter+1) - event.sprite.width - 150, y: FlxG.height/2 - event.sprite.height/2}, Conductor.crochet / 1000,
        {ease: FlxEase.quadInOut, startDelay: Conductor.crochet / 4500});
    } else {
        for (i in 0..._cachedSprites.length) {
            var spr = _cachedSprites[i];
            FlxTween.tween(spr, {angle: FlxG.random.float(-25, 25)}, Conductor.crochet / 500, {ease: FlxEase.quadOut});
            FlxTween.tween(spr, {alpha: 0.5}, Conductor.crochet / 1000);
            FlxTween.tween(spr, {alpha: 0}, Conductor.crochet / 750, {startDelay: Conductor.crochet / 1000});
            FlxTween.tween(spr.scale, {x: (event.scale)-scaleIncrease, y: (event.scale)-scaleIncrease}, Conductor.crochet / 500, {ease: FlxEase.quintOut});
        }
        event.sprite.y = FlxG.height + event.sprite.height + 15;
        FlxTween.tween(event.sprite, {y: FlxG.height/2 - event.sprite.height/2, angle: 0}, Conductor.crochet / 500, {ease: FlxEase.quintOut});
        FlxTween.tween(event.sprite, {alpha: 0}, Conductor.crochet / 750, {ease: FlxEase.quintOut, startDelay: Conductor.crochet / 500});
    }
    
    var time = (event.swagCounter == 3) ? Conductor.crochet / 500 : Conductor.crochet / 1500;
    var delay = (event.swagCounter == 3) ? Conductor.crochet / 3500 : Conductor.crochet / 1000;
    FlxTween.tween(event.sprite.scale, {x: (event.scale)+scaleIncrease, y: (event.scale)+scaleIncrease}, time, {ease: FlxEase.sineInOut, startDelay: Conductor.crochet / 3500});
}

function onSongStart() {
    new FlxTimer().start(5, function() {
        for (spr in _cachedSprites) {
            spr.kill();
            spr.destroy();
            remove(spr, true);
        }
    });
    Conductor.changeBPM(_songBPM);
}