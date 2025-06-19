var daStrumID:Int = 1;

function create(){
    NoSkin = true;
}
function onStrumCreation(e)
    if (e.player == daStrumID)
        e.sprite = "game/notes/Majin_Notes";

function onNoteCreation(event:NoteCreationEvent) {
    event.note.splash = "Majin";
    if (event.strumLineID == daStrumID)
        event.noteSprite = "game/notes/Majin_Notes";
}