
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

var transformOffsetX:Float = 0;
var transformOffsetY:Float = 0;
var transformOffsetRot:Float = 0;

var strumPos = [];
var strumY = 0;

var zoomShader:CustomShader;

var timewarp:FlxSprite;

function postCreate()
{
    trace("Script created successfully");
    for (strum in playerStrums)
    {
        strumY = strum.y;
        strumPos.push(strum.x); 
    }

    zoomShader = new CustomShader("zoom");
    zoomShader.transform = [0, 0];
    zoomShader.zoom = 0;
    zoomShader.invertX = false;// true;
    zoomShader.invertY = false;// true;
    zoomShader.rotation = 0;

    camGame.addShader(zoomShader);
    camHUD.addShader(zoomShader);

    timewarp = new FlxSprite().loadGraphic(Paths.image("bgs\\endeavors\\timewarp"), true, 32, 16);
    timewarp.scale.x = 30;
    timewarp.scale.y = 30;
    timewarp.visible = false;
    timewarp.cameras = [camHUD];
    timewarp.screenCenter();
    timewarp.alpha = 0.5;
    timewarp.animation.add("fu", [0]);
    timewarp.animation.add("ture", [1]);
    timewarp.animation.add("past", [2]);
    timewarp.animation.play("fu");
    insert(0, timewarp);
}

function zoomOut(){
    trace("zoomOut");
    FlxTween.num(0, 0.7, Conductor.crochet * 0.0005, {ease:FlxEase.quintOut}, function(value)
    {
        zoomShader.zoom = value;
    });
    FlxTween.num(0, -3, Conductor.crochet * 0.0005, {ease:FlxEase.quintOut}, function(value)
    {
        zoomShader.rotation = value;
    });
}

function zoomIn(){
    trace("zoomIn");
    FlxTween.num(0.7, 0, Conductor.crochet * 0.0015, {ease:FlxEase.backOut}, function(value)
    {
        zoomShader.zoom = value;
    });
    FlxTween.num(90, 360, Conductor.crochet * 0.0015, {ease:FlxEase.backOut}, function(value)
    {
        zoomShader.rotation = value;
    });
}

var stepHitEvents = [
    136 => function()
    {
        FlxTween.num(0, 0.8, Conductor.crochet * 0.0015, {ease:FlxEase.quadOut}, function(value)
        {
            zoomShader.zoom = value;
        });
        FlxTween.num(0, -3, Conductor.crochet * 0.0015, {ease:FlxEase.quadOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    142 => function()
    {
        FlxTween.num(0.8, 0, Conductor.crochet * 0.0005, {ease:FlxEase.quintIn}, function(value)
        {
            zoomShader.zoom = value;
        });
        FlxTween.num(-363, 0, Conductor.crochet * 0.001, {ease:FlxEase.quintInOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    144 => function()
    {
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID];
            strum.y = strumY;
        }
        /*FlxTween.num(-0.3, 0, 0.6, {ease:FlxEase.quadOut}, function(value)
        {
            zoomShader.zoom = value;
        });*/
        FlxTween.num(-0.3, 0, 1, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.zoom = value;
        });
        /*FlxTween.num(0.04, 0, 0.8, {ease:FlxEase.quintOut}, function(value)
        {
            zoomShader.transform[0] = FlxG.random.float(-value, value);
            zoomShader.transform[1] = FlxG.random.float(-value , value);
        });*/
    },
    260 => function()
    {
        FlxTween.num(0, -0.2, Conductor.crochet * 0.001, {ease:FlxEase.expoIn}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    264 => function()
    {
        zoomShader.invertX = true;
        zoomShader.invertY = true;
        FlxTween.num(0, 0.4, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.zoom = value;
        });
        FlxTween.num(0, -25, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    268 => function()
    {
        FlxTween.num(-25, 25, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    272 => function()
    {
        FlxTween.num(25, 0, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.rotation = value;
        });
        FlxTween.num(0.4, 0, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.zoom = value;
        });
        /*FlxTween.num(0.5, 0, 0.3, {ease:FlxEase.quintOut}, function(value)
        {
            zoomShader.transform[0] = FlxG.random.float(-value, value);
            zoomShader.transform[1] = FlxG.random.float(-value , value);
        });*/
    },// 392 - FU
    // 396 - TURE
    392 => function()
    {
        timewarp.visible = true;
        FlxTween.num(0, 0.6, Conductor.crochet * 0.0015, {ease:FlxEase.quartOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    396 => function()
    {
        timewarp.animation.play("ture");
        FlxTween.num(0, 360, Conductor.crochet * 0.002, {ease:FlxEase.expoInOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    398 => function()
    {
        FlxTween.num(0.6, 0, Conductor.crochet * 0.0005, {ease:FlxEase.quintOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    400 => function()
    {
        timewarp.visible = false;
        zoomShader.invertX = true;
        zoomShader.invertY = true;
        FlxTween.num(-0.3, 0, 1, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.zoom = value;
        });
        /*FlxTween.num(0.04, 0, 0.8, {ease:FlxEase.quintOut}, function(value)
        {
            zoomShader.transform[0] = FlxG.random.float(-value, value);
            zoomShader.transform[1] = FlxG.random.float(-value , value);
        });*/
    },
    648 => function()
    {
        timewarp.animation.play("past");
        timewarp.visible = true;
        FlxTween.tween(timewarp, {alpha: 0, "scale.x": 35, "scale.y": 35}, Conductor.crochet * 0.002);
    },
    656 => function()
    {
        zoomShader.rotation = 0;
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID];
            strum.y = strumY;
        }
    },
    732 => function()
    {
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 1, Conductor.crochet * 0.001, {ease:FlxEase.sineOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    734 => function()
    {
        FlxTween.num(0, 360, Conductor.crochet * 0.0015, {ease:FlxEase.expoInOut}, function(value)
        {
            zoomShader.rotation = value;
        });
    },
    736 => function()
    {
        FlxTween.num(1, 0, 0.15, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    738 => function()
    { 
        zoomShader.invertX = true;
        zoomShader.invertY = true;
    },
    992 => function()
    {
        zoomShader.rotation = 0;
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID];
            strum.y = strumY;
        }
    },
    1016 => function()
    { 
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1020 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1048 => function()
    { 
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    },
    1052 => function()
    { 
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1056 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    }, 

    1080 => function()
    { 
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1084 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1112 => function()
    { 
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    },
    1116 => function()
    { 
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1120 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    }, 

    1144 => function()
    { 
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1148 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    
    1176 => function()
        { 
            FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
            {
                zoomShader.transform[0] = value;
            });
        },
    1180 => function()
    { 
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1184 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    }, 

    1208 => function()
    { 
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 1, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    1212 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    
    1240 => function()
        { 
            FlxTween.num(-1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
            {
                zoomShader.transform[0] = value;
            });
        },
    1244 => function()
    { 
        FlxTween.num(-1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
    },
    /*1248 => function()
    { 
        FlxTween.num(1, 0, 0.4, {ease:FlxEase.backOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
    }, */
    1248 => function() {
        zoomShader.invertX = true;
        zoomShader.invertY = true;
        zoomOut();
    },
    1252 => function() {zoomIn();},
    1280 => function() {zoomOut();},
    1284 => function() {zoomIn();},
    1312 => function() {zoomOut();},
    1316 => function() {zoomIn();},
    1344 => function() {zoomOut();},
    1348 => function() {zoomIn();},
    //1374 => function() {zoomOut();},
    1376 => function() 
    {
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 0.6, Conductor.crochet * 0.002, {ease:FlxEase.quadOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    1504 => function() 
    {
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID];
            strum.y = strumY;
        }
        var step:Float = curStepFloat - 1376;
        FlxTween.num((step) * 0.01, 2, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
        FlxTween.num(FlxMath.fastSin((step) * 0.0375 * Math.PI) * 0.02, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
        FlxTween.num(FlxMath.fastSin((step) * 0.075 * Math.PI) * 2, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.rotation = value;
        });
        
        FlxTween.num(0.6, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    1600 => function() 
    {
        zoomShader.transform[0] = 0;
        zoomShader.invertX = true;
        zoomShader.invertY = true;
    }

    1776 => function() {zoomOut();},
    1780 => function() {zoomIn();},
    1808 => function() {zoomOut();},
    1812 => function() {zoomIn();},
    1840 => function() {zoomOut();},
    1844 => function() {zoomIn();},
    1872 => function() {zoomOut();},
    1876 => function() {zoomIn();},

    1904 => function() 
    {
        zoomShader.invertX = false;
        zoomShader.invertY = false;
        FlxTween.num(0, 0.6, Conductor.crochet * 0.002, {ease:FlxEase.quadOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
    2032 => function() 
    {
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID];
            strum.y = strumY;
        }
        var step:Float = curStepFloat - 1904;
        FlxTween.num(step * 0.01, 2, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.transform[0] = value;
        });
        FlxTween.num(FlxMath.fastSin(step * 0.0375 * Math.PI) * 0.02, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.transform[1] = value;
        });
        FlxTween.num(FlxMath.fastSin(step * 0.075 * Math.PI) * 2, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.rotation = value;
        });
        
        FlxTween.num(0.6, 0, Conductor.crochet * 0.002, {ease:FlxEase.quartInOut}, function(value)
        {
            zoomShader.zoom = value;
        });
    },
];



var stepHitMods = [
    400 => null,
    656 => function()
    {
        var modulo:Int = curStep % 8;
        if (modulo == 0 || modulo == 4)
        {
            var n1:Int = modulo == 0 ? 1 : -1;
            for (strum in playerStrums)
            {
                var n2:Int = strum.ID % 2 == 0 ? -1 : 1;
                FlxTween.tween(strum, {y: strumY + n1 * n2 * 10}, 0.2, {ease: FlxEase.backOut});
            }
            if (curStep >= 404)
            FlxTween.num(-1, 1, 0.2, {ease:FlxEase.backOut}, function(value)
            {
                zoomShader.rotation = n1 * value;
            });
        }
    },
    736 => null,
    992 => function()
    {
        trace("gay");
        var modulo:Int = curStep % 8;
        if (modulo == 0 || modulo == 4)
        {
            var n1:Int = modulo == 0 ? 1 : -1;
            for (strum in playerStrums)
            {
                var n2:Int = strum.ID % 2 == 0 ? -1 : 1;
                FlxTween.tween(strum, {y: strumY + n1 * n2 * 10}, 0.2, {ease: FlxEase.backOut});
            }
            if (curStep >= 740)
            FlxTween.num(-1, 1, 0.2, {ease:FlxEase.backOut}, function(value)
            {
                zoomShader.rotation = n1 * value;
            });
        }
    }
];

var updateMods = [
    144 => function(elapsed)
    {
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID] + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.25) * 15;
            strum.y = strumY + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.5) * 10;
        }

        /*if (curStep > 136){
            //8
            zoomShader.zoom = FlxMath.fastSin((curStepFloat - 136) * 0.125 * Math.PI);
        }*/
    },
    1376 => function(){},
    1504 => function(){
        zoomShader.invertY = false;
        zoomShader.invertX = false;
        //zoomShader.transform[0] = FlxMath.fastSin((curStepFloat) * 0.125 * Math.PI) * 0.2;
        //zoomShader.transform[1] = FlxMath.fastSin((curStepFloat) * 0.125 * Math.PI) * 0.2;
        var step:Float = curStepFloat - 1376;
        zoomShader.transform[0] = step * 0.01;
        zoomShader.transform[1] = FlxMath.fastSin(step * 0.0375 * Math.PI) * 0.02;
        zoomShader.rotation = FlxMath.fastSin(step * 0.075 * Math.PI) * 2;
        for (strum in playerStrums){
            strum.y = strumY + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.5) * 20;
        }
    },
    1776 => function(){},
    1904 => function(elapsed)
    {
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID] + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.25) * 25;
            strum.y = strumY + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.5) * 20;
        }
    },
    2032 => function(elapsed)
    {
        var step:Float = curStepFloat - 1904;
        zoomShader.transform[0] = step * 0.01;
        zoomShader.transform[1] = FlxMath.fastSin(step * 0.0375 * Math.PI) * 0.02;
        zoomShader.rotation = FlxMath.fastSin(step * 0.075 * Math.PI) * 2;
        for (strum in playerStrums){
            strum.x = strumPos[strum.ID] + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.25) * 25;
            strum.y = strumY + FlxMath.fastSin(strum.ID * 0.5 + curBeatFloat * Math.PI * 0.5) * 20;
        }
    }
    ];

function update(elapsed)
{
    var firstMod = null;
    for (mod in updateMods.keyValueIterator())
    {
        if (firstMod == null || (mod.key < firstMod.key && curStep < mod.key))
        {
            firstMod = mod;
        }
        
    }
    if (firstMod != null && (curStep < firstMod.key))
        firstMod.value(elapsed);
    //zoomShader.transform[0] += elapsed * 0.1;
}

function stepHit()
{
    //trace(curStep);
    var firstMod = null;
    for (mod in stepHitMods.keyValueIterator())
    {
        if (firstMod == null || (mod.key < firstMod.key && curStep < mod.key))
        {
            //trace(mod.key);
            firstMod = mod;
        }
        
    }
    if (firstMod != null && (curStep < firstMod.key) && firstMod.value != null)
        firstMod.value();

    for (event in stepHitEvents.keyValueIterator())
    {
        if (curStep == event.key)
        {
            event.value();
            break;
        }
    }
}


// 392 - FU
// 396 - TURE

//var strumPos = []


/*var updateMods = [
    144 => function(elapsed)
        {
            for (strum in playerStrums){
                strum.x = strumPos[strum.ID] + FlxMath.fastSin(curStepFloat * Math.PI) * 10;
            }
        }
    ]
*/

//function update(elapsed)
//{
    //trace("deez");
    /*for (mod in updateMods.keyValueIterator())
    {
        if (curStep < mod.key)
        {
            mod.value();
        }
    }*/
//}