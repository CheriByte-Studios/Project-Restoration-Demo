var woo = new CustomShader("woo");
var isTransIn:Bool = false;
var duration:Float = 1.0;
var fuckingShit:FlxSprite;
var fuckingShitBRUH:FlxSprite;
var finishCallback:Void->Void;
var shitcodelol:Float = 40.0;
var cam:FlxCamera;
var cum:FlxCamera;
var cam2:FlxCamera;
var blackBarThingie2:FlxSprite;

function create() {
	initializeVariables();
	setupCameras();
	removeOldTransitionSprites();

	createTransitionSprites();
	createBlackBar();

	if (newState == null)
		handleNewStateTransition();
	else
		handleExistingStateTransition();

	animateShaderTransition();
	startTransitionTimer();
}

function initializeVariables() {
	isTransIn = false;
	transitionTween.cancel();
}

function setupCameras() {
	FlxG.cameras.add(cam2 = new HudCamera(), false);
	cam2.bgColor = FlxColor.TRANSPARENT;

	FlxG.cameras.add(cum = new HudCamera(), false);
	cum.bgColor = FlxColor.TRANSPARENT;

	FlxG.cameras.add(cam = new HudCamera(), false);
	cam.bgColor = FlxColor.TRANSPARENT;
}

function removeOldTransitionSprites() {
	remove(blackSpr);
	remove(transitionSprite);
	transitionCamera.scroll.y = 0;
}

function createTransitionSprites() {
	fuckingShit = new FlxSprite().loadGraphic(Paths.image('Transition/head'));
	fuckingShit.scrollFactor.set();
	fuckingShit.screenCenter();
	fuckingShit.cameras = [cam];
	fuckingShit.shader = woo;
	add(fuckingShit);

	shitcodelol = newState == null ? 50.0 : 1.0;

	fuckingShitBRUH = new FlxSprite().loadGraphic(Paths.image('Transition/shit'));
	fuckingShitBRUH.setGraphicSize(Std.int(fuckingShitBRUH.width * shitcodelol));
	fuckingShitBRUH.scrollFactor.set();
	fuckingShitBRUH.screenCenter();
	fuckingShitBRUH.cameras = [cum];
	add(fuckingShitBRUH);
}

function createBlackBar() {
	blackBarThingie2 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackBarThingie2.setGraphicSize(Std.int(blackBarThingie2.width * 10));
	blackBarThingie2.alpha = 0;
	blackBarThingie2.cameras = [cam2];
	add(blackBarThingie2);
}

function handleNewStateTransition() {
	blackBarThingie2.alpha = 1;

	FlxTween.tween(blackBarThingie2, {alpha: 0}, 1, {
		onComplete: function(twn:FlxTween) {
			if (finishCallback != null) {
				finishCallback();
			}
		},
		ease: FlxEase.expoInOut,
		startDelay: 0.10
	});

	FlxTween.tween(cam, {zoom: 5}, duration, {
		onComplete: function(twn:FlxTween) {
			if (finishCallback != null) {
				finishCallback();
			}
		},
		ease: FlxEase.expoInOut,
		startDelay: 0.10
	});

	FlxTween.tween(cum, {zoom: 45}, 0.7, {
		ease: FlxEase.expoInOut,
		startDelay: 0.35
	});
}

function handleExistingStateTransition() {
	cum.zoom = 1;

	FlxTween.tween(blackBarThingie2, {alpha: 1}, 0.8, {
		onComplete: function(twn:FlxTween) {
			if (finishCallback != null) {
				finishCallback();
			}
		},
		ease: FlxEase.expoInOut,
		startDelay: 0.10
	});

	FlxTween.tween(cam, {zoom: .1}, 0.6, {
		onComplete: function(twn:FlxTween) {
			if (finishCallback != null) {
				finishCallback();
			}
		},
		ease: FlxEase.expoInOut,
		startDelay: 0.10
	});

	cum.zoom = 19;

	FlxTween.tween(cum, {zoom: 3}, 0.8, {
		ease: FlxEase.expoInOut
	});
}

function animateShaderTransition() {
	var from = newState != null ? 0 : 1;
	var to = newState != null ? 1 : 0;

	FlxTween.num(from, to, 2 / 3, {ease: FlxEase.quadInOut}, (val:Float) -> {
		woo.apply = val;
	});
}

function startTransitionTimer() {
	new FlxTimer().start(1, () -> {
		finish();
	});
}

function camSus() {
	cam.zoom = .1;
	cum.zoom = .3;
}