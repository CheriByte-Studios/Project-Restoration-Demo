//a
var _songBPM = Conductor.bpm;
public var skipcountdownlol:Bool = false;
var redVGcool:FlxSprite;
function create() {
    if (skipcountdownlol) return;
    Conductor.changeBPM(90);
}
function postCreate() {
    if (skipcountdownlol) return;
    Conductor.changeBPM(90);

    new FlxTimer().start(0.0001, function() {
        Conductor.changeBPM(90);
        redVGcool = new FlxSprite(0, 0, Paths.image("global-images/RedVG"));
        redVGcool.setGraphicSize(FlxG.width, FlxG.height);
        redVGcool.updateHitbox();
        redVGcool.screenCenter();
        redVGcool.alpha = 0.001;
        if (cunt != null) redVGcool.cameras = [cunt];
        add(redVGcool);
    });
}
function onCountdown(event) {
    if (skipcountdownlol) return;
    if (event.soundPath != null) event.soundPath = 'xenocount/' + event.soundPath;
    event.antialiasing = true;
    event.spritePath = switch(event.swagCounter) {
        case 0: 'game/Count/xeno/three';
        case 1: 'game/Count/xeno/two';
        case 2: 'game/Count/xeno/one';
        case 3: 'game/Count/xeno/die';
    }
}

var _cahcedOffsets:Array<Dynamic> = [];
var _cachedSprites:Array<FlxSprite> = [];
function onPostCountdown(event) {
    if (skipcountdownlol) return;
    if (event.sprite == null) return;
    if (cunt != null) event.sprite.cameras = [cunt];
    event.spriteTween.cancel();

    var scaleIncrease = (event.swagCounter == 3) ? 0.15 : 0;
    event.sprite.scale.set((event.scale + 0.15) + scaleIncrease, (event.scale + 0.15) + scaleIncrease);

    _cahcedOffsets.push({x: event.sprite.offset.x, y: event.sprite.offset.y});

    if (event.swagCounter < 3) {
        event.sprite.angle = (event.swagCounter % 2 == 1) ? 90 : -90;
        event.sprite.x = (FlxG.width/3)*(event.swagCounter+1) - event.sprite.width - 150;
        
        _cachedSprites.push(event.sprite);
    } else {
        FlxTween.tween(redVGcool, {alpha: 0.75}, Conductor.crochet / 1250, {ease: FlxEase.quadOut});
        FlxTween.tween(redVGcool, {alpha: 0}, Conductor.crochet / 1000, {ease: FlxEase.quadOut, startDelay: Conductor.crochet / 800});
        event.sprite.angle = 45;
        for (i in 0..._cachedSprites.length) {
            var spr = _cachedSprites[i];
            FlxTween.tween(spr, {y: -event.sprite.height, angle: FlxG.random.float(-45, 45)}, Conductor.crochet / 500, {ease: FlxEase.quadOut, startDelay: (Conductor.crochet / 10000)*i});
            FlxTween.tween(spr, {alpha: 0.0001}, Conductor.crochet / 1000);
        }
        FlxTween.tween(event.sprite, {alpha: 0.0001}, Conductor.crochet / 400);
        _shake = true;
        new FlxTimer().start(Conductor.crochet / 750, function() { _shake = false; });
        _cachedSprites.push(event.sprite);
    }
    event.sprite.y = (event.swagCounter % 2 == 1) ? FlxG.height + event.sprite.height + 15 : -event.sprite.height - 15;
    
    FlxTween.tween(event.sprite, {y: FlxG.height/2 - event.sprite.height/2, angle: 0}, Conductor.crochet / 500, {ease: FlxEase.quintOut});

    var time = (event.swagCounter == 3) ? Conductor.crochet / 500 : Conductor.crochet / 750;
    FlxTween.tween(event.sprite.scale, {x: (event.scale)+scaleIncrease, y: (event.scale)+scaleIncrease}, time, {ease: FlxEase.sineInOut, startDelay: Conductor.crochet / 3500});
}

var _shake:Bool = false;
var intensity:Float = 0.02;
function update(elapsed) {
    if (skipcountdownlol) return;
    if (_shake) {
        for (i in 0..._cachedSprites.length) {
            var spr = _cachedSprites[i];
            spr.offset.x = _cahcedOffsets[i].x + FlxG.random.float(-intensity * spr.width, intensity * spr.width);
            spr.offset.y = _cahcedOffsets[i].y + FlxG.random.float(-intensity * spr.height, intensity * spr.height);
        }
    } else {
        for (i in 0..._cachedSprites.length) {
            var spr = _cachedSprites[i];
            spr.offset.x = FlxMath.lerp(spr.offset.x, _cahcedOffsets[i].x, elapsed);
            spr.offset.y = FlxMath.lerp(spr.offset.y, _cahcedOffsets[i].y, elapsed);
        }
    }
}

function onStartSong() {
    if (skipcountdownlol) return;
    new FlxTimer().start(5, function() {
        for (spr in _cachedSprites) {
            spr.kill();
            spr.destroy();
            remove(spr, true);
        }
        redVGcool.kill();
        redVGcool.destroy();
        remove(redVGcool, true);
        _cachedSprites = [];
        _cahcedOffsets = [];
    });
    Conductor.changeBPM(_songBPM);
}