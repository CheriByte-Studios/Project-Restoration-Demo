var schoolhouse:FunkinSprite;
var schoolhouse2:FunkinSprite;
var eye:FlxBackdrop;

import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;

function create(){
    BloodSplash = false;
    boyfriend.alpha = 0;
    defaultCamZoom = 0.8;


    schoolhouse = new FunkinSprite(0,0, Paths.image("bgs/educator/schoolhouse"));
    XMLUtil.addAnimToSprite(schoolhouse, {name: "anim first", anim: "anim first", fps: 12, loop: true, animType: "none", indices: [], x: -140, y: -190, forced: true});
    schoolhouse.playAnim("anim first", true);
    insert(1, schoolhouse);
    schoolhouse.scale.x = 2;
    schoolhouse.scale.y = 2;


    schoolhouse2 = new FunkinSprite(0,0, Paths.image("bgs/educator/schoolhouse"));
    XMLUtil.addAnimToSprite(schoolhouse2, {name: "anim second", anim: "anim second", fps: 12, loop: true, animType: "none", indices: [], x: -140, y: -190, forced: true});
    schoolhouse2.playAnim("anim second", true);
    insert(1, schoolhouse2);
    schoolhouse2.scale.x = 2;
    schoolhouse2.scale.y = 2;


    eye = new FlxBackdrop(Paths.image('bgs/educator/reference-bg'), FlxAxes.X);
    eye.velocity.x = 785;
    insert(1, eye);
    eye.alpha = 0;
    eye.screenCenter();

    long = new FunkinSprite(0,0, Paths.image("bgs/educator/reference-floor"));
    insert(2, long);
    long.alpha = 0;
    long.y = 200;
    long.x = -230;
    long.scale.x = 2;
    long.scale.y = 2;
}



function stepHit() {
    switch (curStep) {
        case 384:
            remove(schoolhouse, true);
            schoolhouse.destroy();
            schoolhouse.playAnim("anim second", true);

        case 640:
            eye.alpha = 1;
            remove(schoolhouse2, true);
            schoolhouse2.destroy();
            long.alpha = 1;
    }
}
