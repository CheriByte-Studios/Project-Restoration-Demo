var dodgeDelay = 1;
var timer:Float = 0;
var box:FlxSprite;
var player:FlxSprite;
var thingy = false;
var canMove = false;
var defX = 0;
var dodge:Bool;
var warning:FlxSprite;
var spikeisfalling:FlxSprite;
var boxwarn:FlxSprite;
var leftSpike = false;
var rightSpike = false;

function create()
{
	// defaultCamZoom = 0.3;
	defX = boyfriend.x;
	box = new FlxSprite().loadGraphic(Paths.image("global-images/mechanic/spike/ui"));
	insert(1, box);
	box.cameras = [camHUD];

	player = new FlxSprite().loadGraphic(Paths.image("global-images/mechanic/spike/ui-player"));
	insert(2, player);
	player.cameras = [camHUD];
	player.x = -70;

	warning = new FlxSprite().loadGraphic(Paths.image("global-images/mechanic/spike/warning"));
	insert(2, warning);
	warning.cameras = [camHUD];
	warning.y = -70;
	warning.alpha = 0;

	spikeisfalling = new FlxSprite().loadGraphic(Paths.image("global-images/mechanic/spike/ui-spike"));
	insert(3, spikeisfalling);
	spikeisfalling.cameras = [camHUD];
	spikeisfalling.x = -70;
	spikeisfalling.alpha = 0;

	notewarn = new FlxSprite(1310, 400).loadGraphic(Paths.image("bgs/Coulrophobia/note-warn"));
	notewarn.cameras = [camGame];
	add(notewarn);
	notewarn.alpha = 0;
	// left spike 1350 right spike 1750
	spike = new FlxSprite(1350, 0).loadGraphic(Paths.image("bgs/Coulrophobia/spike_rock"));
	spike.cameras = [camGame];
	spike.alpha = 0;
	add(spike);
}

function update(elapsed)
{
	if (FlxG.keys.justPressed.SPACE && canMove)
	{
		if (timer > dodgeDelay)
		{ // tnx sage for the timers
			timer = 0;
			if (dodge)
			{
				FlxTween.tween(boyfriend, {x: defX}, 0.3, {ease: FlxEase.quadOut});
				boyfriend.playAnim('dodgeL', true);
				player.x = -70;
			}
			else
			{
				FlxTween.tween(boyfriend, {x: defX + 300}, 0.3, {ease: FlxEase.quadOut});
				boyfriend.playAnim('dodgeR', true);
				player.x = 0;
			}
			dodge = !dodge;
		}
	}
	timer += elapsed;
}

function stepHit(curStep)
{
	if (curStep == 256 || curStep == 384 || curStep == 512 || curStep == 768 || curStep == 816 || curStep == 1024 || curStep == 1152 || curStep == 1280
		|| curStep == 1440 || curStep == 1552)
	{
		Warning();
	}
}

function Warning()
{
	canMove = true;
	if (FlxG.random.int(1, 2) == 1)
	{
		leftSpike = true;
		rightSpike = false;
	}
	else
	{
		leftSpike = false;
		rightSpike = true;
	}
	Spike();
}

function Spike()
{
  for (i in [spikeisfalling, warning, notewarn, spike]){
    i.alpha = 1;
  }
	if (leftSpike)
	{
		spikeisfalling.x = -70;
		spike.x = 1350;
		notewarn.x = 1310;
	}
	else if (rightSpike)
	{
		spikeisfalling.x = 0;
		spike.x = 1750;
		notewarn.x = 1710;
	}

	var timer:FlxTimer = new FlxTimer();
	var timer2:FlxTimer = new FlxTimer();
	timer.start(2.5, wait);
	timer2.start(3, death);
}

function wait()
{
	canMove = false;
	FlxTween.tween(spikeisfalling, {alpha: 0}, 1.0);
	FlxTween.tween(warning, {alpha: 0}, .5);
	FlxTween.tween(spike, {y: 800}, .5);
	FlxG.sound.play(Paths.sound("Fall"), 1);
	FlxTween.tween(notewarn, {alpha: 0}, .5, {onComplete: reset});
}

function death()
{
	if (rightSpike && player.x == 0)
	{
		PlayState.instance.health = -300;
	}
	else if (leftSpike && player.x == -70)
	{
		PlayState.instance.health = -300;
	}
}

function reset()
{
	spike.y = 0;
	FlxTween.tween(spike, {alpha: 0}, .5);
	FlxG.sound.play(Paths.sound("Break"), 0.7);
	var timer3:FlxTimer = new FlxTimer();
	timer3.start(0.2, shake);
}

function shake()
{
	FlxG.camera.shake(0.01);
}
