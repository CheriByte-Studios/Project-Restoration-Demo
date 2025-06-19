var vcr:CustomShader = null;
var fullTimer:Float = 0;
function create(){
    boyfriend.x = 1100;
    boyfriend.y = 200;

    dad.x = 450;
    dad.y = 250;

    black = new FlxSprite().loadGraphic(Paths.image('global-images/black'));
    insert(0, black);
    black.cameras = [camHUD];
    black.alpha = 0; 

    vcr = new CustomShader("VCR");
    vcr.vignetteMoving = false;
    vcr.distortionOn = true;
    vcr.perspectiveOn = true;
    camGame.addShader(vcr);
}
function update(elapsed:Float){
    fullTimer += elapsed;
    vcr.itime = fullTimer;

}



function stepHit(curStep:Int){
    switch(curStep){
        case 259:
        remove(bgbefore, true);

        case 273:
            FlxTween.tween(camGame, {zoom: 0.72}, 0.81, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.72;}});

        case 280:
            FlxTween.tween(camGame, {zoom: 0.81}, 1, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.81;}});

        case 336:
            FlxTween.tween(camGame, {zoom: 0.78}, 0.81, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.72;}});

        case 352:
            FlxTween.tween(camGame, {zoom: 0.81}, 1, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.81;}});

        case 384:
            FlxTween.tween(camGame, {zoom: 0.92}, 0.81, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.92;}});

        case 400:
            FlxTween.tween(camGame, {zoom: 1}, 0.81, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 1;}});

        case 408:
            FlxTween.tween(camGame, {zoom: 0.93}, 0.6, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.93;}});

        case 417:
            FlxTween.tween(camGame, {zoom: 0.8}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 426:
            FlxTween.tween(camGame, {zoom: 0.78}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.78;}});

        case 432:
            FlxTween.tween(camGame, {zoom: 0.8}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 448:
            FlxTween.tween(camGame, {zoom: 0.82}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.82;}});

        case 464:
            FlxTween.tween(camGame, {zoom: 0.8}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 480:
            FlxTween.tween(camGame, {zoom: 0.92}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.92;}});

        case 497:
            FlxTween.tween(camGame, {zoom: 1.1}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 1.1;}});

        case 505:
            FlxTween.tween(camGame, {zoom: 0.96}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.96;}});

        case 512:
            FlxTween.tween(camGame, {zoom: 0.86}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.86;}});

        case 537:
            FlxTween.tween(camGame, {zoom: 0.87}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.87;}});

        case 541:
            FlxTween.tween(camGame, {zoom: 0.88}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.88;}});

        case 545:
            FlxTween.tween(camGame, {zoom: 0.85}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.85;}});

        case 561:
            FlxTween.tween(camGame, {zoom: 0.84}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.84;}});

        case 601:
            FlxTween.tween(camGame, {zoom: 0.8}, 0.3, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 605:
            FlxTween.tween(camGame, {zoom: 0.82}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.82;}});

        case 668:
            FlxTween.tween(camGame, {zoom: 0.78}, 0.4, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.78;}});

        case 672:
            FlxTween.tween(camGame, {zoom: 0.8}, 0.65, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 784:
            FlxTween.tween(camGame, {zoom: 1.25}, 4, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 1.25;}});

        case 912:
            FlxTween.tween(camGame, {zoom: 1.3}, 4, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 1.3;}});

        case 1040:
            FlxTween.tween(camGame, {zoom: 0.8}, 1.4, {ease: FlxEase.linear,onComplete: function(tween:FlxTween){defaultCamZoom = 0.8;}});

        case 1805:
            FlxTween.tween(bg, {alpha:0}, 0.9, {ease: FlxEase.linear});

        case 2065:
            FlxTween.tween(black, {alpha:1}, 3.2, {ease: FlxEase.linear});
    }
}