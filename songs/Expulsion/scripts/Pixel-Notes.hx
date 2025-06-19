function onNoteCreation(event) {
	event.cancel();

	var note:Note = event.note;
	if (note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/SpedEnds'), true, 7, Math.floor(34 / 2));
		note.animation.add('hold', [event.strumID], 24, false);
		note.animation.add('holdend', [event.strumID + 4], 24, false);
	} else {
		note.loadGraphic(Paths.image('game/notes/Sped'), true, 35, 35);
		note.animation.add('scroll', [event.strumID], 24, false);
	}
	note.scale.set(3, 3);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum:Strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/Sped'), true, 35, 35);
	strum.animation.add('static', [event.strumID + 4], 24, false);
	strum.animation.add('pressed', [event.strumID], 24, false);
	strum.animation.add('confirm', [event.strumID], 24, false);

	strum.scale.set(3, 3);
	strum.updateHitbox();
}

function create(){
	BloodSplash = false;
	NoSkin = true;
}
