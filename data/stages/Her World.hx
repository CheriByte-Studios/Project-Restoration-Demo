function create(){
    VHSHud = true;
    EXEHud = false;
    }

function stepHit() {
    switch (curStep) {
        case 385:
            FlxTween.tween(boyfriend, {alpha:0}, 2, {ease: FlxEase.linear});
            FlxTween.tween(dad, {alpha:0}, 2, {ease: FlxEase.linear});
            FlxTween.tween(bglol, {alpha:0}, 2, {ease: FlxEase.linear});
            FlxTween.tween(gf, {alpha:0}, 2, {ease: FlxEase.linear});

        case 480:
            bglol.destroy();
            boyfriend.alpha = 1;
            dad.alpha = 1;
            gf.alpha = 1;
            bg.alpha = 1;
            hill.alpha = 1;
            floor.alpha = 1;
            light.alpha = 1;
            egg.alpha = 1;
            knuk.alpha = 1;

        case 1248:
            knuk.destroy();
            egg.destroy();
            light.destroy();
            floor.destroy();
            hill.destroy();
            dad.alpha = 0;
            boyfriend.alpha = 0;
            gf.alpha = 0;
            FlxTween.tween(camHUD, {alpha:0}, 2, {ease: FlxEase.linear});
    }
}