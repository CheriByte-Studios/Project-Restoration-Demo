import funkin.backend.system.framerate.Framerate;


static var initialized:Bool = true;

static var redirectStates:Map<FlxState, String> = [
    TitleState => "TitleScreen",
    FreeplayState => "DemoFreeplay",
];


function preStateSwitch() {
    FlxG.camera.bgColor = 0x00000000;

	if (!initialized){
		initialized = true;
		FlxG.game._requestedState = new ModState('TitleScreen');
    }else
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function postStateSwitch() {
	// waiting for a fix someone has in CNE server, so uh deal with it ig?

	Framerate.codenameBuildField.visible = true;
	Framerate.codenameBuildField.text = "PROJECT RESTORATION DEMO";

}