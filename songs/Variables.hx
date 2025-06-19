public var EXEHud:Bool = true;
public var VHSHud:Bool = false;

function create() {
	if (EXEHud) importScript("data/scripts/json-check/Normal Hud");
	if (VHSHud) importScript("data/scripts/json-check/VHS Hud");
}