import openfl.geom.ColorTransform;

function create(){
defaultCamZoom = 0.8;

boyfriend.colorTransform.color = 0xFFFFFFFFF;
dad.colorTransform.color = 0xFFFFFFFFF;

BG = new FlxSprite().loadGraphic(Paths.image("bgs/MonoBW/BG"));
insert(1, BG);
BG.x = -1600;
BG.y = -700;
BG.alpha = 0;

dad.x = -300;

boyfriend.y = -170;

boyfriend.alpha = 0;


FLASHING = new FlxSprite().loadGraphic(Paths.image("global-images/Flash"));
add(FLASHING);
FLASHING.cameras = [camHUD];
FLASHING.alpha = 0;
}


function Flash(){
    FLASHING.alpha = 1;
    FlxTween.tween(FLASHING, {alpha:0}, 1, {ease: FlxEase.linear});
}

function Remove(){
    BG.alpha = 0;
    boyfriend.alpha = 0;
    dad.alpha = 0;
    FLASHING.alpha = 1;
    FlxTween.tween(FLASHING, {alpha:0}, 0.3, {ease: FlxEase.linear});
}

function readd(){
    BG.alpha = 1;
    boyfriend.alpha = 1;
    dad.alpha = 1;
}

function flashhold(){
    FLASHING.alpha = 1;
}

function letgo(){
    FlxTween.tween(FLASHING, {alpha:0}, 0.5, {ease: FlxEase.linear});
}

function letgo2(){
    FlxTween.tween(FLASHING, {alpha:0}, 0.3, {ease: FlxEase.linear});
}

function stepHit(curStep:Int) {
    switch (curStep) {
      case 65:
        FlxTween.tween(boyfriend, {alpha:1}, 0.73, {ease: FlxEase.linear});

        case 128:
            BG.alpha = 1;

            boyfriend.colorTransform.color = 0;
            dad.colorTransform.color = 0;
            dad.setColorTransform();
            boyfriend.setColorTransform();

        case 1440:
            BG.alpha = 0;

            boyfriend.colorTransform.color = 0xFFFFFFFFF;
           dad.colorTransform.color = 0xFFFFFFFFF;

        case 1696:
            BG.alpha = 1;

            boyfriend.colorTransform.color = 0;
            dad.colorTransform.color = 0;
            dad.setColorTransform();
            boyfriend.setColorTransform();

        case 1952:
            defaultCamZoom = 1;
            FlxTween.tween(BG, {alpha:0.47}, 1.3, {ease: FlxEase.linear});

        case 2209:
            defaultCamZoom = 0.97;
            FlxTween.tween(BG, {alpha:0.6}, 1.3, {ease: FlxEase.linear});

        case 2720:
            FlxTween.tween(BG, {alpha:0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(boyfriend, {alpha:0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(dad, {alpha:0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(camHUD, {alpha:0}, 1, {ease: FlxEase.linear});

        case 2736:
            BG.alpha = 1;
            defaultCamZoom = 0.8;
            boyfriend.alpha = 1;
            dad.alpha = 1;
            camHUD.alpha = 1;

            case 2992:
                FlxTween.tween(BG, {alpha:0}, 3, {ease: FlxEase.linear});
                FlxTween.tween(boyfriend, {alpha:0}, 3, {ease: FlxEase.linear});
                FlxTween.tween(dad, {alpha:0}, 3, {ease: FlxEase.linear});
                FlxTween.tween(camHUD, {alpha:0}, 3, {ease: FlxEase.linear});  

    }
    }