//a
import flixel.math.FlxAngle;

var opponentRTX:CustomShader;

var gfRTX:CustomShader;

var opponentShadowColor = [(208/255), (142/255), (155/255), 0.045];
function postCreate() {
    
    opponentRTX = new CustomShader("RTXLighting");
    opponentRTX.overlayColor = [0, 0, 0, 1];
    opponentRTX.satinColor = [0.2, 0.2, 0.2, 0.4];
    opponentRTX.innerShadowColor = opponentShadowColor;
    opponentRTX.innerShadowDistance = 65;

    dad.shader = opponentRTX;

}

var theDad = dad;
function onChangeCharacter(oldChar, newChar) {
    if (newChar.isPlayer) return;
    theDad = newChar;
}

var _removedNotes:Bool = false;
function removeAllNotes() {
    if (_removedNotes) return;
    _removedNotes = true;
    strumLines.forEach(function (strum) {
        for (note in strum.notes.members) note.destroy();
        strum.notes.clear();
    });
}
function update(elapsed) {

    if (PlayState.curBeat > 132 && PlayState.curBeat < 196) {
  //      pixel_bfRTX.innerShadowAngle = angleBetweenSprites(charMap[1][0]["bf-pixel"], charMap[0][0]["Xeno-Pixel"]);
    //    pixel_opponentRTX.innerShadowAngle = angleBetweenSprites(charMap[0][0]["Xeno-Pixel"], charMap[1][0]["bf-pixel"]);
    } else {
        var dadCenter = getAnimationCenter(dad);
        var BfCenter = getAnimationCenter(boyfriend);

        opponentRTX.innerShadowAngle = angleBetweenSprites(dadCenter, BfCenter);
    }

    // if (FlxG.keys.justPressed.B) removeAllNotes();
}

/**
    as long as both params have the `.x` and `.y` value this function will return a Rad
**/
function angleBetweenSprites(sprite1:Dynamic, sprite2:Dynamic):Flaot {
    // Calculate the difference in coordinates
    var dx:Float = sprite2.x - sprite1.x;
    var dy:Float = sprite2.y - sprite1.y;

    var angleRad:Float = Math.atan2(dy, dx);

    return angleRad;
}

function getAnimationCenter(sprite:FlxSprite):FlxPoint {
    var frameWidth:Float = sprite.frameWidth;
    var frameHeight:Float = sprite.frameHeight;
    var centerX:Float = sprite.x + (frameWidth / 2);
    var centerY:Float = sprite.y + (frameHeight / 2);
    return {x: centerX, y: centerY }
}

function rgbaToInt(r:Float, g:Float, b:Float, a:Float):Int {
    // Ensure each component is within the range [0, 1]
    r = Math.max(0, Math.min(1, r));
    g = Math.max(0, Math.min(1, g));
    b = Math.max(0, Math.min(1, b));
    a = Math.max(0, Math.min(1, a));

    // Convert each component to an integer between 0 and 255
    var ir = Std.int(r * 255);
    var ig = Std.int(g * 255);
    var ib = Std.int(b * 255);
    var ia = Std.int(a * 255);

    // Combine the components into a single integer
    var color = (ia << 24) | (ir << 16) | (ig << 8) | ib;
    return color;
}

function blendColors(color1:Int, color2:Int, ratio:Float):Int {
    // Ensure the ratio is within the range [0, 1]
    ratio = Math.max(0, Math.min(1, ratio));
    
    // Extract the RGB components of the first color
    var r1 = (color1 >> 16) & 0xFF;
    var g1 = (color1 >> 8) & 0xFF;
    var b1 = color1 & 0xFF;
    
    // Extract the RGB components of the second color
    var r2 = (color2 >> 16) & 0xFF;
    var g2 = (color2 >> 8) & 0xFF;
    var b2 = color2 & 0xFF;
    
    // Interpolate each color component
    var r = Std.int(r1 + ratio * (r2 - r1));
    var g = Std.int(g1 + ratio * (g2 - g1));
    var b = Std.int(b1 + ratio * (b2 - b1));
    
    // Combine the interpolated components back into a single color
    var blendedColor = (r << 16) | (g << 8) | b;
    return blendedColor;
}

function getMidpointDistanceRatio(sprite1:FlxSprite, sprite2:FlxSprite, thirdSprite:FlxSprite, maxDistance:Float):Float {
    // Calculate the midpoint between sprite1 and sprite2
    var sprite1MidX = (sprite1.x + sprite1.width / 2);
    var sprite1MidY = (sprite1.y + sprite1.height / 2);
    var sprite2MidX = (sprite2.x + sprite2.width / 2);
    var sprite2MidY = (sprite2.y + sprite2.height / 2);

    var midpointX = (sprite1MidX + sprite2MidX) / 2;
    var midpointY = (sprite1MidY + sprite2MidY) / 2;

    // Calculate the distance from the midpoint to the third sprite
    var thirdSpriteMidX = thirdSprite.x + thirdSprite.width / 2;
    var thirdSpriteMidY = thirdSprite.y + thirdSprite.height / 2;

    var distance = Math.sqrt(Math.pow(midpointX - thirdSpriteMidX, 2) + Math.pow(midpointY - thirdSpriteMidY, 2));

    // Normalize the distance to get a ratio between 0 and 1
    var ratio = Math.min(distance / maxDistance, 1);

    return ratio;
}

function intToRgba(color:Int) {
    // Extract each component using bitwise operations
    var a = ((color >> 24) & 0xFF) / 255.0;
    var r = ((color >> 16) & 0xFF) / 255.0;
    var g = ((color >> 8) & 0xFF) / 255.0;
    var b = (color & 0xFF) / 255.0;

    // Return the components as a map
    return { r: r, g: g, b: b, a: a }
}