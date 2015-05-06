// Sassafracas (TuneMachine II)
// v0.5 - 20150412 - M. Hairston

// TODO
// Define a player (via a prototype pattern)
// collection of instruments to choose from (for each note or each part?)
// durations, degrees, legato, octaves, amplitudes,
// outside notes, pattern length, accuracy (lag)
// include an amplitude factor.
// A player is composed of an amalgam of prototype patterns (partials)
// (building blocks of a synthetic style).
// They all follow a master scale.
// Include an "arranger" player who affects the mix and texture.


(
Tempo.bpm = 60;
~sc = Scale.harmonicMinor;
~root = 3;
~mtr = 5;
~groups = Group()!3;

~common = Pbind(
  \scale, Pfunc({~sc}),
  \ctranspose, Pfunc({~root}),
  \mtranspose, Pfunc({~mtr})
);

~dst = Synth.tail(s,\tube);
~dst.run(0);
~rvb = Synth.tail(s,\gverb,[\roomsize,10,\revtime,1.5,\taillevel,0.3]);
~rvb.run(1).set(\revtime,0.7,\taillevel,0.06);

// drums
~ppSize = [2,3,4,4,4,4,4,6,6,8,8,8].choose;
~ppInstrs = {[\sn,\sn,\sn,\kick,\kick,\kick,
  \kick,\hh,\hh,\hh,\hh,\hh,\hh,\hh,\hh,\hh,\hh].choose}!~ppSize;
~ppDurs = {[0.125,0.25,0.25,0.25,0.5,0.5,1].choose}!~ppSize;
~ppAmps = {[0.3,0.5,0.5,0.5,0.5,0.5,0.8].choose}!~ppSize;
~pan = -0.8;
~pDrums = Pbind(
  \instrument, Pshuf(~ppInstrs,inf),
  \dur, Pshuf(~ppDurs,inf),
  \amp, Pshuf(~ppAmps,inf),
  \pan, ~pan,
  \group, ~groups[0].nodeID
).play(quant:2);

// bass player
~ppSize = [2,4,4,8,8,8,8].choose;
~ppInstrs = [\bass,\percBass,\ixibass].choose;
~ppDegrees = {[0,0,0,0,3,3,3,2,5,7,8].choose}!~ppSize;
~ppDurs = {[0.25,0.25,0.5,0.5,1,2].choose}!~ppSize;
~pan = 0;
~pBass = ~common <> Pbind(
  \scale,Pfunc({~sc}),
  \instrument, ~ppInstrs,
  \degree, Pseq(Pshuf(~ppDegrees)!2,inf),
  \octave, Pshuf([2,2,3,3,3,3,3,3,4],inf),
  \dur, Pshuf(~ppDurs,inf),
  \pan, ~pan,
  \group, ~groups[1].nodeID
);
~pBass.play(quant:2);

// keyboard player
~ppSize = [2,3,4,4,6,8,8,8,8,16,16].choose;
~ppInstrs = {[\pinggnip,\i2,\hum,\apad,\gnip,\het,\sinePerc,\ping,\red,\strings,\chromPerc,\bling,\straw].choose}!3;
~ppDegrees = {[0,0,0,0,3,3,3,2,5,7,8].choose}!~ppSize;
~ppAmps = {[0.1,0.1,0.1,0.2,0.2,0.2,0.3,0.3,0.3,0.3,0.3,0.4].choose}!~ppSize;
~ppDurs = {[0.5,0.5,0.5,0.5,0.25,0.25,1,1,1,2,2].choose}!~ppSize;
~pan = 0.7;
~pKeys = ~common <> Pbind(
  \instrument, Pshuf(~ppInstrs,inf),
  \att,0,
  \attack,0,
  \degree, Pshuf(~ppDegrees,inf),
  \dur, Pshuf(~ppDurs,inf),
  \legato, 0.8,
  \pan, ~pan,
  \group, ~groups[2].nodeID
);
~pKeys.play;
)

~pDrums.stop
