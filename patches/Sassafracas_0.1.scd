// Sassafracas (TuneMachine II)
// v0.1 - 20150412 - M. Hairston

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
~voices = 4;
Tempo.bpm = 60;
~ch = 1;
~pan = rrand(0.5,0.9) * ([1,-1].choose);
~m = [\het,\ping,\boop,\red,\dow,\clav,\strings,\fmPerc,\chromPerc,\bling,\straw,\droner,\tribe1,\sinePerc];
~v = [0,0.4,0.4,0.8];
~p = Array.newClear(~voices);
~sc = Scale.choose;
~root = 3;
~mtr = 5;
g = Group();
~dst = Synth.tail(g,\tube);
~dst.run(1);
~hum = Synth.tail(g,\chorus);
~rvb = Synth.tail(g,\gverb,[\roomsize,10,\revtime,2.4,\taillevel,0.3]);

~voices.do({
  ~p.put(
    ~ch,
    Pbind(
      \instrument, ~m.choose.postln,
      \scale, ~sc,
      \ctranspose, Pfunc({~root}),
      \mtranspose, Pfunc({~mtr}),
      \octave, 2 + ~ch,
      \legato, rrand(0.2,0.9),
      \degree, Pseq({(-4..14).choose}!12,inf),
      \dur, [1,0.5,0.5,0.25,0.25,0.125].choose,
      \amp, Pseq({[0,0.4,0.4,0.4,0.4,0.4,0.8,0.8].choose}!4,inf),
      \pan, Pfunc({~pan}),
      \outbus, ~ch
    ).play(quant:2);
  );
  ~ch = (~ch + 1) % ~voices;
});

)

~p[1].xstop(2)
~p[2].xstop(2)
~p[3].xstop(2)
~p[4].xstop(2)

~p[8]
