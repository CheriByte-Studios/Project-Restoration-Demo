import flixel.addons.display.FlxBackdrop;
import lime.utils.Assets;
import haxe.Json;

// SpriteGroups
var descOrChLGroup:FlxTypedGroup<FlxSprite>;
var descOrChLGroup = new FlxTypedGroup();
var verGroup:FlxTypedGroup<FlxSprite>;
var verGroup = new FlxTypedGroup();
var versionsGroup:FlxTypedGroup<FlxSprite>;
var versionsGroup = new FlxTypedGroup();

// FlxBackdrops
var scrollBG:FlxBackdrop;
var trianglesUP:FlxBackdrop;
var trianglesDOWN:FlxBackdrop;

// ints
var verSel:Int = 0;
var listScrolled:Int;
var yList:Int = 0;
var yVarList = 0;
var ySelVer:Int = 0;

// sprites
// cuz it wasnt working..lol
var curVer = new FlxSprite(0, 85 + ySelVer).loadGraphic(Paths.image('menus/Patch Menu/current-ver'));
var arrow = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/Patch Menu/new-ver'));
var backplateInfo:FlxSprite;
var backplate:FlxSprite;
var descbg:FlxSprite;
var changelogSplash:FlxSprite;
var descriptionSplash:FlxSprite;

// bools
var doNotPressFast:Bool = false;
var inDescOrCh:Bool = false;

// floats
var arrowsNewerDelay:Float = 0;
var holdTime:Float = 0;

// bools
var SelVerU:Bool = false;
var verNotFound:Bool = false;
var erasedSomeAndFound:Bool = false;

// array
var versions:Array<{version:String, description:String}> = [];
var descOrChL:Array<String> = [];

// extras
var ver = new FlxText(0, 109 + yList, FlxG.width);

function create() {
	// for txt not done!!
	versions = Json.parse(Assets.getText(Paths.json('PatchNotes/0'))).skibidi;

	FlxG.sound.playMusic(Paths.music('update-changelog'), 0);
	FlxG.sound.music.fadeIn(0.5, 0, 0.6);

	scrollBG = new FlxBackdrop(Paths.image('menus/Patch Menu/bg'), FlxAxes.Y);
	scrollBG.screenCenter();
	add(scrollBG);

	trianglesUP = new FlxBackdrop(Paths.image('menus/Patch Menu/triangles-u'), FlxAxes.X);
	add(trianglesUP);

	trianglesDOWN = new FlxBackdrop(Paths.image('menus/Patch Menu/triangles-d'), FlxAxes.X);
	trianglesDOWN.y += 606;
	add(trianglesDOWN);

	descbg = new FlxSprite(523, 101).makeGraphic(757, 625, 0xFF000000);
	descbg.alpha = 0;
	add(descbg);
	add(descOrChLGroup);

	backplate = new FlxSprite(0, 93).loadGraphic(Paths.image('menus/Patch Menu/backplate'));
	backplate.scrollFactor.set();
	backplate.screenCenter(FlxAxes.X);
	add(backplate);

	for (i in 0...versions.length) {
		ver = new FlxText(0, 109 + yList, FlxG.width, versions[i].versions);
		ver.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 28, 0xFFFFFFFF, "center");
		ver.wordWrap = false;
		ver.y = 200 * i;
		ver.screenCenter(FlxAxes.X);
		ver.scrollFactor.set();
		ver.ID = i;
		if (ver.ID == 0) ver.y = 109 + yList;
		if (ver.ID == 2) ver.y = 290 + yList;
		ver.alpha = 1;
		verGroup.add(ver);

		var descChL = new FlxText(534, 113, 743, versions[i].description);
		descChL.setFormat(Paths.font("advanced.ttf"), 30, 0xFFFF0000, "left");
		descChL.scrollFactor.set();
		descChL.alpha = 0;
		descChL.ID = i;
		descOrChLGroup.add(descChL);
	}
	curVer.scrollFactor.set();
	curVer.screenCenter(FlxAxes.X);
	versionsGroup.add(curVer);

	backplateInfo = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/Patch Menu/update-info'));
	backplateInfo.scrollFactor.set();
	backplateInfo.screenCenter(FlxAxes.X);
	add(backplateInfo);

	changelogSplash = new FlxSprite(985, 0).loadGraphic(Paths.image('menus/Patch Menu/changelog'));
	changelogSplash.scrollFactor.set();
	changelogSplash.alpha = 0;
	add(changelogSplash);

	descriptionSplash = new FlxSprite(985, 0).loadGraphic(Paths.image('menus/Patch Menu/description'));
	descriptionSplash.scrollFactor.set();
	descriptionSplash.alpha = 0;
	add(descriptionSplash);

	if (!SelVerU) ySelVer += 77;
	yList += 77;

	add(verGroup);
	add(versionsGroup);

	// stupid black restored devs this doesnt go in Update!!!!
	scrollBG.velocity.set(0, 35);
	trianglesUP.velocity.set(-35, 0);
	trianglesDOWN.velocity.set(35, 0);
	selectVer(verSel);

	descOrChLGroup.forEach(function(spr:FlxSprite) {
		spr.alpha = 0;
	});
}

function update(elapsed:Float) {
	if (FlxG.keys.justReleased.ENTER)
		pressVer(verSel, true);

	// for mouse
	mouseCon();

	if (controls.BACK || #if desktop FlxG.mouse.justPressedRight #else FlxG.android.justReleased.BACK #end) {
		if (inDescOrCh) {
			back();
		} else {
			FlxG.sound.play(Paths.sound('menu/cancel'));
			FlxG.switchState(new ModState('DemoFreeplay'));
		}
	}
}

function pressVer(sel:Int, mouse:Bool = false) {
	doNotPressFast = true;
	inDescOrCh = true;
	new FlxTimer().start(.25, function() {
		doNotPressFast = false;
	});
	FlxTween.tween(curVer, {x: -10}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(backplateInfo, {x: -25}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(backplate, {x: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(descbg, {alpha: 0.7}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(changelogSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(changelogSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(descriptionSplash, {alpha: 1}, 0.25, {ease: FlxEase.quadInOut});

	verGroup.forEach(function(spr:FlxSprite) {
		FlxTween.tween(spr, {x: -399}, 0.25, {ease: FlxEase.quadInOut});
	});
	descOrChLGroup.forEach(function(spr:FlxSprite) {
		if (spr.ID == verSel) {
			FlxTween.tween(spr, {alpha: 1}, 0.25, {ease: FlxEase.quadInOut});
		}
	});
}

function back() {
	FlxG.sound.play(Paths.sound('menu/cancel'));
	doNotPressFast = true;
	inDescOrCh = false;
	new FlxTimer().start(.25, function() {
		doNotPressFast = false;
	});
	FlxTween.tween(curVer, {x: 380}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(changelogSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(descriptionSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(backplateInfo, {x: 380}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(descbg, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
	FlxTween.tween(backplate, {x: 400}, 0.25, {ease: FlxEase.quadInOut});

	verGroup.forEach(function(spr:FlxSprite) {
		FlxTween.tween(spr, {x: 0}, 0.25, {ease: FlxEase.quadInOut});
	});
	descOrChLGroup.forEach(function(spr:FlxSprite) {
		if (spr.ID == verSel) {
			FlxTween.tween(spr, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		}
	});
}

function selectVer(verS:Int, mouse:Bool = false) {
	if (!mouse) {
		verSel += verS;
		if (verSel >= versions.length)
			verSel = 0;
		if (verSel < 0)
			verSel = versions.length - 1;
	} else {
		if (verSel != verS)
			verSel = verS;
	}
	if (verSel <= versions.length - 3 && versions.length > 7) {
		if (verSel > 5)
			yVarList = -77 * (verSel - 5);
		else
			yVarList = 0;
	}
	verGroup.forEach(function(spr:FlxSprite) {
		if (spr.ID == verSel) {
			FlxTween.tween(curVer, {y: spr.y - 20}, 0.25, {ease: FlxEase.quadInOut});
			spr.color = 0xFFFFFFFF;
			spr.alpha = 1;
		} else {
			spr.color = 0xFFFF5E5E;
			spr.alpha = 0.3;
		}
	});
	descOrChLGroup.forEach(function(spr:FlxSprite) {
		if (spr.ID == verSel && inDescOrCh) {
			spr.alpha = 1;
		} else {
			spr.alpha = 0;
		}
	});
}

function mouseCon() {
	if (!doNotPressFast) {
		if (FlxG.mouse.overlaps(curVer)) {
			if (FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) {
				pressVer(verSel, true);
			}
		}
	}
	if (!FlxG.mouse.overlaps(versionsGroup)) {
		var shiftMult:Int = 1;
		if (controls.UP_P) {
			selectVer(-1);
			holdTime = 0;
		}
		if (controls.DOWN_P) {
			selectVer(1);
			holdTime = 0;
		}
	}
}
