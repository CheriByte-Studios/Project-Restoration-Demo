public var disableGhosts:Bool = false;

var data:Map<Int, {colors:Array<FlxColor>, lastNote:{time:Float, id:Int}}> = [];

function postCreate()
	for (sl in strumLines.members)
		data[strumLines.members.indexOf(sl)] = {
			colors: [for (character in sl.characters) switch(sl.data.position) {
				default: 0xFFFFFFFF;
				case 'boyfriend': 0xFFFFFFFF;
			}],

			lastNote: {
				time: -9999,
				id: -1
			}
		}

function onNoteHit(event:NoteHitEvent) {
	if (event.note.isSustainNote) return;

	var target = data[strumLines.members.indexOf(event.note.strumLine)];
	var doDouble = (event.note.strumTime - target.lastNote.time) <= 2 && event.note.noteData != target.lastNote.id;
	target.lastNote.time = event.note.strumTime;
	target.lastNote.id = event.note.noteData;

	if(doDouble && !disableGhosts)
		for (character in event.characters)
			if (character.visible) doGhostAnim(character, target.colors[event.characters.indexOf(character)]).playAnim(character.getAnimName(), true);
}

var zoomShit = FlxG.save.data.trailZoom;
function doGhostAnim(char:Character, color:FlxColor) {
	camGame.zoom += .015 * zoomShit;
	camHUD.zoom += .03 * zoomShit;

	var trail:Character = new Character(char.x, char.y, char.curCharacter, char.isPlayer);
	trail.color = char.color;
	trail.flipX = char.flipX;
	trail.alpha = char.alpha;
	trail.visible = char.visible;
	trail.scale.set(char.scale.x, char.scale.y);
	insert(members.indexOf(char), trail);
	FlxTween.tween(trail, {x: char.isPlayer ? char.x + 150 : char.x - 150, alpha: 0}, .5, {ease: FlxEase.circOut}).onComplete = function() {
		trail.kill();
		remove(trail, true);
	}
	return trail;
}