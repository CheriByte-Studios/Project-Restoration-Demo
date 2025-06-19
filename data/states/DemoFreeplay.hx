import flixel.addons.display.FlxBackdrop;
import funkin.savedata.FunkinSave;

var data = [
	'majin' => ['endeavors'],
	'educator' => ['expulsion'],
	'lord x' => ['judgement'],
	'lumpy sonic' => ['frenzy'],
	'mono bw' => ['color blind'],
	'luther' => ['her world'],
	'rosy' => ['coulrophobia']
];

var characters:Array<String> = [
	'majin', 'educator', 'lord x', 'lumpy sonic', 'mono bw', 'luther', 'rosy'
];

var songToChar:Map<String, String> = [];
var songSelected:String;
var okay:Array<String>;
var scoreBG:FlxSprite;
var artItems:FlxTypedGroup<FlxSprite>;
var coverBorders:FlxTypedGroup<FlxSprite>;
var artStatic:FlxTypedGroup<FlxSprite>;
var scorchedMoment:FlxSprite;
var charText:FlxText;
var scoreText:FlxText;
var lerpScore:Int = 0;
var lerpRating:Float = 0;
var intendedScore:Int = 0;
var textList:FlxTypedGroup<FlxText>;
var scoreChoiceText:FlxText;
var scoreChoiceSongSeleted:String = '';
var lerpChoiceScore:Int = 0;
var lerpChoiceRating:Float = 0;
var intendedChoiceScore:Int = 0;
var intendedChoiceRating:Float = 0;
var curSelected:Int = 0;
var sm_cur:Int = 0;
var selectingMode:Bool = false;
var canScroll:Bool = true;
var canControl:Bool = true;
var EndlessChoice:FlxSpriteGroup<FlxSprite>;
var EndlessVerOne:FlxSprite;
var EndlessVerTwo:FlxSprite;
var EndlessVerThree:FlxSprite;
var EndlessVerFour:FlxSprite;
var EndlessWindow:FlxSprite;
var EndlessChoiceExit:FlxSprite;
var EndlessSelectedNum:Int = 0;
var EndlessSelection:Bool = false;
var EndlessMenuCanControl:Bool = false;
var bg:FlxBackdrop;
var sidebar:FlxBackdrop;

function fucker() {
	songToChar.clear();
	for (character in data.keys()) {
		var songs = data.get(character);
		for (song in songs)
			songToChar.set(song, character);
	}
}

function getSongsByChar(char:String) {
	if (data.exists(char))
		return data.get(char);
	return [];
}

function create() {
	FlxG.mouse.visible = true;

	fucker();
	okay = getSongsByChar(characters[curSelected]);
	songSelected = okay[sm_cur];

	window.title = 'Sonic.EXE - Misfits Freeplay Menu';
	CoolUtil.playMusic(Paths.music('freeplay'), false, 0);
	FlxTween.tween(FlxG.sound.music, {volume: 1}, 1);

	bg = new FlxBackdrop(Paths.image('menus/freeplay/Misfits/bg'), FlxAxes.X);
	bg.screenCenter();
	add(bg);
	bg.velocity.x = 50;

	sidebar = new FlxBackdrop(Paths.image('menus/freeplay/Misfits/sidebar'), FlxAxes.Y);
	sidebar.screenCenter();
	add(sidebar);
	sidebar.velocity.y = 50;

	artItems = new FlxTypedGroup();
	add(artItems);

	artStatic = new FlxTypedGroup();
	add(artStatic);

	coverBorders = new FlxTypedGroup();
	add(coverBorders);

	textList = new FlxTypedGroup();
	add(textList);

	updateInfoButton = new FlxSprite(0, 0, Paths.image('update'));
	add(updateInfoButton);
	updateInfoButton.updateHitbox();
	updateInfoButton.x = 65 - 65;

	for (i in 0...characters.length) {
		var artName = characters[i];

		var art:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/Misfits/artwork/' + artName));
		art.ID = i;
		art.scale.set(0.55, 0.55);
		art.antialiasing = true;
		var spot = ((FlxG.height / 2) - (art.frameHeight / 2)) - (400 * (10 - i));
		art.y = spot;
		artItems.add(art);

		var artStat:FlxSprite = new FlxSprite();
		artStat.frames = Paths.getSparrowAtlas('static');
		artStat.animation.addByPrefix('static', 'static', 24, true);
		artStat.animation.play('static');
		artStat.x = art.x;
		artStat.y = spot;
		artStat.scale.set(0.56, 0.56);
		artStat.antialiasing = true;
		artStat.ID = i;
		artStatic.add(artStat);

		var cover:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/Misfits/box'));
		cover.ID = i;
		cover.scale.set(0.55, 0.55);
		cover.antialiasing = true;
		coverBorders.add(cover);
	}
	charText = new FlxText(0, 25, 0, characters[curSelected], 32);
	charText.setFormat(Paths.font('sonic-cd-menu-font.ttf'), charText.size, FlxColor.WHITE, 'center');
	charText.screenCenter(FlxAxes.X);
	add(charText);

	scoreText = new FlxText(FlxG.width * 0.7, charText.y + 65, 0, 'Score', 16);
	scoreText.screenCenter(FlxAxes.X);
	scoreText.setFormat(Paths.font('sonic-cd-menu-font.ttf'), scoreText.size, FlxColor.WHITE, 'right');
	add(scoreText);

	EndlessChoice = new FlxSpriteGroup();
	add(EndlessChoice);
	EndlessVerOne = new FlxSprite(137, 156).loadGraphic(Paths.image('menus/freeplay/song-version-select/endless/ver-1'));
	EndlessVerOne.antialiasing = true;
	EndlessChoice.add(EndlessVerOne);
	EndlessVerTwo = new FlxSprite(643, 156).loadGraphic(Paths.image('menus/freeplay/song-version-select/endless/ver-2'));
	EndlessVerTwo.antialiasing = true;
	EndlessChoice.add(EndlessVerTwo);
	EndlessVerThree = new FlxSprite(137, 401).loadGraphic(Paths.image('menus/freeplay/song-version-select/endless/ver-3'));
	EndlessVerThree.antialiasing = true;
	EndlessChoice.add(EndlessVerThree);
	EndlessVerFour = new FlxSprite(643, 401).loadGraphic(Paths.image('menus/freeplay/song-version-select/endless/ver-4'));
	EndlessVerFour.antialiasing = true;
	EndlessChoice.add(EndlessVerFour);
	EndlessWindow = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/freeplay/song-version-select/endless/window'));
	EndlessWindow.antialiasing = true;
	EndlessWindow.screenCenter();
	EndlessChoice.add(EndlessWindow);
	EndlessChoice.forEach(function(spr:FlxSprite) {
		spr.alpha = 0;
	});

	changeSelection(0, true);
}

var holdTime:Float = 0;
var disable:Bool = false;

function update(elapsed:Float) {
	songSelected = okay[sm_cur];

	if (Math.abs(lerpChoiceScore - intendedChoiceScore) <= 10)
		lerpChoiceScore = intendedChoiceScore;
	if (Math.abs(lerpChoiceRating - intendedChoiceRating) <= 0.01)
		lerpChoiceRating = intendedChoiceRating;

	artItems.forEach(function(spr:FlxSprite) {
		spr.x = -325;
		var spot = ((FlxG.height / 2) - (spr.frameHeight / 2)) - (400 * (curSelected - spr.ID));
		spr.y = FlxMath.lerp(spr.y, spot, FlxMath.bound(FlxG.elapsed * 7, 0, 1));
		if (spr.ID == curSelected) {
			spr.alpha = FlxMath.lerp(spr.alpha, 1, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.x = FlxMath.lerp(spr.scale.x, 0.55, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.y = FlxMath.lerp(spr.scale.y, 0.55, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		} else {
			spr.alpha = FlxMath.lerp(spr.alpha, 0.4, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.x = FlxMath.lerp(spr.scale.x, 0.45, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.y = FlxMath.lerp(spr.scale.y, 0.45, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		}

		coverBorders.members[spr.ID].setPosition(spr.x, spr.y);
		coverBorders.members[spr.ID].alpha = spr.alpha;
		coverBorders.members[spr.ID].scale.x = spr.scale.x;
		coverBorders.members[spr.ID].scale.y = spr.scale.y;
	});

	artStatic.forEach(function(spr:FlxSprite) {
		spr.x = 5;

		var spot = ((FlxG.height / 2) - (spr.frameHeight / 2)) - (400 * (curSelected - spr.ID));

		spr.y = FlxMath.lerp(spr.y, spot, FlxMath.bound(FlxG.elapsed * 7, 0, 1));

		if (spr.ID == curSelected) {
			spr.alpha = FlxMath.lerp(spr.alpha, 0.2, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.x = FlxMath.lerp(spr.scale.x, 0.56, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.y = FlxMath.lerp(spr.scale.y, 0.56, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		} else {
			spr.alpha = FlxMath.lerp(spr.alpha, 0.1, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.x = FlxMath.lerp(spr.scale.x, 0.46, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
			spr.scale.y = FlxMath.lerp(spr.scale.y, 0.46, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		}
	});

	if (FlxG.mouse.overlaps(updateInfoButton)) {
		updateInfoButton.color = 0xFF606060;
		if (FlxG.mouse.justPressed)
			FlxG.switchState(new ModState('Patch'));
	} else
		updateInfoButton.color = 0xFFFFFFFF;

	var shiftMult:Int = 1;
	if (canScroll && canControl) {
		if (!disable) {
			if (controls.UP_P) {
				changeSelection(-shiftMult, true);
			}
			if (controls.DOWN_P) {
				changeSelection(shiftMult, true);
			}
			if (FlxG.mouse.wheel != 0) {
				changeSelection(-shiftMult * FlxG.mouse.wheel, true);
			}
		}
	}

	if (controls.ACCEPT) {
		if (canControl) {
			if (selectingMode) {
				if (songSelected.toLowerCase() != 'endless' && !EndlessSelection) {
					playShit();
				} else {
					EndlessSelectionMenu('open');
				}
			} else {
				selectingMode = true;
				changeSelection(0, true);
			}
		}
	}
	if ((controls.ACCEPT
		|| ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed)
			&& (FlxG.mouse.overlaps(EndlessVerOne)
				|| FlxG.mouse.overlaps(EndlessVerTwo)
				|| FlxG.mouse.overlaps(EndlessVerThree)
				|| FlxG.mouse.overlaps(EndlessVerFour))))
		&& EndlessMenuCanControl) {
		switch (EndlessSelectedNum) {
			case 0:
				playShitVer('endless');
				EndlessMenuCanControl = false;
			case 1 | 2 | 3:
				switch (EndlessSelectedNum) {
					case 1: playShitVer('endless og');
					case 2: playShitVer('Endless JP');
					case 3: playShitVer('endless us');
				}
				EndlessMenuCanControl = false;
		}
	}
	if (canControl) {
		if (selectingMode) {
			if (FlxG.mouse.overlaps(textList) && FlxG.mouse.justPressed) {
				if (songSelected.toLowerCase() != 'endless' && !EndlessSelection) {
					playShit();
				} else {
					EndlessSelectionMenu('open');
				}
			}
		}
	}

	if (EndlessSelection) {
		if (!FlxG.mouse.overlaps(EndlessVerOne)
			&& !FlxG.mouse.overlaps(EndlessVerTwo)
			&& !FlxG.mouse.overlaps(EndlessVerThree)
			&& !FlxG.mouse.overlaps(EndlessVerFour)) {
			if (controls.LEFT_P && EndlessSelectedNum == 1)
				EndlessSelectionMenu('sel-1', true);
			if (controls.LEFT_P && EndlessSelectedNum == 3)
				EndlessSelectionMenu('sel-3', true);
			if (controls.RIGHT_P && EndlessSelectedNum == 0)
				EndlessSelectionMenu('sel-2', true);
			if (controls.RIGHT_P && EndlessSelectedNum == 2)
				EndlessSelectionMenu('sel-4', true);
			if (controls.UP_P && EndlessSelectedNum == 2)
				EndlessSelectionMenu('sel-1', true);
			if (controls.UP_P && EndlessSelectedNum == 3)
				EndlessSelectionMenu('sel-2', true);
			if (controls.DOWN_P && EndlessSelectedNum == 0)
				EndlessSelectionMenu('sel-3', true);
			if (controls.DOWN_P && EndlessSelectedNum == 1)
				EndlessSelectionMenu('sel-4', true);
		} else {
			if (FlxG.mouse.overlaps(EndlessVerOne) && EndlessSelectedNum != 0)
				EndlessSelectionMenu('sel-1', true);
			if (FlxG.mouse.overlaps(EndlessVerTwo) && EndlessSelectedNum != 1)
				EndlessSelectionMenu('sel-2', true);
			if (FlxG.mouse.overlaps(EndlessVerThree) && EndlessSelectedNum != 2)
				EndlessSelectionMenu('sel-3', true);
			if (FlxG.mouse.overlaps(EndlessVerFour) && EndlessSelectedNum != 3)
				EndlessSelectionMenu('sel-4', true);
		}
	}

	if (controls.BACK || FlxG.mouse.justPressedRight) {
		if (canControl) {
			FlxG.sound.play(Paths.sound('menu/cancel'));
			if (selectingMode) {
				selectingMode = false;
				changeSelection(0, false);
				charText.text = (characters[curSelected]);
				charText.screenCenter(FlxAxes.X);
				scoreText.text = 'Score:';
			} else {
				persistentUpdate = false;
				FlxG.switchState(new ModState('TitleScreen'));
			}
		} else {
			if (EndlessSelection) {
				if (controls.BACK || FlxG.mouse.justPressedRight)
					EndlessSelectionMenu('close');
			}
		}
	}

	for (i in 0...textList.members.length) {
		if (i == sm_cur && selectingMode)
			textList.members[i].alpha = 1;
		else
			textList.members[i].alpha = 0.3;
	}
	scoreText.screenCenter(FlxAxes.X);
}

function playShit() {
	canControl = false;
	var songLowercase:String = songSelected.toLowerCase();
	FlxG.sound.play(Paths.sound('menu/confirm'));
	FlxG.sound.music.fadeOut(0.5, 0);
	camera.fade(FlxColor.WHITE, 0.4); // just use fade bruh
	PlayState.loadSong(songLowercase, 'hard');
	new FlxTimer().start(1, function(tmr:FlxTimer) {
		FlxG.switchState(new PlayState());
	});
}

function playShitVer(song:String) {
	canControl = false;
	FlxG.sound.play(Paths.sound('menu/confirm'));
	FlxG.sound.music.fadeOut(0.5, 0);
	camera.fade(FlxColor.WHITE, 0.4); // just use fade bruh
	PlayState.loadSong(song, 'hard');
	new FlxTimer().start(1, function(tmr:FlxTimer) {
		FlxG.switchState(new PlayState());
	});
}

function EndlessSelectionMenu(option:String, playSound:Bool = false) {
	if (playSound)
		FlxG.sound.play(Paths.sound('menu/scroll'), 0.4);
	switch (option) {
		case 'open':
			EndlessSelection = true;
			canControl = false;
			canScroll = false;
			new FlxTimer().start(0.25, function(lkjh:FlxTimer) {
				EndlessMenuCanControl = true;
			});
			EndlessChoice.forEach(function(spr:FlxSprite) {
				FlxTween.tween(spr, {alpha: 1}, 0.125);
			});
			switch (EndlessSelectedNum) {
				case 0:
					EndlessVerOne.color = 0xFFFFFFFF;
					EndlessVerTwo.color = 0xFF232323;
					EndlessVerThree.color = 0xFF232323;
					EndlessVerFour.color = 0xFF232323;
				case 1:
					EndlessVerOne.color = 0xFF232323;
					EndlessVerTwo.color = 0xFFFFFFFF;
					EndlessVerThree.color = 0xFF232323;
					EndlessVerFour.color = 0xFF232323;
				case 2:
					EndlessVerOne.color = 0xFF232323;
					EndlessVerTwo.color = 0xFF232323;
					EndlessVerThree.color = 0xFFFFFFFF;
					EndlessVerFour.color = 0xFF232323;
				case 3:
					EndlessVerOne.color = 0xFF232323;
					EndlessVerTwo.color = 0xFF232323;
					EndlessVerThree.color = 0xFF232323;
					EndlessVerFour.color = 0xFFFFFFFF;
			}
		case 'close':
			FlxG.sound.play(Paths.sound('menu/cancel'));
			EndlessSelection = false;
			canControl = true;
			canScroll = true;
			EndlessMenuCanControl = false;
			EndlessChoice.forEach(function(spr:FlxSprite) {
				FlxTween.tween(spr, {alpha: 0}, 0.125);
			});
		case 'sel-1':
			EndlessSelectedNum = 0;
			EndlessVerOne.color = 0xFFFFFFFF;
			EndlessVerTwo.color = 0xFF232323;
			EndlessVerThree.color = 0xFF232323;
			EndlessVerFour.color = 0xFF232323;
		case 'sel-2':
			EndlessSelectedNum = 1;
			EndlessVerOne.color = 0xFF232323;
			EndlessVerTwo.color = 0xFFFFFFFF;
			EndlessVerThree.color = 0xFF232323;
			EndlessVerFour.color = 0xFF232323;
		case 'sel-3':
			EndlessSelectedNum = 2;
			EndlessVerOne.color = 0xFF232323;
			EndlessVerTwo.color = 0xFF232323;
			EndlessVerThree.color = 0xFFFFFFFF;
			EndlessVerFour.color = 0xFF232323;
		case 'sel-4':
			EndlessSelectedNum = 3;
			EndlessVerOne.color = 0xFF232323;
			EndlessVerTwo.color = 0xFF232323;
			EndlessVerThree.color = 0xFF232323;
			EndlessVerFour.color = 0xFFFFFFFF;
	}
}

function changeSelection(change:Int = 0, playSound:Bool = false, ?mouse:Bool = false) {
	if (playSound)
		FlxG.sound.play(Paths.sound('menu/scroll'), 0.4);

	if (selectingMode) {
		if (!mouse) {
			sm_cur += change;
			if (sm_cur < 0)
				sm_cur = okay.length - 1;
			if (sm_cur >= okay.length)
				sm_cur = 0;
		} else {
			sm_cur = change;
		}
		artStatic.forEach(function(spr:FlxSprite) {
			if (spr.ID == curSelected) {
				spr.alpha = 1;
				spr.alpha = FlxMath.lerp(spr.alpha, 0, FlxMath.bound(FlxG.elapsed * 1, 0, 2));
			}
		});
		songSelected = okay[sm_cur];

		var lerpFactor = FlxMath.bound(FlxG.elapsed * 10, 0, 1);
		intendedScore = FunkinSave.getSongHighscore(songSelected, 'hard').score;
		// lerpScore = FlxMath.lerp(lerpScore, intendedScore, 0.1);
		trace('lerpScore after lerp: ' + lerpScore);
		trace(FunkinSave.getSongHighscore(songSelected, 'hard').score);
		lerpScore = FlxMath.lerp(scoreText.text, 'Score: ' + intendedScore, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		scoreText.text = 'Score: ' + intendedScore;

		artItems.forEach(function(obj:FlxSprite) {
			if (obj.ID == curSelected) {
				switch (characters[curSelected]) {
					default:
						obj.loadGraphic(Paths.image('menus/freeplay/Misfits/artwork/' + characters[curSelected]));
						charText.text = characters[curSelected];
						charText.screenCenter(FlxAxes.X);
				}
			}
		});
		artStatic.forEach(function(spr:FlxSprite) {
			spr.alpha = FlxMath.lerp(spr.alpha, 1, FlxMath.bound(FlxG.elapsed * 6, 0, 1));
		});
	} else {
		curSelected += change;
		if (curSelected < 0)
			curSelected = characters.length - 1;
		if (curSelected >= characters.length)
			curSelected = 0;

		okay = getSongsByChar(characters[curSelected]);
		textList.clear();
		for (i in 0...okay.length) {
			var peepeepoopoocheck = okay[i];
			var SongsText:FlxText;
			SongsText = new FlxText(0, 25, 0, peepeepoopoocheck, 32);
			SongsText.setFormat(Paths.font('sonic-cd-menu-font.ttf'), SongsText.size, FlxColor.WHITE, 'center');
			SongsText.screenCenter();

			var midPoint = (FlxG.height / 2) - (SongsText.frameHeight / 2);
			SongsText.x += 325;
			SongsText.y = (midPoint + (25 * i)) - (((SongsText.frameHeight / 2) * ((okay.length - 1) - i)) / 2);
			textList.add(SongsText);
		}

		artItems.forEach(function(obj:FlxSprite) {
			if (obj.ID == curSelected) {
				obj.loadGraphic(Paths.image('menus/freeplay/Misfits/artwork/' + characters[curSelected]));
				charText.text = characters[curSelected];
				charText.screenCenter(FlxAxes.X);
			}
		});
	}
}
