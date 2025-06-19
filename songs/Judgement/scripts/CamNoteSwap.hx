scripts.getByPath('songs/camNoteMove.hx').active = false;

var intensity = 5; // How far the camera moves on press, default is 5 // 5 = 50 Pixels
var alignX = true; // Makes up and down movement 70% of left and right movement, defualt is true
var move = true; // Do you want the camera to move? default is true (can also be toggled with "toggleMovePress" event)

function onCameraMove(event) {
	if (event.position.x == dad.getCameraPosition().x && event.position.y == dad.getCameraPosition().y)
		camTarget = "dad";
	else if (event.position.x == boyfriend.getCameraPosition().x && event.position.y == boyfriend.getCameraPosition().y)
		camTarget = "boyfriend";

	if (dad.getAnimName() == "idle" && boyfriend.getAnimName() == "idle" && move) {} else
		event.cancel();
}

var inte:Float = intensity * 10;
var inteW:Float = (intensity * 10) * (alignX ? 0.7 : 1);
var posOffsets:Array<Array<Float>> = [
	[-inte, 0],
	[0, inteW],
	[0, -inteW],
	[inte, 0]
];

function noteDataEKConverter(data, amount) {
	if (amount == 1) {
		if (data == 0) return 2;
		else return data;

	} else if (amount == 2) {
		if (data == 1) return 3;
		else return data;

	} else if (amount == 3) {
		if (data == 1) return 2;
		else if (data == 2) return 3;
		else return data;

	/* } else if (amount == 4) {
		return data; */

	} else if (amount == 5) {
		if (data == 3) return 2;
		else if (data == 4) return 3;
		else return data;

	} else if (amount == 6) {
		if (data == 1) return 2;
		else if (data == 2) return 3;
		else if (data == 3) return 0;
		else if (data == 4) return 1;
		else if (data == 5) return 3;
		else return data;

	} else if (amount == 7) {
		if (data == 1) return 2;
		else if (data == 2) return 3;
		else if (data == 3) return 2;
		else if (data == 4) return 0;
		else if (data == 5) return 1;
		else if (data == 6) return 3;
		else return data;

	} else if (amount == 8) {
		if (data == 4) return 0;
		else if (data == 5) return 1;
		else if (data == 6) return 2;
		else if (data == 7) return 3;
		else return data;

	} else if (amount == 9) {
		if (data == 4) return 2;
		else if (data == 5) return 0;
		else if (data == 6) return 1;
		else if (data == 7) return 2;
		else if (data == 8) return 3;
		else return data;

	} else return data;
}

function onNoteHit(event) {
	var dir:Int = noteDataEKConverter(event.direction, event.note.strumLine.length);
	if (move)
		if (camTarget == "dad")
			camFollow.setPosition(dad.getCameraPosition().x + posOffsets[dir][0], dad.getCameraPosition().y + posOffsets[dir][1]);
		else if (camTarget == "boyfriend")
			camFollow.setPosition(boyfriend.getCameraPosition().x + posOffsets[dir][0], boyfriend.getCameraPosition().y + posOffsets[dir][1]);
}

function toggleMovePress(event)
	move = !move;