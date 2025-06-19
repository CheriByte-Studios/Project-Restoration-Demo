import flixel.tweens.FlxTween.FlxTweenType;
import funkin.backend.utils.DiscordUtil;
import lime.graphics.Image;
import funkin.menus.ModSwitchMenu;

var canDoShit:Bool = true;

function new() CoolUtil.playMenuSong();

static var initialized:Bool = false;
var blackScreen:FlxSprite;
var logo:FlxSprite;
var ngSpr:FlxSprite;
var code:Int = 0;
var wackyImage:FlxSprite;
var skippedIntro:Bool = false;

function skipIntro():Void {
	if (!skippedIntro) {
		FlxG.sound.play(Paths.sound('showMoment'), .4);

		FlxG.camera.flash(FlxColor.RED, 2);
		skippedIntro = true;
	}
}

function startIntro() {
	if (!initialized) {
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
		FlxG.sound.music.fadeIn(5, 0, 0.7);
	}

	Conductor.changeBPM(190);
	persistentUpdate = true;

	bg = new FlxSprite(0, 0);
	bg.frames = Paths.getSparrowAtlas('menus/title/static');
	bg.animation.addByPrefix('idle', "anim", 24);
	bg.animation.play('idle');
	bg.alpha = .75;
	bg.scale.x = 3;
	bg.scale.y = 3;
	bg.antialiasing = true;
	bg.updateHitbox();
	bg.screenCenter();
	add(bg);

	spikes = new FlxSprite(0, 0);
	spikes.frames = Paths.getSparrowAtlas('menus/title/spikes');
	spikes.animation.addByPrefix('idle', "anim", 13);
	spikes.antialiasing = true;
	spikes.animation.play('idle');
	spikes.updateHitbox();
	spikes.screenCenter();
	add(spikes);

	logo = new FlxSprite().loadGraphic(Paths.image('menus/title/logo'));
	logo.antialiasing = true;
	logo.screenCenter();
	logo.updateHitbox();
	logo.scale.x = 0.35;
	logo.scale.y = 0.35;
	add(logo);
	FlxTween.tween(logo, {y: -630}, 1.3, {ease: FlxEase.quadInOut, type: FlxTweenType.PINGPONG});

	titleText = new FlxSprite(0, 0);
	titleText.frames = Paths.getSparrowAtlas('menus/title/titleEnter-new');
	titleText.animation.addByIndices('idle', 'enter', [0, 1, 2, 3], "", 18);
	titleText.animation.addByIndices('press', 'enter', [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27], "", 24, false);
	titleText.antialiasing = true;
	titleText.animation.play('idle');
	titleText.updateHitbox();
	titleText.screenCenter();
	add(titleText);
	titleText.scale.x = 0.7;
	titleText.scale.y = 0.7;
	titleText.y = 500;

	DLC = new FlxText(0, 680, FlxG.width, "Press tab to access MODS");
	DLC.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 20, 0x00FFFFFF, "left");
	add(DLC);

	trans = new FlxSprite(0, 0);
	trans.frames = Paths.getSparrowAtlas('menus/title/Transition');
	trans.animation.addByPrefix('idle', "Fade in", 13);
	trans.antialiasing = true;
	trans.updateHitbox();
	trans.screenCenter();
	add(trans);
	trans.alpha = 0;

	blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	add(blackScreen);

	FlxG.sound.play(Paths.sound('TitleLaugh'), 1, false, null, false, function() {
		skipIntro();
		remove(blackScreen);
	});
}

function create() {
	window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon'))));
	DiscordUtil.changePresence('In the Title Screen');
	window.title = "Sonic.EXE - Title Screen";
	new FlxTimer().start(1, function(tmr:FlxTimer) {
		startIntro();
	});
}

var transitioning:Bool = false;

function update(elapsed:Float) {
	if (FlxG.mouse.pressed && !transitioning && skippedIntro) {
		trans.alpha = 1;
		trans.animation.play('idle');

		FlxTween.tween(titleText, {alpha: 0}, 0.5, {ease: FlxEase.linear});
		FlxTween.cancelTweensOf(logo);
		titleText.animation.play('press');
		FlxTween.tween(logo, {alpha: 0}, 0.5, {ease: FlxEase.linear});
		FlxTween.tween(DLC, {alpha: 0}, 0.5, {ease: FlxEase.linear});

		FlxG.camera.flash(FlxColor.RED, 0.2);
		FlxG.sound.play(Paths.sound('menumomentclick'));
		FlxG.sound.play(Paths.sound('menulaugh'));

		FlxTween.tween(bg, {alpha: 0}, 0.5);

		new FlxTimer().start(3, function(tmr:FlxTimer) {
			FlxG.switchState(new ModState('DemoFreeplay'));
		});
		transitioning = true;
	}

	if (FlxG.keys.justPressed.UP)
		if (code == 0) code = 1;
		else code == 0;

	if (FlxG.keys.justPressed.DOWN)
		if (code == 1) code = 2;
		else code == 0;

	if (FlxG.keys.justPressed.LEFT)
		if (code == 2) code = 3;
		else code == 0;

	if (FlxG.keys.justPressed.RIGHT)
		if (code == 3) code = 4;
		else code == 0;

	if (controls.ACCEPT && !transitioning && skippedIntro) {
		FlxTween.tween(DLC, {alpha: 0}, 0.5, {ease: FlxEase.linear});
		trans.alpha = 1;
		trans.animation.play('idle');

		FlxTween.tween(titleText, {alpha: 0}, 0.5, {ease: FlxEase.linear});
		FlxTween.cancelTweensOf(logo);
		titleText.animation.play('press');
		FlxTween.tween(logo, {alpha: 0}, 0.5, {ease: FlxEase.linear});

		FlxG.camera.flash(FlxColor.RED, 0.2);
		FlxG.sound.play(Paths.sound('menumomentclick'));
		FlxG.sound.play(Paths.sound('menulaugh'));

		FlxTween.tween(bg, {alpha: 0}, 0.5);

		new FlxTimer().start(3, function(tmr:FlxTimer) {
			FlxG.switchState(new ModState('DemoFreeplay'));
		});
		transitioning = true;
	}
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = false;
		persistentDraw = true;
	}
}
