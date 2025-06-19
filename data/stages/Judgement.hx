import flixel.tweens.FlxTween.FlxTweenType;

var floor:FlxSprite;
var bg:FlxSprite;
var spikes:FlxSprite;
var vg:FlxSprite;
var floating:FlxSprite;
var anotherone:FlxSprite;
var anotherone2:FlxSprite;
var redshit:FunkinSprite;
var black:FlxSprite;
var BopRedVG:Bool = false;

function postCreate() {
	healthBar.visible = healthBarBG.visible = iconP1.visible = iconP2.visible = false;
}

function create() {
	boyfriend.x = -590;
	boyfriend.y = 400;

	dad.x = -2600;
	dad.y = -700;

	floor = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/ground"));
	insert(1, floor);
	floor.scale.set(2.2, 2.2);
	floor.x = -2000;
	floor.y = -1700;

	bg = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/bg"));
	insert(0, bg);
	bg.scale.set(2, 2);
	bg.x = -2200;
	bg.y = -2700;

	spikes = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/cool-thing"));
	insert(3, spikes);
	spikes.scale.set(2, 2);
	spikes.x = -1800;
	spikes.y = -2400;

	platform = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/floating-1"));
	insert(4, platform);
	platform.scale.set(2, 2);
	platform.x = -2300;
	platform.y = -1500;
	FlxTween.tween(platform, {y: -2000}, 4.3, {ease: FlxEase.quadOut, type: FlxTweenType.PINGPONG}); // thanks sage lmfao

	anotherone = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/floating-2"));
	insert(5, anotherone);
	anotherone.scale.set(2, 2);
	anotherone.x = -2300;
	anotherone.y = -1700;
	FlxTween.tween(anotherone, {y: -2000}, 4.3, {ease: FlxEase.quadOut, type: FlxTweenType.PINGPONG});

	anotherone2 = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/floating-2"));
	insert(5, anotherone2);
	anotherone2.scale.set(2, 2);
	anotherone2.x = -2300;
	anotherone2.y = -1700;
	FlxTween.tween(anotherone2, {y: -2000}, 4.3, {ease: FlxEase.quadOut, type: FlxTweenType.PINGPONG});
	anotherone2.flipX = true;

	vg = new FlxSprite().loadGraphic(Paths.image("stages/lordx/judgement/vg"));
	insert(2, vg);
	vg.cameras = [camHUD];

	RVG = new FlxSprite().loadGraphic(Paths.image('global-images/redvg'));
	insert(1, RVG);
	RVG.cameras = [cunt];
	RVG.alpha = 0;

	// Alpha it all out lmao
	camHUD.alpha = 0;
	vg.alpha = 0;
	anotherone2.alpha = 0;
	anotherone.alpha = 0;
	platform.alpha = 0;
	spikes.alpha = 0;
	bg.alpha = 0;
	floor.alpha = 0;
	dad.alpha = 0;
	boyfriend.alpha = 0;
}

function postUpdate(elapsed:Float) { // script by maz. im not like every other exe guy who steals shit and doesnt credit lol
	if (curCameraTarget == 0) {
		defaultCamZoom = 0.22;
	} else {
		defaultCamZoom = 0.5;
	}
	RVG.alpha = lerp(RVG.alpha, 0, 0.15, false);
}

function stepHit() {
	switch (curStep) {
		case 79:
			FlxTween.tween(dad, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(vg, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(anotherone2, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(anotherone, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(platform, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(spikes, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(bg, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(floor, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(dad, {alpha: 1}, 1, {ease: FlxEase.linear});
			FlxTween.tween(boyfriend, {alpha: 1}, 1, {ease: FlxEase.linear});

		case 104:
			FlxTween.tween(camHUD, {alpha: 0.5}, 1.32, {ease: FlxEase.linear});

		case 1489:
			FlxTween.tween(camHUD, {alpha: 0}, 1.32, {ease: FlxEase.linear});
	}
}

function beatHit() {
	if (BopRedVG)
		RVG.alpha = 1;
}

function setAlphaBop(value:String) {
	BopRedVG = value == 'true';
}

function onDadHit() {
	FlxG.camera.shake(0.005);
}