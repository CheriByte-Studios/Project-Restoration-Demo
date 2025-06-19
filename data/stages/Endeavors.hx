import openfl.geom.ColorTransform;
import flixel.tweens.FlxTween.FlxTweenType;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;

var shader;

function create(){
    defaultCamZoom = 1;
    BloodSplash = false;

    vg = new FlxSprite().loadGraphic(Paths.image('global-images/blueVg'));
    insert(1, vg);
    vg.cameras = [camHUD];
    vg.alpha = 0;

    FLASHING = new FlxSprite().loadGraphic(Paths.image("global-images/Flash"));
    add(FLASHING);
    FLASHING.cameras = [camHUD];
    FLASHING.alpha = 0;

    fgbutuhh = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/future/columns-fg"));
    add(fgbutuhh);
    fgbutuhh.alpha = 0;
    fgbutuhh.x = -600;
    fgbutuhh.y = -400;

    onemore = new FunkinSprite(0,0, Paths.image("bgs/endeavors/hype/last"));
    XMLUtil.addAnimToSprite(onemore, {
        name: "majin dance ",
        anim: "majin dance ",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: -1400,
        y: -1000,
        forced: false,
    });
    add(onemore);
    onemore.scale.x = 0.6;
    onemore.scale.y = 0.6;
    onemore.alpha = 0;
    onemore.screenCenter();
    onemore.playAnim("majin dance ", true);

    pog = new FunkinSprite(0,0, Paths.image("bgs/endeavors/hype/majin-left-pog"));
    XMLUtil.addAnimToSprite(pog, {
        name: "meme majin",
        anim: "meme majin",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: 1800,
        y: -1600,
        forced: false,
    });
    add(pog);
    pog.scale.x = 0.4;
    pog.scale.y = 0.4;
    pog.alpha = 0;
    pog.screenCenter();
    pog.playAnim("meme majin", true);

    behindya = new FunkinSprite(0,0, Paths.image("bgs/endeavors/hype/majon"));
    XMLUtil.addAnimToSprite(behindya, {
        name: "BINBON MAJON",
        anim: "BINBON MAJON",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: -600,
        y: 300,
        forced: false,
    });
    insert(1, behindya);
    behindya.alpha = 0;
    behindya.screenCenter();
    behindya.playAnim("BINBON MAJON", true);

    eggman = new FunkinSprite(0,0, Paths.image("bgs/endeavors/hype/egg-dj"));
    XMLUtil.addAnimToSprite(eggman, {
        name: "eggy dance",
        anim: "eggy dance",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: -50,
        y: -100,
        forced: false,
    });
    insert(1, eggman);
    eggman.alpha = 0;
    eggman.screenCenter();
    eggman.playAnim("eggy dance", true);

    lightbutcool = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/hype/light"));
    insert(1, lightbutcool);
    lightbutcool.alpha = 0;
    lightbutcool.y = -600;
    lightbutcool.x = -500;

    notagain = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/hype/columns"));
    insert(1, notagain);
    notagain.alpha = 0;
    notagain.y = -600;
    notagain.x = -500;

    hypeground = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/hype/ground"));
    insert(1, hypeground);
    hypeground.alpha = 0;
    hypeground.y = -600;
    hypeground.x = -900;

    colstand = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/past/col"));
    insert(1, colstand);
    colstand.alpha = 0;
    colstand.y = 900;

    cooltext = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/past/cool-text"));
    insert(1, cooltext);
    cooltext.alpha = 0;
    cooltext.screenCenter();
    cooltext.scale.x = 2;
    cooltext.scale.y = 2;

    colstand2 = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/past/col"));
    insert(1, colstand2);
    colstand2.alpha = 0;
    colstand2.y = 900;
    colstand2.x = 800;

    majinbgshit = new FlxBackdrop(Paths.image('bgs/endeavors/past/majin-bg'), FlxAxes.X);
    majinbgshit.screenCenter();
    insert(1, majinbgshit);
    majinbgshit.velocity.x = 75;
    majinbgshit.y = 100;
    majinbgshit.alpha = 0;

    hypebgsky = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/hype/sky-1"));
    insert(1, hypebgsky);
    hypebgsky.alpha = 0;
    hypebgsky.y = -600;
    hypebgsky.x = -600;

    light = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/future/light-fg"));
    add(light);
    light.alpha = 0;
    light.x = -300;

    flooring = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/future/floor"));
    insert(1, flooring);
    flooring.alpha = 0;
    flooring.y = -650;
    flooring.x = -800;
    flooring.scale.x = 2;
    flooring.scale.y = 2;

    rocks = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/future/rocks"));
    insert(1, rocks);
    rocks.alpha = 0;
    rocks.x = -600;
    rocks.y = -800;

    colu = new FlxSprite().loadGraphic(Paths.image("bgs/endeavors/future/columns-fg"));
    add(colu);
    colu.alpha = 0;
    colu.x = -500;

    boppingjin = new FunkinSprite(0,0, Paths.image("bgs/endeavors/future/majin-right"));
    XMLUtil.addAnimToSprite(boppingjin, {
        name: "idl",
        anim: "idl",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: -1300,
        y: -530,
        forced: false,
    });
    add(boppingjin);
    boppingjin.alpha = 0;
    boppingjin.screenCenter();
    boppingjin.playAnim("idl", true);

    boppingjin2 = new FunkinSprite(0,0, Paths.image("bgs/endeavors/future/majin-left"));
    XMLUtil.addAnimToSprite(boppingjin2, {
        name: "idle",
        anim: "idle",
        fps: 24,
        loop: true,
        animType: "none",
        indices: [],
        x: 850,
        y: -730,
        forced: false,
    });
    add(boppingjin2);
    boppingjin2.alpha = 0;
    boppingjin2.screenCenter();
    boppingjin2.playAnim("idle", true);
}



function stepHit(curStep:Int){
    switch(curStep){
        case 144:
            defaultCamZoom = 0.8;

        case 176:
            defaultCamZoom = 0.7;

        case 192:
            defaultCamZoom = 0.9;

        case 241:
            defaultCamZoom = 0.8;

        case 265:
            defaultCamZoom = 0.7;
        case 268:
            defaultCamZoom = 0.6;
        case 272:
            defaultCamZoom = 0.8;

        case 301:
            defaultCamZoom = 0.9;

        case 337:
            defaultCamZoom = 1;

        case 353:
            defaultCamZoom = 1.1;

        case 268:
            defaultCamZoom = 1.2;

        case 385:
            defaultCamZoom = 1.3;

        case 392:
            defaultCamZoom = 1.4;

        case 400:
            defaultCamZoom = 0.6;
            sky.destroy();
            remove(majin, true);
            remove(mazin, true);
            bush.destroy();
            bush2.destroy();
            bgfloor.destroy();
            remove(bleh, true);
            remove(mlem, true);
            remove(over, true);
            boppingjin.alpha = 1;
            boppingjin2.alpha = 1;
            colu.alpha = 1;
            light.alpha = 1;
            flooring.alpha = 1;
            rocks.alpha = 1;

            case 464:
                defaultCamZoom = 1;

            case 497:
                defaultCamZoom = 0.7;

            case 524:
                defaultCamZoom = 0.5; 

            case 545:
                defaultCamZoom = 0.6;  
            
            case 577:
                defaultCamZoom = 0.7; 

            case 621:
                defaultCamZoom = 0.6; 

            case 695:
                defaultCamZoom = 0.7; 

            case 704:
                defaultCamZoom = 0.6;

            case 720:
                defaultCamZoom = 0.8; 

            case 736:
                defaultCamZoom = 0.6; 

            case 768:
                defaultCamZoom = 1; 

            case 776:
                defaultCamZoom = 1.1;
                
            case 784:
                defaultCamZoom = 0.8; 

            case 800:
                defaultCamZoom = 1.1;

            case 814:
                defaultCamZoom = 0.7;

            case 832:
                defaultCamZoom = 0.6;

            case 849:
                defaultCamZoom = 1;

            case 878:
                defaultCamZoom = 0.8;

            case 897:
                defaultCamZoom = 0.6;

            case 928:
                defaultCamZoom = 1.2;

            case 952:
                defaultCamZoom = 1;

            case 976:
                defaultCamZoom = 0.7;

            case 992:
                defaultCamZoom = 0.6;

            case 1016:
                defaultCamZoom = 1;

            case 1020:
                defaultCamZoom = 0.7;

            case 1024:
                defaultCamZoom = 0.5;

            case 2048:
                defaultCamZoom = 0.4;

            case 1052:
                defaultCamZoom = 0.6;

            case 1081:
                defaultCamZoom = 1.3;

            case 1084:
                defaultCamZoom = 1;

            case 1088:
                defaultCamZoom = 0.9;

            case 1120:
                defaultCamZoom = 0.8;

            case 1185:
                defaultCamZoom = 0.6;

            case 1249:
                defaultCamZoom = 0.4;
                majinbgshit.destroy();
                remove(cooltext, true);
                remove(colstand, true);
                remove(colstand2, true);   
                boyfriend.colorTransform.color = 191970;
                dad.colorTransform.color = 191970;

                case 1372:
                    defaultCamZoom = 2;

            case 672:
                defaultCamZoom = 0.9; 
                remove(boppingjin, true);
                remove(boppingjin2, true);
                remove(colu, true);
                remove(rocks, true);
                remove(flooring, true);
                remove(light, true);
                
                shader = new CustomShader("Pincushion");
                camGame.addShader(shader);
                colstand.alpha = 1;
                cooltext.alpha = 1;
                colstand2.alpha = 1;
                majinbgshit.alpha = 1;
                boyfriend.y = 220;

            case 1377:
                camGame.removeShader(shader);
                boyfriend.colorTransform.color = 000000;
                boyfriend.colorTransform();
                boyfriend.color = FlxColor.WHITE;
                hypeground.alpha = 1;
                hypebgsky.alpha = 1;
                notagain.alpha = 1;
                fgbutuhh.alpha = 1;
                lightbutcool.alpha = 1;
                eggman.alpha = 1;
                behindya.alpha = 1;
                pog.alpha = 1;
                onemore.alpha = 1;
                defaultCamZoom = 0.7;

                case 1780:
            FlxTween.tween(vg, {alpha:1}, 1, {ease: FlxEase.linear, type:FlxTweenType.PINGPONG});

            case 2032:
                FlxTween.tween(camGame, {alpha:0}, 1.3, {ease: FlxEase.linear});
                FlxTween.tween(camHUD, {alpha:0}, 1.3, {ease: FlxEase.linear});
    }
}

function Flash(){
    FLASHING.alpha = 1;
    FlxTween.tween(FLASHING, {alpha:0}, 1, {ease: FlxEase.linear});
}