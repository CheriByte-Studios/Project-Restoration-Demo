// sorta complicated but its odd instantiating a tween every hit so...... -srt
var icons = [];
var lastHit:Array<Float> = [0, 0];
function postCreate() {
	icons = [iconP1, iconP2];
	doIconBop = false; //tysm care
}

function postUpdate(e) {
	if (Conductor.songPosition < 0) return;
	var fract = 1 / (Conductor.crochet * 0.5); // the "1 / " is so we can multiply fract instead of divide
	for (i in 0...icons.length) {
		var time:Float = (Conductor.songPosition - lastHit[i]) * fract;
		// time = FlxEase.quadOut(time); // if yall want better eases because linear is weird.....
		time = Math.min(Math.max(time, 0), 1); // cap it to 1.

		icons[i].scale.x = icons[i].scale.y = FlxMath.lerp(1.5, 1, time);
	}
}

function onNoteHit(event)
	lastHit[event.note.strumLine.opponentSide ? 1 : 0] = event.note.strumTime;