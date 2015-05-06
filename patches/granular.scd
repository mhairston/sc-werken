

// clouds
// m. hairston 24 Apr 2008

// Synthdef modified from GrainSin help page


(

SynthDef(\cloud, {
  arg outbus = 0, gate = 1, attack = 0, release = 0,
  freq = 440, freq2 = 440, freqdev = 0.01, freqdev2 = 0.01,
  amp = 0.7, amp2 = 0.7,graindur = 0.1, graindur2 = 0.1,
  graindurdev = 0, graindurdev2 = 0, pan = 0, pan2 = 0,
  dur = 4, density = 10, density2 = 10, envbuf = -1;
	var freqEnv, freqdevEnv, freqdevMul, graindurdevEnv,
  graindurdevMul, panEnv, ampEnv, graindurEnv, densityEnv,
  trig, sig, totalDur;
	totalDur = 				attack+dur+release;
	freqEnv =				XLine.kr(freq,freq2,totalDur);
	freqdevEnv =			Line.kr(freqdev,freqdev2,totalDur);
	graindurdevEnv =		Line.kr(graindurdev,graindurdev2,totalDur);
	ampEnv =				EnvGen.kr(Env.new([0,amp,amp2,0],[attack,dur,release],'sine'),gate:gate,doneAction:2);
	graindurEnv =			Line.kr(graindur,graindur2,totalDur);
	panEnv =				Line.kr(pan,pan2,totalDur);
	densityEnv =			Line.kr(density,density2,totalDur);
	freqdevMul = 			WhiteNoise.kr(mul:freqdevEnv)+1;
	graindurdevMul = 		WhiteNoise.kr(mul:graindurdevEnv)+1;
	trig = 					Impulse.kr(densityEnv);
	sig = 					GrainSin.ar(2, trig, graindurEnv * graindurdevMul, freqEnv * freqdevMul, panEnv, envbuf, mul:max(0,ampEnv));
	//sig=LPF.ar(sig,LFNoise0.kr(densityEnv).range(freqEnv*2,freqEnv*5));
		sig=LPF.ar(sig,LFNoise0.kr(densityEnv).range(500,5000));
	Out.ar(outbus,sig);
}).add;

~random={arg channel=1,dur=1;
	Synth.tail(WS.snd[1],\cloud, [
		\dur,			dur,
		\attack,		0,
		\release,		0,
		\freq,			10000,
		\freq2,			10000,
		\freqdev,		0.99,
		\freqdev2,		0.99,
		\amp,			rrand(0.1,0.4),
		\amp2,			rrand(0.1,0.4),
		\graindur,		rrand(0.001,0.2),
		\graindur2,		rrand(0.001,0.2),
		\density,		rrand(5,60),
		\density2,		rrand(5,60),
		\pan,			rrand(-1,1),
		\pan2,			rrand(-1,1),
		\target,		WS.snd[channel].nodeID,
		\outbus,		WS.bus[channel]
	]);
};

~spatter={arg channel=1,dur=1,layers=4;
	layers.do({
	    ~random.value(channel,dur);
	});
};

~drone={arg channel=1,freq=440,freqdev=0.1,amp=0.5,graindur=0.1,graindurdev=0.01,dur=1,attack=1,release=1;
	Synth.tail(WS.snd[1],\cloud, [
		\dur,			dur,
		\attack,		attack,
		\release,		release,
		\freq,			freq,
		\freq2,			freq,
		\freqdev,		0.001,
		\freqdev2,		0.001,
		\freqdev,		freqdev,
		\amp,			amp,
		\amp2,			amp,
		\graindur,		graindur,
		\graindur2,		graindur,
		\graindurdev,	graindurdev,
		\graindurdev2,	graindurdev,
		\density,		20,
		\density2,		20,
		\target,		WS.snd[channel].nodeID,
		\outbus,		WS.bus[channel]
	]);
};

~chordCloud={arg channel=1, freqs=[440,660,880], freqdev=0.01, amp=0.5, graindur=0.1, graindurdev=0.1, dur=3, attack=1, release=1;
	freqs.do({arg f;
		~drone.value(channel:channel, freq:f, freqdev:freqdev, amp:amp, dur:dur, graindurdev:graindurdev, attack:attack, release:release);
	})
};

~swell = {arg channel=1, freq=440, amp=0.5, dur=1;
	Synth.tail(WS.snd[1],\cloud, [
		\dur,			0,
		\attack,		dur,
		\release,		0.05,
		\freq,			freq,
		\freq2,			freq,
		\freqdev,		0.01,
		\freqdev2,		0.01,
		\amp,			amp/5,
		\amp2,			amp,
		\graindur,		0.05,
		\graindur2,		0.05,
		\graindurdev,	0.05,
		\graindurdev2,	0.05,
		\density,		40,
		\density2,		40,
		\pan,			0,
		\pan2,			0,
		\target,		WS.snd[channel].nodeID,
		\outbus,		WS.bus[channel]
	]);
};
)

(
~coalesce =	{arg freq=440,freqdev=0.001,amp=0.3,dur=4;

	Synth.tail(WS.snd[1],\cloud, [
		\dur,			dur,
		\attack,		1,
		\release,		1,
		\freq,			freq,
		\freq2,			freq,
		\freqdev,		freqdev,
		\freqdev2,		freqdev,
		\amp,			amp,
		\amp2,			amp/4,
		\graindur,		rrand(0.01,0.05),
		\graindur2,		0.1,
		\graindurdev,	0.05,
		\graindurdev2,	0.05,
		\density,		rrand(5,20),
		\density2,		30,
		\pan,			-1,
		\pan2,			1,
		\target,		WS.snd[1].nodeID,
		\outbus,		WS.bus[1]
	]);
}
)

(
~test =	Synth.tail(WS.snd[1],\cloud, [
	\dur,			12,
	\attack,		1,
	\release,		1,
	\freq,			1500,
	\freq2,			1500,
	\freqdev,		0.0,
	\freqdev2,		0.0,
	\amp,			0.2,
	\amp2,			0.2,
	\graindur,		0.4,
	\graindur2,		0.4,
	\graindurdev,	0.00,
	\graindurdev2,	0.00,
	\density,		4,
	\density2,		4,
	\pan,			-1,
	\pan2,			1,
	\target,		WS.snd[1].nodeID,
	\outbus,		WS.bus[1]
]);
)

(
~rvb1=WS.playfx(1,"reverb");
	~rvb1.set(\decay,5,\damp,0.75,\mix,0.2);
~rvb2=WS.playfx(2,"reverb");
	~rvb2.set(\decay,8,\damp,0.9,\mix,0.1);
~lpf2=WS.playfx(3,"LPF");
	~lpf2.set(\cutoff,3500);
~rvb3=WS.playfx(3,"reverb");
	~rvb3.set(\decay,3,\damp,0.5,\mix,0.1);
~lpf3=WS.playfx(3,"LPF");
	~lpf3.set(\cutoff,2000);
)

~spatter.value(channel:2,dur:4,layers:1);

// overlapping clouds:
(
Task({
	~spatter.value(channel:2,dur:4,layers:8);
	3.wait;
	~spatter.value(channel:1,dur:4,layers:12);
	1.5.wait;
	~spatter.value(channel:3,dur:6,layers:8);
}).play;
)

// cloud of clouds:
(
Task({
	32.do({
		~spatter.value(1,0.02,60);
		[0.1].choose.wait;
	});
}).play
)


// methods that generate different species of clouds.
// Each should have a small number of params, with the rest following a particular algorithm.
// One param should be channel; could set up different effects chains on each channel, and direct clouds to each.
// ideas for cloud types:
// Clouds.spatter(channel,dur,layers)
//     one or more highly randomized streams of grains.
// Clouds.drone(channel,freq,amp,dur,attack,release)
//     pitch stays the same; other params vary for organic texture.
// Clouds.gliss(channel,freq,freq2,freqdev,amp,dur,attack,release)

~drone.value(freq:790,graindur:0.1);
~chordCloud.value(freqs:([60,67,74]+(12.rand)).midicps*2,amp:0.1,dur:6,attack:3,release:1);
~chordCloud.value(freqs:[30,150,475,1000,2198,3456,4321,6543]+rrand(0,1000),amp:0.1,dur:6,attack:3,release:1,graindurdev:0.9,freqdev:0.01);
~swell.value(freq:68.midicps);

(
// coalescing chord
Routine({
	[57,65,69,73,77].do({arg i;
		~coalesce.value(i.midicps*4);
		0.1.wait;
	})
}).play;
)


	